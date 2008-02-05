From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH-v5 4/4] git-commit: add a prepare-commit-msg hook
Date: Tue, 5 Feb 2008 08:04:18 +0100
Message-ID: <E1JMgdC-00019t-HY@fencepost.gnu.org>
References: <E1JMe6e-0004HH-Uq@fencepost.gnu.org> <7v1w7q4khm.fsf@gitster.siamese.dyndns.org> <E1JMfN3-0006XI-Qs@fencepost.gnu.org> <7vy79y1mhb.fsf@gitster.siamese.dyndns.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 10:32:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMgdm-0003Of-8F
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 10:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760903AbYBFJby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 04:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760896AbYBFJbx
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 04:31:53 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:52849 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760895AbYBFJbv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 04:31:51 -0500
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1JMgdC-00019t-HY; Wed, 06 Feb 2008 04:31:50 -0500
In-Reply-To: <7vy79y1mhb.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72783>

The prepare-commit-msg hook is run whenever a "fresh" commit message
is prepared, just before it is shown in the editor (if it is).
It can modify the commit message in-place and/or abort the commit.

It takes one to three parameters.  The first is the name of the file that
the commit log message.  The second is the source of the commit message,
and can be: "message" (if a -m or -F option was given); "template" (if a
-t option was given or the configuration option commit.template is set);
"merge" (if the commit is a merge or a .git/MERGE_MSG file exists);
"squash" (if a .git/SQUASH_MSG file exists); or "commit", followed by
a commit SHA1 as the third parameter (if a -c, -C or --amend option
was given).

If the exit status is non-zero, git-commit will abort.  The hook is
not suppressed by the --no-verify option, so it should not be used
as a replacement for the pre-commit hook.

The hook is allowed to edit the message file in place.  It can also be
used for the same purpose as the pre-commit message, if the verification
should not be skipped for automatic commits (e.g. during interactive
rebasing).

The default prepare-commit-msg comments out the `Conflicts:` part of
a merge's commit message; other examples are commented out, including
adding a Signed-off-by line at the bottom of the commit messsage,
that the user can then edit or discard altogether.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/git-commit.txt        |    4 +-
 Documentation/hooks.txt             |   26 ++++++
 builtin-commit.c                    |   19 ++++
 t/t7505-prepare-commit-msg-hook.sh  |  155 +++++++++++++++++++++++++++++++++++
 templates/hooks--commit-msg         |    3 +
 templates/hooks--prepare-commit-msg |   36 ++++++++
 6 files changed, 241 insertions(+), 2 deletions(-)
 create mode 100755 t/t7505-prepare-commit-msg-hook.sh
 create mode 100644 templates/hooks--prepare-commit-msg

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index c3725b2..b4ae61f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -280,8 +280,8 @@ order).
 
 HOOKS
 -----
-This command can run `commit-msg`, `pre-commit`, and
-`post-commit` hooks.  See link:hooks.html[hooks] for more
+This command can run `commit-msg`, `prepare-commit-msg`, `pre-commit`,
+and `post-commit` hooks.  See link:hooks.html[hooks] for more
 information.
 
 
diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index e8d80cf..b91d85e 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -65,6 +65,32 @@ All the `git-commit` hooks are invoked with the environment
 variable `GIT_EDITOR=:` if the command will not bring up an editor
 to modify the commit message.
 
+prepare-commit-msg
+------------------
+
+This hook is invoked by `git-commit` right after preparing the
+default log message, and before the editor is started.
+
+It takes one to three parameters.  The first is the name of the file
+that the commit log message.  The second is the source of the commit
+message, and can be: `message` (if a `\-m` or `\-F` option was
+given); `template` (if a `\-t` option was given or the
+configuration option `commit.template` is set); `merge` (if the
+commit is a merge or a `.git/MERGE_MSG` file exists); `squash`
+(if a `.git/SQUASH_MSG` file exists); or `commit`, followed by
+a commit SHA1 (if a `\-c`, `\-C` or `\--amend` option was given).
+
+If the exit status is non-zero, `git-commit` will abort.
+The hook is not suppressed by the `\--no-verify` option.
+
+The hook is allowed to edit the message file in place.  It can also be
+used for the same purpose as the pre-commit message, if the verification
+should not be skipped for automatic commits (e.g. during interactive
+rebasing).
+
+The default `prepare-commit-msg` comments out the `Conflicts:` part of
+a merge's commit message.
+
 commit-msg
 ----------
 
diff --git a/builtin-commit.c b/builtin-commit.c
index d8945ac..9468d27 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -394,6 +394,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 	struct strbuf sb;
 	char *buffer;
 	FILE *fp;
