From: Adam Roben <aroben@apple.com>
Subject: [PATCH] Add GIT_EDITOR environment variable and core.editor configuration variable
Date: Thu, 19 Jul 2007 22:09:35 -0700
Message-ID: <11849081753870-git-send-email-aroben@apple.com>
References: <11848913032579-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 07:09:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBkkG-0000Bw-SI
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 07:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbXGTFJh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 01:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750944AbXGTFJg
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 01:09:36 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:53360 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbXGTFJf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 01:09:35 -0400
Received: from relay5.apple.com (relay5.apple.com [17.128.113.35])
	by mail-out4.apple.com (Postfix) with ESMTP id 5DA23C80F6B;
	Thu, 19 Jul 2007 22:09:35 -0700 (PDT)
Received: from relay5.apple.com (unknown [127.0.0.1])
	by relay5.apple.com (Symantec Mail Security) with ESMTP id 48E9829C002;
	Thu, 19 Jul 2007 22:09:35 -0700 (PDT)
X-AuditID: 11807123-a4f3cbb000000b34-42-46a0438f91f1
Received: from localhost.localdomain (il0301e-dhcp181.apple.com [17.203.15.181])
	by relay5.apple.com (Apple SCV relay) with ESMTP id 1FDF330400C;
	Thu, 19 Jul 2007 22:09:35 -0700 (PDT)
X-Mailer: git-send-email 1.5.3.rc2.20.g2e098-dirty
In-Reply-To: <11848913032579-git-send-email-aroben@apple.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53053>

These variables let you specify an editor that will be launched in preference to
the EDITOR and VISUAL environment variables. The order of preference is
GIT_EDITOR, core.editor, EDITOR, VISUAL.

Signed-off-by: Adam Roben <aroben@apple.com>
---
This patch obsoletes all the previous ones I've sent for this change.

After discussing a bit with Junio and Shawn, this patch introduces
git-sh-setup::git_editor() to handle invoking the editor. It also respects the
GIT_EDITOR environment variable for overriding the choice of editor.

Hopefully this is the last version of this patch :-)

 Documentation/git-commit.txt     |   10 ++++++----
 Documentation/git-send-email.txt |    4 ++--
 git-am.sh                        |    2 +-
 git-commit.sh                    |   11 +----------
 git-rebase--interactive.sh       |    2 +-
 git-send-email.perl              |    7 +++----
 git-sh-setup.sh                  |   15 +++++++++++++++
 git-tag.sh                       |    2 +-
 8 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f96142f..8e0e7e2 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -244,10 +244,12 @@ on the Subject: line and the rest of the commit in the body.
 
 include::i18n.txt[]
 
-ENVIRONMENT VARIABLES
----------------------
-The command specified by either the VISUAL or EDITOR environment
-variables is used to edit the commit log message.
+ENVIRONMENT AND CONFIGURATION VARIABLES
+---------------------------------------
+The editor used to edit the commit log message will be chosen from the
+GIT_EDITOR environment variable, the core.editor configuration variable, the
+VISUAL environment variable, or the EDITOR environment variable (in that
+order).
 
 HOOKS
 -----
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 293686c..d243ed1 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -44,8 +44,8 @@ The --cc option must be repeated for each user you want on the cc list.
 	value; if that is unspecified, default to --chain-reply-to.
 
 --compose::
-	Use $EDITOR to edit an introductory message for the
-	patch series.
+	Use $GIT_EDITOR, core.editor, $VISUAL, or $EDITOR to edit an
+	introductory message for the patch series.
 
 --from::
 	Specify the sender of the emails.  This will default to
diff --git a/git-am.sh b/git-am.sh
index e5e6f2c..bfd65dc 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -364,7 +364,7 @@ do
 		[yY]*) action=yes ;;
 		[aA]*) action=yes interactive= ;;
 		[nN]*) action=skip ;;
-		[eE]*) "${VISUAL:-${EDITOR:-vi}}" "$dotest/final-commit"
+		[eE]*) git_editor "$dotest/final-commit"
 		       action=again ;;
 		[vV]*) action=again
 		       LESS=-S ${PAGER:-less} "$dotest/patch" ;;
diff --git a/git-commit.sh b/git-commit.sh
index 3f3de17..92749df 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -544,18 +544,9 @@ fi
 
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
 	git-var GIT_AUTHOR_IDENT > /dev/null  || die
 	git-var GIT_COMMITTER_IDENT > /dev/null  || die
-	${VISUAL:-${EDITOR:-vi}} "$GIT_DIR/COMMIT_EDITMSG"
+	git_editor "$GIT_DIR/COMMIT_EDITMSG"
 	;;
 esac
 
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index f395076..a2d4d09 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -414,7 +414,7 @@ EOF
 			die_abort "Nothing to do"
 
 		cp "$TODO" "$TODO".backup
-		${VISUAL:-${EDITOR:-vi}} "$TODO" ||
+		git_editor "$TODO" ||
 			die "Could not execute editor"
 
 		test -z "$(grep -ve '^$' -e '^#' < $TODO)" &&
diff --git a/git-send-email.perl b/git-send-email.perl
index 7552cac..a09b1c9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -49,8 +49,8 @@ Options:
    --bcc          Specify a list of email addresses that should be Bcc:
 		  on all the emails.
 
-   --compose      Use \$EDITOR to edit an introductory message for the
-                  patch series.
+   --compose      Use \$GIT_EDITOR, core.editor, \$EDITOR, or \$VISUAL to edit
+		  an introductory message for the patch series.
 
    --subject      Specify the initial "Subject:" line.
                   Only necessary if --compose is also set.  If --compose
@@ -341,8 +341,7 @@ GIT: for the patch you are writing.
 EOT
 	close(C);
 
-	my $editor = $ENV{EDITOR};
-	$editor = 'vi' unless defined $editor;
+	my $editor = $ENV{GIT_EDITOR} || $repo->config("core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
 	system($editor, $compose_filename);
 
 	open(C2,">",$compose_filename . ".final")
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 4ed07e9..c51985e 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -28,6 +28,21 @@ set_reflog_action() {
 	fi
 }
 
+git_editor() {
+	GIT_EDITOR=${GIT_EDITOR:-$(git config core.editor || echo ${VISUAL:-${EDITOR}})}
+	case "$GIT_EDITOR,$TERM" in
+	,dumb)
+		echo >&2 "No editor specified in GIT_EDITOR, core.editor, VISUAL,"
+		echo >&2 "or EDITOR. Tried to fall back to vi but terminal is dumb."
+		echo >&2 "Please set one of these variables to an appropriate"
+		echo >&2 "editor or run $0 with options that will not cause an"
+		echo >&2 "editor to be invoked (e.g., -m or -F for git-commit)."
+		exit 1
+		;;
+	esac
+	"${GIT_EDITOR:-vi}" "$1"
+}
+
 is_bare_repository () {
 	git rev-parse --is-bare-repository
 }
diff --git a/git-tag.sh b/git-tag.sh
index 1c25d88..5ee3f50 100755
--- a/git-tag.sh
+++ b/git-tag.sh
@@ -177,7 +177,7 @@ if [ "$annotate" ]; then
         ( echo "#"
           echo "# Write a tag message"
           echo "#" ) > "$GIT_DIR"/TAG_EDITMSG
-        ${VISUAL:-${EDITOR:-vi}} "$GIT_DIR"/TAG_EDITMSG || exit
+        git_editor "$GIT_DIR"/TAG_EDITMSG || exit
     else
         printf '%s\n' "$message" >"$GIT_DIR"/TAG_EDITMSG
     fi
-- 
1.5.3.rc2.20.g2e098-dirty
