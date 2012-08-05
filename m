From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v2 03/16] Modify match_stat_basic to prepare for other index formats
Date: Sun,  5 Aug 2012 23:49:00 +0200
Message-ID: <1344203353-2819-4-git-send-email-t.gummerer@gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, mhagger@alum.mit.edu, gitster@pobox.com,
	pcouds@gmail.com, robin.rosenberg@dewire.com,
	Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 23:51:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sy8jn-0002ZR-S5
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 23:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755217Ab2HEVun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 17:50:43 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48918 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755164Ab2HEVtw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 17:49:52 -0400
Received: by mail-ee0-f46.google.com with SMTP id l10so649089eei.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 14:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bkuPe8VEoHRpsaoT7J16udpY3tyCpwwb0lXyReEyjZw=;
        b=a3o+j01teW+VE61lzXO/xF8IH80vaIpfTk1DL1PXkYuOZUyH2xF1z8ow6itzGZzms3
         3P3CSCgxKsDzJ4+EMIiMKKksH2+qiv6GfX330bEAfRboz9Uwt1KMEru1viFwoa34UcfA
         gcnY3Zxr+kOOZ76Z3BRtSQUlLGWRzJEbo1MsoQOszo/qdJdHyedKJ9EB8PfdeUEUBBc4
         3QXwVdp3cU5x3t55AX+m+XWppd53kViEHhsnribNb7L/Dx4B546vTqiN0w2AK2V7W610
         PYXffW4iFe6wRG2t0MdB6ixQKri4ezGFLrPrBygF3BSnbDoI902z/fY5d11k+Bjg7BTb
         yb0Q==
Received: by 10.14.210.194 with SMTP id u42mr10500968eeo.11.1344203391607;
        Sun, 05 Aug 2012 14:49:51 -0700 (PDT)
Received: from localhost ([2a01:7e00::f03c:91ff:fedf:f4db])
        by mx.google.com with ESMTPS id a48sm2783639eeo.1.2012.08.05.14.49.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Aug 2012 14:49:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202939>

Modify match_stat_basic, into one function that handles the
general case, which is the same for all index formats, and
a function that handles the specific parts for each index
file version.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 read-cache.c |   71 +++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 31 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 24b5e02..6e8991a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -163,38 +163,10 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
-static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
+static int ce_match_stat_basic_v2(struct cache_entry *ce,
+				struct stat *st,
+				int changed)
 {
-	unsigned int changed = 0;
-
-	if (ce->ce_flags & CE_REMOVE)
-		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
-
-	switch (ce->ce_mode & S_IFMT) {
-	case S_IFREG:
-		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
-		/* We consider only the owner x bit to be relevant for
-		 * "mode changes"
-		 */
-		if (trust_executable_bit &&
-		    (0100 & (ce->ce_mode ^ st->st_mode)))
-			changed |= MODE_CHANGED;
-		break;
-	case S_IFLNK:
-		if (!S_ISLNK(st->st_mode) &&
-		    (has_symlinks || !S_ISREG(st->st_mode)))
-			changed |= TYPE_CHANGED;
-		break;
-	case S_IFGITLINK:
-		/* We ignore most of the st_xxx fields for gitlinks */
-		if (!S_ISDIR(st->st_mode))
-			changed |= TYPE_CHANGED;
-		else if (ce_compare_gitlink(ce))
-			changed |= DATA_CHANGED;
-		return changed;
-	default:
-		die("internal error: ce_mode is %o", ce->ce_mode);
-	}
 	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
 		changed |= MTIME_CHANGED;
 	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
@@ -235,6 +207,43 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	return changed;
 }
 
+static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
+{
+	unsigned int changed = 0;
+
+	if (ce->ce_flags & CE_REMOVE)
+		return MODE_CHANGED | DATA_CHANGED | TYPE_CHANGED;
+
+	switch (ce->ce_mode & S_IFMT) {
+	case S_IFREG:
+		changed |= !S_ISREG(st->st_mode) ? TYPE_CHANGED : 0;
+		/* We consider only the owner x bit to be relevant for
+		 * "mode changes"
+		 */
+		if (trust_executable_bit &&
+		    (0100 & (ce->ce_mode ^ st->st_mode)))
+			changed |= MODE_CHANGED;
+		break;
+	case S_IFLNK:
+		if (!S_ISLNK(st->st_mode) &&
+		    (has_symlinks || !S_ISREG(st->st_mode)))
+			changed |= TYPE_CHANGED;
+		break;
+	case S_IFGITLINK:
+		/* We ignore most of the st_xxx fields for gitlinks */
+		if (!S_ISDIR(st->st_mode))
+			changed |= TYPE_CHANGED;
+		else if (ce_compare_gitlink(ce))
+			changed |= DATA_CHANGED;
+		return changed;
+	default:
+		die("internal error: ce_mode is %o", ce->ce_mode);
+	}
+
+	changed = ce_match_stat_basic_v2(ce, st, changed);
+	return changed;
+}
+
 static int is_racy_timestamp(const struct index_state *istate, struct cache_entry *ce)
 {
 	return (!S_ISGITLINK(ce->ce_mode) &&
-- 
1.7.10.GIT
