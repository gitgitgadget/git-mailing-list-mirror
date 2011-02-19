From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH v2 7/8] git-p4: decode p4 wildcard characters
Date: Sat, 19 Feb 2011 08:18:00 -0500
Message-ID: <1298121481-7005-8-git-send-email-pw@padd.com>
References: <1298121481-7005-1-git-send-email-pw@padd.com>
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	Vitor Antunes <vitor.hda@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 14:18:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqmiB-0001ch-06
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 14:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655Ab1BSNSj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 08:18:39 -0500
Received: from honk.padd.com ([74.3.171.149]:51182 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301Ab1BSNST (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 08:18:19 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 2EE2120CB;
	Sat, 19 Feb 2011 05:18:18 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id F0F7731AEE; Sat, 19 Feb 2011 08:18:06 -0500 (EST)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1298121481-7005-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167278>

There are four wildcard characters in p4.  Files with these
characters can be added to p4 repos using the "-f" option.
They are stored in %xx notation, and when checked out, p4
converts them back to normal.

This patch does the same thing when importing into git,
converting the four special characters.  Without this change,
the files appear with literal %xx in their names.

Be careful not to produce "*" in filenames on windows.  That
will fail.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   18 ++++++++++++++++++
 t/t9800-git-p4.sh          |   22 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04e6c3d..98597d3 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -884,6 +884,23 @@ class P4Sync(Command):
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
 
+    #
+    # P4 wildcards are not allowed in filenames.  P4 complains
+    # if you simply add them, but you can force it with "-f", in
+    # which case it translates them into %xx encoding internally.
+    # Search for and fix just these four characters.  Do % last so
+    # that fixing it does not inadvertently create new %-escapes.
+    #
+    def wildcard_decode(self, path):
+        # Cannot have * in a filename in windows; untested as to
+        # what p4 would do in such a case.
+        if not self.isWindows:
+            path = path.replace("%2A", "*")
+        path = path.replace("%23", "#") \
+                   .replace("%40", "@") \
+                   .replace("%25", "%")
+        return path
+
     def extractFilesFromCommit(self, commit):
         self.cloneExclude = [re.sub(r"\.\.\.$", "", path)
                              for path in self.cloneExclude]
@@ -962,6 +979,7 @@ class P4Sync(Command):
 	    return
 
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
+        relPath = self.wildcard_decode(relPath)
         if verbose:
             sys.stderr.write("%s\n" % relPath)
 
diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index c1ea4d4..026277a 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -58,6 +58,28 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
 	test_must_fail grep -q Traceback errs
 '
 
+test_expect_success 'add p4 files with wildcards in the names' '
+	cd "$cli" &&
+	echo file-wild-hash >file-wild#hash &&
+	echo file-wild-star >file-wild\*star &&
+	echo file-wild-at >file-wild@at &&
+	echo file-wild-percent >file-wild%percent &&
+	p4 add -f file-wild* &&
+	p4 submit -d "file wildcards" &&
+	cd "$TRASH_DIRECTORY"
+'
+
+test_expect_success 'wildcard files git-p4 clone' '
+	"$GITP4" clone --dest="$git" //depot &&
+	cd "$git" &&
+	test -f file-wild#hash &&
+	test -f file-wild\*star &&
+	test -f file-wild@at &&
+	test -f file-wild%percent &&
+	cd "$TRASH_DIRECTORY" &&
+	rm -rf "$git" && mkdir "$git"
+'
+
 test_expect_success 'shutdown' '
 	pid=`pgrep -f p4d` &&
 	test -n "$pid" &&
-- 
1.7.4.1
