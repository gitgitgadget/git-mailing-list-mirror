From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 3/6] git p4: catch p4 errors when streaming file contents
Date: Fri, 23 Nov 2012 17:35:36 -0500
Message-ID: <1353710139-16207-4-git-send-email-pw@padd.com>
References: <1353710139-16207-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 23 23:37:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc1rm-0005eo-3R
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 23:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730Ab2KWWgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 17:36:43 -0500
Received: from honk.padd.com ([74.3.171.149]:35230 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756397Ab2KWWgm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 17:36:42 -0500
Received: from arf.padd.com (unknown [50.55.150.96])
	by honk.padd.com (Postfix) with ESMTPSA id 4A1B4E9A;
	Fri, 23 Nov 2012 14:36:42 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id EA4C927578; Fri, 23 Nov 2012 17:36:39 -0500 (EST)
X-Mailer: git-send-email 1.8.0.360.gc68af86
In-Reply-To: <1353710139-16207-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210277>

Error messages that arise during the "p4 print" phase of
generating commits were silently ignored.  Catch them,
abort the fast-import, and exit.

Without this fix, the sync/clone appears to work, but files that
are inaccessible by the p4d server will still be imported to git,
although without the proper contents.  Instead the errant files
will contain a p4 error message, such as "Librarian checkout
//depot/path failed".

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py               | 38 +++++++++++++++++++++++++++++++-------
 t/t9800-git-p4-basic.sh | 13 ++++++++++++-
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 9644c9f..cb1ec8d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2139,6 +2139,29 @@ class P4Sync(Command, P4UserMap):
     # handle another chunk of streaming data
     def streamP4FilesCb(self, marshalled):
 
+        # catch p4 errors and complain
+        err = None
+        if "code" in marshalled:
+            if marshalled["code"] == "error":
+                if "data" in marshalled:
+                    err = marshalled["data"].rstrip()
+        if err:
+            f = None
+            if self.stream_have_file_info:
+                if "depotFile" in self.stream_file:
+                    f = self.stream_file["depotFile"]
+            # force a failure in fast-import, else an empty
+            # commit will be made
+            self.gitStream.write("\n")
+            self.gitStream.write("die-now\n")
+            self.gitStream.close()
+            # ignore errors, but make sure it exits first
+            self.importProcess.wait()
+            if f:
+                die("Error from p4 print for %s: %s" % (f, err))
+            else:
+                die("Error from p4 print: %s" % err)
+
         if marshalled.has_key('depotFile') and self.stream_have_file_info:
             # start of a new file - output the old one first
             self.streamOneP4File(self.stream_file, self.stream_contents)
@@ -2900,12 +2923,13 @@ class P4Sync(Command, P4UserMap):
 
         self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
 
-        importProcess = subprocess.Popen(["git", "fast-import"],
-                                         stdin=subprocess.PIPE, stdout=subprocess.PIPE,
-                                         stderr=subprocess.PIPE);
-        self.gitOutput = importProcess.stdout
-        self.gitStream = importProcess.stdin
-        self.gitError = importProcess.stderr
+        self.importProcess = subprocess.Popen(["git", "fast-import"],
+                                              stdin=subprocess.PIPE,
+                                              stdout=subprocess.PIPE,
+                                              stderr=subprocess.PIPE);
+        self.gitOutput = self.importProcess.stdout
+        self.gitStream = self.importProcess.stdin
+        self.gitError = self.importProcess.stderr
 
         if revision:
             self.importHeadRevision(revision)
@@ -2965,7 +2989,7 @@ class P4Sync(Command, P4UserMap):
             self.importP4Labels(self.gitStream, missingP4Labels)
 
         self.gitStream.close()
-        if importProcess.wait() != 0:
+        if self.importProcess.wait() != 0:
             die("fast-import failed: %s" % self.gitError.read())
         self.gitOutput.close()
         self.gitError.close()
diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index b7ad716..05797c3 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -143,7 +143,18 @@ test_expect_success 'exit when p4 fails to produce marshaled output' '
 	! test_i18ngrep Traceback errs
 '
 
-test_expect_success 'clone bare' '
+# Hide a file from p4d, make sure we catch its complaint.  This won't fail in
+# p4 changes, files, or describe; just in p4 print.  If P4CLIENT is unset, the
+# message will include "Librarian checkout".
+test_expect_success 'exit gracefully for p4 server errors' '
+	test_when_finished "mv \"$db\"/depot/file1,v,hidden \"$db\"/depot/file1,v" &&
+	mv "$db"/depot/file1,v "$db"/depot/file1,v,hidden &&
+	test_when_finished cleanup_git &&
+	test_expect_code 1 git p4 clone --dest="$git" //depot@1 >out 2>err &&
+	test_i18ngrep "Error from p4 print" err
+'
+
+test_expect_success 'clone --bare should make a bare repository' '
 	rm -rf "$git" &&
 	git p4 clone --dest="$git" --bare //depot &&
 	test_when_finished cleanup_git &&
-- 
1.8.0.276.gd9397fc
