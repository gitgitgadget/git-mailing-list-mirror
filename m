From: Luke Diamand <luke@diamand.org>
Subject: [PATCH v3] git-p4: stream from perforce to speed up clones
Date: Thu, 30 Jul 2009 00:13:46 +0100
Message-ID: <1248909226-17526-1-git-send-email-luke@diamand.org>
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
	Pete Wyckoff <pw@padd.com>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Thu Jul 30 01:14:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWILQ-0002ym-7q
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 01:14:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbZG2XNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 19:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754097AbZG2XNw
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 19:13:52 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:40556 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbZG2XNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 19:13:51 -0400
Received: by ewy10 with SMTP id 10so364883ewy.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 16:13:50 -0700 (PDT)
Received: by 10.210.58.13 with SMTP id g13mr448714eba.99.1248909230186;
        Wed, 29 Jul 2009 16:13:50 -0700 (PDT)
Received: from localhost.localdomain (cpc1-cmbg14-0-0-cust733.cmbg.cable.ntl.com [213.106.82.222])
        by mx.google.com with ESMTPS id 5sm571488eyh.26.2009.07.29.16.13.49
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Jul 2009 16:13:49 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124410>

Change commit() to stream data from Perforce and into fast-import
rather than reading into memory first, and then writing out. This
hugely reduces the memory requirements when cloning non-incrementally.

Signed-off-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
I've modified git-p4 so that it streams/pipes data into fast-import rather
that reading everything into memory first. The old scheme meant that
for a large repository (mine is around 2G) my PC just grinds to a
halt and never actually finishes. With this change it takes around ten
minutes.

Pete Wyckoff kindly submitted some patches on top of this which tidied it
up and fixed a few bugs; this patch merges my original patch with those
changes.

Simon - could you review this change please?

Thanks,
Luke

 contrib/fast-import/git-p4 |  169 ++++++++++++++++++++++++++-----------------
 1 files changed, 102 insertions(+), 67 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 342529d..38438f3 100755
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
@@ -950,10 +953,84 @@ class P4Sync(Command):
 
         return branches
 
