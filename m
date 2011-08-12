From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 38/56] merge-recursive: Fix modify/delete resolution in the recursive case
Date: Thu, 11 Aug 2011 23:20:11 -0600
Message-ID: <1313126429-17368-39-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:22:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkCL-0005Kt-7y
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab1HLFWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:22:03 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39648 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173Ab1HLFWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:22:00 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so835125iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=V42fpbeYzuUrpSxyNjZr2aGhY3qvtBtATh68RxnXyz8=;
        b=VeXzL9jwgeFSMSU5NdUgql9BHs/aMcNWzi/8s9QY6TQ72eZwZaRSaRStsghcop9tJv
         QdOFp9Ng9r231n/dR5nUNthsDwUxbTtOBe2zAjO5SQc//yDEuI7IN31/GG/huPxTd9+W
         WON4PGauDd3uiJoKwk4O6FoAKirYrOXQd+Yig=
Received: by 10.42.139.6 with SMTP id e6mr508125icu.188.1313126520590;
        Thu, 11 Aug 2011 22:22:00 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.21.58
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:21:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179188>

When o->call_depth>0 and we have conflicts, we try to find "middle ground"
when creating the virtual merge base.  In the case of content conflicts,
this can be done by doing a three-way content merge and using the result.
In all parts where the three-way content merge is clean, it is the correct
middle ground, and in parts where it conflicts there is no middle ground
but the conflict markers provide a good compromise since they are unlikely
to accidentally match any further changes.

In the case of a modify/delete conflict, we cannot do the same thing.
Accepting either endpoint as the resolution for the virtual merge base
runs the risk that when handling the non-recursive case we will silently
accept one person's resolution over another without flagging a conflict.
In this case, the closest "middle ground" we have is actually the merge
base of the candidate merge bases.  (We could alternatively attempt a
three way content merge using an empty file in place of the deleted file,
but that seems to be more work than necessary.)

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 merge-recursive.c                 |   38 +++++++++++++++++++++++-------------
 t/t6036-recursive-corner-cases.sh |    4 +-
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index ccf71d3..a0dc0bf 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1324,27 +1324,42 @@ error_return:
 
 static void handle_delete_modify(struct merge_options *o,
 				 const char *path,
-				 const char *new_path,
+				 unsigned char *o_sha, int o_mode,
 				 unsigned char *a_sha, int a_mode,
 				 unsigned char *b_sha, int b_mode)
 {
-	if (!a_sha) {
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
 		output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
 		       "and modified in %s. Version %s of %s left in tree%s%s.",
 		       path, o->branch1,
 		       o->branch2, o->branch2, path,
-		       NULL == new_path ? "" : " at ",
-		       NULL == new_path ? "" : new_path);
-		update_file(o, 0, b_sha, b_mode, new_path ? new_path : path);
+		       NULL == renamed ? "" : " at ",
+		       NULL == renamed ? "" : renamed);
+		update_file(o, 0, b_sha, b_mode, renamed ? renamed : path);
 	} else {
 		output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
 		       "and modified in %s. Version %s of %s left in tree%s%s.",
 		       path, o->branch2,
 		       o->branch1, o->branch1, path,
-		       NULL == new_path ? "" : " at ",
-		       NULL == new_path ? "" : new_path);
-		update_file(o, 0, a_sha, a_mode, new_path ? new_path : path);
+		       NULL == renamed ? "" : " at ",
+		       NULL == renamed ? "" : renamed);
+		update_file(o, 0, a_sha, a_mode, renamed ? renamed : path);
 	}
+	free(renamed);
+
 }
 
 static int merge_content(struct merge_options *o,
@@ -1514,14 +1529,9 @@ static int process_entry(struct merge_options *o,
 			remove_file(o, 1, path, !a_sha);
 		} else {
 			/* Modify/delete; deleted side may have put a directory in the way */
-			char *renamed = NULL;
 			clean_merge = 0;
-			if (dir_in_way(path, !o->call_depth)) {
-				renamed = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
-			}
-			handle_delete_modify(o, path, renamed,
+			handle_delete_modify(o, path, o_sha, o_mode,
 					     a_sha, a_mode, b_sha, b_mode);
-			free(renamed);
 		}
 	} else if ((!o_sha && a_sha && !b_sha) ||
 		   (!o_sha && !a_sha && b_sha)) {
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index b046e1b..314fdae 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -296,7 +296,7 @@ test_expect_success 'setup criss-cross + modify/delete resolved differently' '
 	git tag E
 '
 
-test_expect_failure 'git detects conflict merging criss-cross+modify/delete' '
+test_expect_success 'git detects conflict merging criss-cross+modify/delete' '
 	git checkout D^0 &&
 
 	test_must_fail git merge -s recursive E^0 &&
@@ -308,7 +308,7 @@ test_expect_failure 'git detects conflict merging criss-cross+modify/delete' '
 	test $(git rev-parse :2:file) = $(git rev-parse B:file)
 '
 
-test_expect_failure 'git detects conflict merging criss-cross+modify/delete, reverse direction' '
+test_expect_success 'git detects conflict merging criss-cross+modify/delete, reverse direction' '
 	git reset --hard &&
 	git checkout E^0 &&
 
-- 
1.7.6.100.gac5c1