+	const char *hook_arg1 = NULL;
+	const char *hook_arg2 = NULL;
 
 	if (!no_verify && run_hook(index_file, "pre-commit", NULL))
 		return 0;
@@ -401,32 +403,45 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 	strbuf_init(&sb, 0);
 	if (message.len) {
 		strbuf_addbuf(&sb, &message);
+		hook_arg1 = "message";
 	} else if (logfile && !strcmp(logfile, "-")) {
 		if (isatty(0))
 			fprintf(stderr, "(reading log message from standard input)\n");
 		if (strbuf_read(&sb, 0, 0) < 0)
 			die("could not read log from standard input");
+		hook_arg1 = "message";
 	} else if (logfile) {
 		if (strbuf_read_file(&sb, logfile, 0) < 0)
 			die("could not read log file '%s': %s",
 			    logfile, strerror(errno));
+		hook_arg1 = "message";
 	} else if (use_message) {
 		buffer = strstr(use_message_buffer, "\n\n");
 		if (!buffer || buffer[2] == '\0')
 			die("commit has empty message");
 		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
+		hook_arg1 = "commit";
+		hook_arg2 = use_message;
 	} else if (!stat(git_path("MERGE_MSG"), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path("MERGE_MSG"), 0) < 0)
 			die("could not read MERGE_MSG: %s", strerror(errno));
+		hook_arg1 = "merge";
 	} else if (!stat(git_path("SQUASH_MSG"), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path("SQUASH_MSG"), 0) < 0)
 			die("could not read SQUASH_MSG: %s", strerror(errno));
+		hook_arg1 = "squash";
 	} else if (template_file && !stat(template_file, &statbuf)) {
 		if (strbuf_read_file(&sb, template_file, 0) < 0)
 			die("could not read %s: %s",
 			    template_file, strerror(errno));
+		hook_arg1 = "template";
 	}
 
+	/* This final case does not modify the template message, it just sets
+	   the argument to the prepare-commit-msg hook.  */
+	else if (in_merge)
+		hook_arg1 = "merge";
+
 	fp = fopen(git_path(commit_editmsg), "w");
 	if (fp == NULL)
 		die("could not open %s", git_path(commit_editmsg));
@@ -534,6 +549,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		return 0;
 	}
 
