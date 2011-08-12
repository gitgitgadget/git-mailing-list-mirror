From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 41/56] merge-recursive: Small cleanups for conflict_rename_rename_1to2
Date: Thu, 11 Aug 2011 23:20:14 -0600
Message-ID: <1313126429-17368-42-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:22:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkCM-0005Kt-CC
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab1HLFWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:07 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab1HLFWG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:06 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3Ebd8U6WSUwAJYdbrrgw3h3sEKevxRYFQPv/A3sEAo8=;
        b=x3ywDBl5bWUDMdK8ndptYvSRgOcRWv9dCMZSUqyTAcu2rEG4a0584GvtZeq3iYqAUC
         kusg1WxFl/yOG2JU5aiV2Zh+zQWJfA2EgJOlm6YYADiksUgVxijitZuExdwATh6ft7H3
         zLCIankvp5fpyTz0bM+SanALO7rGzKBO4W+CM=
Received: by 10.43.132.73 with SMTP id ht9mr590354icc.54.1313126526153;
        Thu, 11 Aug 2011 22:22:06 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.04
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179196>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c |   60 +++++++++++++++++++++++-----------------------------
 1 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 58a6ce3..8b65051 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -966,58 +966,55 @@ static void conflict_rename_delete(struct merge_options *o,
 }
 
 static void conflict_rename_rename_1to2(struct merge_options *o,
-					struct diff_filepair *pair1,
-					const char *branch1,
-					struct diff_filepair *pair2,
-					const char *branch2)
+					struct rename_conflict_info *ci)
 {
 	/* One file was renamed in both branches, but to different names. */
+	struct diff_filespec *one = ci->pair1->one;
+	struct diff_filespec *a = ci->pair1->two;
+	struct diff_filespec *b = ci->pair2->two;
+	const char *dst_name_a = a->path;
+	const char *dst_name_b = b->path;
 	char *del[2];
 	int delp = 0;
-	const char *src      = pair1->one->path;
-	const char *ren1_dst = pair1->two->path;
-	const char *ren2_dst = pair2->two->path;
-	const char *dst_name1 = ren1_dst;
-	const char *dst_name2 = ren2_dst;
 
 	output(o, 1, "CONFLICT (rename/rename): "
 	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
 	       "rename \"%s\"->\"%s\" in \"%s\"%s",
-	       src, pair1->two->path, branch1,
-	       src, pair2->two->path, branch2,
+	       one->path, a->path, ci->branch1,
+	       one->path, b->path, ci->branch2,
 	       o->call_depth ? " (left unresolved)" : "");
-	if (dir_in_way(ren1_dst, !o->call_depth)) {
-		dst_name1 = del[delp++] = unique_path(o, ren1_dst, branch1);
+	if (dir_in_way(a->path, !o->call_depth)) {
+		dst_name_a = del[delp++] = unique_path(o, a->path, ci->branch1);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
-		       ren1_dst, branch2, dst_name1);
+		       a->path, ci->branch2, dst_name_a);
 	}
-	if (dir_in_way(ren2_dst, !o->call_depth)) {
-		dst_name2 = del[delp++] = unique_path(o, ren2_dst, branch2);
+	if (dir_in_way(b->path, !o->call_depth)) {
+		dst_name_b = del[delp++] = unique_path(o, b->path, ci->branch2);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
-		       ren2_dst, branch1, dst_name2);
+		       b->path, ci->branch1, dst_name_b);
 	}
 	if (o->call_depth) {
 		struct merge_file_info mfi;
-		mfi = merge_file(o, src,
-				 pair1->one->sha1, pair1->one->mode,
-				 pair1->two->sha1, pair1->two->mode,
-				 pair2->two->sha1, pair2->two->mode,
-				 branch1, branch2);
+		mfi = merge_file(o, one->path,
+				 one->sha1, one->mode,
+				 a->sha1, a->mode,
+				 b->sha1, b->mode,
+				 ci->branch1, ci->branch2);
 		/*
 		 * FIXME: For rename/add-source conflicts (if we could detect
 		 * such), this is wrong.  We should instead find a unique
 		 * pathname and then either rename the add-source file to that
 		 * unique path, or use that unique path instead of src here.
 		 */
-		update_file(o, 0, mfi.sha, mfi.mode, src);
-		remove_file_from_cache(ren1_dst);
-		remove_file_from_cache(ren2_dst);
+		update_file(o, 0, mfi.sha, mfi.mode, one->path);
+		remove_file_from_cache(a->path);
+		remove_file_from_cache(b->path);
 	} else {
-		update_stages(ren1_dst, NULL, pair1->two, NULL);
-		update_stages(ren2_dst, NULL, NULL, pair2->two);
+		update_stages(a->path, NULL, a, NULL);
+		update_stages(b->path, NULL, NULL, b);
 
-		update_file(o, 0, pair1->two->sha1, pair1->two->mode, dst_name1);
-		update_file(o, 0, pair2->two->sha1, pair2->two->mode, dst_name2);
+		update_file(o, 0, a->sha1, a->mode, dst_name_a);
+		update_file(o, 0, b->sha1, b->mode, dst_name_b);
 	}
 	while (delp--)
 		free(del[delp]);
@@ -1505,10 +1502,7 @@ static int process_entry(struct merge_options *o,
 			break;
 		case RENAME_ONE_FILE_TO_TWO:
 			clean_merge = 0;
-			conflict_rename_rename_1to2(o, conflict_info->pair1,
-						    conflict_info->branch1,
-						    conflict_info->pair2,
-						    conflict_info->branch2);
+			conflict_rename_rename_1to2(o, conflict_info);
 			break;
 		default:
 			entry->processed = 0;
-- 
1.7.6.100.gac5c1
