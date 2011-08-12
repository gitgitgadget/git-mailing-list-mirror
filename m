From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 46/56] merge-recursive: Make modify/delete handling code reusable
Date: Thu, 11 Aug 2011 23:20:19 -0600
Message-ID: <1313126429-17368-47-git-send-email-newren@gmail.com>
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
	id 1QrkCP-0005Kt-6B
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:22:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391Ab1HLFWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:18 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:37921 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355Ab1HLFWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:16 -0400
Received: by iye16 with SMTP id 16so837450iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MY0dmCfJDIO3yQn0GZBTRdpynwhhWiwpOIh28Eo03F4=;
        b=DeErT9+kfhiPNOh/AA53m1tGlXfVRhAgsgRn8eTadeB621Y4NB55aCAe6cYhrq/oeP
         kRRb2EaXWO37/OIWjREeidc+r4N1H8QIgnbBZ1agZOdC2qL0A7eUj9jYE7ZxFvIg8UDS
         y0GeGbDyCZoZDKig5m/skTJthd4Ax7kdtDJVY=
Received: by 10.231.35.13 with SMTP id n13mr1082808ibd.57.1313126535563;
        Thu, 11 Aug 2011 22:22:15 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.22.13
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:22:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179195>

modify/delete and rename/delete share a lot of similarities; we'd like all
the criss-cross and D/F conflict handling specializations to be shared
between the two.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c       |   82 +++++++++++++++++++++++++++-------------------
 t/t6022-merge-rename.sh |    4 +-
 2 files changed, 50 insertions(+), 36 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c305857..17fe7c3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -994,6 +994,46 @@ static struct merge_file_info merge_file(struct merge_options *o,
 	return merge_file_1(o, &one, &a, &b, branch1, branch2);
 }
 
+static void handle_change_delete(struct merge_options *o,
+				 const char *path,
+				 const unsigned char *o_sha, int o_mode,
+				 const unsigned char *a_sha, int a_mode,
+				 const unsigned char *b_sha, int b_mode,
+				 const char *change, const char *change_past)
+{
+	char *renamed = NULL;
+	if (dir_in_way(path, !o->call_depth)) {
+		renamed = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
+	}
+
+	if (o->call_depth) {
+		/*
+		 * We cannot arbitrarily accept either a_sha or b_sha as
+		 * correct; since there is no true "middle point" between
+		 * them, simply reuse the base version for virtual merge base.
+		 */
+		remove_file_from_cache(path);
+		update_file(o, 0, o_sha, o_mode, renamed ? renamed : path);
+	} else if (!a_sha) {
+		output(o, 1, "CONFLICT (%s/delete): %s deleted in %s "
+		       "and %s in %s. Version %s of %s left in tree%s%s.",
+		       change, path, o->branch1,
+		       change_past, o->branch2, o->branch2, path,
+		       NULL == renamed ? "" : " at ",
+		       NULL == renamed ? "" : renamed);
+		update_file(o, 0, b_sha, b_mode, renamed ? renamed : path);
+	} else {
+		output(o, 1, "CONFLICT (%s/delete): %s deleted in %s "
+		       "and %s in %s. Version %s of %s left in tree%s%s.",
+		       change, path, o->branch2,
+		       change_past, o->branch1, o->branch1, path,
+		       NULL == renamed ? "" : " at ",
+		       NULL == renamed ? "" : renamed);
+		update_file(o, 0, a_sha, a_mode, renamed ? renamed : path);
+	}
+	free(renamed);
+}
+
 static void conflict_rename_delete(struct merge_options *o,
 				   struct diff_filepair *pair,
 				   const char *rename_branch,
@@ -1411,44 +1451,18 @@ error_return:
 	return ret;
 }
 
-static void handle_delete_modify(struct merge_options *o,
+static void handle_modify_delete(struct merge_options *o,
 				 const char *path,
 				 unsigned char *o_sha, int o_mode,
 				 unsigned char *a_sha, int a_mode,
 				 unsigned char *b_sha, int b_mode)
 {
-	char *renamed = NULL;
-	if (dir_in_way(path, !o->call_depth)) {
-		renamed = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
-	}
-
-	if (o->call_depth) {
-		/*
-		 * We cannot arbitrarily accept either a_sha or b_sha as
-		 * correct; since there is no true "middle point" between
-		 * them, simply reuse the base version for virtual merge base.
-		 */
-		remove_file_from_cache(path);
-		update_file(o, 0, o_sha, o_mode, renamed ? renamed : path);
-	} else if (!a_sha) {
-		output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
-		       "and modified in %s. Version %s of %s left in tree%s%s.",
-		       path, o->branch1,
-		       o->branch2, o->branch2, path,
-		       NULL == renamed ? "" : " at ",
-		       NULL == renamed ? "" : renamed);
-		update_file(o, 0, b_sha, b_mode, renamed ? renamed : path);
-	} else {
-		output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
-		       "and modified in %s. Version %s of %s left in tree%s%s.",
-		       path, o->branch2,
-		       o->branch1, o->branch1, path,
-		       NULL == renamed ? "" : " at ",
-		       NULL == renamed ? "" : renamed);
-		update_file(o, 0, a_sha, a_mode, renamed ? renamed : path);
-	}
-	free(renamed);
-
+	handle_change_delete(o,
+			     path,
+			     o_sha, o_mode,
+			     a_sha, a_mode,
+			     b_sha, b_mode,
+			     "modify", "modified");
 }
 
 static int merge_content(struct merge_options *o,
@@ -1614,7 +1628,7 @@ static int process_entry(struct merge_options *o,
 		} else {
 			/* Modify/delete; deleted side may have put a directory in the way */
 			clean_merge = 0;
-			handle_delete_modify(o, path, o_sha, o_mode,
+			handle_modify_delete(o, path, o_sha, o_mode,
 					     a_sha, a_mode, b_sha, b_mode);
 		}
 	} else if ((!o_sha && a_sha && !b_sha) ||
diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index d96d3c5..74dcf20 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -303,7 +303,7 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 	git checkout -q renamed-file-has-no-conflicts^0 &&
 	test_must_fail git merge --strategy=recursive dir-in-way >output &&
 
-	grep "CONFLICT (delete/modify): dir/file-in-the-way" output &&
+	grep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
 	grep "Auto-merging dir" output &&
 	grep "Adding as dir~HEAD instead" output &&
 
@@ -325,7 +325,7 @@ test_expect_success 'Same as previous, but merged other way' '
 	test_must_fail git merge --strategy=recursive renamed-file-has-no-conflicts >output 2>errors &&
 
 	! grep "error: refusing to lose untracked file at" errors &&
-	grep "CONFLICT (delete/modify): dir/file-in-the-way" output &&
+	grep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
 	grep "Auto-merging dir" output &&
 	grep "Adding as dir~renamed-file-has-no-conflicts instead" output &&
 
-- 
1.7.6.100.gac5c1
