From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2 8/8] git-p4: support clone --bare
Date: Sat, 19 Feb 2011 08:18:01 -0500
Message-ID: <1298121481-7005-9-git-send-email-pw@padd.com>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 14:19:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqmiC-0001ch-Jl
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 14:19:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695Ab1BSNSp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 08:18:45 -0500
Received: from honk.padd.com ([74.3.171.149]:51199 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389Ab1BSNST (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 08:18:19 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 361F520CC;
	Sat, 19 Feb 2011 05:18:18 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id F348431B26; Sat, 19 Feb 2011 08:18:06 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1298121481-7005-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167279>

Just like git clone --bare, build a .git directory but no
checked out files.

Signed-off-by: Pete Wyckoff <pw@padd.com>
Acked-By: Tor Arvid Lund <torarvid@gmail.com>
---
 contrib/fast-import/git-p4 |   17 +++++++++++++----
 t/t9800-git-p4.sh          |   10 ++++++++++
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 98597d3..725af75 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1776,10 +1776,13 @@ class P4Clone(P4Sync):
                                  help="where to leave result of the clone"),
             optparse.make_option("-/", dest="cloneExclude",
                                  action="append", type="string",
-                                 help="exclude depot path")
+                                 help="exclude depot path"),
+            optparse.make_option("--bare", dest="cloneBare",
+                                 action="store_true", default=False),
         ]
         self.cloneDestination = None
         self.needsGit = False
+        self.cloneBare = False
 
     # This is required for the "append" cloneExclude action
     def ensure_value(self, attr, value):
@@ -1819,11 +1822,16 @@ class P4Clone(P4Sync):
             self.cloneDestination = self.defaultDestination(args)
 
         print "Importing from %s into %s" % (', '.join(depotPaths), self.cloneDestination)
+
         if not os.path.exists(self.cloneDestination):
             os.makedirs(self.cloneDestination)
         chdir(self.cloneDestination)
-        system("git init")
-        self.gitdir = os.getcwd() + "/.git"
+
+        init_cmd = [ "git", "init" ]
+        if self.cloneBare:
+            init_cmd.append("--bare")
+        subprocess.check_call(init_cmd)
+
         if not P4Sync.run(self, depotPaths):
             return False
         if self.branch != "master":
@@ -1833,7 +1841,8 @@ class P4Clone(P4Sync):
                 masterbranch = "refs/heads/p4/master"
             if gitBranchExists(masterbranch):
                 system("git branch master %s" % masterbranch)
-                system("git checkout -f")
+                if not self.cloneBare:
+                    system("git checkout -f")
             else:
                 print "Could not detect main branch. No checkout/master branch created."
 
diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 026277a..1969e6b 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -80,6 +80,16 @@ test_expect_success 'wildcard files git-p4 clone' '
 	rm -rf "$git" && mkdir "$git"
 '
 
+test_expect_success 'clone bare' '
+	"$GITP4" clone --dest="$git" --bare //depot &&
+	cd "$git" &&
+	test ! -d .git &&
+	bare=`git config --get core.bare` &&
+	test "$bare" = true &&
+	cd "$TRASH_DIRECTORY" &&
+	rm -rf "$git" && mkdir "$git"
+'
+
 test_expect_success 'shutdown' '
 	pid=`pgrep -f p4d` &&
 	test -n "$pid" &&
-- 
1.7.4.1
