From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH v2 3/3] Add 'update-branch' hook
Date: Wed, 23 Apr 2014 14:42:40 -0500
Message-ID: <1398282160-26151-4-git-send-email-felipe.contreras@gmail.com>
References: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:53:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3EX-0006he-4c
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 21:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757883AbaDWTxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 15:53:22 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:45377 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757622AbaDWTxS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 15:53:18 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so1572733obc.24
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZAdunfFBr1wgRpJQl5uMBeFK1UjS17tTY4k0gMQ6lYQ=;
        b=VAB8pUJt38rEcQT75CFNu9TAo9n2osychgP6WfucT8T83dDMFXLPX0fS8ZaCk3SsZG
         5/G5RCabG4ofzAIEySqeByRylB86wjIJ9P2lGxzx+CcG1NUuoJQRfUz+Bvn0+4vWV05G
         pcKUk5CTOI13ccxUYF++yjQUpM9JQCwd/YktWOpDI+UlwvhYN6/4OSVtX4xyROaVarHu
         e4DrRIHFJhWFkCZ/5MAJNunUEDj8+zipPgkq+u8BC8pXvB3r1exL8hir5qZtLQbI80i9
         H59Otg23b/LctfSr2kEzc9W8Ed5b0bQaHEcfShvQkS1+limlZLlEje4i5o+Zktgm1rZl
         6Amg==
X-Received: by 10.60.131.172 with SMTP id on12mr44457742oeb.18.1398282798170;
        Wed, 23 Apr 2014 12:53:18 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id tz6sm3687489obc.10.2014.04.23.12.53.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Apr 2014 12:53:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
In-Reply-To: <1398282160-26151-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246878>

This hook is invoked before a branch is updated, either when a branch is
created or updated with 'git branch', or when it's rebased with 'git
rebase'.  It receives three parameters; the name of the branch, the
SHA-1 of the latest commit, and the SHA-1 of the first commit of the
branch.

When a branch is created the first and last commits of the branch are
the same, however when a branch is rebased they are not. If the SHA-1 of
the first commit of the branch is not available (e.g. git reset) a null
SHA-1 (40 zeroes) would be passed.

The hook exit status can be used to deny the branch update.

