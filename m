From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v2 06/23] commit: allow disabling pre-commit and commit-msg separately
Date: Thu,  7 Aug 2014 01:59:13 +0200
Message-ID: <7b3f91d5d079de10aebedcf6d6e7f43c0e7f1fce.1407368621.git.bafain@gmail.com>
References: <53A258D2.7080806@gmail.com> <cover.1407368621.git.bafain@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 02:00:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB8P-0003kY-6W
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 02:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbaHGAAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 20:00:37 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:37508 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754283AbaHGAAf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 20:00:35 -0400
Received: by mail-qa0-f53.google.com with SMTP id v10so3327478qac.12
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 17:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J8RpPD4nI6qf4dLelv/PjoiNsPoyaycG36HpnfPSoRQ=;
        b=A5xtnVh/UrX/wQ05lMFQrVjbdlT95cTvvLyjfK6DPzU1KQ7TUzVbG5fZVHgw87aj51
         i0lp6wxbOWnq5txblVS0fkGa/1D4KjaxfqWPyEYX1ZxkA+Nw4jRTYZAQq8ozYP1Uqejl
         vRpfnmpQUb2SFrKsnitbe4ajsKWAjYe/GoPA+yCJlZPGrWdGPZr2OMgKtTcTp/mT9Tec
         zv9kcJ8npbwmsFq/RJhCZne6huhE4uc9rUswFNbQXJqf9MhEHrbiBAFIL0Wfmt43v3Xj
         eJHbQ/m+a/ZreFzIKmsYdmSNofM6udxOCdlnnj0wt7gfgtFeNLE2+mgDC8vO2Yq6GebU
         dyJA==
X-Received: by 10.224.172.129 with SMTP id l1mr21997162qaz.90.1407369634851;
        Wed, 06 Aug 2014 17:00:34 -0700 (PDT)
Received: from puffy.localdomain (HSI-KBW-046-005-203-106.hsi8.kabel-badenwuerttemberg.de. [46.5.203.106])
        by mx.google.com with ESMTPSA id n74sm2637391qga.34.2014.08.06.17.00.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Aug 2014 17:00:34 -0700 (PDT)
X-Mailer: git-send-email 2.0.1
In-Reply-To: <cover.1407368621.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254922>

Introduce the git-commit command line options `--no-pre-commit` and
`--no-commit-msg` to disable the pre-commit and commit-msg hooks,
respectively. Make `--no-verify` a synonym for specifying both at the
same time.

This change is motivated by an internal usage of git-commit in
git-rebase--interactive to disable pre-commit while keeping
commit-msg enabled when rewording a commit.

Make `test_commit` forward unknown options to git-commit instead of
teaching it all possible options. In order to support leading double
dashes in `<message>`, stop interpreting `test_commit` arguments
following a `--` argument as options. This wasn't a problem before
because the first unknown option would be used as `<message>`.

Allow disabling tag creation to avoid name clashes when using
`test_commit` with the same arguments several times from the same
test suite. By default, `test_commit` tags successful commits using
git-tag for easy reference. The `--notag` option skips this step.

Add tests.

Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 Documentation/git-commit.txt |  8 ++++-
 builtin/commit.c             | 32 ++++++++++++++---
 t/t7503-pre-commit-hook.sh   | 65 ++++++++++++++++++++++++++++-----
 t/t7504-commit-msg-hook.sh   | 85 ++++++++++++++++++++++++++++++++++----------
 t/test-lib-functions.sh      | 23 ++++++++----
 5 files changed, 176 insertions(+), 37 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 0bbc8f5..28a2c5c 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -158,7 +158,7 @@ OPTIONS
 
 -n::
 --no-verify::
-	This option bypasses the pre-commit and commit-msg hooks.
+	A synonym for `--no-pre-commit --no-commit-msg`.
 	See also linkgit:githooks[5].
 
 --allow-empty::