+	if (run_hook(index_file, "prepare-commit-msg",
+		     git_path(commit_editmsg), hook_arg1, hook_arg2, NULL))
+		return 0;
+
 	if (use_editor) {
 		char index[PATH_MAX];
 		const char *env[2] = { index, NULL };
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
new file mode 100755
index 0000000..7ddec99
--- /dev/null
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -0,0 +1,155 @@
+#!/bin/sh
+
+test_description='prepare-commit-msg hook'
+
+. ./test-lib.sh
+
+test_expect_success 'with no hook' '
+
+	echo "foo" > file &&
+	git add file &&
+	git commit -m "first"
+
+'
+
+# set up fake editor for interactive editing
+cat > fake-editor <<'EOF'
+#!/bin/sh
+exit 0
+EOF
+chmod +x fake-editor
+FAKE_EDITOR="$(pwd)/fake-editor"
+export FAKE_EDITOR
+
+# now install hook that always succeeds and adds a message
+HOOKDIR="$(git rev-parse --git-dir)/hooks"
+HOOK="$HOOKDIR/prepare-commit-msg"
+mkdir -p "$HOOKDIR"
+cat > "$HOOK" <<'EOF'
+#!/bin/sh
+if test "$2" = commit; then
+  source=$(git-rev-parse "$3")
+else
+  source=${2-default}
+fi
+if test "$GIT_EDITOR" = :; then
+  sed -e "1s/.*/$source (no editor)/" "$1" > msg.tmp
+else
+  sed -e "1s/.*/$source/" "$1" > msg.tmp
+fi
+mv msg.tmp "$1"
+exit 0
+EOF
+chmod +x "$HOOK"
+
+echo dummy template > "$(git rev-parse --git-dir)/template"
+
+test_expect_success 'with hook (-m)' '
+
+	echo "more" >> file &&
+	git add file &&
+	git commit -m "more" &&
+	test "`git log -1 --pretty=format:%s`" = "message (no editor)"
+
+'
+
+test_expect_success 'with hook (-m editor)' '
+
+	echo "more" >> file &&
+	git add file &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit -e -m "more more" &&
+	test "`git log -1 --pretty=format:%s`" = message
+
+'
+
+test_expect_success 'with hook (-t)' '
+
+	echo "more" >> file &&
+	git add file &&
+	git commit -t "$(git rev-parse --git-dir)/template" &&
+	test "`git log -1 --pretty=format:%s`" = template
+
+'
+
+test_expect_success 'with hook (-F)' '
+
+	echo "more" >> file &&
+	git add file &&
+	(echo more | git commit -F -) &&
+	test "`git log -1 --pretty=format:%s`" = "message (no editor)"
+
+'
+
+test_expect_success 'with hook (-F editor)' '
+
+	echo "more" >> file &&
+	git add file &&
+	(echo more more | GIT_EDITOR="$FAKE_EDITOR" git commit -e -F -) &&
+	test "`git log -1 --pretty=format:%s`" = message
+
+'
+
+test_expect_success 'with hook (-C)' '
+
+	head=`git rev-parse HEAD` &&
+	echo "more" >> file &&
+	git add file &&
+	git commit -C $head &&
+	test "`git log -1 --pretty=format:%s`" = "$head (no editor)"
+
+'
+
+test_expect_success 'with hook (editor)' '
+
+	echo "more more" >> file &&
+	git add file &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit &&
+	test "`git log -1 --pretty=format:%s`" = default
+
+'
+
+test_expect_success 'with hook (--amend)' '
+
+	head=`git rev-parse HEAD` &&
+	echo "more" >> file &&
+	git add file &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit --amend &&
+	test "`git log -1 --pretty=format:%s`" = "$head"
+
+'
+
+test_expect_success 'with hook (-c)' '
+
+	head=`git rev-parse HEAD` &&
+	echo "more" >> file &&
+	git add file &&
+	GIT_EDITOR="$FAKE_EDITOR" git commit -c $head &&
+	test "`git log -1 --pretty=format:%s`" = "$head"
+
+'
+
+cat > "$HOOK" <<'EOF'
+#!/bin/sh
+exit 1
+EOF
+
+test_expect_success 'with failing hook' '
+
+	head=`git rev-parse HEAD` &&
+	echo "more" >> file &&
+	git add file &&
+	! GIT_EDITOR="$FAKE_EDITOR" git commit -c $head
+
+'
+
+test_expect_success 'with failing hook (--no-verify)' '
+
+	head=`git rev-parse HEAD` &&
+	echo "more" >> file &&
+	git add file &&
+	! GIT_EDITOR="$FAKE_EDITOR" git commit --no-verify -c $head
+
+'
+
+
+test_done
diff --git a/templates/hooks--commit-msg b/templates/hooks--commit-msg
index c5cdb9d..4ef86eb 100644
--- a/templates/hooks--commit-msg
+++ b/templates/hooks--commit-msg
@@ -9,6 +9,9 @@
 # To enable this hook, make this file executable.
 
 # Uncomment the below to add a Signed-off-by line to the message.
+# Doing this in a hook is a bad idea in general, but the prepare-commit-msg
+# hook is more suited to it.
+#
 # SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
 # grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
 
diff --git a/templates/hooks--prepare-commit-msg b/templates/hooks--prepare-commit-msg
new file mode 100644
index 0000000..8509ba0
--- /dev/null
+++ b/templates/hooks--prepare-commit-msg
@@ -0,0 +1,36 @@
+#!/bin/sh
+#
+# An example hook script to prepare the commit log message.
+# Called by git-commit with the name of the file that has the
+# commit message, followed by the description of the commit
+# message's source.  The hook should exit with non-zero
+# status after issuing an appropriate message if it wants to stop the
+# commit.  The hook is allowed to edit the commit message file.
+#
+# To enable this hook, make this file executable.
+
+# This hook includes three examples.  The first comments out the
+# "Conflicts:" part of a merge commit.
+#
+# The second includes the output of "git diff --name-status -r"
+# into the message, just before the "git status" output.  It is
+# commented because it doesn't cope with --amend or with squashed
+# commits.
+#
+# The third example adds a Signed-off-by line to the message, that can
+# still be edited.  This is rarely a good idea.
+
+case "$2 $3" in
+  merge)
+    sed -i '/^Conflicts:/,/#/!b;s/^/# &/;s/^# #/#/' "$1" ;;
+
+# ""|template)
+#   perl -i -pe '
+#      print "\n" . `git diff --cached --name-status -r`
+#	 if /^#/ && $first++ == 0' "$1" ;;
+
+  *) ;;
+esac
+
+# SOB=$(git var GIT_AUTHOR_IDENT | sed -n 's/^\(.*>\).*$/Signed-off-by: \1/p')
+# grep -qs "^$SOB" "$1" || echo "$SOB" >> "$1"
-- 
1.5.3.4.910.gc5122-dirty
