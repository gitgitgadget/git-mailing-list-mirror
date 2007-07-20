From: Adam Roben <aroben@apple.com>
Subject: [PATCH] Add core.editor configuration variable
Date: Thu, 19 Jul 2007 17:28:23 -0700
Message-ID: <11848913032579-git-send-email-aroben@apple.com>
References: <7vfy3k2an7.fsf@assigned-by-dhcp.cox.net>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 02:28:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBgMQ-0006FY-JW
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 02:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758074AbXGTA2i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 20:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758014AbXGTA2i
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 20:28:38 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:49940 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758008AbXGTA2h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 20:28:37 -0400
Received: from relay6.apple.com (relay6.apple.com [17.128.113.36])
	by mail-out4.apple.com (Postfix) with ESMTP id F1FB7C7C555;
	Thu, 19 Jul 2007 17:28:11 -0700 (PDT)
Received: from relay6.apple.com (unknown [127.0.0.1])
	by relay6.apple.com (Symantec Mail Security) with ESMTP id E15F51011D;
	Thu, 19 Jul 2007 17:28:11 -0700 (PDT)
X-AuditID: 11807124-a5fb9bb0000007f3-b6-46a0019bf002
Received: from localhost.localdomain (unknown [17.112.108.169])
	by relay6.apple.com (Apple SCV relay) with ESMTP id 2ADF81004D;
	Thu, 19 Jul 2007 17:28:10 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc2.21.gfc4a18-dirty
In-Reply-To: <7vfy3k2an7.fsf@assigned-by-dhcp.cox.net>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53043>

This variable lets you specify an editor that will be launched in preference to
the EDITOR and VISUAL environment variables.

Signed-off-by: Adam Roben <aroben@apple.com>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
On Jul 19, 2007, at 5:15 PM, Junio C Hamano wrote:

> Could you please re-diff to make this into a single patch
> without intermediate "Oh, doing it this way is cleaner", and
> also with Dscho's Ack?  I do not think we would need to have 3
> commits for this topic --- it is not like wide userbase tested
> each iteration.

 Documentation/git-commit.txt     |    9 +++++----
 Documentation/git-send-email.txt |    4 ++--
 git-am.sh                        |    3 ++-
 git-commit.sh                    |   12 ++----------
 git-rebase--interactive.sh       |    3 ++-
 git-send-email.perl              |    3 +--
 git-sh-setup.sh                  |   16 ++++++++++++++++
 git-tag.sh                       |    3 ++-
 8 files changed, 32 insertions(+), 21 deletions(-)

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
index e5e6f2c..dd517f4 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -364,7 +364,8 @@ do
 		[yY]*) action=yes ;;
 		[aA]*) action=yes interactive= ;;
 		[nN]*) action=skip ;;
-		[eE]*) "${VISUAL:-${EDITOR:-vi}}" "$dotest/final-commit"
+		[eE]*) set_editor
+		       "$GIT_EDITOR" "$dotest/final-commit"
 		       action=again ;;
 		[vV]*) action=again
 		       LESS=-S ${PAGER:-less} "$dotest/patch" ;;
diff --git a/git-commit.sh b/git-commit.sh
index 3f3de17..4d5d898 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -544,18 +544,10 @@ fi
 
 case "$no_edit" in
 '')
-	case "${VISUAL:-$EDITOR},$TERM" in
-	,dumb)
-		echo >&2 "Terminal is dumb but no VISUAL nor EDITOR defined."
-		echo >&2 "Please supply the commit log message using either"
-		echo >&2 "-m or -F option.  A boilerplate log message has"
-		echo >&2 "been prepared in $GIT_DIR/COMMIT_EDITMSG"
-		exit 1
-		;;
-	esac
+	set_editor
 	git-var GIT_AUTHOR_IDENT > /dev/null  || die
 	git-var GIT_COMMITTER_IDENT > /dev/null  || die
-	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG"
+	$GIT_EDITOR "$GIT_DIR/COMMIT_EDITMSG"
 	;;
 esac
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f395076..27f8639 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -414,7 +414,8 @@ EOF
 			die_abort "Nothing to do"
 
 		cp "$TODO" "$TODO".backup
-		${VISUAL:-${EDITOR:-vi}} "$TODO" ||
+		set_editor
+		$GIT_EDITOR "$TODO" ||
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
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 4ed07e9..dbc4833 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -28,6 +28,22 @@ set_reflog_action() {
 	fi
 }
 
+set_editor() {
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
+}
+
 is_bare_repository () {
 	git rev-parse --is-bare-repository
 }
diff --git a/git-tag.sh b/git-tag.sh
index 1c25d88..f1a66d0 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -177,7 +177,8 @@ if [ "$annotate" ]; then
         ( echo "#"
           echo "# Write a tag message"
           echo "#" ) > "$GIT_DIR"/TAG_EDITMSG
-        ${VISUAL:-${EDITOR:-vi}} "$GIT_DIR"/TAG_EDITMSG || exit
+        set_editor
+        $GIT_EDITOR "$GIT_DIR"/TAG_EDITMSG || exit
     else
         printf '%s\n' "$message" >"$GIT_DIR"/TAG_EDITMSG
     fi
-- 
1.5.3.rc2.21.gfc4a18-dirty
