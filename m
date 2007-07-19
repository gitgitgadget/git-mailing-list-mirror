From: Adam Roben <aroben@apple.com>
Subject: [PATCH] Add commit.editor configuration variable
Date: Wed, 18 Jul 2007 22:39:48 -0700
Message-ID: <11848235881723-git-send-email-aroben@apple.com>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Roben <aroben@apple.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 07:39:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBOjw-0006mE-T3
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 07:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbXGSFju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 01:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753781AbXGSFju
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 01:39:50 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:58883 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753058AbXGSFjt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 01:39:49 -0400
Received: from relay8.apple.com (relay8.apple.com [17.128.113.38])
	by mail-out4.apple.com (Postfix) with ESMTP id 1B401C67333;
	Wed, 18 Jul 2007 22:39:49 -0700 (PDT)
Received: from relay8.apple.com (unknown [127.0.0.1])
	by relay8.apple.com (Symantec Mail Security) with ESMTP id 0539E40452;
	Wed, 18 Jul 2007 22:39:49 -0700 (PDT)
X-AuditID: 11807126-a6c47bb0000007e3-ac-469ef924536b
Received: from localhost.localdomain (unknown [17.112.108.175])
	by relay8.apple.com (Apple SCV relay) with ESMTP id B098C4044E;
	Wed, 18 Jul 2007 22:39:48 -0700 (PDT)
X-Mailer: git-send-email 1.5.2.2.620.g42358-dirty
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52937>

This variable lets you specify a different editor for editing commit messages.
If commit.editor is not set, git-commit falls back to VISUAL, then EDITOR as
before.

Signed-off-by: Adam Roben <aroben@apple.com>
---
 Documentation/git-commit.txt |    9 +++++----
 git-commit.sh                |   13 +++++++------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f96142f..1a628be 100644
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
+commit.editor configuration variable, the VISUAL environment variable, or the
+EDITOR environment variable (in that order).
 
 HOOKS
 -----
diff --git a/git-commit.sh b/git-commit.sh
index 3f3de17..c4d8501 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -544,18 +544,19 @@ fi
 
 case "$no_edit" in
 '')
-	case "${VISUAL:-$EDITOR},$TERM" in
+	commit_editor=$(git config commit.editor || echo ${VISUAL:-$EDITOR})
+	case "$commit_editor,$TERM" in
 	,dumb)
-		echo >&2 "Terminal is dumb but no VISUAL nor EDITOR defined."
-		echo >&2 "Please supply the commit log message using either"
-		echo >&2 "-m or -F option.  A boilerplate log message has"
-		echo >&2 "been prepared in $GIT_DIR/COMMIT_EDITMSG"
+		echo >&2 "Terminal is dumb but commit.editor, VISUAL, and EDITOR"
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
 
-- 
1.5.2.2.620.g42358-dirty
