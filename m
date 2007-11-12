From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Mon, 12 Nov 2007 22:21:17 +0800
Message-ID: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
Cc: Ping Yin <pkufranky@gmail.com>
To: "git@git"@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 15:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IraCp-0006lc-QQ
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 15:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbXKLOXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 09:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753670AbXKLOXs
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 09:23:48 -0500
Received: from mail.qikoo.org ([60.28.205.235]:57192 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753196AbXKLOXr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 09:23:47 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id CE98647067; Mon, 12 Nov 2007 22:21:17 +0800 (CST)
X-Mailer: git-send-email 1.5.3.4
In-Reply-To: 47382506.1090106@viscovery.net
References: 47382506.1090106@viscovery.net
In-Reply-To: <47382506.1090106@viscovery.net>
References: <47382506.1090106@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64626>

git status/commit just treats submodules as ordinary files when reporting status
changes. However, one may also wonder how submodules change (the commits).

This commit teaches git status/commit to additionally show commit summary of
user-cared (i.e. checked out) modified submodules since HEAD (or HEAD^ if
--amend option is on). For submodules deleted or initially added, commit summary
are not shown.

A configuration variable 'submodule.status' is used to turn this summary
behaviour on or off (default off). Also --submodule and --no-submodule options
are added.

By introducing this commit, git status will additionally give
'Submodules modified' section just before 'Untracked files' section as the
following example shows.

	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#	modified:   sm1
	#	modified:   sm2
	#	modified:   sm3
	#	deleted:    sm4
	#
	# Submodules modifiled: sm1 sm2 sm3
	#
	# * sm1 354cd45...3f751e5:
	#   <one line message for C
	#   <one line message for B
	#   >one line message for D
	#   >one line message for E
	#
	# * sm2 5c8bfb5...ac46d84:
	#   <msg
	#
	# * sm3 354cd45...3f751e5:
	#   Warn: sm3 doesn't contains commit 354cd45
	#
	# Untracked files:
	#   (use "git add <file>..." to include in what will be committed)
	#
	#	file1

This superproject shown has modified/deleted submodules sm1 to sm4.

sm1 has commit C in HEAD and commit E in index. The history of sm1 is
	--A-->B-->C (in HEAD:354cd45)
	  \
	   -->D-->E (in index:3f751e5)

The 'Submodules modified' section for sm1 shows how to change sm1 from commit C
(in HEAD) to commit E (in index): backward (<) to commit A first, and then
forward (>) to commit E.

Similar illustration for output of sm2 is omitted.

If the commit recorded in HEAD/index for a submodule is not found in the work
tree (say the submodule respository in the work tree), a warning will be issued.
Submodule sm3 falls into this case.

Commits of sm4 are not shown since it's a deleted submodule.

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 Documentation/git-commit.txt |   10 +++++
 Documentation/git-status.txt |    3 +
 git-commit.sh                |   90 ++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index e54fb12..0680a57 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -139,6 +139,13 @@ but can be used to amend a merge commit.
 -q|--quiet::
 	Suppress commit summary message.
 
+--submodule|--no-submodule
+    Show/Don't show commit summary for user-cared (i.e. checked out)
+    modified submodules. Summaries for submodules deleted or initial
+    added are not shown. The bool configuration variable
+    'submodule.status' is used to control the default behaviour
+    (don't show by default).
+
 \--::
 	Do not interpret any more arguments as options.
 
@@ -259,6 +266,9 @@ GIT_EDITOR environment variable, the core.editor configuration variable, the
 VISUAL environment variable, or the EDITOR environment variable (in that
 order).
 
+The bool configuration variable 'submodule.status' is also honored to
+enable/disable the submodule summary behaviour (see option --submodule).
+
 HOOKS
 -----
 This command can run `commit-msg`, `pre-commit`, and
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 8fd0fc6..7afe6a0 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -49,6 +49,9 @@ mean the same thing and the latter is kept for backward
 compatibility) and `color.status.<slot>` configuration variables
 to colorize its output.
 
+The bool configuration variable 'submodule.status' is also honored
+to enable/disable the submodule summary behaviour (see option --submodule).
+
 See Also
 --------
 gitlink:gitignore[5]
diff --git a/git-commit.sh b/git-commit.sh
index fcb8443..813eb4e 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -33,6 +33,65 @@ save_index () {
 	cp -p "$THIS_INDEX" "$NEXT_INDEX"
 }
 
+# Show log of modified submodule (index modification since HEAD or $1)
+# $1 is the commit to be compared, default 'HEAD'
+show_module_log () {
+	cwd=$(pwd)
+	cd_to_toplevel
+
+	# get modified modules which have been checked out (i.e. cared by user)
+	modules=$(git diff --cached --name-only $1 |
+	(
+		IFS=''	# handle the module name containing space or tab
+		while read name
+		do
+			git ls-files --stage "$name" | grep '^160000 ' >&/dev/null &&
+			GIT_DIR="$name/.git" git-rev-parse --git-dir >&/dev/null &&
+			echo "$name"
+		done
+	)
+	)
+
+	# TODO: quote module names containing space or tab
+	test -n "$modules" && echo -e "# Submodules modifiled: "$modules"\n#"
+	OLDIFS=$IFS
+	IFS=$'\n\r'	# '\r' for mac os
+	for name in $modules
+	do
+		range=$(git diff --cached -- "$name" | sed -n '/^index.*160000$/ p' | awk '{print $2}')
+		indexone=${range#*..}
+		headone=${range%..*}
+		(
+			echo "* $name $headone...$indexone:"
+			headfail=
+			indexfail=
+			GIT_DIR="$name/.git" git-rev-parse $headone >&/dev/null || headfail='t'
+			GIT_DIR="$name/.git" git-rev-parse $indexone >&/dev/null || indexfail='t'
+			case "$headfail,$indexfail" in
+			t,)
+				echo "  Warn: $name doesn't contains commit $headone"
+				;;
+			,t)
+				echo "  Warn: $name doesn't contains commit $indexone"
+				;;
+			t,t)
+				echo "  Warn: $name doesn't contains commits $headone and $indexone"
+				;;
+			*)
+				left=$(GIT_DIR="$name/.git" git log --pretty=format:"  <%s" $indexone..$headone 2>&1)
+				right=$(GIT_DIR="$name/.git" git log --reverse --pretty=format:"  >%s" $headone..$indexone 2>&1) &&
+				test -n "$left" && echo "$left"
+				test -n "$right" && echo "$right"
+				;;
+			esac
+			echo
+		) | sed 's/^/# /'
+	done
+	IFS=$OLDIFS
+
+	cd "$cwd"
+}
+
 run_status () {
 	# If TMP_INDEX is defined, that means we are doing
 	# "--only" partial commit, and that index file is used
@@ -55,10 +114,25 @@ run_status () {
 	else
 		color=--nocolor
 	fi
-	git runstatus ${color} \
-		${verbose:+--verbose} \
-		${amend:+--amend} \
-		${untracked_files:+--untracked}
+	if test -n "$showsubmodule"
+	then
+		git runstatus ${color} \
+			${verbose:+--verbose} \
+			${amend:+--amend} \
+			${untracked_files:+--untracked} |
+		awk -v modulelog="$(show_module_log ${amend:+HEAD^})" '
+		/^# Untracked files:/ {shown=1; if (modulelog) print modulelog}
+		{print}
+		END {
+			if (!shown && modulelog) print modulelog
+		}
+		'
+	else
+		git runstatus ${color} \
+			${verbose:+--verbose} \
+			${amend:+--amend} \
+			${untracked_files:+--untracked}
+	fi
 }
 
 trap '
@@ -90,6 +164,8 @@ force_author=
 only_include_assumed=
 untracked_files=
 templatefile="`git config commit.template`"
+showsubmodule=$(git config --bool submodule.status 2>/dev/null)
+test "$showsubmodule" == "true" || showsubmodule=""
 while test $# != 0
 do
 	case "$1" in
@@ -230,6 +306,12 @@ do
 	--untracked-file|--untracked-files)
 		untracked_files=t
 		;;
+	--su|--sub|--subm|--submo|--submod|--submodu|--submodul|--submodule)
+		showsubmodule=t
+		;;
+	--no-su|--no-sub|--no-subm|--no-submo|--no-submod|--no-submodu|--no-submodul|--no-submodule)
+		showsubmodule=
+		;;
 	--)
 		shift
 		break
-- 
1.5.3.4
