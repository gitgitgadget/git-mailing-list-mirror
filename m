From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 37/48] merge-recursive: Fix modify/delete resolution in the recursive case
Date: Wed,  8 Jun 2011 01:31:07 -0600
Message-ID: <1307518278-23814-38-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:31:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDEq-0006q0-0u
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733Ab1FHHbH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:31:07 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35036 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862Ab1FHHaK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:30:10 -0400
Received: by mail-pw0-f46.google.com with SMTP id 15so118980pwi.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=EK4wp3ujqT2bBrJZUDnK2zIMLIZ7kBtpDVQmYW8ijtQ=;
        b=j3yPnUC434qOvzeiGCVX5vgKVZV6fT6iCT0y4+/gv/CbMm0UJGHU+lCS1ATfs8HdWr
         AQ4b4XAYRU8SR5Nt4IXVh0G+SC7ahWBmirUff9v2llmmwpzp8XwqmcNq/2u4JOgZwi0I
         1bpHQjuUFl/isC1bgf+oYnJpfQv0UopbeM0lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Wj+fzQ62RA+JfAEcLitgFUeEeK2mI6b2hpTcMeqE5437ka0vftd/fYTpHE1Pof2RJX
         vP7/z7sFZgUzNm0amBZuW9H3NIK32ugN2yeTeW6YObKVMgl6k2u+xAmDwDOMit5Vmpn4
         IOuuxjat7VGNB+ZDfT7nu+c5Nh1ZDH+4tXjDk=
Received: by 10.68.1.137 with SMTP id 9mr590551pbm.475.1307518210387;
        Wed, 08 Jun 2011 00:30:10 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.30.08
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:30:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175336>

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
---
 merge-recursive.c                 |   32 +++++++++++++++++++++-----------
 t/t6036-recursive-corner-cases.sh |    4 ++--
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index da507a3..5a70a87 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1309,11 +1309,26 @@ error_return:
 
 static void handle_delete_modify(struct merge_options *o,
 				 const char *path,
-				 const char *new_path,
+				 unsigned char *o_sha, int o_mode,
 				 unsigned char *a_sha, int a_mode,
 				 unsigned char *b_sha, int b_mode)
 {
-	if (!a_sha) {
+	char *new_path = NULL;
+	int free_me = 0;
+	if (dir_in_way(path, !o->call_depth)) {
+		new_path = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
+		free_me = 1;
+	}
+
+	if (o->call_depth) {
+		/*
+		 * We cannot arbitrarily accept either a_sha or b_sha as
+		 * correct; since there is no true "middle point" between
+		 * them, simply reuse the base version for virtual merge base.
+		 */
+		remove_file_from_cache(path);
+		update_file(o, 0, o_sha, o_mode, new_path ? new_path : path);
+	} else if (!a_sha) {
 		output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
 		       "and modified in %s. Version %s of %s left in tree%s%s.",
 		       path, o->branch1,
@@ -1330,6 +1345,9 @@ static void handle_delete_modify(struct merge_options *o,
 		       NULL == new_path ? "" : new_path);
 		update_file(o, 0, a_sha, a_mode, new_path ? new_path : path);
 	}
+	if (free_me)
+		free(new_path);
+
 }
 
 static int merge_content(struct merge_options *o,
@@ -1482,17 +1500,9 @@ static int process_entry(struct merge_options *o,
 			remove_file(o, 1, path, !a_sha);
 		} else {
 			/* Modify/delete; deleted side may have put a directory in the way */
-			char *new_path = NULL;
-			int free_me = 0;
 			clean_merge = 0;
-			if (dir_in_way(path, !o->call_depth)) {
-				new_path = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
-				free_me = 1;
-			}
-			handle_delete_modify(o, path, new_path,
+			handle_delete_modify(o, path, o_sha, o_mode,
 					     a_sha, a_mode, b_sha, b_mode);
-			if (free_me)
-				free(new_path);
 		}
 	} else if ((!o_sha && a_sha && !b_sha) ||
 		   (!o_sha && !a_sha && b_sha)) {
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 8d1d303..d27477b 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -290,7 +290,7 @@ test_expect_success 'setup criss-cross + modify/delete resolved differently' '
 	git tag E
 '
 
-test_expect_failure 'git detects conflict merging criss-cross+modify/delete' '
+test_expect_success 'git detects conflict merging criss-cross+modify/delete' '
 	git checkout D^0 &&
 
 	test_must_fail git merge -s recursive E^0 &&
@@ -302,7 +302,7 @@ test_expect_failure 'git detects conflict merging criss-cross+modify/delete' '
 	test $(git rev-parse :2:file) = $(git rev-parse B:file)
 '
 
-test_expect_failure 'git detects conflict merging criss-cross+modify/delete, reverse direction' '
+test_expect_success 'git detects conflict merging criss-cross+modify/delete, reverse direction' '
 	git reset --hard &&
 	git checkout E^0 &&
 
-- 
1.7.6.rc0.62.g2d69f