@@ -238,6 +238,12 @@ You should understand the implications of rewriting history if you
 amend a commit that has already been published.  (See the "RECOVERING
 FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 
+--no-pre-commit::
+	This option bypasses the pre-commit hook.
+
+--no-commit-msg::
+	This option bypasses the commit-msg hook.
+
 --no-post-rewrite::
 	Bypass the post-rewrite hook.
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 5ed6036..dfd354e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -98,12 +98,27 @@ static char *edit_message, *use_message;
 static char *fixup_message, *squash_message;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
-static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
+static int quiet, verbose, allow_empty, dry_run, renew_authorship;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg;
 static char *sign_commit;
 
 /*
+ * The verify variable is interpreted as a bitmap of enabled commit
+ * verification hooks according to the legend below.
+ *
+ * By default, the pre-commit and commit-msg hooks are enabled. This
+ * is represented by both the PRE_COMMIT and COMMIT_MSG bits being
+ * set.
+ *
+ * The bitmap is changed through the command line options
+ * --no-verify, --no-pre-commit and --no-commit-msg.
+ */
+#define PRE_COMMIT (1<<0)
+#define COMMIT_MSG (1<<1)
+static int verify = PRE_COMMIT | COMMIT_MSG;
+
+/*
  * The default commit message cleanup mode will remove the lines
  * beginning with # (shell comments) and leading and trailing
  * whitespaces (empty lines or containing only whitespaces)
@@ -661,7 +676,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
+	if (verify & PRE_COMMIT &&
+	    run_commit_hook(use_editor, index_file, "pre-commit", NULL))
 		return 0;
 
 	if (squash_message) {
@@ -962,7 +978,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		}
 	}
 
-	if (!no_verify &&
+	if (verify & COMMIT_MSG &&
 	    run_commit_hook(use_editor, index_file, "commit-msg", git_path(commit_editmsg), NULL)) {
 		return 0;
 	}
@@ -1590,7 +1606,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "interactive", &interactive, N_("interactively add files")),
 		OPT_BOOL('p', "patch", &patch_interactive, N_("interactively add changes")),
 		OPT_BOOL('o', "only", &only, N_("commit only specified files")),
-		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit hook")),
+		OPT_NEGBIT('n', "no-verify", &verify,
+			   N_("synonym for --no-pre-commit --no-commit-msg"),
+			   PRE_COMMIT | COMMIT_MSG),
 		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be committed")),
 		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
 			    STATUS_FORMAT_SHORT),
@@ -1603,6 +1621,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('z', "null", &s.null_termination,
 			 N_("terminate entries with NUL")),
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
+		OPT_NEGBIT(0, "no-pre-commit", &verify,
+			   N_("bypass pre-commit hook"),
+			   PRE_COMMIT),
+		OPT_NEGBIT(0, "no-commit-msg", &verify,
+			   N_("bypass commit-msg hook"),
+			   COMMIT_MSG),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		/* end commit contents options */
diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index 984889b..db5de1c 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -12,11 +12,11 @@ test_expect_success 'with no hook' '
 
 '
 
-test_expect_success '--no-verify with no hook' '
+test_expect_success '--no-pre-commit with no hook' '
 
 	echo "bar" > file &&
 	git add file &&
-	git commit --no-verify -m "bar"
+	git commit --no-pre-commit -m "bar"
 
 '
 
@@ -38,11 +38,11 @@ test_expect_success 'with succeeding hook' '
 
 '
 
-test_expect_success '--no-verify with succeeding hook' '
+test_expect_success '--no-pre-commit with succeeding hook' '
 
 	echo "even more" >> file &&
 	git add file &&
-	git commit --no-verify -m "even more"
+	git commit --no-pre-commit -m "even more"
 
 '
 
@@ -60,11 +60,11 @@ test_expect_success 'with failing hook' '
 
 '
 
-test_expect_success '--no-verify with failing hook' '
+test_expect_success '--no-pre-commit with failing hook' '
 
 	echo "stuff" >> file &&
 	git add file &&
-	git commit --no-verify -m "stuff"
+	git commit --no-pre-commit -m "stuff"
 
 '
 
@@ -77,15 +77,64 @@ test_expect_success POSIXPERM 'with non-executable hook' '
 
 '
 
-test_expect_success POSIXPERM '--no-verify with non-executable hook' '
+test_expect_success POSIXPERM '--no-pre-commit with non-executable hook' '
 
 	echo "more content" >> file &&
 	git add file &&
-	git commit --no-verify -m "more content"
+	git commit --no-pre-commit -m "more content"
 
 '
 chmod +x "$HOOK"
 
+test_hook_enabled () {
+	git checkout --detach master &&
+	output="running failing pre-commit hook with ${*:-(none)}..." &&
+	>actual.output &&
+	cat >"$HOOK" <<-EOF &&
+	#!/bin/sh
+	echo "$output" >>actual.output
+	exit 1
+	EOF
+	chmod +x "$HOOK" &&
+	echo "$output" >expected.output &&
+	test_must_fail test_commit $* file &&
+	test_cmp expected.output actual.output
+}
+
+test_hook_disabled () {
+	git checkout --detach master &&
+	output="running failing pre-commit hook with ${*:-(none)}..." &&
+	>actual.output &&
+	cat >"$HOOK" <<-EOF &&
+	#!/bin/sh
+	echo "$output" >>actual.output
+	exit 1
+	EOF
+	chmod +x "$HOOK" &&
+	test_commit --notag $* file &&
+	test_must_be_empty actual.output
+}
+
+test_expect_success 'command line options combinations' '
+	test_hook_enabled &&
+	test_hook_enabled --pre-commit &&
+	test_hook_enabled --no-pre-commit --pre-commit &&
+	test_hook_enabled --no-verify --pre-commit &&
+	test_hook_enabled --verify &&
+	test_hook_enabled --no-pre-commit --verify &&
+	test_hook_enabled --no-verify --verify &&
+	test_hook_enabled --verify --no-commit-msg &&
+	test_hook_enabled --verify --commit-msg &&
+	test_hook_disabled --no-pre-commit &&
+	test_hook_disabled --pre-commit --no-pre-commit &&
+	test_hook_disabled --pre-commit --no-verify &&
+	test_hook_disabled --no-verify &&
+	test_hook_disabled --verify --no-pre-commit &&
+	test_hook_disabled --verify --no-verify &&
+	test_hook_disabled --no-verify --no-commit-msg &&
+	test_hook_disabled --no-verify --commit-msg
+'
+
 # a hook that checks $GIT_PREFIX and succeeds inside the
 # success/ subdirectory only
 cat > "$HOOK" <<EOF
diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
index 1f53ea8..59642a3 100755
--- a/t/t7504-commit-msg-hook.sh
+++ b/t/t7504-commit-msg-hook.sh
@@ -34,20 +34,20 @@ test_expect_success 'with no hook (editor)' '
 
 '
 
-test_expect_success '--no-verify with no hook' '
+test_expect_success '--no-commit-msg with no hook' '
 
 	echo "bar" > file &&
 	git add file &&
-	git commit --no-verify -m "bar"
+	git commit --no-commit-msg -m "bar"
 
 '
 
-test_expect_success '--no-verify with no hook (editor)' '
+test_expect_success '--no-commit-msg with no hook (editor)' '
 
 	echo "more bar" > file &&
 	git add file &&
 	echo "more bar" > FAKE_MSG &&
-	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-commit-msg
 
 '
 
@@ -78,20 +78,20 @@ test_expect_success 'with succeeding hook (editor)' '
 
 '
 
-test_expect_success '--no-verify with succeeding hook' '
+test_expect_success '--no-commit-msg with succeeding hook' '
 
 	echo "even more" >> file &&
 	git add file &&
-	git commit --no-verify -m "even more"
+	git commit --no-commit-msg -m "even more"
 
 '
 
-test_expect_success '--no-verify with succeeding hook (editor)' '
+test_expect_success '--no-commit-msg with succeeding hook (editor)' '
 
 	echo "even more more" >> file &&
 	git add file &&
 	echo "even more more" > FAKE_MSG &&
-	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-commit-msg
 
 '
 
@@ -118,20 +118,20 @@ test_expect_success 'with failing hook (editor)' '
 
 '
 
-test_expect_success '--no-verify with failing hook' '
+test_expect_success '--no-commit-msg with failing hook' '
 
 	echo "stuff" >> file &&
 	git add file &&
-	git commit --no-verify -m "stuff"
+	git commit --no-commit-msg -m "stuff"
 
 '
 
-test_expect_success '--no-verify with failing hook (editor)' '
+test_expect_success '--no-commit-msg with failing hook (editor)' '
 
 	echo "more stuff" >> file &&
 	git add file &&
 	echo "more stuff" > FAKE_MSG &&
-	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-commit-msg
 
 '
 
@@ -153,23 +153,72 @@ test_expect_success POSIXPERM 'with non-executable hook (editor)' '
 
 '
 
-test_expect_success POSIXPERM '--no-verify with non-executable hook' '
+test_expect_success POSIXPERM '--no-commit-msg with non-executable hook' '
 
 	echo "more content" >> file &&
 	git add file &&
-	git commit --no-verify -m "more content"
+	git commit --no-commit-msg -m "more content"
 
 '
 
-test_expect_success POSIXPERM '--no-verify with non-executable hook (editor)' '
+test_expect_success POSIXPERM '--no-commit-msg with non-executable hook (editor)' '
 
 	echo "even more content" >> file &&
 	git add file &&
 	echo "even more content" > FAKE_MSG &&
-	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-commit-msg
 
 '
 
+test_hook_enabled () {
+	git checkout --detach master &&
+	output="running failing commit-msg hook with ${*:-(none)}..." &&
+	>actual.output &&
+	cat >"$HOOK" <<-EOF &&
+	#!/bin/sh
+	echo "$output" >>actual.output
+	exit 1
+	EOF
+	chmod +x "$HOOK" &&
+	echo "$output" >expected.output &&
+	test_must_fail test_commit $* file &&
+	test_cmp expected.output actual.output
+}
+
+test_hook_disabled () {
+	git checkout --detach master &&
+	output="running failing commit-msg hook with ${*:-(none)}..." &&
+	>actual.output &&
+	cat >"$HOOK" <<-EOF &&
+	#!/bin/sh
+	echo "$output" >>actual.output
+	exit 1
+	EOF
+	chmod +x "$HOOK" &&
+	test_commit --notag $* file &&
+	test_must_be_empty actual.output
+}
+
+test_expect_success 'command line options combinations' '
+	test_hook_enabled &&
+	test_hook_enabled --commit-msg &&
+	test_hook_enabled --no-commit-msg --commit-msg &&
+	test_hook_enabled --no-verify --commit-msg &&
+	test_hook_enabled --verify &&
+	test_hook_enabled --no-commit-msg --verify &&
+	test_hook_enabled --no-verify --verify &&
+	test_hook_enabled --verify --no-pre-commit &&
+	test_hook_enabled --verify --pre-commit &&
+	test_hook_disabled --no-commit-msg &&
+	test_hook_disabled --commit-msg --no-commit-msg &&
+	test_hook_disabled --commit-msg --no-verify &&
+	test_hook_disabled --no-verify &&
+	test_hook_disabled --verify --no-commit-msg &&
+	test_hook_disabled --verify --no-verify &&
+	test_hook_disabled --no-verify --no-pre-commit &&
+	test_hook_disabled --no-verify --pre-commit
+'
+
 # now a hook that edits the commit message
 cat > "$HOOK" <<'EOF'
 #!/bin/sh
@@ -205,7 +254,7 @@ test_expect_success "hook doesn't edit commit message" '
 
 	echo "plus" >> file &&
 	git add file &&
-	git commit --no-verify -m "plus" &&
+	git commit --no-commit-msg -m "plus" &&
 	commit_msg_is "plus"
 
 '
@@ -215,7 +264,7 @@ test_expect_success "hook doesn't edit commit message (editor)" '
 	echo "more plus" >> file &&
 	git add file &&
 	echo "more plus" > FAKE_MSG &&
-	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-verify &&
+	GIT_EDITOR="\"\$FAKE_EDITOR\"" git commit --no-commit-msg &&
 	commit_msg_is "more plus"
 
 '
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index dafd6ad..a107073 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -154,20 +154,28 @@ test_pause () {
 
 test_commit () {
 	notick= &&
-	signoff= &&
+	notag= &&
+	commit_opts= &&
 	while test $# != 0
 	do
 		case "$1" in
 		--notick)
 			notick=yes
 			;;
-		--signoff)
-			signoff="$1"
+		--notag)
+			notag=yes
+			;;
+		--)
+			shift &&
+			break
+			;;
+		-*)
+			commit_opts="$commit_opts $1"
 			;;
 		*)
 			break
 			;;
-		esac
+		esac &&
 		shift
 	done &&
 	file=${2:-"$1.t"} &&
@@ -177,8 +185,11 @@ test_commit () {
 	then
 		test_tick
 	fi &&
-	git commit $signoff -m "$1" &&
-	git tag "${4:-$1}"
+	git commit $commit_opts -m "$1" &&
+	if test -z "$notag"
+	then
+		git tag "${4:-$1}"
+	fi
 }
 
 # Call test_merge with the arguments "<message> <commit>", where <commit>
-- 
2.0.1
