From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v2 3/7] i18n: git-parse-remote.sh: mark strings for translation
Date: Sat,  9 Apr 2016 20:38:40 +0000
Message-ID: <1460234324-13506-3-git-send-email-vascomalmeida@sapo.pt>
References: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 22:39:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aozfA-00010m-PD
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 22:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbcDIUjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 16:39:19 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:53532 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754517AbcDIUjS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 16:39:18 -0400
Received: (qmail 14478 invoked from network); 9 Apr 2016 20:39:03 -0000
Received: (qmail 16207 invoked from network); 9 Apr 2016 20:39:03 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 9 Apr 2016 20:38:58 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1460234324-13506-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291130>

Change Makefile to include git-parse-remote.sh in LOCALIZED_SH.

TODO: remove 3rd argument of error_on_missing_default_upstream function
that is no longer required.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 Makefile            |  2 +-
 git-parse-remote.sh | 50 +++++++++++++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index 2742a69..2249bab 100644
--- a/Makefile
+++ b/Makefile
@@ -2069,7 +2069,7 @@ XGETTEXT_FLAGS_SH = $(XGETTEXT_FLAGS) --language=Shell \
 	--keyword=gettextln --keyword=eval_gettextln
 XGETTEXT_FLAGS_PERL = $(XGETTEXT_FLAGS) --keyword=__ --language=Perl
 LOCALIZED_C = $(C_OBJ:o=c) $(LIB_H) $(GENERATED_H)
-LOCALIZED_SH = $(SCRIPT_SH)
+LOCALIZED_SH = $(SCRIPT_SH) git-parse-remote.sh
 LOCALIZED_PERL = $(SCRIPT_PERL)
 
 ifdef XGETTEXT_INCLUDE_TESTS
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 55fe8d5..c5e5840 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -6,6 +6,9 @@
 # this would fail in that case and would issue an error message.
 GIT_DIR=$(git rev-parse -q --git-dir) || :;
 
+. git-sh-setup
+. git-sh-i18n
+
 get_default_remote () {
 	curr_branch=$(git symbolic-ref -q HEAD)
 	curr_branch="${curr_branch#refs/heads/}"
@@ -56,11 +59,13 @@ get_remote_merge_branch () {
 error_on_missing_default_upstream () {
 	cmd="$1"
 	op_type="$2"
-	op_prep="$3"
+	op_prep="$3" # FIXME: op_prep is no longer used
 	example="$4"
 	branch_name=$(git symbolic-ref -q HEAD)
+	display_branch_name="${branch_name#refs/heads/}"
 	# If there's only one remote, use that in the suggestion
-	remote="<remote>"
+	remote="$(gettext "<remote>")"
+	branch="$(gettext "branch")"
 	if test $(git remote | wc -l) = 1
 	then
 		remote=$(git remote)
@@ -68,22 +73,33 @@ error_on_missing_default_upstream () {
 
 	if test -z "$branch_name"
 	then
-		echo "You are not currently on a branch. Please specify which
-branch you want to $op_type $op_prep. See git-${cmd}(1) for details.
-
-    $example
-"
+		gettextln "You are not currently on a branch."
+		if test "$op_type" = rebase
+		then
+			gettextln "Please specify which branch you want to rebase against."
+		else
+			gettextln "Please specify which branch you want to merge with."
+		fi
+		eval_gettextln "See git-\${cmd}(1) for details."
+		echo
+		echo "    $example"
+		echo
 	else
-		echo "There is no tracking information for the current branch.
-Please specify which branch you want to $op_type $op_prep.
-See git-${cmd}(1) for details
-
-    $example
-
-If you wish to set tracking information for this branch you can do so with:
-
-    git branch --set-upstream-to=$remote/<branch> ${branch_name#refs/heads/}
-"
+		gettextln "There is no tracking information for the current branch."
+		if test "$op_type" = rebase
+		then
+			gettextln "Please specify which branch you want to rebase against."
+		else
+			gettextln "Please specify which branch you want to merge with."
+		fi
+		eval_gettextln "See git-\${cmd}(1) for details."
+		echo
+		echo "    $example"
+		echo
+		gettextln "If you wish to set tracking information for this branch you can do so with:"
+		echo
+		echo "    git branch --set-upstream-to=$remote/<$branch> $display_branch_name"
+		echo
 	fi
 	exit 1
 }
-- 
2.1.4
