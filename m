From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH v2] Teach git-commit about commit message templates.
Date: Mon, 23 Jul 2007 06:32:45 -0700
Message-ID: <20070723133245.GA24760@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 23 15:32:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICy1q-0007aF-M8
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 15:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759117AbXGWNcr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 09:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758381AbXGWNcr
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 09:32:47 -0400
Received: from 91.86.32.216.static.reverse.layeredtech.com ([216.32.86.91]:55753
	"HELO midwinter.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with SMTP id S1758672AbXGWNcq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 09:32:46 -0400
Received: (qmail 25218 invoked by uid 1001); 23 Jul 2007 13:32:45 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53436>

These are useful in organizations that enforce particular formats
for commit messages, e.g., to specify bug IDs or test plans.
Use of the template is not enforced; it is simply used as the
initial content when the editor is invoked.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
	Updated based on feedback from Dscho. This depends on his
	patch to add the --strip-comments option to git-stripspace.
	That seemed like a pretty uncontroversial change to me, but
	I can easily switch back to "grep -v" to remove the
	dependency if desired.

	I am using diff > /dev/null rather than git diff --quiet
	because the latter doesn't work at the moment (see the test
	case I just sent to the list.)

 Documentation/git-commit.txt |    8 ++++
 git-commit.sh                |   40 ++++++++++++++----
 t/t7500-commit.sh            |   96 ++++++++++++++++++++++++++++++++++++++++++
 t/t7500/add-comments         |    4 ++
 t/t7500/add-content          |    3 +
 t/t7500/add-signed-off       |    3 +
 6 files changed, 146 insertions(+), 8 deletions(-)
 create mode 100755 t/t7500-commit.sh
 create mode 100755 t/t7500/add-comments
 create mode 100755 t/t7500/add-content
 create mode 100755 t/t7500/add-signed-off

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 8e0e7e2..3f36c67 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -74,6 +74,14 @@ OPTIONS
 -m <msg>|--message=<msg>::
 	Use the given <msg> as the commit message.
 
+-t <file>|--template=<file>::
+	Use the contents of the given file as the initial version
+	of the commit message. The editor is invoked and you can
+	make subsequent changes. If a message is specified using
+	the `-m` or `-F` options, this option has no effect. The
+	template file may also be specified using the `commit.template`
+	configuration variable.
+
 -s|--signoff::
 	Add Signed-off-by line at the end of the commit message.
 
diff --git a/git-commit.sh b/git-commit.sh
index 92749df..5a471e1 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Linus Torvalds
 # Copyright (c) 2006 Junio C Hamano
 
-USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i | -o] <path>...]'
+USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [--template <file>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
@@ -87,6 +87,7 @@ signoff=
 force_author=
 only_include_assumed=
 untracked_files=
+templatefile="`git config commit.template`"
 while case "$#" in 0) break;; esac
 do
 	case "$1" in
@@ -248,6 +249,13 @@ $1"
 		signoff=t
 		shift
 		;;
+	-t|--t|--te|--tem|--temp|--templ|--templa|--templat|--template)
+		case "$#" in 1) usage ;; esac
+		shift
+		templatefile="$1"
+		no_edit=
+		shift
+		;;
 	-q|--q|--qu|--qui|--quie|--quiet)
 		quiet=t
 		shift
@@ -321,6 +329,14 @@ t,,[1-9]*)
 	die "No paths with -i does not make sense." ;;
 esac
 
+if test ! -z "$templatefile" -a -z "$log_given"
+then
+	if test ! -f "$templatefile"
+	then
+		die "Commit template file does not exist."
+	fi
+fi
+
 ################################################################
 # Prepare index to have a tree to be committed
 
@@ -454,6 +470,9 @@ then
 elif test -f "$GIT_DIR/SQUASH_MSG"
 then
 	cat "$GIT_DIR/SQUASH_MSG"
+elif test "$templatefile" != ""
+then
+	cat "$templatefile"
 fi | git stripspace >"$GIT_DIR"/COMMIT_EDITMSG
 
 case "$signoff" in
@@ -565,17 +584,22 @@ then
 	    s///
 	    q
 	}
-	/^#/d
     ' "$GIT_DIR"/COMMIT_EDITMSG
 else
     cat "$GIT_DIR"/COMMIT_EDITMSG
 fi |
