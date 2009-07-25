From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 5/5] git-p4 stream: use existing p4CmdList with callback
Date: Sat, 25 Jul 2009 10:25:09 -0400
Message-ID: <20090725142509.GF3841@arf.padd.com>
References: <1247301071-9541-1-git-send-email-luke@diamand.org> <20090725142329.GA3841@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 16:33:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUiJI-0007D8-40
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 16:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbZGYOdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 10:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbZGYOdI
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 10:33:08 -0400
Received: from marge.padd.com ([99.188.165.110]:39111 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693AbZGYOdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 10:33:04 -0400
Received: from arf.padd.com (pool-71-111-229-253.rlghnc.dsl-w.verizon.net [71.111.229.253])
	by marge.padd.com (Postfix) with ESMTPSA id 074F7121A70B;
	Sat, 25 Jul 2009 07:25:13 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 9CA6F3E40FE; Sat, 25 Jul 2009 10:25:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20090725142329.GA3841@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124010>

Add a callback argrument to iterate over returned contents
rather than replicate the entire function just to do that.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   88 +++++++++++++++++++-------------------------
 1 files changed, 38 insertions(+), 50 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index af66026..eece984 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -201,7 +201,7 @@ def isModeExec(mode):
 def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
-def p4CmdList(cmd, stdin=None, stdin_mode='w+b'):
+def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
     cmd = p4_build_cmd("-G %s" % (cmd))
     if verbose:
         sys.stderr.write("Opening pipe: %s\n" % cmd)
@@ -224,7 +224,10 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b'):
     try:
         while True:
             entry = marshal.load(p4.stdout)
-            result.append(entry)
+	    if cb is not None:
+		cb(entry)
+	    else:
+		result.append(entry)
     except EOFError:
         pass
     exitCode = p4.wait()
@@ -1003,6 +1006,26 @@ class P4Sync(Command):
             sys.stderr.write("delete %s\n" % relPath)
         self.gitStream.write("D %s\n" % relPath)
 
+    # handle another chunk of streaming data
+    def streamP4FilesCb(self, marshalled):
+
+	if marshalled.has_key('depotFile') and self.stream_have_file_info:
+	    # start of a new file - output the old one first
+	    self.streamOneP4File(self.stream_file, self.stream_contents)
+	    self.stream_file = {}
+	    self.stream_contents = []
+	    self.stream_have_file_info = False
+
+	# pick up the new file information... for the
+	# 'data' field we need to append to our array
+	for k in marshalled.keys():
+	    if k == 'data':
+		self.stream_contents.append(marshalled['data'])
+	    else:
+		self.stream_file[k] = marshalled[k]
+
+	self.stream_have_file_info = True
+
     # Stream directly from "p4 files" into "git fast-import"
     def streamP4Files(self, files):
         filesForCommit = []
@@ -1024,62 +1047,27 @@ class P4Sync(Command):
                 else:
                     filesToDelete.append(f)
 
-        filedata = []
-
         # deleted files...
         for f in filesToDelete:
             self.streamOneP4Deletion(f)
 
         if len(filesToRead) > 0:
-            stdin_file = tempfile.TemporaryFile(prefix='p4-stdin', mode='w+b')
-            stdin_file.write('\n'.join(['%s#%s' % (f['path'], f['rev'])
-                                                  for f in filesToRead]))
-            stdin_file.flush()
-            stdin_file.seek(0)
-            try:
-                p4 = subprocess.Popen('p4 -G -x - print',
-                                        shell=True,
-                                        stdin=stdin_file,
-                                        stdout=subprocess.PIPE);
-            except OSError,e:
-                print >> sys.stderr, "p4 print failed:", e
+            self.stream_file = {}
+            self.stream_contents = []
+            self.stream_have_file_info = False
 
-            file = {}
-            contents = []
-            have_file_info = False
+	    # curry self argument
+	    def streamP4FilesCbSelf(entry):
+		self.streamP4FilesCb(entry)
 
-            try:
-                while True:
-                    marshalled = marshal.load(p4.stdout)
-
-                    if marshalled.has_key('depotFile') and have_file_info:
-                        # start of a new file - output the old one first
-                        self.streamOneP4File(file, contents)
-                        file = {}
-                        contents = []
-                        have_file_info = False
-
-                    # pick up the new file information... for the
-                    # 'data' field we need to append to our array
-                    for k in marshalled.keys():
-                        if k == 'data':
-                            contents.append(marshalled['data'])
-                        else:
-                            file[k] = marshalled[k]
-
-                    have_file_info = True
-            except EOFError:
-                pass
+	    p4CmdList("-x - print",
+		'\n'.join(['%s#%s' % (f['path'], f['rev'])
+                                                  for f in filesToRead]),
+	        cb=streamP4FilesCbSelf)
 
             # do the last chunk
-
-            if file.has_key('depotFile'):
-                self.streamOneP4File(file,contents)
-
-            exitCode = p4.wait()
-            if exitCode != 0:
-                sys.stderr.write("p4 subshell failed getting file data\n")
-                sys.exit(1)
+            if self.stream_file.has_key('depotFile'):
+                self.streamOneP4File(self.stream_file, self.stream_contents)
 
     def commit(self, details, files, branch, branchPrefixes, parent = ""):
         epoch = details["time"]
-- 
1.6.2.5
