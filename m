From: Adam Roben <aroben@apple.com>
Subject: [PATCH] Add git-sh-setup::set_editor()
Date: Thu, 19 Jul 2007 11:24:08 -0700
Message-ID: <11848694482569-git-send-email-aroben@apple.com>
References: <Pine.LNX.4.64.0707191053230.14781@racer.site>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Shindelin <Johannes.Schindelin@gmx.de>,
	Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 20:24:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBaff-0001o5-O1
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 20:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761992AbXGSSYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 14:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759893AbXGSSYM
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 14:24:12 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:49566 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759309AbXGSSYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 14:24:11 -0400
Received: from relay8.apple.com (relay8.apple.com [17.128.113.38])
	by mail-out3.apple.com (Postfix) with ESMTP id 8D727C2A73A;
	Thu, 19 Jul 2007 11:24:07 -0700 (PDT)
Received: from relay8.apple.com (unknown [127.0.0.1])
	by relay8.apple.com (Symantec Mail Security) with ESMTP id 74F9340450;
	Thu, 19 Jul 2007 11:24:07 -0700 (PDT)
X-AuditID: 11807126-a5c45bb0000007e3-dc-469fac47c8bc
Received: from localhost.localdomain (il0301e-dhcp181.apple.com [17.203.15.181])
	by relay8.apple.com (Apple SCV relay) with ESMTP id 4C2F840018;
	Thu, 19 Jul 2007 11:24:07 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc2.20.g8e32-dirty
In-Reply-To: <Pine.LNX.4.64.0707191053230.14781@racer.site>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53014>

This function can be used to set the GIT_EDITOR variable to the user's
preferred editor.

Signed-off-by: Adam Roben <aroben@apple.com>
---
On Jul 19, 2007, at 2:54 AM, Johannes Schindelin wrote:
> Now with so many commands in the lot, how about putting the code into 
> git-sh-setup, into a function "get_editor()"?

Here you go. I didn't add anything similar for git-send-email.perl since that
is the only case we have in perl of invoking the editor right now, and I wasn't
sure of a good place to add such a function.

 git-am.sh                  |    3 ++-
 git-commit.sh              |    6 +++---
 git-rebase--interactive.sh |    3 ++-
 git-sh-setup.sh            |    5 +++++
 git-tag.sh                 |    3 ++-
 5 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 3a651ae..a5de0a1 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -7,6 +7,7 @@ USAGE='[--signoff] [--dotest=<dir>] [--utf8 | --no-utf8] [--binary] [--3way]
   or, when resuming [--skip | --resolved]'
 . git-sh-setup
 set_reflog_action am
+set_editor
 require_work_tree
 
 git var GIT_COMMITTER_IDENT >/dev/null || exit
@@ -364,7 +365,7 @@ do
 		[yY]*) action=yes ;;
 		[aA]*) action=yes interactive= ;;
 		[nN]*) action=skip ;;
-		[eE]*) "$(git config core.editor || echo ${VISUAL:-${EDITOR:-vi}})" "$dotest/final-commit"
+		[eE]*) "$GIT_EDITOR" "$dotest/final-commit"
 		       action=again ;;
 		[vV]*) action=again
 		       LESS=-S ${PAGER:-less} "$dotest/patch" ;;
diff --git a/git-commit.sh b/git-commit.sh
index 72e4cf0..9adb03c 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -6,6 +6,7 @@
 USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
+set_editor
 require_work_tree
 
 git rev-parse --verify HEAD >/dev/null 2>&1 || initial_commit=t
@@ -544,8 +545,7 @@ fi
 
 case "$no_edit" in
 '')
-	commit_editor=$(git config core.editor || echo ${VISUAL:-$EDITOR})
-	case "$commit_editor,$TERM" in
+	case "$GIT_EDITOR,$TERM" in
 	,dumb)
 		echo >&2 "Terminal is dumb but core.editor, VISUAL, and EDITOR"
 		echo >&2 "are undefined. Please supply the commit log message"
@@ -556,7 +556,7 @@ case "$no_edit" in
 	esac
 	git-var GIT_AUTHOR_IDENT > /dev/null  || die
 	git-var GIT_COMMITTER_IDENT > /dev/null  || die
-	${commit_editor:-vi} "$GIT_DIR/COMMIT_EDITMSG"
+	$GIT_EDITOR "$GIT_DIR/COMMIT_EDITMSG"
 	;;
 esac
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2e15abb..32d1f53 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -15,6 +15,7 @@ USAGE='(--continue | --abort | --skip | [--preserve-merges] [--verbose]
 
 . git-sh-setup
 require_work_tree
+set_editor
 
 DOTEST="$GIT_DIR/.dotest-merge"
 TODO="$DOTEST"/todo
@@ -414,7 +415,7 @@ EOF
 			die_abort "Nothing to do"
 
 		cp "$TODO" "$TODO".backup
-		$(git config core.editor || echo ${VISUAL:-${EDITOR:-vi}}) "$TODO" ||
+		$GIT_EDITOR "$TODO" ||
 			die "Could not execute editor"
 
 		test -z "$(grep -ve '^$' -e '^#' < $TODO)" &&
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 4ed07e9..f43ab33 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -28,6 +28,11 @@ set_reflog_action() {
 	fi
 }
 
+set_editor() {
+    GIT_EDITOR=$(git config core.editor || echo ${VISUAL:-${EDITOR:-vi}})
+    export GIT_EDITOR
+}
+
 is_bare_repository () {
 	git rev-parse --is-bare-repository
 }
diff --git a/git-tag.sh b/git-tag.sh
index 9aa30b4..0a6f2e7 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -4,6 +4,7 @@
 USAGE='[-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg>] <tagname> [<head>]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
+set_editor
 
 message_given=
 annotate=
@@ -177,7 +178,7 @@ if [ "$annotate" ]; then
         ( echo "#"
           echo "# Write a tag message"
           echo "#" ) > "$GIT_DIR"/TAG_EDITMSG
-        $(git config core.editor || echo ${VISUAL:-${EDITOR:-vi}}) "$GIT_DIR"/TAG_EDITMSG || exit
+        $GIT_EDITOR "$GIT_DIR"/TAG_EDITMSG || exit
     else
         printf '%s\n' "$message" >"$GIT_DIR"/TAG_EDITMSG
     fi
-- 
1.5.3.rc2.20.g8e32-dirty
