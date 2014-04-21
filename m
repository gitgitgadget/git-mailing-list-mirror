From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RTC/PATCH] Add 'update-branch' hook
Date: Sun, 20 Apr 2014 21:23:36 -0500
Message-ID: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 04:34:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wc43X-00039o-3O
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 04:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbaDUCd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 22:33:59 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:44657 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbaDUCd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 22:33:57 -0400
Received: by mail-yk0-f182.google.com with SMTP id 142so2990538ykq.41
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 19:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=y+ygM1tP+0+grCnwN2jzIhPLBmQo+Jlql4FQLbmVkiA=;
        b=x/irGPJr4r/4heA34ahiKoUrY2jPZOEMlCzDfi1UB/HU6hUtDH2SRuq57oLU8uT0l7
         xYS2WhhsamWrUiDxezIXEMrSmEELx6nZS3P3z0QiHVRKKK+P3FYOhI5NkQrCK3tlo1RH
         LPo9zrCklBmS8GxplBV9kVtWwIDlamUx5XBfJWMSvnyvMh3jNiT8q2I1pw0KPTLyqy87
         1qHAi0ix3Ev2j7hvtbTyj5myueDsxQVHC/Mj3qqa+atOIlg3LjHV9kwFkev/poY1oqap
         lDJzVZm0jaDk3fJUT5nTiefWIpMxSqbyxCcr0w59al53+rycsjnG/Ld+ldrg+PCU3JpS
         1MtQ==
X-Received: by 10.236.86.226 with SMTP id w62mr152921yhe.94.1398047637058;
        Sun, 20 Apr 2014 19:33:57 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id l4sm67083845yhj.24.2014.04.20.19.33.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Apr 2014 19:33:55 -0700 (PDT)
X-Mailer: git-send-email 1.9.2+fc1.1.g5c924db
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246605>

This hook is invoked whenever a branch is updated, either when a branch
is created or updated with 'git branch', or when it's rebased with 'git
rebase'. It receives two parameters; the name of the branch, and the
SHA-1 of the latest commit, additionally, if there was a base commit the
branch was rebased onto, a third parameter contains it.

