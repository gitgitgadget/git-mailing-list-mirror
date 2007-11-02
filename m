From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] status&commit: Teach them to show commits of modified submodules.
Date: Fri,  2 Nov 2007 19:53:47 +0800
Message-ID: <1194004427-26934-1-git-send-email-pkufranky@gmail.com>
Cc: Ping Yin <pkufranky@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 13:25:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InvaX-0007QH-NC
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 13:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbXKBMZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 08:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753482AbXKBMZK
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 08:25:10 -0400
Received: from mail.qikoo.org ([60.28.205.235]:55464 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753018AbXKBMZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 08:25:09 -0400
X-Greylist: delayed 1864 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Nov 2007 08:25:09 EDT
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id 3937447067; Fri,  2 Nov 2007 19:53:47 +0800 (CST)
X-Mailer: git-send-email 1.5.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63110>

git status/commit just treats submodules as ordinary files when reporting status
changes. However, one may also wonder how the submodules change.

This commit teaches git status/commit to also show commits of
modified submodules since HEAD (or HEAD^ if --amend option is on).

For example, when commiting, submodule sm1 and sm2 are both changed. sm1 has commit C in HEAD and
commit E in index. The history of sm1 is
	--A-->B-->C (in HEAD:354cd45)
	  \
	   -->D->E (in index:3f751e5)

git status will give the following output (just output commits of submodules
before normal output) to show how to change from commit C (in HEAD) to commit
E (in index): backward ('<<<') to commit A, and then forward ('>>>') to commit
E.

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
---
 git-commit.sh |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index fcb8443..d362caa 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -33,6 +33,40 @@ save_index () {
 	cp -p "$THIS_INDEX" "$NEXT_INDEX"
 }
 
+# Show log of modified submodule (index modification since HEAD or $1)
+show_module_log () {
+	modules=`git diff --cached --name-only $1 |
+	while read name
+	do
+		git ls-files --stage $name
+	done |
+	grep '^160000 ' | awk '{print $4}'`
+	test -z "$modules" && return
+
+	modules=$(echo $modules)
+	echo -e "#\n# submodule modifiled: $modules\n#"
+	for name in $modules
+	do
+		range=`git diff --cached -- $name | sed -n '2 p' | awk '{print $2}'`
+		indexone=${range#*..}
+		headone=${range%..*}
+		(
+			echo "* $name $headone...$indexone:"
+			cd $name >&/dev/null || { echo "  Warning: fail to chdir to $name" && exit; }
+			left="`git log --pretty=oneline $indexone..$headone 2>&1 | sed 's/^\w\+ /  \t/'`"
+			right="`git log --pretty=oneline --reverse  $headone..$indexone 2>&1 | sed 's/^\w\+ /  \t/'`"
+			if echo "$left$right" | grep 'unknown revision' >&/dev/null
+			then
+				echo "  Warning: $name is not a repository or dosn't contains commit $headone/$indexone"
+			else
+				test -n "$left" && echo -e "  <<<\n$left"
+				test -n "$right" && echo -e "  >>>\n$right"
+			fi
+			echo
+		) | sed 's/^/# /'
+	done
+}
+
 run_status () {
 	# If TMP_INDEX is defined, that means we are doing
 	# "--only" partial commit, and that index file is used
@@ -55,6 +89,12 @@ run_status () {
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
