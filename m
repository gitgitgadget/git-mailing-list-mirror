From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH] git-p4: submit files with wildcards
Date: Sun, 26 Feb 2012 09:55:00 -0500
Message-ID: <1330268100-29630-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 15:55:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1fVv-0000zj-Un
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 15:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415Ab2BZOzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 09:55:35 -0500
Received: from honk.padd.com ([74.3.171.149]:47073 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751666Ab2BZOzF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 09:55:05 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id 4561D24A6;
	Sun, 26 Feb 2012 06:55:03 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id BECB1313D8; Sun, 26 Feb 2012 09:55:00 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.285.gbece5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191562>

There are four wildcard characters in p4.  Files with these
characters can be added to p4 repos using the "-f" option.  They
are stored in %xx notation, and when checked out, p4 converts
them back to normal.

When adding files with wildcards in git, the submit path must
be careful to use the encoded names in some places, and it
must use "-f" to add them.

Support for wildcards in the clone/sync path was added in
084f630 (git-p4: decode p4 wildcard characters, 2011-02-19),
but that change did not handle the submit path.

Reported-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   64 ++++++++++++++++++++++++++++---------------
 t/t9800-git-p4-basic.sh    |   23 ++++++++++++++++
 2 files changed, 65 insertions(+), 22 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 0539553..bd89402 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -136,8 +136,8 @@ def p4_integrate(src, dest):
 def p4_sync(path):
     p4_system(["sync", path])
 
-def p4_add(f):
-    p4_system(["add", f])
+def p4_add(path, *options):
+    p4_system(["add"] + list(options) + [path])
 
 def p4_delete(f):
     p4_system(["delete", f])
@@ -232,8 +232,12 @@ def setP4ExecBit(file, mode):
     # Reopens an already open file and changes the execute bit to match
     # the execute bit setting in the passed in mode.
 
-    p4Type = "+x"
+    # Since this is working on already opened files, any with wildcards
+    # in the name have been encoded already, and must be referred to
+    # with the encoded name.
+    file = wildcard_encode(file)
 
+    p4Type = "+x"
     if not isModeExec(mode):
         p4Type = getP4OpenedType(file)
         p4Type = re.sub('^([cku]?)x(.*)', '\\1\\2', p4Type)
@@ -596,6 +600,34 @@ def p4PathStartsWith(path, prefix):
         return path.lower().startswith(prefix.lower())
     return path.startswith(prefix)
 
+#
+# P4 wildcards are not allowed in filenames.  P4 complains
+# if you simply add them, but you can force it with "-f", in
+# which case it translates them into %xx encoding internally.
+#
+def wildcard_decode(path):
+    # Search for and fix just these four characters.  Do % last so
+    # that fixing it does not inadvertently create new %-escapes.
+    # Cannot have * in a filename in windows; untested as to
+    # what p4 would do in such a case.
+    if not platform.system() == "Windows":
+        path = path.replace("%2A", "*")
+    path = path.replace("%23", "#") \
+               .replace("%40", "@") \
+               .replace("%25", "%")
+    return path
+
+def wildcard_encode(path):
+    # do % first to avoid double-encoding the %s introduced here
+    path = path.replace("%", "%25") \
+               .replace("*", "%2A") \
+               .replace("#", "%23") \
+               .replace("@", "%40")
+    return path
+
+def wildcard_present(path):
+    return path.translate(None, "*#@%") != path
+
 class Command:
     def __init__(self):
         self.usage = "usage: %prog [options]"
@@ -1099,7 +1131,12 @@ class P4Submit(Command, P4UserMap):
         system(applyPatchCmd)
 
         for f in filesToAdd:
-            p4_add(f)
+            # forcibly add file names with wildcards; see also
+            # wildcard_decode() in the sync path
+            if wildcard_present(f):
+                p4_add(f, "-f")
+            else:
+                p4_add(f)
         for f in filesToDelete:
             p4_revert(f)
             p4_delete(f)
@@ -1537,23 +1574,6 @@ class P4Sync(Command, P4UserMap):
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
 
-    #
-    # P4 wildcards are not allowed in filenames.  P4 complains
-    # if you simply add them, but you can force it with "-f", in
-    # which case it translates them into %xx encoding internally.
-    # Search for and fix just these four characters.  Do % last so
-    # that fixing it does not inadvertently create new %-escapes.
-    #
-    def wildcard_decode(self, path):
-        # Cannot have * in a filename in windows; untested as to
-        # what p4 would do in such a case.
-        if not self.isWindows:
-            path = path.replace("%2A", "*")
-        path = path.replace("%23", "#") \
-                   .replace("%40", "@") \
-                   .replace("%25", "%")
-        return path
-
     # Force a checkpoint in fast-import and wait for it to finish
     def checkpoint(self):
         self.gitStream.write("checkpoint\n\n")
@@ -1638,7 +1658,7 @@ class P4Sync(Command, P4UserMap):
 
     def streamOneP4File(self, file, contents):
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
-        relPath = self.wildcard_decode(relPath)
+        relPath = wildcard_decode(relPath)
         if verbose:
             sys.stderr.write("%s\n" % relPath)
 
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 04ee20e..22669df 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -163,6 +163,29 @@ test_expect_success 'wildcard files git-p4 clone' '
 	)
 '
 
+test_expect_success 'wildcard files submit back to p4' '
+	"$GITP4" clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		echo git-wild-hash >git-wild#hash &&
+		echo git-wild-star >git-wild\*star &&
+		echo git-wild-at >git-wild@at &&
+		echo git-wild-percent >git-wild%percent &&
+		git add git-wild* &&
+		git commit -m "add some wildcard filenames" &&
+		git config git-p4.skipSubmitEditCheck true &&
+		"$GITP4" submit
+	) &&
+	(
+		cd "$cli" &&
+		test_path_is_file git-wild#hash &&
+		test_path_is_file git-wild\*star &&
+		test_path_is_file git-wild@at &&
+		test_path_is_file git-wild%percent
+	)
+'
+
 test_expect_success 'clone bare' '
 	"$GITP4" clone --dest="$git" --bare //depot &&
 	test_when_finished cleanup_git &&
-- 
1.7.9.220.g4b839
