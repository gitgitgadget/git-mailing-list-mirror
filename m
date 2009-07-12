From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 1/6] config: allow false and true values for branch.autosetuprebase
Date: Sun, 12 Jul 2009 14:17:28 +0200
Message-ID: <1247401053-20429-2-git-send-email-bonzini@gnu.org>
References: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 12 14:17:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPy08-0001H1-6t
	for gcvg-git-2@gmane.org; Sun, 12 Jul 2009 14:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748AbZGLMRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2009 08:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbZGLMRm
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jul 2009 08:17:42 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:60346 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbZGLMRj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2009 08:17:39 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MPxzu-0003Ra-AW
	for git@vger.kernel.org; Sun, 12 Jul 2009 08:17:38 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1247401053-20429-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123142>

Boolean values can be clearly DWIM'ed from false to never and
from true to always.  This is nicer to the user because autosetupmerge
allows boolean values.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
---
 Documentation/config.txt |    4 ++--
 config.c                 |   12 ++++++------
 t/t3200-branch.sh        |   15 ++++++++++++---
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index cb6832b..1e37e33 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -479,12 +479,12 @@ branch.autosetuprebase::
 	When a new branch is created with 'git-branch' or 'git-checkout'
 	that tracks another branch, this variable tells git to set
 	up pull to rebase instead of merge (see "branch.<name>.rebase").
-	When `never`, rebase is never automatically set to true.
+	When `never` or `false`, rebase is never automatically set to true.
 	When `local`, rebase is set to true for tracked branches of
 	other local branches.
 	When `remote`, rebase is set to true for tracked branches of
 	remote branches.
-	When `always`, rebase will be set to true for all tracking
+	When `always` or `true`, rebase will be set to true for all tracking
 	branches.
 	See "branch.autosetupmerge" for details on how to set up a
 	branch to track another branch.
diff --git a/config.c b/config.c
index 1682273..b47a40e 100644
--- a/config.c
+++ b/config.c
@@ -557,17 +557,17 @@ static int git_default_branch_config(const char *var, const char *value)
 	}
 	if (!strcmp(var, "branch.autosetuprebase")) {
 		if (!value)
-			return config_error_nonbool(var);
-		else if (!strcmp(value, "never"))
-			autorebase = AUTOREBASE_NEVER;
+			value = "always";
+		autorebase = AUTOREBASE_NEVER;
+		if (!strcmp(value, "never"))
+			;
 		else if (!strcmp(value, "local"))
 			autorebase = AUTOREBASE_LOCAL;
 		else if (!strcmp(value, "remote"))
 			autorebase = AUTOREBASE_REMOTE;
-		else if (!strcmp(value, "always"))
+		else if (!strcmp(value, "always") ||
+			 git_config_bool (var, value))
 			autorebase = AUTOREBASE_ALWAYS;
-		else
-			return error("Malformed value for %s", var);
 		return 0;
 	}
 
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index d59a9b4..b14a3a9 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -461,11 +461,20 @@ test_expect_success 'detect misconfigured autosetuprebase (bad value)' '
 	test_must_fail git branch
 '
 
-test_expect_success 'detect misconfigured autosetuprebase (no value)' '
+test_expect_success 'boolean value (no value) for autosetuprebase' '
 	git config --unset branch.autosetuprebase &&
 	echo "[branch] autosetuprebase" >> .git/config &&
-	test_must_fail git branch &&
-	git config --unset branch.autosetuprebase
+	git config remote.local.url . &&
+	git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
+	(git show-ref -q refs/remotes/local/master || git fetch local) &&
+	git branch --track myr21 local/master &&
+	git branch --track myr22 myr21 &&
+	test "$(git config branch.myr21.remote)" = local &&
+	test "$(git config branch.myr21.merge)" = refs/heads/master &&
+	test "z$(git config branch.myr21.rebase)" = ztrue &&
+	test "$(git config branch.myr22.remote)" = . &&
+	test "$(git config branch.myr22.merge)" = refs/heads/myr21 &&
+	test "z$(git config branch.myr22.rebase)" = ztrue
 '
 
 test_done
-- 
1.6.2.5
