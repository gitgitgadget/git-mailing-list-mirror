From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 06/11] git-p4: honor --changesfile option and test
Date: Sat, 24 Dec 2011 21:07:35 -0500
Message-ID: <1324778860-4821-7-git-send-email-pw@padd.com>
References: <1324778860-4821-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 03:10:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RedXv-00011S-Nz
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 03:10:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758029Ab1LYCKk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Dec 2011 21:10:40 -0500
Received: from honk.padd.com ([74.3.171.149]:37311 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755440Ab1LYCKj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Dec 2011 21:10:39 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id A2B2131BF;
	Sat, 24 Dec 2011 18:10:38 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id D4460315E1; Sat, 24 Dec 2011 21:09:40 -0500 (EST)
X-Mailer: git-send-email 1.7.8.1.398.gf9d11
In-Reply-To: <1324778860-4821-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187669>

When an explicit list of changes is given, it makes no sense to
use @all or @3,5 or any of the other p4 revision specifiers.
Make the code notice when this happens, instead of just ignoring
--changesfile.  Test it.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   16 +++++++++++++++-
 t/t9806-git-p4-options.sh  |   23 +++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index dafc4a2..d0a9b0d 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -2024,6 +2024,17 @@ class P4Sync(Command, P4UserMap):
         revision = ""
         self.users = {}
 
+        # Make sure no revision specifiers are used when --changesfile
+        # is specified.
+        bad_changesfile = False
+        if len(self.changesFile) > 0:
+            for p in self.depotPaths:
+                if p.find("@") >= 0 or p.find("#") >= 0:
+                    bad_changesfile = True
+                    break
+        if bad_changesfile:
+            die("Option --changesfile is incompatible with revision specifiers")
+
         newPaths = []
         for p in self.depotPaths:
             if p.find("@") != -1:
@@ -2040,7 +2051,10 @@ class P4Sync(Command, P4UserMap):
                 revision = p[hashIdx:]
                 p = p[:hashIdx]
             elif self.previousDepotPaths == []:
-                revision = "#head"
+                # pay attention to changesfile, if given, else import
+                # the entire p4 tree at the head revision
+                if len(self.changesFile) == 0:
+                    revision = "#head"
 
             p = re.sub ("\.\.\.$", "", p)
             if not p.endswith("/"):
diff --git a/t/t9806-git-p4-options.sh b/t/t9806-git-p4-options.sh
index 7e2e45a..7a1dba6 100755
--- a/t/t9806-git-p4-options.sh
+++ b/t/t9806-git-p4-options.sh
@@ -38,6 +38,29 @@ test_expect_success 'clone --branch' '
 	)
 '
 
+test_expect_success 'clone --changesfile' '
+	cf="$TRASH_DIRECTORY/cf" &&
+	test_when_finished "rm \"$cf\"" &&
+	printf "1\n3\n" >"$cf" &&
+	"$GITP4" clone --changesfile="$cf" --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git log --oneline p4/master >lines &&
+		test_line_count = 2 lines
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_file file3
+	)
+'
+
+test_expect_success 'clone --changesfile, @all' '
+	cf="$TRASH_DIRECTORY/cf" &&
+	test_when_finished "rm \"$cf\"" &&
+	printf "1\n3\n" >"$cf" &&
+	test_must_fail "$GITP4" clone --changesfile="$cf" --dest="$git" //depot@all
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
1.7.8.534.g03ab.dirty
