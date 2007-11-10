From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Sun, 11 Nov 2007 03:27:43 +0800
Message-ID: <1194722863-14741-1-git-send-email-pkufranky@gmail.com>
Cc: Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 20:30:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqw24-0001zb-DN
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 20:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbXKJT34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 14:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbXKJT34
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 14:29:56 -0500
Received: from mail.qikoo.org ([60.28.205.235]:57863 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752915AbXKJT3z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 14:29:55 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id CEE8A47067; Sun, 11 Nov 2007 03:27:43 +0800 (CST)
X-Mailer: git-send-email 1.5.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64371>

git status/commit just treats submodules as ordinary files when reporting status
changes. However, one may also wonder how submodules change (the commits).

This commit teaches git status/commit to also show commits of user-cared
modified submodules since HEAD (or HEAD^ if --amend option is on).
Notes:
	1. Submodules already checked out are considered to be user-cared ones.
	2. For submodules deleted or initially added, commits are not shown.

For example, when commiting, submodule sm1 and sm2 are both changed. sm1 has
commit C in HEAD and commit E in index. The history of sm1 is
	--A-->B-->C (in HEAD:354cd45)
	  \
	   -->D->E (in index:3f751e5)

git status will give the following output (just output commits of submodules
before the original output) to show how to change from commit C (in HEAD) to
commit E (in index) for submodule sm1: backward ('<<<') to commit A, and then
forward ('>>>') to commit E. Similar illustration for output of sm2 is omitted.

	#
	# submodule modifiled: sm1 sm2
	#
	# * sm1 354cd45...3f751e5:
	#   <<<
	#   	one line message for C
	#   	one line message for B
	#   >>>
	#   	one line message for D
	#   	one line message for E
	#
	# * sm2 5c8bfb5...ac46d84:
	#   <<<
	#   	msg
	#
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#	modified:   sm1
	#	modified:   sm2

For sm1, if the commit recorded in HEAD/index (say commit C/E) is not found in
the work tree (say sm1 respository in the work tree), a warning will be issued.

	#
	# submodule modifiled: sm1
	#
	# * sm1 354cd45...3f751e5:
	#   Warn: sm1 doesn't contains commit 354cd45
	#
	# On branch master
	# Changes to be committed:
	#   (use "git reset HEAD <file>..." to unstage)
	#
	#	modified:   sm1

Signed-off-by: Ping Yin <pkufranky@gmail.com>
---
 git-commit.sh |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index fcb8443..29f2ebe 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -33,6 +33,68 @@ save_index () {
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
+	test -n "$modules" && echo -e "#\n# submodule modifiled: "$modules"\n#"
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
+				echo "  Warn: $name dosn't contains commit $headone"
+				;;
+			,t)
+				echo "  Warn: $name dosn't contains commit $indexone"
+				;;
+			t,t)
+				echo "  Warn: $name dosn't contains commits $headone and $indexone"
+				;;
+			*)
+				left=$(GIT_DIR="$name/.git" git log --pretty=oneline $indexone..$headone 2>&1 |
+				sed 's/^\w\+ /  \t/')
+				right=$(GIT_DIR="$name/.git" git log --pretty=oneline --reverse  $headone..$indexone 2>&1 |
+				sed 's/^\w\+ /  \t/')
+
+				test -n "$left" && echo -e "  <<<\n$left"
+				test -n "$right" && echo -e "  >>>\n$right"
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
@@ -55,6 +117,12 @@ run_status () {
 	else
 		color=--nocolor
 	fi
+	if test -z "$amend"
+	then
+		show_module_log
+	else
+		show_module_log "HEAD^"
+	fi
 	git runstatus ${color} \
 		${verbose:+--verbose} \
 		${amend:+--amend} \
-- 
1.5.3.4