-git stripspace >"$GIT_DIR"/COMMIT_MSG
-
-if cnt=`grep -v -i '^Signed-off-by' "$GIT_DIR"/COMMIT_MSG |
-	git stripspace |
-	wc -l` &&
-   test 0 -lt $cnt
+git stripspace --strip-comments >"$GIT_DIR"/COMMIT_MSG
+
+# Make sure the commit message has actual new content (something other than
+# comments, Signed-off-by lines, and lines from the template.)
+grep -v -i '^Signed-off-by' "$GIT_DIR"/COMMIT_MSG |
+	git stripspace > "$GIT_DIR"/COMMIT_BAREMSG
+trap 'rm -f "$GIT_DIR"/COMMIT_BAREMSG' 0
+
+if test -s "$GIT_DIR"/COMMIT_BAREMSG &&
+	test -z "$templatefile" ||
+	! (git stripspace --strip-comments < "$templatefile" |
+	   diff - "$GIT_DIR"/COMMIT_BAREMSG > /dev/null)
 then
 	if test -z "$TMP_INDEX"
 	then
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
new file mode 100755
index 0000000..f11ada8
--- /dev/null
+++ b/t/t7500-commit.sh
@@ -0,0 +1,96 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Steven Grimm
+#
+
+test_description='git-commit
+
+Tests for selected commit options.'
+
+. ./test-lib.sh
+
+commit_msg_is () {
+	test "`git log --pretty=format:%s%b -1`" = "$1"
+}
+
+# A sanity check to see if commit is working at all.
+test_expect_success 'a basic commit in an empty tree should succeed' '
+	echo content > foo &&
+	git add foo &&
+	git commit -m "initial commit"
+'
+
+test_expect_success 'nonexistent template file should return error' '
+	echo changes >> foo &&
+	git add foo &&
+	! git commit --template "$PWD"/notexist
+'
+
+test_expect_success 'nonexistent template file in config should return error' '
+	git config commit.template "$PWD"/notexist &&
+	! git commit &&
+	git config --unset commit.template
+'
+
+# From now on we'll use a template file that exists.
+TEMPLATE="$PWD"/template
+
+test_expect_success 'unedited template should not commit' '
+	echo "template line" > "$TEMPLATE" &&
+	! git commit --template "$TEMPLATE"
+'
+
+test_expect_success 'unedited template with comments should not commit' '
+	echo "# comment in template" >> "$TEMPLATE" &&
+	! git commit --template "$TEMPLATE"
+'
+
+test_expect_success 'a Signed-off-by line by itself should not commit' '
+	! GIT_EDITOR=../t7500/add-signed-off git commit --template "$TEMPLATE"
+'
+
+test_expect_success 'adding comments to a template should not commit' '
+	! GIT_EDITOR=../t7500/add-comments git commit --template "$TEMPLATE"
+'
+
+test_expect_success 'adding real content to a template should commit' '
+	GIT_EDITOR=../t7500/add-content git commit --template "$TEMPLATE" &&
+	commit_msg_is "template linecommit message"
+'
+
+test_expect_success '-t option should be short for --template' '
+	echo "short template" > "$TEMPLATE" &&
+	echo "new content" >> foo &&
+	git add foo &&
+	GIT_EDITOR=../t7500/add-content git commit -t "$TEMPLATE" &&
+	commit_msg_is "short templatecommit message"
+'
+
+test_expect_success 'config-specified template should commit' '
+	echo "new template" > "$TEMPLATE" &&
+	git config commit.template "$TEMPLATE" &&
+	echo "more content" >> foo &&
+	git add foo &&
+	GIT_EDITOR=../t7500/add-content git commit &&
+	git config --unset commit.template &&
+	commit_msg_is "new templatecommit message"
+'
+
+test_expect_success 'explicit commit message should override template' '
+	echo "still more content" >> foo &&
+	git add foo &&
+	GIT_EDITOR=../t7500/add-content git commit --template "$TEMPLATE" \
+		-m "command line msg" &&
+	commit_msg_is "command line msg<unknown>"
+'
+
+test_expect_success 'commit message from file should override template' '
+	echo "content galore" >> foo &&
+	git add foo &&
+	echo "standard input msg" |
+		GIT_EDITOR=../t7500/add-content git commit \
+			--template "$TEMPLATE" --file - &&
+	commit_msg_is "standard input msg<unknown>"
+'
+
+test_done
diff --git a/t/t7500/add-comments b/t/t7500/add-comments
new file mode 100755
index 0000000..a72e65c
--- /dev/null
+++ b/t/t7500/add-comments
@@ -0,0 +1,4 @@
+#!/bin/sh
+echo "# this is a new comment" >> "$1"
+echo "# and so is this" >> "$1"
+exit 0
diff --git a/t/t7500/add-content b/t/t7500/add-content
new file mode 100755
index 0000000..2fa3d86
--- /dev/null
+++ b/t/t7500/add-content
@@ -0,0 +1,3 @@
+#!/bin/sh
+echo "commit message" >> "$1"
+exit 0
diff --git a/t/t7500/add-signed-off b/t/t7500/add-signed-off
new file mode 100755
index 0000000..e1d856a
--- /dev/null
+++ b/t/t7500/add-signed-off
@@ -0,0 +1,3 @@
+#!/bin/sh
+echo "Signed-off-by: foo <bar@frotz>" >> "$1"
+exit 0
-- 
1.5.3.rc2.4.g726f9