It can be used to verify the validity of branch names, and also to keep
track of the origin point of a branch, which is otherwise not possible
to find out [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/198587

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/githooks.txt    |  9 +++++++++
 branch.c                      |  6 ++++++
 builtin/clone.c               |  7 +++++--
 git-rebase--interactive.sh    |  6 +++++-
 git-rebase.sh                 |  6 +++++-
 t/t5408-update-branch-hook.sh | 39 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 69 insertions(+), 4 deletions(-)
 create mode 100755 t/t5408-update-branch-hook.sh

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index d954bf6..9e50697 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -381,6 +381,15 @@ rebase::
 The commits are guaranteed to be listed in the order that they were
 processed by rebase.
 
+update-branch
+~~~~~~~~~~~~~
+
+This hook is invoked whenever a branch is updated, either when a branch is
+created or updated with 'git branch', or when it's rebased with 'git rebase'.
+It receives two parameters; the name of the branch, and the SHA-1 of the latest
+commit, additionally, if there was a base commit the branch was rebased onto, a
+third parameter contains it.
+
 
 GIT
 ---
diff --git a/branch.c b/branch.c
index 660097b..c2058d1 100644
--- a/branch.c
+++ b/branch.c
@@ -4,6 +4,7 @@
 #include "refs.h"
 #include "remote.h"
 #include "commit.h"
+#include "run-command.h"
 
 struct tracking {
 	struct refspec spec;
@@ -304,6 +305,11 @@ void create_branch(const char *head,
 	if (real_ref && track)
 		setup_tracking(ref.buf + 11, real_ref, track, quiet);
 
+	if (run_hook_le(NULL, "update-branch", ref.buf + 11, sha1_to_hex(sha1), NULL)) {
+		unlock_ref(lock);
+		die("hook 'update-branch' returned error");
+	}
+
 	if (!dont_change_ref)
 		if (write_ref_sha1(lock, sha1, msg) < 0)
 			die_errno(_("Failed to write ref"));
diff --git a/builtin/clone.c b/builtin/clone.c
index 9b3c04d..6ec96e5 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -581,9 +581,10 @@ static void update_remote_refs(const struct ref *refs,
 	}
 }
 
-static void update_head(const struct ref *our, const struct ref *remote,
+static int update_head(const struct ref *our, const struct ref *remote,
 			const char *msg)
 {
+	int err = 0;
 	if (our && starts_with(our->name, "refs/heads/")) {
 		/* Local default branch link */
 		create_symref("HEAD", our->name, NULL);
@@ -591,6 +592,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 			const char *head = skip_prefix(our->name, "refs/heads/");
 			update_ref(msg, "HEAD", our->old_sha1, NULL, 0, DIE_ON_ERR);
 			install_branch_config(0, head, option_origin, our->name);
+			err = run_hook_le(NULL, "update-branch", head, sha1_to_hex(our->old_sha1), NULL);
 		}
 	} else if (our) {
 		struct commit *c = lookup_commit_reference(our->old_sha1);
@@ -606,6 +608,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
 		update_ref(msg, "HEAD", remote->old_sha1,
 			   NULL, REF_NODEREF, DIE_ON_ERR);
 	}
+	return err;
 }
 
 static int checkout(void)
@@ -987,7 +990,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport, !is_local);
 
-	update_head(our_head_points_at, remote_head, reflog_msg.buf);
+	err = update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
 	transport_unlock_pack(transport);
 	transport_disconnect(transport);
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 1c41cbd..084dc36 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -631,7 +631,11 @@ do_next () {
 		git update-ref -m "$message" $head_name $newhead $orig_head &&
 		git symbolic-ref \
 		  -m "$GIT_REFLOG_ACTION: returning to $head_name" \
-		  HEAD $head_name
+		  HEAD $head_name &&
+		if test -x "$GIT_DIR"/hooks/update-branch; then
+			"$GIT_DIR"/hooks/update-branch $branch_name \
+				$newhead $onto
+		fi
 		;;
 	esac && {
 		test ! -f "$state_dir"/verbose ||
diff --git a/git-rebase.sh b/git-rebase.sh
index 2c75e9f..ededa32 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -149,7 +149,11 @@ move_to_original_branch () {
 			$head_name $(git rev-parse HEAD) $orig_head &&
 		git symbolic-ref \
 			-m "rebase finished: returning to $head_name" \
-			HEAD $head_name ||
+			HEAD $head_name &&
+		if test -x "$GIT_DIR"/hooks/update-branch; then
+			"$GIT_DIR"/hooks/update-branch $branch_name \
+				$(git rev-parse HEAD) $onto
+		fi ||
 		die "$(gettext "Could not move back to $head_name")"
 		;;
 	esac
diff --git a/t/t5408-update-branch-hook.sh b/t/t5408-update-branch-hook.sh
new file mode 100755
index 0000000..d921c0e
--- /dev/null
+++ b/t/t5408-update-branch-hook.sh
@@ -0,0 +1,39 @@
+#!/bin/sh
+
+test_description='Test the update-branch hook'
+
+. ./test-lib.sh
+
+setup () {
+	mkdir -p .git/hooks &&
+	cat > .git/hooks/update-branch <<-'EOF' &&
+	#!/bin/sh
+	echo $@ > .git/update-branch.args
+	EOF
+	chmod +x .git/hooks/update-branch &&
+	echo one > content &&
+	git add content &&
+	git commit -a -m one
+}
+
+setup
+
+test_expect_success 'creating a branch' '
+	git checkout -b test master &&
+	echo two > new &&
+	git add new &&
+	git commit -a -m two
+	echo "test $(git rev-parse master)" > expected &&
+	test_cmp expected .git/update-branch.args
+'
+
+test_expect_success 'doing a rebase' '
+	git checkout -b next master &&
+	echo three > content &&
+	git commit -a -m three &&
+	git rebase --onto next master test &&
+	echo "test $(git rev-parse HEAD) $(git rev-parse next)" > expected &&
+	test_cmp expected .git/update-branch.args
+'
+
+test_done
-- 
1.9.2+fc1.1.g5c924db
