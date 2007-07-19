From: Adam Roben <aroben@apple.com>
Subject: [PATCH] Print an error when falling back to vi on a dumb terminal
Date: Thu, 19 Jul 2007 14:10:19 -0700
Message-ID: <11848794193942-git-send-email-aroben@apple.com>
References: <Pine.LNX.4.64.0707191944560.14781@racer.site>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes.Schindelin@gmx.de,
	Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 23:10:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBdGa-0003PS-4q
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 23:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762296AbXGSVKR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 17:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759418AbXGSVKQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 17:10:16 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:64856 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757485AbXGSVKO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 17:10:14 -0400
Received: from relay7.apple.com (relay7.apple.com [17.128.113.37])
	by mail-out4.apple.com (Postfix) with ESMTP id 3BB66C780A2;
	Thu, 19 Jul 2007 14:10:13 -0700 (PDT)
Received: from relay7.apple.com (unknown [127.0.0.1])
	by relay7.apple.com (Symantec Mail Security) with ESMTP id 260F1300A3;
	Thu, 19 Jul 2007 14:10:13 -0700 (PDT)
X-AuditID: 11807125-a1a1dbb0000007e5-98-469fd3357ce6
Received: from localhost.localdomain (il0301e-dhcp181.apple.com [17.203.15.181])
	by relay7.apple.com (Apple SCV relay) with ESMTP id F01EA30077;
	Thu, 19 Jul 2007 14:10:12 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc2.21.gfc4a18-dirty
In-Reply-To: <Pine.LNX.4.64.0707191944560.14781@racer.site>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53032>

Signed-off-by: Adam Roben <aroben@apple.com>
---
On Jul 19, 2007, at 11:46 AM, Johannes Schindelin wrote:

> > -       commit_editor=$(git config core.editor || echo ${VISUAL:-$EDITOR})
> > -       case "$commit_editor,$TERM" in
> > +       case "$GIT_EDITOR,$TERM" in
> >         ,dumb)
> 
>         This can no longer happen, since ...
> 
> >         +set_editor() {
> >         +    GIT_EDITOR=$(git config core.editor || echo ${VISUAL:-${EDITOR:-vi}})
> >         +    export GIT_EDITOR
> >         +}
> 
>         ... "vi" is the last resort, not "", right?
> 
>         So I guess you just want to drag that test and warning into git-sh-setup 
>         (where I think it has a better home anyway).

Here you go. I'm not terribly happy with the error message, though. I tried to
be as clear as possible and to keep some of the nice information that was in
the git-commit error message. Please improve upon it if you can.

 git-am.sh                  |    4 ++--
 git-commit.sh              |   11 +----------
 git-rebase--interactive.sh |    2 +-
 git-sh-setup.sh            |   15 +++++++++++++--
 git-tag.sh                 |    2 +-
 5 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index a5de0a1..dd517f4 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -7,7 +7,6 @@ USAGE='[--signoff] [--dotest=<dir>] [--utf8 | --no-utf8] [--binary] [--3way]
   or, when resuming [--skip | --resolved]'
 . git-sh-setup
 set_reflog_action am
-set_editor
 require_work_tree
 
 git var GIT_COMMITTER_IDENT >/dev/null || exit
@@ -365,7 +364,8 @@ do
 		[yY]*) action=yes ;;
 		[aA]*) action=yes interactive= ;;
 		[nN]*) action=skip ;;
-		[eE]*) "$GIT_EDITOR" "$dotest/final-commit"
+		[eE]*) set_editor
+		       "$GIT_EDITOR" "$dotest/final-commit"
 		       action=again ;;
 		[vV]*) action=again
 		       LESS=-S ${PAGER:-less} "$dotest/patch" ;;
diff --git a/git-commit.sh b/git-commit.sh
index 9adb03c..4d5d898 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -6,7 +6,6 @@
 USAGE='[-a | --interactive] [-s] [-v] [--no-verify] [-m <message> | -F <logfile> | (-C|-c) <commit> | --amend] [-u] [-e] [--author <author>] [[-i | -o] <path>...]'
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
-set_editor
 require_work_tree
 
 git rev-parse --verify HEAD >/dev/null 2>&1 || initial_commit=t
@@ -545,15 +544,7 @@ fi
 
 case "$no_edit" in
 '')
-	case "$GIT_EDITOR,$TERM" in
-	,dumb)
-		echo >&2 "Terminal is dumb but core.editor, VISUAL, and EDITOR"
-		echo >&2 "are undefined. Please supply the commit log message"
-		echo >&2 "using either -m or -F option.  A boilerplate log message"
-		echo >&2 "has been prepared in $GIT_DIR/COMMIT_EDITMSG"
-		exit 1
-		;;
-	esac
+	set_editor
 	git-var GIT_AUTHOR_IDENT > /dev/null  || die
 	git-var GIT_COMMITTER_IDENT > /dev/null  || die
 	$GIT_EDITOR "$GIT_DIR/COMMIT_EDITMSG"
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 32d1f53..27f8639 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -15,7 +15,6 @@ USAGE='(--continue | --abort | --skip | [--preserve-merges] [--verbose]
 
 . git-sh-setup
 require_work_tree
-set_editor
 
 DOTEST="$GIT_DIR/.dotest-merge"
 TODO="$DOTEST"/todo
@@ -415,6 +414,7 @@ EOF
 			die_abort "Nothing to do"
 
 		cp "$TODO" "$TODO".backup
+		set_editor
 		$GIT_EDITOR "$TODO" ||
 			die "Could not execute editor"
 
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index f43ab33..dbc4833 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -29,8 +29,19 @@ set_reflog_action() {
 }
 
 set_editor() {
-    GIT_EDITOR=$(git config core.editor || echo ${VISUAL:-${EDITOR:-vi}})
-    export GIT_EDITOR
+	GIT_EDITOR=$(git config core.editor || echo ${VISUAL:-${EDITOR}})
+	case "$GIT_EDITOR,$TERM" in
+	,dumb)
+		echo >&2 "No editor specified in core.editor, VISUAL, or EDITOR."
+		echo >&2 "Tried to fall back to vi but terminal is dumb."
+		echo >&2 "Please set one of these variables to an appropriate"
+		echo >&2 "editor or run $0 with options that will not cause an"
+		echo >&2 "editor to be invoked (e.g., -m or -F for git-commit)."
+		exit 1
+		;;
+	esac
+	GIT_EDITOR=${GIT_EDITOR:-vi}
+	export GIT_EDITOR
 }
 
 is_bare_repository () {
diff --git a/git-tag.sh b/git-tag.sh
index 0a6f2e7..f1a66d0 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -4,7 +4,6 @@
 USAGE='[-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f | -d | -v] [-m <msg>] <tagname> [<head>]'
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
-set_editor
 
 message_given=
 annotate=
@@ -178,6 +177,7 @@ if [ "$annotate" ]; then
         ( echo "#"
           echo "# Write a tag message"
           echo "#" ) > "$GIT_DIR"/TAG_EDITMSG
+        set_editor
         $GIT_EDITOR "$GIT_DIR"/TAG_EDITMSG || exit
     else
         printf '%s\n' "$message" >"$GIT_DIR"/TAG_EDITMSG
-- 
1.5.3.rc2.21.gfc4a18-dirty
