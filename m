Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EC2A1F437
	for <e@80x24.org>; Sat, 28 Jan 2017 20:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752112AbdA1UyH (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jan 2017 15:54:07 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:34920 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbdA1UyE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jan 2017 15:54:04 -0500
Received: from homiemail-a99.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id C1883D5937
        for <git@vger.kernel.org>; Sat, 28 Jan 2017 12:53:46 -0800 (PST)
Received: from homiemail-a99.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a99.g.dreamhost.com (Postfix) with ESMTP id 073AAD3E068
        for <git@vger.kernel.org>; Sat, 28 Jan 2017 12:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=from
        :date:subject:to:content-transfer-encoding:message-id:
        mime-version; s=mattmccutchen.net; bh=p9/95YmXc0pymCQU7dbEj8L+KX
        w=; b=cNLQ01kGxmerbWasdpj/wLMv9Ck5G6450rUf+M5Nfl2AF4b2N//ISRJH34
        KZhA5ouMuHs8gUczGIoeH2J2s4iwhsWLx+GnKWjoM29n4KwzZO2g/kVbHxLsoXXz
        ZDj19iDJZWjCREk+gz2VOKhm7+/6cLhyT9y65XFb+W2pHZ8/s=
Received: from main (c-50-177-20-184.hsd1.ma.comcast.net [50.177.20.184])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a99.g.dreamhost.com (Postfix) with ESMTPSA id A4545D3E067
        for <git@vger.kernel.org>; Sat, 28 Jan 2017 12:52:45 -0800 (PST)
From:   Matt McCutchen <matt@mattmccutchen.net>
Date:   Sat, 28 Jan 2017 15:37:01 -0500
Subject: [PATCH] merge-recursive: make "CONFLICT (rename/delete)" message
 show both paths
To:     git@vger.kernel.org
X-Mailer: Evolution 3.22.4 (3.22.4-2.fc25) 
Content-Transfer-Encoding: 7bit
Message-ID: <1485636764.2482.2.camel@mattmccutchen.net>
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The current message printed by "git merge-recursive" for a rename/delete
conflict is like this:

CONFLICT (rename/delete): new-path deleted in HEAD and renamed in
other-branch. Version other-branch of new-path left in tree.

To be more helpful, the message should show both paths of the rename and
state that the deletion occurred at the old path, not the new path.  So
change the message to the following format:

CONFLICT (rename/delete): old-path deleted in HEAD and renamed to
new-path in other-branch. Version other-branch of new-path left in tree.

Since this doubles the number of cases in handle_change_delete (modify vs.
rename), refactor the code to halve the number of cases again by merging the
cases where o->branch1 has the change and o->branch2 has the delete with the
cases that are the other way around.

Also add a simple test of the new conflict message.

Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
---

This came up at:

https://github.com/cristibalan/braid/issues/41#issuecomment-275826716

Please check that my refactoring is indeed correct!  All the existing tests pass
for me, but the existing test coverage of these conflict messages looks poor.

 merge-recursive.c              | 117 ++++++++++++++++++++++-------------------
 t/t6045-merge-rename-delete.sh |  23 ++++++++
 2 files changed, 86 insertions(+), 54 deletions(-)
 create mode 100755 t/t6045-merge-rename-delete.sh

diff --git a/merge-recursive.c b/merge-recursive.c
index d327209..e8fce10 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1061,16 +1061,20 @@ static int merge_file_one(struct merge_options *o,
 }
 
 static int handle_change_delete(struct merge_options *o,
-				 const char *path,
+				 const char *path, const char *old_path,
 				 const struct object_id *o_oid, int o_mode,
-				 const struct object_id *a_oid, int a_mode,
-				 const struct object_id *b_oid, int b_mode,
+				 const struct object_id *changed_oid,
+				 int changed_mode,
+				 const char *change_branch,
+				 const char *delete_branch,
 				 const char *change, const char *change_past)
 {
-	char *renamed = NULL;
+	char *alt_path = NULL;
+	const char *update_path = path;
 	int ret = 0;
+
 	if (dir_in_way(path, !o->call_depth, 0)) {
-		renamed = unique_path(o, path, a_oid ? o->branch1 : o->branch2);
+		update_path = alt_path = unique_path(o, path, change_branch);
 	}
 
 	if (o->call_depth) {
@@ -1081,43 +1085,43 @@ static int handle_change_delete(struct merge_options *o,
 		 */
 		ret = remove_file_from_cache(path);
 		if (!ret)
-			ret = update_file(o, 0, o_oid, o_mode,
-					  renamed ? renamed : path);
-	} else if (!a_oid) {
-		if (!renamed) {
-			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
-			       "and %s in %s. Version %s of %s left in tree."),
-			       change, path, o->branch1, change_past,
-			       o->branch2, o->branch2, path);
-			ret = update_file(o, 0, b_oid, b_mode, path);
-		} else {
-			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
-			       "and %s in %s. Version %s of %s left in tree at %s."),
-			       change, path, o->branch1, change_past,
-			       o->branch2, o->branch2, path, renamed);
-			ret = update_file(o, 0, b_oid, b_mode, renamed);
-		}
+			ret = update_file(o, 0, o_oid, o_mode, update_path);
 	} else {
-		if (!renamed) {
-			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
-			       "and %s in %s. Version %s of %s left in tree."),
-			       change, path, o->branch2, change_past,
-			       o->branch1, o->branch1, path);
+		if (!alt_path) {
+			if (!old_path) {
+				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
+				       "and %s in %s. Version %s of %s left in tree."),
+				       change, path, delete_branch, change_past,
+				       change_branch, change_branch, path);
+			} else {
+				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
+				       "and %s to %s in %s. Version %s of %s left in tree."),
+				       change, old_path, delete_branch, change_past, path,
+				       change_branch, change_branch, path);
+			}
 		} else {
-			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
-			       "and %s in %s. Version %s of %s left in tree at %s."),
-			       change, path, o->branch2, change_past,
-			       o->branch1, o->branch1, path, renamed);
-			ret = update_file(o, 0, a_oid, a_mode, renamed);
+			if (!old_path) {
+				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
+				       "and %s in %s. Version %s of %s left in tree at %s."),
+				       change, path, delete_branch, change_past,
+				       change_branch, change_branch, path, alt_path);
+			} else {
+				output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
+				       "and %s to %s in %s. Version %s of %s left in tree at %s."),
+				       change, old_path, delete_branch, change_past, path,
+				       change_branch, change_branch, path, alt_path);
+			}
 		}
 		/*
-		 * No need to call update_file() on path when !renamed, since
-		 * that would needlessly touch path.  We could call
-		 * update_file_flags() with update_cache=0 and update_wd=0,
-		 * but that's a no-op.
+		 * No need to call update_file() on path when change_branch ==
+		 * o->branch1 && !alt_path, since that would needlessly touch
+		 * path.  We could call update_file_flags() with update_cache=0
+		 * and update_wd=0, but that's a no-op.
 		 */
