From: Luke Diamand <luke@diamand.org>
Subject: [PATCH/RFC] git-p4: stream from perforce to speed up clones
Date: Fri, 10 Jul 2009 21:10:44 +0100
Message-ID: <200907102110.44973.luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 22:11:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPMQw-0006aF-He
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 22:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbZGJUK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 16:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbZGJUKz
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 16:10:55 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:48027 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751571AbZGJUKz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 16:10:55 -0400
Received: by bwz25 with SMTP id 25so1110596bwz.37
        for <git@vger.kernel.org>; Fri, 10 Jul 2009 13:10:53 -0700 (PDT)
Received: by 10.204.58.79 with SMTP id f15mr2220480bkh.202.1247256653020;
        Fri, 10 Jul 2009 13:10:53 -0700 (PDT)
Received: from ethel.localnet (cpc1-cmbg14-0-0-cust733.cmbg.cable.ntl.com [213.106.82.222])
        by mx.google.com with ESMTPS id b17sm3197638fka.6.2009.07.10.13.10.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 10 Jul 2009 13:10:52 -0700 (PDT)
User-Agent: KMail/1.11.1 (Linux/2.6.28-lgd; KDE/4.2.1; x86_64; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123081>

Change commit() to stream data from Perforce and into fast-import
rather than reading into memory first, and then writing out. This
hugely reduces the memory requirements when cloning non-incrementally.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
I've modified git-p4 so that it streams/pipes data into fast-import rather
that reading everything into memory first. The old scheme meant that
for a large repository (mine is around 2G) my PC just grinds to a
halt and never actually finishes. With this change it takes around ten
minutes.

Obviously there's scope here for breaking git-p4 quite badly. I have a
small test harness that covers regular and incremental imports, file
deletion and keyword expansion, but perhaps there are other aspects
I need to look at as well?

 contrib/fast-import/git-p4 |  164 ++++++++++++++++++++++++++++++++++++--------
 1 files changed, 136 insertions(+), 28 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 342529d..f415ad0 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -1008,6 +1008,141 @@ class P4Sync(Command):
 
         return filesForCommit
 
+    # output one file from the P4 stream
+    # - helper for streamP4Files
+
+    def streamOneP4File(self, file, contents, branchPrefixes):
+        if verbose:
+            sys.stderr.write("%s\n" %  file["depotFile"])
+
+        relPath = self.stripRepoPath(file['depotFile'], branchPrefixes)
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
+    def streamOneP4Deletion(self, file, branchPrefixes):
+        if verbose:
+            sys.stderr.write("delete %s\n" %  file["path"])
+
+        relPath = self.stripRepoPath(file['path'], branchPrefixes)
+
+        self.gitStream.write("D %s\n" % relPath)
+
+    # Stream directly from "p4 files" into "git fast-import"
+    def streamP4Files(self, files, branchPrefixes):
+        filesForCommit = []
+        filesToRead = []
+        filesToDelete = []
+
+        for f in files:
+            includeFile = True
+            for val in self.clientSpecDirs:
+                if f['path'].startswith(val[0]):
+                    if val[1] <= 0:
+                        includeFile = False
+                    break
+
+            if includeFile:
+                filesForCommit.append(f)
+                if f['action'] not in ('delete', 'purge'):
+                    filesToRead.append(f)
+                else:
+                    filesToDelete.append(f)
+
+        filedata = []
+
+        # deleted files...
+        for f in filesToDelete:
+            self.streamOneP4Deletion(f, branchPrefixes)
+
+        if len(filesToRead) > 0:
+            stdin_file = tempfile.TemporaryFile(prefix='p4-stdin', mode='w+b')
+            stdin_file.write('\n'.join(['%s#%s' % (f['path'], f['rev'])
+                                                  for f in filesToRead]))
+            stdin_file.flush()
+            stdin_file.seek(0)
+            try:
+                p4 = subprocess.Popen('p4 -G -x - print',
+                                        shell=True,
+                                        stdin=stdin_file,
+                                        stdout=subprocess.PIPE);
+            except OSError,e:
+                print >> sys.stderr, "p4 print failed:", e
+
+            file = {}
+            contents = []
+            have_file_info = False
+
+            try:
+                while True:
+                    marshalled = marshal.load(p4.stdout)
+
+                    if marshalled.has_key('depotFile') and have_file_info:
+                        # start of a new file - output the old one first
+
+                        if file["type"] == "apple":
+                            print "\nfile %s is a strange apple file that forks. Ignoring" % file['path']
+                            continue
+
+
+                        self.streamOneP4File(file,contents,branchPrefixes)
+                        file = {}
+                        contents = []
+                        have_file_info = False
+
+                    # pick up the new file information... for the
+                    # 'data' field we need to append to our array
+                    for k in marshalled.keys():
+                        if k == 'data':
+                            contents.append(marshalled['data'])
+                        else:
+                            file[k] = marshalled[k]
+
+                    have_file_info = True
+            except EOFError:
+                pass
+
+            # do the last chunk
+
+            if file.has_key('depotFile'):
+                self.streamOneP4File(file,contents,branchPrefixes)
+
+            exitCode = p4.wait()
+            if exitCode != 0:
+                sys.stderr.write("p4 subshell failed getting file data\n")
+                sys.exit(1)
+
     def commit(self, details, files, branch, branchPrefixes, parent = ""):
         epoch = details["time"]
         author = details["user"]
@@ -1023,7 +1158,6 @@ class P4Sync(Command):
                 new_files.append (f)
             else:
                 sys.stderr.write("Ignoring file outside of prefix: %s\n" % path)
-        files = self.readP4Files(new_files)
 
         self.gitStream.write("commit %s\n" % branch)
 #        gitStream.write("mark :%s\n" % details["change"])
@@ -1051,33 +1185,7 @@ class P4Sync(Command):
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
+        self.streamP4Files(new_files,branchPrefixes)
         self.gitStream.write("\n")
 
         change = int(details["change"])
-- 
1.6.3.GIT
