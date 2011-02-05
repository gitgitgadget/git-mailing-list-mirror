From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 7/8] git-p4: decode p4 wildcard characters
Date: Sat, 5 Feb 2011 17:52:37 -0500
Message-ID: <20110205225237.GH30963@arf.padd.com>
References: <20110205224848.GA30963@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 05 23:52:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Plqzr-0006ep-KW
	for gcvg-git-2@lo.gmane.org; Sat, 05 Feb 2011 23:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab1BEWwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Feb 2011 17:52:47 -0500
Received: from honk.padd.com ([74.3.171.149]:33466 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735Ab1BEWwq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Feb 2011 17:52:46 -0500
Received: from arf.padd.com (pool-71-111-208-86.rlghnc.dsl-w.verizon.net [71.111.208.86])
	by honk.padd.com (Postfix) with ESMTPSA id 7822BEF;
	Sat,  5 Feb 2011 14:52:45 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9894D31ADE; Sat,  5 Feb 2011 17:52:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20110205224848.GA30963@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166127>

There are four wildcard characters in p4.  Files with these
characters can be added to p4 repos using the "-f" option.
They are stored in %xx notation, and when checked out, p4
converts them back to normal.

This patch does the same thing when importing into git,
converting the four special characters.  Without this change,
the files appear with literal %xx in their names.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   13 +++++++++++++
 t/t9800-git-p4.sh          |   22 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04e6c3d..5b08cd6 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -884,6 +884,18 @@ class P4Sync(Command):
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
 
+    # The p4 wildcards are not allowed in filenames.  It complains
+    # if you try to add them, but you can override with "-f", in
+    # which case it translates them into %xx encoding.  Search for
+    # and fix just these four characters.  Do % last so it does
+    # not inadvertantly create new %-escapes.
+    def wildcard_decode(self, path):
+        path = path.replace("%23", "#") \
+                   .replace("%2A", "*") \
+                   .replace("%40", "@") \
+                   .replace("%25", "%")
+        return path
+
     def extractFilesFromCommit(self, commit):
         self.cloneExclude = [re.sub(r"\.\.\.$", "", path)
                              for path in self.cloneExclude]
@@ -962,6 +974,7 @@ class P4Sync(Command):
 	    return
 
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
+        relPath = self.wildcard_decode(relPath)
         if verbose:
             sys.stderr.write("%s\n" % relPath)
 
diff --git a/t/t9800-git-p4.sh b/t/t9800-git-p4.sh
index 41e57bb..72c38af 100755
--- a/t/t9800-git-p4.sh
+++ b/t/t9800-git-p4.sh
@@ -65,6 +65,28 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
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
1.7.2.3