+		if (change_branch != o->branch1 || alt_path)
+			ret = update_file(o, 0, changed_oid, changed_mode, update_path);
 	}
-	free(renamed);
+	free(alt_path);
 
 	return ret;
 }
@@ -1125,28 +1129,17 @@ static int handle_change_delete(struct merge_options *o,
 static int conflict_rename_delete(struct merge_options *o,
 				   struct diff_filepair *pair,
 				   const char *rename_branch,
-				   const char *other_branch)
+				   const char *delete_branch)
 {
 	const struct diff_filespec *orig = pair->one;
 	const struct diff_filespec *dest = pair->two;
-	const struct object_id *a_oid = NULL;
-	const struct object_id *b_oid = NULL;
-	int a_mode = 0;
-	int b_mode = 0;
-
-	if (rename_branch == o->branch1) {
-		a_oid = &dest->oid;
-		a_mode = dest->mode;
-	} else {
-		b_oid = &dest->oid;
-		b_mode = dest->mode;
-	}
 
 	if (handle_change_delete(o,
 				 o->call_depth ? orig->path : dest->path,
+				 o->call_depth ? NULL : orig->path,
 				 &orig->oid, orig->mode,
-				 a_oid, a_mode,
-				 b_oid, b_mode,
+				 &dest->oid, dest->mode,
+				 rename_branch, delete_branch,
 				 _("rename"), _("renamed")))
 		return -1;
 
@@ -1665,11 +1658,27 @@ static int handle_modify_delete(struct merge_options *o,
 				 struct object_id *a_oid, int a_mode,
 				 struct object_id *b_oid, int b_mode)
 {
+	const char *modify_branch, *delete_branch;
+	struct object_id *changed_oid;
+	int changed_mode;
+
+	if (a_oid) {
+		modify_branch = o->branch1;
+		delete_branch = o->branch2;
+		changed_oid = a_oid;
+		changed_mode = a_mode;
+	} else {
+		modify_branch = o->branch2;
+		delete_branch = o->branch1;
+		changed_oid = b_oid;
+		changed_mode = b_mode;
+	}
+
 	return handle_change_delete(o,
-				    path,
+				    path, NULL,
 				    o_oid, o_mode,
-				    a_oid, a_mode,
-				    b_oid, b_mode,
+				    changed_oid, changed_mode,
+				    modify_branch, delete_branch,
 				    _("modify"), _("modified"));
 }
 
diff --git a/t/t6045-merge-rename-delete.sh b/t/t6045-merge-rename-delete.sh
new file mode 100755
index 0000000..8f33244
--- /dev/null
+++ b/t/t6045-merge-rename-delete.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+
+test_description='Merge-recursive rename/delete conflict message'
+. ./test-lib.sh
+
+test_expect_success 'rename/delete' '
+echo foo >A &&
+git add A &&
+git commit -m "initial" &&
+
+git checkout -b rename &&
+git mv A B &&
+git commit -m "rename" &&
+
+git checkout master &&
+git rm A &&
+git commit -m "delete" &&
+
+test_must_fail git merge --strategy=recursive rename >output &&
+test_i18ngrep "CONFLICT (rename/delete): A deleted in HEAD and renamed to B in rename. Version rename of B left in tree." output
+'
+
+test_done
-- 
2.9.3


