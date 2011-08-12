From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 19/56] merge-recursive: Consolidate different update_stages functions
Date: Thu, 11 Aug 2011 23:19:52 -0600
Message-ID: <1313126429-17368-20-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkBQ-0004nj-PX
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186Ab1HLFVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:21:20 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab1HLFVM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:21:12 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=urPwwIceScUKcGbspXs8APuolY/LnIXD9+Y7Bm2lHsA=;
        b=eKOxDUi1hzWZwa8dGjATSn9ZHSd/p6tVHbfspXi6CGdxtBEk/M4XOqQJa6OmWDQZf4
         A3uvm9Gs0NCFQ+0/r5u9fTb25Xg9rSrvdhq/xkfsBNjutYI8YmACrszH0qjWr6BVWnre
         flTKlM/9mtfVkt22EtCbGN7bMQE4ITFbEVANM=
Received: by 10.42.154.132 with SMTP id q4mr500358icw.489.1313126472615;
        Thu, 11 Aug 2011 22:21:12 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.10
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179173>

We are only calling update_stages_options() one way really, so we can
consolidate the slightly different variants into one and remove some
parameters whose values are always the same.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Changes since v1: This patch now appears much earlier in the series than before.

 merge-recursive.c |   27 +++++++++------------------
 1 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 317bf23..8a5c1a6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -461,11 +461,12 @@ static struct string_list *get_renames(struct merge_options *o,
 	return renames;
 }
 
-static int update_stages_options(const char *path, const struct diff_filespec *o,
-				 const struct diff_filespec *a,
-				 const struct diff_filespec *b,
-				 int clear, int options)
+static int update_stages(const char *path, const struct diff_filespec *o,
+			 const struct diff_filespec *a,
+			 const struct diff_filespec *b)
 {
+	int clear = 1;
+	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
 	if (clear)
 		if (remove_file_from_cache(path))
 			return -1;
@@ -481,14 +482,6 @@ static int update_stages_options(const char *path, const struct diff_filespec *o
 	return 0;
 }
 
-static int update_stages(const char *path, struct diff_filespec *o,
-			 struct diff_filespec *a, struct diff_filespec *b,
-			 int clear)
-{
-	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE;
-	return update_stages_options(path, o, a, b, clear, options);
-}
-
 static int update_stages_and_entry(const char *path,
 				   struct stage_data *entry,
 				   struct diff_filespec *o,
@@ -505,8 +498,7 @@ static int update_stages_and_entry(const char *path,
 	hashcpy(entry->stages[1].sha, o->sha1);
 	hashcpy(entry->stages[2].sha, a->sha1);
 	hashcpy(entry->stages[3].sha, b->sha1);
-	options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
-	return update_stages_options(path, o, a, b, clear, options);
+	return update_stages(path, o, a, b);
 }
 
 static int remove_file(struct merge_options *o, int clean,
@@ -862,8 +854,7 @@ static void conflict_rename_delete(struct merge_options *o,
 	if (!o->call_depth)
 		update_stages(dest_name, NULL,
 			      rename_branch == o->branch1 ? pair->two : NULL,
-			      rename_branch == o->branch1 ? NULL : pair->two,
-			      1);
+			      rename_branch == o->branch1 ? NULL : pair->two);
 	if (lstat(dest_name, &st) == 0 && S_ISDIR(st.st_mode)) {
 		dest_name = unique_path(o, dest_name, rename_branch);
 		df_conflict = 1;
@@ -907,8 +898,8 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		 * update_file(o, 0, pair2->two->sha1, pair2->two->mode, dst_name2);
 		 */
 	} else {
-		update_stages(ren1_dst, NULL, pair1->two, NULL, 1);
-		update_stages(ren2_dst, NULL, NULL, pair2->two, 1);
+		update_stages(ren1_dst, NULL, pair1->two, NULL);
+		update_stages(ren2_dst, NULL, NULL, pair2->two);
 
 		update_file(o, 0, pair1->two->sha1, pair1->two->mode, dst_name1);
 		update_file(o, 0, pair2->two->sha1, pair2->two->mode, dst_name2);
-- 
1.7.6.100.gac5c1
