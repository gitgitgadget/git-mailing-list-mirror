From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/2] git-p4: set useClientSpec variable on initial clone
Date: Sat, 25 Feb 2012 20:06:24 -0500
Message-ID: <1330218385-22309-2-git-send-email-pw@padd.com>
References: <1330218385-22309-1-git-send-email-pw@padd.com>
Cc: =?UTF-8?q?Laurent=20Charri=C3=A8re?= <lcharriere@promptu.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 02:07:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1SZm-0003tB-Cm
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 02:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab2BZBGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 20:06:55 -0500
Received: from honk.padd.com ([74.3.171.149]:55347 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751305Ab2BZBGt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 20:06:49 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id EDFBBE8D;
	Sat, 25 Feb 2012 17:06:48 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id B0873313D8; Sat, 25 Feb 2012 20:06:45 -0500 (EST)
X-Mailer: git-send-email 1.7.9.220.g4b839
In-Reply-To: <1330218385-22309-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191549>

If --use-client-spec was given, set the matching configuration
variable.  This is necessary to ensure that future submits
work properly.

The alternatives of requiring the user to set it, or providing
a command-line option on every submit, are error prone.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 Documentation/git-p4.txt      |   10 +++++++---
 contrib/fast-import/git-p4    |   11 ++++++++++-
 t/t9809-git-p4-client-view.sh |   17 +++++++++++++++++
 3 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 78938b2..ed82790 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -303,9 +303,13 @@ CLIENT SPEC
 -----------
 The p4 client specification is maintained with the 'p4 client' command
 and contains among other fields, a View that specifies how the depot
-is mapped into the client repository.  Git-p4 can consult the client
-spec when given the '--use-client-spec' option or useClientSpec
-variable.
+is mapped into the client repository.  The 'clone' and 'sync' commands
+can consult the client spec when given the '--use-client-spec' option or
+when the useClientSpec variable is true.  After 'git p4 clone', the
+useClientSpec variable is automatically set in the repository
+configuration file.  This allows future 'git p4 submit' commands to
+work properly; the submit command looks only at the variable and does
+not have a command-line option.
 
 The full syntax for a p4 view is documented in 'p4 help views'.  Git-p4
 knows only a subset of the view syntax.  It understands multi-line
diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3e1aa27..94f0a12 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1428,6 +1428,7 @@ class P4Sync(Command, P4UserMap):
         self.p4BranchesInGit = []
         self.cloneExclude = []
         self.useClientSpec = False
+        self.useClientSpec_from_options = False
         self.clientSpecDirs = None
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
@@ -2136,7 +2137,11 @@ class P4Sync(Command, P4UserMap):
             if not gitBranchExists(self.refPrefix + "HEAD") and self.importIntoRemotes and gitBranchExists(self.branch):
                 system("git symbolic-ref %sHEAD %s" % (self.refPrefix, self.branch))
 
-        if not self.useClientSpec:
+        # accept either the command-line option, or the configuration variable
+        if self.useClientSpec:
+            # will use this after clone to set the variable
+            self.useClientSpec_from_options = True
+        else:
             if gitConfig("git-p4.useclientspec", "--bool") == "true":
                 self.useClientSpec = True
         if self.useClientSpec:
@@ -2455,6 +2460,10 @@ class P4Clone(P4Sync):
             else:
                 print "Could not detect main branch. No checkout/master branch created."
 
+        # auto-set this variable if invoked with --use-client-spec
+        if self.useClientSpec_from_options:
+            system("git config --bool git-p4.useclientspec true")
+
         return True
 
 class P4Branches(Command):
diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index c9471d5..25e01a4 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -241,6 +241,23 @@ test_expect_success 'quotes on rhs only' '
 '
 
 #
+# Submit tests
+#
+
+# clone sets variable
+test_expect_success 'clone --use-client-spec sets useClientSpec' '
+	client_view "//depot/... //client/..." &&
+	test_when_finished cleanup_git &&
+	"$GITP4" clone --use-client-spec --dest="$git" //depot &&
+	(
+		cd "$git" &&
+		git config --bool git-p4.useClientSpec >actual &&
+		echo true >true &&
+		test_cmp actual true
+	)
+'
+
+#
 # Rename directories to test quoting in depot-side mappings
 # //depot
 #    - "dir 1"
-- 
1.7.9.219.g1d56c.dirty