It can be used to verify the validity of branch names, and also to keep
track of the origin point of a branch, which is otherwise not possible
to find out [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/198587

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/githooks.txt    | 15 +++++++++
 branch.c                      | 12 ++++++-
 builtin/clone.c               |  8 +++--
 builtin/reset.c               |  5 +++
 git-rebase--interactive.sh    |  4 +++
 git-rebase.sh                 |  4 +++
 t/t5408-update-branch-hook.sh | 76 +++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 121 insertions(+), 3 deletions(-)
 create mode 100755 t/t5408-update-branch-hook.sh

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d954bf6..4a44262 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -381,6 +381,21 @@ rebase::
 The commits are guaranteed to be listed in the order that they were
 processed by rebase.
 
+update-branch
+~~~~~~~~~~~~~
+
+This hook is invoked before a branch is updated, either when a branch is
+created or updated with 'git branch', or when it's rebased with 'git rebase'.
+It receives three parameters; the name of the branch, the SHA-1 of the latest
+commit, and the SHA-1 of the first commit of the branch.
+
+When a branch is created the first and last commits of the branch are the same,
+however when a branch is rebased they are not. If the SHA-1 of the first
+commit of the branch is not available (e.g. git reset) a null SHA-1 (40 zeroes)
+would be passed.
+
+The hook exit status can be used to deny the branch update.
+
 
 GIT
 ---
diff --git a/branch.c b/branch.c
index 660097b..7ec0be5 100644
--- a/branch.c
+++ b/branch.c
@@ -4,6 +4,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "commit.h"
+#include "run-command.h"
 
 struct tracking {
 	struct refspec spec;
@@ -234,6 +235,7 @@ void create_branch(const char *head,
 	int forcing = 0;
 	int dont_change_ref = 0;
 	int explicit_tracking = 0;
+	unsigned const char *orig_sha1;
 
 	if (track == BRANCH_TRACK_EXPLICIT || track == BRANCH_TRACK_OVERRIDE)
 		explicit_tracking = 1;
@@ -304,9 +306,17 @@ void create_branch(const char *head,
 	if (real_ref && track)
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
-	if (!dont_change_ref)
+	if (!dont_change_ref) {
+		orig_sha1 = forcing ? null_sha1 : sha1;
+		if (run_hook_le(NULL, "update-branch", ref.buf + 11,
+					sha1_to_hex(sha1), sha1_to_hex(orig_sha1), NULL)) {
+			unlock_ref(lock);
+			die("hook 'update-branch' returned error");
+		}
+
 		if (write_ref_sha1(lock, sha1, msg) < 0)
 			die_errno(_("Failed to write ref"));
+	}
 
 	strbuf_release(&ref);
 	free(real_ref);
diff --git a/builtin/clone.c b/builtin/clone.c
index 9b3c04d..d68c49b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -581,7 +581,7 @@ static void update_remote_refs(const struct ref *refs,
 	}
 }
 
-static void update_head(const struct ref *our, const struct ref *remote,
+static int update_head(const struct ref *our, const struct ref *remote,
 			const char *msg)
 {
 	if (our && starts_with(our->name, "refs/heads/")) {
@@ -589,6 +589,9 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		create_symref("HEAD", our->name, NULL);
 		if (!option_bare) {
 			const char *head = skip_prefix(our->name, "refs/heads/");
+			if (run_hook_le(NULL, "update-branch", head,
+						sha1_to_hex(our->old_sha1), sha1_to_hex(our->old_sha1), NULL))
+				return 1;
 			update_ref(msg, "HEAD", our->old_sha1, NULL, 0, DIE_ON_ERR);
 			install_branch_config(0, head, option_origin, our->name);
 		}
@@ -606,6 +609,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		update_ref(msg, "HEAD", remote->old_sha1,
 			   NULL, REF_NODEREF, DIE_ON_ERR);
 	}
+	return 0;
 }
 
 static int checkout(void)
@@ -987,7 +991,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport, !is_local);
 
-	update_head(our_head_points_at, remote_head, reflog_msg.buf);
+	err = update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
 	transport_unlock_pack(transport);
 	transport_disconnect(transport);
diff --git a/builtin/reset.c b/builtin/reset.c
index f4e0875..9d8cc1f 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -246,11 +246,16 @@ static int reset_refs(const char *rev, const unsigned char *sha1)
 	struct strbuf msg = STRBUF_INIT;
 	unsigned char *orig = NULL, sha1_orig[20],
 		*old_orig = NULL, sha1_old_orig[20];
+	const char *head;
 
 	if (!get_sha1("ORIG_HEAD", sha1_old_orig))
 		old_orig = sha1_old_orig;
 	if (!get_sha1("HEAD", sha1_orig)) {
 		orig = sha1_orig;
+		head = resolve_ref_unsafe("HEAD", sha1_orig, 1, NULL);
+		if (run_hook_le(NULL, "update-branch", skip_prefix(head, "refs/heads/"),
+					sha1_to_hex(sha1), sha1_to_hex(null_sha1), NULL))
+			return 1;
 		set_reflog_message(&msg, "updating ORIG_HEAD", NULL);
 		update_ref(msg.buf, "ORIG_HEAD", orig, old_orig, 0, MSG_ON_ERR);
 	} else if (old_orig)
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1c41cbd..1bedb27 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -628,6 +628,10 @@ do_next () {
 	case $head_name in
 	refs/*)
 		message="$GIT_REFLOG_ACTION: $head_name onto $onto" &&
+		if test -x "$GIT_DIR"/hooks/update-branch; then
+			"$GIT_DIR"/hooks/update-branch $branch_name \
+				$newhead $onto
+		fi &&
 		git update-ref -m "$message" $head_name $newhead $orig_head &&
 		git symbolic-ref \
 		  -m "$GIT_REFLOG_ACTION: returning to $head_name" \
diff --git a/git-rebase.sh b/git-rebase.sh
index 2c75e9f..3ede5be 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -145,6 +145,10 @@ move_to_original_branch () {
 	case "$head_name" in
 	refs/*)
 		message="rebase finished: $head_name onto $onto"
+		if test -x "$GIT_DIR"/hooks/update-branch; then
+			"$GIT_DIR"/hooks/update-branch $branch_name \
+				$(git rev-parse HEAD) $onto
+		fi &&
 		git update-ref -m "$message" \
 			$head_name $(git rev-parse HEAD) $orig_head &&
 		git symbolic-ref \
diff --git a/t/t5408-update-branch-hook.sh b/t/t5408-update-branch-hook.sh
new file mode 100755
index 0000000..8a05aa2
--- /dev/null
+++ b/t/t5408-update-branch-hook.sh
@@ -0,0 +1,76 @@
+#!/bin/sh
+
+test_description='Test the update-branch hook'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	mkdir -p .git/hooks &&
+	cat > .git/hooks/update-branch <<-\EOF &&
+	#!/bin/sh
+	echo $@ > "$GIT_DIR"/update-branch.out
+	EOF
+	chmod +x .git/hooks/update-branch &&
+	echo one > content &&
+	git add content &&
+	git commit -a -m one &&
+	echo two > content &&
+	git commit -a -m two
+'
+
+test_expect_success 'creating a branch' '
+	test_when_finished "rm -f .git/update-branch.out" &&
+	git branch new master &&
+	echo "new $(git rev-parse master) $(git rev-parse master)" > expected &&
+	test_cmp expected .git/update-branch.out
+'
+
+test_expect_success 'creating a branch with checkout' '
+	test_when_finished "rm -f .git/update-branch.out" &&
+	git checkout -b test master &&
+	echo three > content &&
+	git commit -a -m three &&
+	echo "test $(git rev-parse master) $(git rev-parse master)" > expected &&
+	test_cmp expected .git/update-branch.out
+'
+
+test_expect_success 'reseting a branch' '
+	test_when_finished "rm -f .git/update-branch.out" &&
+	git branch --force new master &&
+	echo "new $(git rev-parse master) 0000000000000000000000000000000000000000" > expected &&
+	test_cmp expected .git/update-branch.out
+'
+
+test_expect_success 'reseting a branch with reset' '
+	test_when_finished "rm -f .git/update-branch.out" &&
+	git checkout test &&
+	git reset --hard master &&
+	echo "test $(git rev-parse master) 0000000000000000000000000000000000000000" > expected &&
+	test_cmp expected .git/update-branch.out
+'
+
+test_expect_success 'cloning' '
+	test_when_finished "rm -f .git/update-branch.out" &&
+	mkdir -p templates/hooks &&
+	cat > templates/hooks/update-branch <<-\EOF &&
+	#!/bin/sh
+	echo $@ > "$GIT_DIR"/update-branch.out
+	EOF
+	chmod +x templates/hooks/update-branch &&
+	git clone --template=templates . clone &&
+	echo "test $(git rev-parse test) $(git rev-parse test)" > expected &&
+	test_cmp expected clone/.git/update-branch.out
+'
+
+test_expect_success 'doing a rebase' '
+	test_when_finished "rm -f .git/update-branch.out" &&
+	git checkout -b next master &&
+	echo three > content &&
+	git commit -a -m three &&
+	git branch test-old test &
+	git rebase -f --onto next master test &&
+	echo "test $(git rev-parse HEAD) $(git rev-parse next)" > expected &&
+	test_cmp expected .git/update-branch.out
+'
+
+test_done
-- 
1.9.2+fc1.1.g5c924db
