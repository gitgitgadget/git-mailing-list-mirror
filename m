From: Tommy Thorn <tommy-git@thorn.ws>
Subject: [PATCH 3/3] git-p4: no longer keep all file contents while cloning
Date: Sun,  3 Feb 2008 01:21:06 -0800
Message-ID: <98fe358f9523dec637dbe87a0258e3327cd901cd.1202029604.git.tommy-git@thorn.ws>
References: <9439626e72a267ff29cb6eaa1c733ec4641341d9.1202029604.git.tommy-git@thorn.ws>
 <dd96ea0b47e8ec67ef14e4e954aa9ec7bec3c295.1202029604.git.tommy-git@thorn.ws>
Cc: Tommy Thorn <tommy-git@thorn.ws>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 11:03:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLbhZ-0001K7-QT
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 11:03:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760550AbYBCKDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 05:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759187AbYBCKDW
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 05:03:22 -0500
Received: from server204.webhostingpad.com ([69.65.0.218]:60871 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760297AbYBCKDD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Feb 2008 05:03:03 -0500
Received: from 208.65.183.75.static.etheric.net ([208.65.183.75] helo=localhost.localdomain)
	by server204.webhostingpad.com with esmtpa (Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1JLb2C-0006wh-Il; Sun, 03 Feb 2008 03:21:08 -0600
X-Mailer: git-send-email 1.5.4.rc5.17.g22b645
In-Reply-To: <dd96ea0b47e8ec67ef14e4e954aa9ec7bec3c295.1202029604.git.tommy-git@thorn.ws>
In-Reply-To: <9439626e72a267ff29cb6eaa1c733ec4641341d9.1202029604.git.tommy-git@thorn.ws>
References: <9439626e72a267ff29cb6eaa1c733ec4641341d9.1202029604.git.tommy-git@thorn.ws>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server204.webhostingpad.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thorn.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72342>

- Factor out the pipe creation part of p4CmdList() as p4CmdListPipe()

- Factor readP4Files() into openP4Files() and readP4File() and
  changed P4Sync to use this.

The upshot is that git-p4 now read only one file at a time and
immediately pass it on to fast-import. This massively reduces the
memory requirement of git-p4.

Note, git-p4 still reads in the whole file in memory -- this can and
should be fixed in future.

Signed-off-by: Tommy Thorn <tommy-git@thorn.ws>
---
 contrib/fast-import/git-p4 |  102 ++++++++++++++++++++++++++++++-------------
 1 files changed, 71 insertions(+), 31 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2340876..78a5d02 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -144,7 +144,8 @@ def isModeExec(mode):
 def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
-def p4CmdList(cmd, stdin=None, stdin_mode='w+b'):
+# p4CmdListPipe returns a pipe delivering the result of the p4 command
+def p4CmdListPipe(cmd, stdin=None, stdin_mode='w+b'):
     cmd = "p4 -G %s" % cmd
     if verbose:
         sys.stderr.write("Opening pipe: %s\n" % cmd)
@@ -162,7 +163,11 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b'):
     p4 = subprocess.Popen(cmd, shell=True,
                           stdin=stdin_file,
                           stdout=subprocess.PIPE)
+    return p4
 
+# p4CmdList returns the stdout result of the p4 command
+def p4CmdList(cmd, stdin=None, stdin_mode='w+b'):
+    p4 = p4CmdListPipe(cmd, stdin, stdin_mode)
     result = []
     try:
         while True:
@@ -950,42 +955,62 @@ class P4Sync(Command):
         return branches
 
     ## Should move this out, doesn't use SELF.
-    def readP4Files(self, files):
+    def openP4Files(self, files):
         files = [f for f in files
                  if f['action'] != 'delete']
 
         if not files:
             return
 
-        filedata = p4CmdList('-x - print',
-                             stdin='\n'.join(['%s#%s' % (f['path'], f['rev'])
-                                              for f in files]),
-                             stdin_mode='w+')
-        if "p4ExitCode" in filedata[0]:
-            die("Problems executing p4. Error: [%d]."
-                % (filedata[0]['p4ExitCode']));
-
-        j = 0;
-        contents = {}
-        while j < len(filedata):
-            stat = filedata[j]
-            j += 1
-            text = ''
-            while j < len(filedata) and filedata[j]['code'] in ('text',
-                                                                'binary'):
-                text += filedata[j]['data']
-                j += 1
+        p4 = p4CmdListPipe('-x - print',
+                           stdin='\n'.join(['%s#%s' % (f['path'], f['rev'])
+                                            for f in files]),
+                           stdin_mode='w+')
 
+        self.curDepotFile = None
+        return p4
 
-            if not stat.has_key('depotFile'):
-                sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
-                continue
+    # Uisng the pipe handle provided by openP4File, read in a file and
+    # return the pair of (depot file name, contents)
+    def readP4File(self, p4):
+        text = ''
 
-            contents[stat['depotFile']] = text
+        try:
+            while True:
+                entry = marshal.load(p4.stdout)
+
+                if entry['code'] in ('text', 'binary'):
+                    text += entry['data']
+                elif entry['code'] == 'stat':
+                    # We are done with the previous file
+                    if self.curDepotFile is not None:
+                        if not entry.has_key('depotFile'):
+                            sys.stderr.write("p4 print fails with: %s\n" % repr(entry))
+                            self.curDepotFile = None
+                            continue
+
+                        depotFile = self.curDepotFile
+                        self.curDepotFile = entry['depotFile']
+                        if verbose: sys.stderr.write('Read %s\n' % depotFile)
+                        return (depotFile, text)
+
+                    text = ''
+                    self.curDepotFile = entry['depotFile']
+                else:
+                    sys.stderr.write("p4 print returned unexpected code: %s\n" % entry['code'])
+
+        except EOFError:
+            pass
+
+        exitCode = p4.wait()
+        if exitCode != 0:
+            die("Problems executing p4. Error: [%d]." % exitCode);
+
+        depotFile = self.curDepotFile
+        self.curDepotFile = None
+        if verbose: sys.stderr.write('Read %s\n' % depotFile)
+        return (depotFile, text)
 
-        for f in files:
-            assert not f.has_key('data')
-            f['data'] = contents[f['path']]
 
     def commit(self, details, files, branch, branchPrefixes, parent = ""):
         epoch = details["time"]
@@ -996,6 +1021,10 @@ class P4Sync(Command):
 
         # start with reading files; if that fails, we should not
         # create a commit.
+
+        # XXX No, reading all file contents into memory is to tall a
+        # price to pay. Right now if an error is found, it will abort,
+        # leaving cruft for git gc to prune.
         new_files = []
         for f in files:
             if [p for p in branchPrefixes if f['path'].startswith(p)]:
@@ -1003,7 +1032,6 @@ class P4Sync(Command):
             else:
                 sys.stderr.write("Ignoring file outside of prefix: %s\n" % path)
         files = new_files
-        self.readP4Files(files)
 
 
 
@@ -1034,17 +1062,26 @@ class P4Sync(Command):
                 print "parent %s" % parent
             self.gitStream.write("from %s\n" % parent)
 
-        for file in files:
+        # Create a depotFileName -> file mapping
+        revFile = {}
+        for f in files:
+            revFile[f['path']] = f
+
+        p4 = self.openP4Files(files)
+        (depotFile, data) = self.readP4File(p4)
+
+        while depotFile is not None:
+
+            file = revFile[depotFile]
             if file["type"] == "apple":
                 print "\nfile %s is a strange apple file that forks. Ignoring!" % file['path']
+                (depotFile, data) = self.readP4File(p4)
                 continue
 
             relPath = self.stripRepoPath(file['path'], branchPrefixes)
             if file["action"] == "delete":
                 self.gitStream.write("D %s\n" % relPath)
             else:
-                data = file['data']
-
                 mode = "644"
                 if isP4Exec(file["type"]):
                     mode = "755"
@@ -1061,6 +1098,9 @@ class P4Sync(Command):
                 self.gitStream.write(data)
                 self.gitStream.write("\n")
 
+            (depotFile, data) = self.readP4File(p4)
+
+
         self.gitStream.write("\n")
 
         change = int(details["change"])
-- 
1.5.4.rc5.17.g22b645
