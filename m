From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH v4 04/14] diffcore-rename.c: move code around to prepare for
 the next patch
Date: Thu, 07 Nov 2013 15:36:11 +0100
Message-ID: <527BA55B.4080700@gmail.com>
References: <527BA483.6040803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <tr@thomasrast.ch>, Jens Lehmann <Jens.Lehmann@web.de>,
	Karsten Blees <karsten.blees@gmail.com>
To: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 07 15:36:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeQgw-0000ih-R8
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 15:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab3KGOgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Nov 2013 09:36:10 -0500
Received: from mail-ee0-f49.google.com ([74.125.83.49]:55169 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab3KGOgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Nov 2013 09:36:09 -0500
Received: by mail-ee0-f49.google.com with SMTP id e52so351921eek.36
        for <git@vger.kernel.org>; Thu, 07 Nov 2013 06:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=VwsLs+rFdp8n17SHySmcz/eV4Dl0mA/OY2AqoKGQvYM=;
        b=pkkarM3MZAEbALjwPPUtePdV9fRX8+x2RqVjh/urCi6U27lbKe52GZrTNWLs9JH8VC
         Ms9BCDMMfNlhH+qJW+/DLWbOrmrI11L1rGRH+s6W7HHDBGVRiZo/iGLa6luGgmXBef8T
         NeLaW6+4YjG4GtNai8iLcsMCGTb/JYgOgKDlhH/O6TdeDLMVteQX0j+KrI7/WRIaIgPm
         gq576NT1N9I0etYXlbclMKTvjyeJgdV9pH1hpL2Ejbv47nklTGakUZIc8EzdGDInVNRa
         oxeG2mJMhrAutxerUDDEm0NwZ9bM44RKigEJqMXwvIj7dJwIKdhfZ65FTto0UhzBIfFp
         avGA==
X-Received: by 10.14.173.198 with SMTP id v46mr82057eel.132.1383834968012;
        Thu, 07 Nov 2013 06:36:08 -0800 (PST)
Received: from [10.1.100.55] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id y7sm9977439eea.5.2013.11.07.06.36.06
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Nov 2013 06:36:07 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <527BA483.6040803@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237399>

No actual code changes, just move hash_filespec up and outdent part of
find_identical_files.

Signed-off-by: Karsten Blees <blees@dcon.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-rename.c | 98 +++++++++++++++++++++++++++----------------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 6c7a72f..008a60c 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -248,6 +248,18 @@ struct file_similarity {
 	struct file_similarity *next;
 };
 
+static unsigned int hash_filespec(struct diff_filespec *filespec)
+{
+	unsigned int hash;
+	if (!filespec->sha1_valid) {
+		if (diff_populate_filespec(filespec, 0))
+			return 0;
+		hash_sha1_file(filespec->data, filespec->size, "blob", filespec->sha1);
+	}
+	memcpy(&hash, filespec->sha1, sizeof(hash));
+	return hash;
+}
+
 static int find_identical_files(struct file_similarity *src,
 				struct file_similarity *dst,
 				struct diff_options *options)
@@ -258,46 +270,46 @@ static int find_identical_files(struct file_similarity *src,
 	 * Walk over all the destinations ...
 	 */
 	do {
-		struct diff_filespec *target = dst->filespec;
-		struct file_similarity *p, *best;
-		int i = 100, best_score = -1;
-
-		/*
-		 * .. to find the best source match
-		 */
-		best = NULL;
-		for (p = src; p; p = p->next) {
-			int score;
-			struct diff_filespec *source = p->filespec;
-
-			/* False hash collision? */
-			if (hashcmp(source->sha1, target->sha1))
-				continue;
-			/* Non-regular files? If so, the modes must match! */
-			if (!S_ISREG(source->mode) || !S_ISREG(target->mode)) {
-				if (source->mode != target->mode)
-					continue;
-			}
-			/* Give higher scores to sources that haven't been used already */
-			score = !source->rename_used;
-			if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY)
-				continue;
-			score += basename_same(source, target);
-			if (score > best_score) {
-				best = p;
-				best_score = score;
-				if (score == 2)
-					break;
-			}
+	struct diff_filespec *target = dst->filespec;
+	struct file_similarity *p, *best;
+	int i = 100, best_score = -1;
 
-			/* Too many identical alternatives? Pick one */
-			if (!--i)
-				break;
+	/*
+	 * .. to find the best source match
+	 */
+	best = NULL;
+	for (p = src; p; p = p->next) {
+		int score;
+		struct diff_filespec *source = p->filespec;
+
+		/* False hash collision? */
+		if (hashcmp(source->sha1, target->sha1))
+			continue;
+		/* Non-regular files? If so, the modes must match! */
+		if (!S_ISREG(source->mode) || !S_ISREG(target->mode)) {
+			if (source->mode != target->mode)
+				continue;
 		}
-		if (best) {
-			record_rename_pair(dst->index, best->index, MAX_SCORE);
-			renames++;
+		/* Give higher scores to sources that haven't been used already */
+		score = !source->rename_used;
+		if (source->rename_used && options->detect_rename != DIFF_DETECT_COPY)
+			continue;
+		score += basename_same(source, target);
+		if (score > best_score) {
+			best = p;
+			best_score = score;
+			if (score == 2)
+				break;
 		}
+
+		/* Too many identical alternatives? Pick one */
+		if (!--i)
+			break;
+	}
+	if (best) {
+		record_rename_pair(dst->index, best->index, MAX_SCORE);
+		renames++;
+	}
 	} while ((dst = dst->next) != NULL);
 	return renames;
 }
@@ -343,18 +355,6 @@ static int find_same_files(void *ptr, void *data)
 	return ret;
 }
 
-static unsigned int hash_filespec(struct diff_filespec *filespec)
-{
-	unsigned int hash;
-	if (!filespec->sha1_valid) {
-		if (diff_populate_filespec(filespec, 0))
-			return 0;
-		hash_sha1_file(filespec->data, filespec->size, "blob", filespec->sha1);
-	}
-	memcpy(&hash, filespec->sha1, sizeof(hash));
-	return hash;
-}
-
 static void insert_file_table(struct hash_table *table, int src_dst, int index, struct diff_filespec *filespec)
 {
 	void **pos;
-- 
1.8.4.msysgit.0.12.g88f5ed0