-    ## Should move this out, doesn't use SELF.
-    def readP4Files(self, files):
+    # output one file from the P4 stream
+    # - helper for streamP4Files
+
+    def streamOneP4File(self, file, contents):
+	if file["type"] == "apple":
+	    print "\nfile %s is a strange apple file that forks. Ignoring" % \
+		file['depotFile']
+	    return
+
+        relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
+        if verbose:
+            sys.stderr.write("%s\n" % relPath)
+
+        mode = "644"
+        if isP4Exec(file["type"]):
+            mode = "755"
+        elif file["type"] == "symlink":
+            mode = "120000"
+            # p4 print on a symlink contains "target\n", so strip it off
+            last = contents.pop()
+            last = last[:-1]
+            contents.append(last)
+
+        if self.isWindows and file["type"].endswith("text"):
+            mangled = []
+            for data in contents:
+                data = data.replace("\r\n", "\n")
+                mangled.append(data)
+            contents = mangled
+
+        if file['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
+            contents = map(lambda text: re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text), contents)
+        elif file['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
+            contents = map(lambda text: re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$\n]*\$',r'$\1$', text), contents)
+
+        self.gitStream.write("M %s inline %s\n" % (mode, relPath))
+
+        # total length...
+        length = 0
+        for d in contents:
+            length = length + len(d)
+
+        self.gitStream.write("data %d\n" % length)
+        for d in contents:
+            self.gitStream.write(d)
+        self.gitStream.write("\n")
+
+    def streamOneP4Deletion(self, file):
+        relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
+        if verbose:
+            sys.stderr.write("delete %s\n" % relPath)
+        self.gitStream.write("D %s\n" % relPath)
+
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
+    # Stream directly from "p4 files" into "git fast-import"
+    def streamP4Files(self, files):
         filesForCommit = []
         filesToRead = []
+        filesToDelete = []
 
         for f in files:
             includeFile = True
@@ -967,50 +1044,35 @@ class P4Sync(Command):
                 filesForCommit.append(f)
                 if f['action'] not in ('delete', 'purge'):
                     filesToRead.append(f)
+                else:
+                    filesToDelete.append(f)
 
-        filedata = []
-        if len(filesToRead) > 0:
-            filedata = p4CmdList('-x - print',
-                                 stdin='\n'.join(['%s#%s' % (f['path'], f['rev'])
-                                                  for f in filesToRead]),
-                                 stdin_mode='w+')
-
-            if "p4ExitCode" in filedata[0]:
-                die("Problems executing p4. Error: [%d]."
-                    % (filedata[0]['p4ExitCode']));
-
-        j = 0;
-        contents = {}
-        while j < len(filedata):
-            stat = filedata[j]
-            j += 1
-            text = ''
-            while j < len(filedata) and filedata[j]['code'] in ('text', 'unicode', 'binary'):
-                text += filedata[j]['data']
-                del filedata[j]['data']
-                j += 1
-
-            if not stat.has_key('depotFile'):
-                sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
-                continue
+        # deleted files...
+        for f in filesToDelete:
+            self.streamOneP4Deletion(f)
 
-            if stat['type'] in ('text+ko', 'unicode+ko', 'binary+ko'):
-                text = re.sub(r'(?i)\$(Id|Header):[^$]*\$',r'$\1$', text)
-            elif stat['type'] in ('text+k', 'ktext', 'kxtext', 'unicode+k', 'binary+k'):
-                text = re.sub(r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision):[^$\n]*\$',r'$\1$', text)
+        if len(filesToRead) > 0:
+            self.stream_file = {}
+            self.stream_contents = []
+            self.stream_have_file_info = False
 
-            contents[stat['depotFile']] = text
+	    # curry self argument
+	    def streamP4FilesCbSelf(entry):
+		self.streamP4FilesCb(entry)
 
-        for f in filesForCommit:
-            path = f['path']
-            if contents.has_key(path):
-                f['data'] = contents[path]
+	    p4CmdList("-x - print",
+		'\n'.join(['%s#%s' % (f['path'], f['rev'])
+                                                  for f in filesToRead]),
+	        cb=streamP4FilesCbSelf)
 
-        return filesForCommit
+            # do the last chunk
+            if self.stream_file.has_key('depotFile'):
+                self.streamOneP4File(self.stream_file, self.stream_contents)
 
     def commit(self, details, files, branch, branchPrefixes, parent = ""):
         epoch = details["time"]
         author = details["user"]
+	self.branchPrefixes = branchPrefixes
 
         if self.verbose:
             print "commit into %s" % branch
@@ -1023,7 +1085,6 @@ class P4Sync(Command):
                 new_files.append (f)
             else:
                 sys.stderr.write("Ignoring file outside of prefix: %s\n" % path)
-        files = self.readP4Files(new_files)
 
         self.gitStream.write("commit %s\n" % branch)
 #        gitStream.write("mark :%s\n" % details["change"])
@@ -1051,33 +1112,7 @@ class P4Sync(Command):
                 print "parent %s" % parent
             self.gitStream.write("from %s\n" % parent)
 
-        for file in files:
-            if file["type"] == "apple":
-                print "\nfile %s is a strange apple file that forks. Ignoring!" % file['path']
-                continue
-
-            relPath = self.stripRepoPath(file['path'], branchPrefixes)
-            if file["action"] in ("delete", "purge"):
-                self.gitStream.write("D %s\n" % relPath)
-            else:
-                data = file['data']
-
-                mode = "644"
-                if isP4Exec(file["type"]):
-                    mode = "755"
-                elif file["type"] == "symlink":
-                    mode = "120000"
-                    # p4 print on a symlink contains "target\n", so strip it off
-                    data = data[:-1]
-
-                if self.isWindows and file["type"].endswith("text"):
-                    data = data.replace("\r\n", "\n")
-
-                self.gitStream.write("M %s inline %s\n" % (mode, relPath))
-                self.gitStream.write("data %s\n" % len(data))
-                self.gitStream.write(data)
-                self.gitStream.write("\n")
-
+        self.streamP4Files(new_files)
         self.gitStream.write("\n")
 
         change = int(details["change"])
-- 
1.6.3.GIT
