From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH/RFC] read-cache: fix file time comparisons with different
 precisions
Date: Mon, 28 Sep 2015 12:39:52 +0200
Message-ID: <560918F8.1080905@gmail.com>
References: <5605D88A.20104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 28 12:40:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgVqo-00087i-O7
	for gcvg-git-2@plane.gmane.org; Mon, 28 Sep 2015 12:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014AbbI1Kj7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2015 06:39:59 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34896 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933011AbbI1Kjz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2015 06:39:55 -0400
Received: by wicge5 with SMTP id ge5so98638839wic.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2015 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=zixg3TrqU87cP9AG6ROgmRX3+UILZHA5G502qFixkvc=;
        b=l+xfETUSnyfChupJyZriGlLo//cyO5n06eNGpvxRJmT3Svv4hA6zA9dst2tK195ciX
         zvFHztxsCHXdTQRYfzxYx9rLP8IdOIMzzUt2zIIlWQsQhUqKpkg6r/MktLE9K3AUVl68
         67x8UwwylMws5gevvwNMtUD0EfRNbtMjhR40RrwXNBNJiR0iprX/gAmGbPthVvjkIQFo
         mJsM0fAYGRAQNQcA9g3mTKBTiy0g4lWZLNKBAc0KBNsZFEIg9blpEFPkiUSVhRUGwy8i
         74qH3mOFlDk3T+3BHAuHhVJSY7RENefhRdQv4MAUn0kspIY2OU8at5fcLtZx6/uE9XN6
         HR6w==
X-Received: by 10.194.80.42 with SMTP id o10mr3930182wjx.31.1443436794075;
        Mon, 28 Sep 2015 03:39:54 -0700 (PDT)
Received: from [10.1.116.51] (ns.dcon.de. [77.244.111.149])
        by smtp.googlemail.com with ESMTPSA id s1sm5364728wik.16.2015.09.28.03.39.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2015 03:39:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <5605D88A.20104@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278713>

Different git variants record file times in the index with different
precisions, according to their capabilities. E.g. git compiled with NO_NSEC
records seconds only, JGit records the mtime in milliseconds, but leaves
ctime blank (because ctime is unavailable in Java).

This causes performance issues in git compiled with USE_NSEC, because index
entries with such 'incomplete' timestamps are considered dirty, triggering
unnecessary content checks.

Add a file time comparison function that auto-detects the precision based
on the number of trailing 0 digits, and compares with the lower precision
of both values. This initial version supports the known precisions seconds
(git + NO_NSEC), milliseconds (JGit) and nanoseconds (git + USE_NSEC), but
can be easily extended to e.g. microseconds.

Use the new comparison function in both dirty and racy checks. As a side
effect, this fixes racy detection in USE_NSEC-enabled git with
core.checkStat=minimal, as the coreStat setting now affects racy checks as
well.

Finally, do not check ctime if ctime.sec is 0 (as recorded by JGit).

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 read-cache.c | 62 ++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 21 deletions(-)


This patch fixes problems 3 and 4, by trying to auto-detect the recorded file
time precision.


diff --git a/read-cache.c b/read-cache.c
index 87204a5..3a4e6cd 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -99,23 +99,50 @@ void fill_stat_data(struct stat_data *sd, struct stat *st)
 	sd->sd_size = st->st_size;
 }
 
+/*
+ * Compares two file times. Returns 0 if equal, <0 if t1 < t2, >0 if t1 > t2.
+ * Auto-detects precision based on trailing 0 digits. Compares seconds only if
+ * core.checkStat=minimal.
+ */
+static inline int cmp_filetime(uint32_t t1_sec, uint32_t t1_nsec,
+			       uint32_t t2_sec, uint32_t t2_nsec) {
+#ifdef USE_NSEC
+	/*
+	 * Compare seconds and return result if different, or checkStat=mimimal,
+	 * or one of the time stamps has second precision only (nsec == 0).
+	 */
+	int diff = t1_sec - t2_sec;
+	if (diff || !check_stat || !t1_nsec || !t2_nsec)
+		return diff;
+
+	/*
+	 * Check if one of the time stamps has millisecond precision only (i.e.
+	 * the trailing 6 digits are 0). First check the trailing 6 bits so that
+	 * we only do (slower) modulo division if necessary.
+	 */
+	if ((!(t1_nsec & 0x3f) && !(t1_nsec % 1000000)) ||
+	    (!(t2_nsec & 0x3f) && !(t2_nsec % 1000000)))
+		/* Compare milliseconds. */
+		return (t1_nsec - t2_nsec) / 1000000;
+
+	/* Compare nanoseconds */
+	return t1_nsec - t2_nsec;
+#else
+	return t1_sec - t2_sec;
+#endif
+}
+
 int match_stat_data(const struct stat_data *sd, struct stat *st)
 {
 	int changed = 0;
 
-	if (sd->sd_mtime.sec != (unsigned int)st->st_mtime)
-		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
-	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
-		changed |= CTIME_CHANGED;
-
-#ifdef USE_NSEC
-	if (check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
+	if (cmp_filetime(sd->sd_mtime.sec, sd->sd_mtime.nsec,
+			 (unsigned) st->st_mtime, ST_MTIME_NSEC(*st)))
 		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
-	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
+	if (trust_ctime && check_stat && sd->sd_ctime.sec &&
+	    cmp_filetime(sd->sd_ctime.sec, sd->sd_ctime.nsec,
+			 (unsigned) st->st_ctime, ST_CTIME_NSEC(*st)))
 		changed |= CTIME_CHANGED;
-#endif
 
 	if (check_stat) {
 		if (sd->sd_uid != (unsigned int) st->st_uid ||
@@ -276,16 +303,9 @@ static int ce_match_stat_basic(const struct cache_entry *ce, struct stat *st)
 static int is_racy_stat(const struct index_state *istate,
 			const struct stat_data *sd)
 {
-	return (istate->timestamp.sec &&
-#ifdef USE_NSEC
-		 /* nanosecond timestamped files can also be racy! */
-		(istate->timestamp.sec < sd->sd_mtime.sec ||
-		 (istate->timestamp.sec == sd->sd_mtime.sec &&
-		  istate->timestamp.nsec <= sd->sd_mtime.nsec))
-#else
-		istate->timestamp.sec <= sd->sd_mtime.sec
-#endif
-		);
+	return istate->timestamp.sec &&
+	       (cmp_filetime(istate->timestamp.sec, istate->timestamp.nsec,
+			     sd->sd_mtime.sec, sd->sd_mtime.nsec) <= 0);
 }
 
 static int is_racy_timestamp(const struct index_state *istate,
-- 
2.1.0.msysgit.0
