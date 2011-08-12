From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 40/56] merge-recursive: Fix rename/rename(1to2) resolution for virtual merge base
Date: Thu, 11 Aug 2011 23:20:13 -0600
Message-ID: <1313126429-17368-41-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:22:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkCM-0005Kt-UL
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273Ab1HLFWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:09 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59382 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116Ab1HLFWE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:04 -0400
Received: by ywf7 with SMTP id 7so1759031ywf.19
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=WZiGlzz1JclYBee+C41fEp0KAESvbx9lj/jGIMUc0oM=;
        b=wYy5IdvWSJYlG07SxdHqzuiWm+kjyT8IVfZhUJC6LJOVIArTcVCAdwGD5Suykmvjs4
         PzlOrRPc5mcsaz/0YxWhLVaTnuddN2fJLW8ogyKuUeg+gwzdvlPbvsScMSApB0iwEmQV
         8+/uKLo1Jq17O2TzHsBOcNxKGW2bp4e+Xebl4=
Received: by 10.42.245.3 with SMTP id ls3mr504648icb.70.1313126524305;
        Thu, 11 Aug 2011 22:22:04 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.02
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179190>

When renaming one file to two files, we really should be doing a content
merge.  Also, in the recursive case, undoing the renames and recording the
merged file in the index with the source of the rename (while deleting
both destinations) allows the renames to be re-detected in the
non-recursive merge and will result in fewer spurious conflicts.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c                 |   30 +++++++++++++-----------------
 t/t6036-recursive-corner-cases.sh |    2 +-
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 76a451c..58a6ce3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -986,17 +986,6 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 	       src, pair1->two->path, branch1,
 	       src, pair2->two->path, branch2,
 	       o->call_depth ? " (left unresolved)" : "");
-	if (o->call_depth) {
-		/*
-		 * FIXME: Why remove file from cache, and then
-		 * immediately readd it?  Why not just overwrite using
-		 * update_file only?  Also...this is buggy for
-		 * rename/add-source situations...
-		 */
-		remove_file_from_cache(src);
-		update_file(o, 0, pair1->one->sha1, pair1->one->mode, src);
-	}
-
 	if (dir_in_way(ren1_dst, !o->call_depth)) {
 		dst_name1 = del[delp++] = unique_path(o, ren1_dst, branch1);
 		output(o, 1, "%s is a directory in %s adding as %s instead",
@@ -1008,14 +997,21 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		       ren2_dst, branch1, dst_name2);
 	}
 	if (o->call_depth) {
-		remove_file_from_cache(dst_name1);
-		remove_file_from_cache(dst_name2);
+		struct merge_file_info mfi;
+		mfi = merge_file(o, src,
+				 pair1->one->sha1, pair1->one->mode,
+				 pair1->two->sha1, pair1->two->mode,
+				 pair2->two->sha1, pair2->two->mode,
+				 branch1, branch2);
 		/*
-		 * Uncomment to leave the conflicting names in the resulting tree
-		 *
-		 * update_file(o, 0, pair1->two->sha1, pair1->two->mode, dst_name1);
-		 * update_file(o, 0, pair2->two->sha1, pair2->two->mode, dst_name2);
+		 * FIXME: For rename/add-source conflicts (if we could detect
+		 * such), this is wrong.  We should instead find a unique
+		 * pathname and then either rename the add-source file to that
+		 * unique path, or use that unique path instead of src here.
 		 */
+		update_file(o, 0, mfi.sha, mfi.mode, src);
+		remove_file_from_cache(ren1_dst);
+		remove_file_from_cache(ren2_dst);
 	} else {
 		update_stages(ren1_dst, NULL, pair1->two, NULL);
 		update_stages(ren2_dst, NULL, NULL, pair2->two);
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 314fdae..5a7af0c 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -633,7 +633,7 @@ test_expect_success 'setup rename/rename(1to2)/modify followed by what looks lik
 	git tag E
 '
 
-test_expect_failure 'handle rename/rename(1to2)/modify followed by what looks like rename/rename(2to1)/modify' '
+test_expect_success 'handle rename/rename(1to2)/modify followed by what looks like rename/rename(2to1)/modify' '
 	git checkout D^0 &&
 
 	git merge -s recursive E^0 &&
-- 
1.7.6.100.gac5c1
