From: Adam Roben <aroben@apple.com>
Subject: [PATCH (REVISED)] Add core.editor configuration variable
Date: Wed, 18 Jul 2007 23:55:30 -0700
Message-ID: <11848281302504-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 08:55:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBPvG-00087K-0X
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 08:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598AbXGSGzf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 02:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755764AbXGSGzf
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 02:55:35 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:63328 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754929AbXGSGze (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 02:55:34 -0400
Received: from relay7.apple.com (relay7.apple.com [17.128.113.37])
	by mail-out4.apple.com (Postfix) with ESMTP id 2A231C684F5;
	Wed, 18 Jul 2007 23:55:34 -0700 (PDT)
Received: from relay7.apple.com (unknown [127.0.0.1])
	by relay7.apple.com (Symantec Mail Security) with ESMTP id 172203007D;
	Wed, 18 Jul 2007 23:55:34 -0700 (PDT)
X-AuditID: 11807125-a1a1dbb0000007e5-db-469f0ae59bfd
Received: from localhost.localdomain (unknown [17.112.108.175])
	by relay7.apple.com (Apple SCV relay) with ESMTP id A8AA930006;
	Wed, 18 Jul 2007 23:55:32 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc2.19.gc4fba-dirty
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52945>

This variable lets you specify an editor that will be launched in preference to
the EDITOR and VISUAL environment variables.

Signed-off-by: Adam Roben <aroben@apple.com>
---
On Jul 18, 2007, at 11:23 PM, Shawn O. Pearce wrote:
> We only launch an editor for three reasons: commit messages, tag
> messages and git-rebase -i.  If we were to ever add a new editor
> using thingy, odds are the user would want the same editor by
> default for that too.

   Well, it turns out we already do launch an editor in other places, namely
"git am -i" and "git send-email --compose". So, this patch takes care of those
cases as well.

   My original intent had been to have an editor that really was *just* for
commit messages, but I realize now that that is probably something that not too
many people want, whereas core.editor is much more generally useful. Thanks
Junio and Shawn for the advice.

 Documentation/git-commit.txt     |    9 +++++----
 Documentation/git-send-email.txt |    4 ++--
 git-am.sh                        |    2 +-
 git-commit.sh                    |   13 +++++++------
 git-rebase--interactive.sh       |    2 +-
 git-send-email.perl              |    3 +--
 git-tag.sh                       |    2 +-
 7 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f96142f..5caad56 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -244,10 +244,11 @@ on the Subject: line and the rest of the commit in the body.
 
 include::i18n.txt[]
 
-ENVIRONMENT VARIABLES
----------------------
-The command specified by either the VISUAL or EDITOR environment
-variables is used to edit the commit log message.
+ENVIRONMENT AND CONFIGURATION VARIABLES
+---------------------------------------
+The editor used to edit the commit log message will be chosen from the
+core.editor configuration variable, the VISUAL environment variable, or the
+EDITOR environment variable (in that order).
 
 HOOKS
 -----
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 293686c..e7723c9 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -44,8 +44,8 @@ The --cc option must be repeated for each user you want on the cc list.
 	value; if that is unspecified, default to --chain-reply-to.
 
 --compose::
-	Use $EDITOR to edit an introductory message for the
-	patch series.
+	Use core.editor, $VISUAL, or $EDITOR to edit an introductory message
+	for the patch series.
 
 --from::
 	Specify the sender of the emails.  This will default to
diff --git a/git-am.sh b/git-am.sh
index e5e6f2c..3a651ae 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -364,7 +364,7 @@ do
 		[yY]*) action=yes ;;
 		[aA]*) action=yes interactive= ;;
 		[nN]*) action=skip ;;
-		[eE]*) "${VISUAL:-${EDITOR:-vi}}" "$dotest/final-commit"
+		[eE]*) "$(git config core.editor || echo ${VISUAL:-${EDITOR:-vi}})" "$dotest/final-commit"
 		       action=again ;;
 		[vV]*) action=again
 		       LESS=-S ${PAGER:-less} "$dotest/patch" ;;
diff --git a/git-commit.sh b/git-commit.sh
index 3f3de17..72e4cf0 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -544,18 +544,19 @@ fi
 
 case "$no_edit" in
 '')
-	case "${VISUAL:-$EDITOR},$TERM" in
+	commit_editor=$(git config core.editor || echo ${VISUAL:-$EDITOR})
+	case "$commit_editor,$TERM" in
 	,dumb)
-		echo >&2 "Terminal is dumb but no VISUAL nor EDITOR defined."
-		echo >&2 "Please supply the commit log message using either"
-		echo >&2 "-m or -F option.  A boilerplate log message has"
-		echo >&2 "been prepared in $GIT_DIR/COMMIT_EDITMSG"
+		echo >&2 "Terminal is dumb but core.editor, VISUAL, and EDITOR"
+		echo >&2 "are undefined. Please supply the commit log message"
+		echo >&2 "using either -m or -F option.  A boilerplate log message"
+		echo >&2 "has been prepared in $GIT_DIR/COMMIT_EDITMSG"
 		exit 1
 		;;
 	esac
 	git-var GIT_AUTHOR_IDENT > /dev/null  || die
 	git-var GIT_COMMITTER_IDENT > /dev/null  || die
-	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG"
+	${commit_editor:-vi} "$GIT_DIR/COMMIT_EDITMSG"
 	;;
 esac
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f395076..2e15abb 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -414,7 +414,7 @@ EOF
 			die_abort "Nothing to do"
 
 		cp "$TODO" "$TODO".backup
-		${VISUAL:-${EDITOR:-vi}} "$TODO" ||
+		$(git config core.editor || echo ${VISUAL:-${EDITOR:-vi}}) "$TODO" ||
 			die "Could not execute editor"
 
 		test -z "$(grep -ve '^$' -e '^#' < $TODO)" &&
diff --git a/git-send-email.perl b/git-send-email.perl
index 7552cac..ad17b4e 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -341,8 +341,7 @@ GIT: for the patch you are writing.
 EOT
 	close(C);
 
-	my $editor = $ENV{EDITOR};
-	$editor = 'vi' unless defined $editor;
+	my $editor = $repo->config("core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
 	system($editor, $compose_filename);
 
 	open(C2,">",$compose_filename . ".final")
diff --git a/git-tag.sh b/git-tag.sh
index 1c25d88..9aa30b4 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -177,7 +177,7 @@ if [ "$annotate" ]; then
         ( echo "#"
           echo "# Write a tag message"
           echo "#" ) > "$GIT_DIR"/TAG_EDITMSG
-        ${VISUAL:-${EDITOR:-vi}} "$GIT_DIR"/TAG_EDITMSG || exit
+        $(git config core.editor || echo ${VISUAL:-${EDITOR:-vi}}) "$GIT_DIR"/TAG_EDITMSG || exit
     else
         printf '%s\n' "$message" >"$GIT_DIR"/TAG_EDITMSG
     fi
-- 
1.5.3.rc2.19.gc4fba-dirty
