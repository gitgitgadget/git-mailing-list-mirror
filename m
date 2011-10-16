From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 6/6] git-p4: handle files with shell metacharacters
Date: Sun, 16 Oct 2011 10:47:52 -0400
Message-ID: <20111016144752.GI22144@arf.padd.com>
References: <20111016144215.GC22144@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Luke Diamand <luke@diamand.org>, Chris Li <git@chrisli.org>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 16 16:48:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFS0b-0007Nm-TQ
	for gcvg-git-2@lo.gmane.org; Sun, 16 Oct 2011 16:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582Ab1JPOsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 10:48:09 -0400
Received: from honk.padd.com ([74.3.171.149]:57960 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754536Ab1JPOsI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 10:48:08 -0400
Received: from arf.padd.com (unknown [50.55.131.180])
	by honk.padd.com (Postfix) with ESMTPSA id 0FEFB1FEA;
	Sun, 16 Oct 2011 07:48:07 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 51BFD313B8; Sun, 16 Oct 2011 10:47:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20111016144215.GC22144@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183721>

From: Luke Diamand <luke@diamand.org>

git-p4 used to simply pass strings into system() and popen(), and
relied on the shell doing the necessary expansion. This though meant
that shell metacharacters in file names would be corrupted - for
example files with $ or space in them.

Switch to using subprocess.Popen() and friends, and pass in explicit
arrays in the places where it matters. This then avoids needing shell
expansion.

Add trivial helper functions for some common perforce operations. Add
test case.

[pw: test cleanup]

Signed-off-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4     |  200 ++++++++++++++++++++++++---------------
 t/t9803-git-shell-metachars.sh |   64 +++++++++++++
 2 files changed, 187 insertions(+), 77 deletions(-)
 create mode 100755 t/t9803-git-shell-metachars.sh

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 55b1667..f885d70 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -22,36 +22,39 @@ def p4_build_cmd(cmd):
     location. It means that hooking into the environment, or other configuration
     can be done more easily.
     """
-    real_cmd = "%s " % "p4"
+    real_cmd = ["p4"]
 
     user = gitConfig("git-p4.user")
     if len(user) > 0:
-        real_cmd += "-u %s " % user
+        real_cmd += ["-u",user]
 
     password = gitConfig("git-p4.password")
     if len(password) > 0:
-        real_cmd += "-P %s " % password
+        real_cmd += ["-P", password]
 
     port = gitConfig("git-p4.port")
     if len(port) > 0:
-        real_cmd += "-p %s " % port
+        real_cmd += ["-p", port]
 
     host = gitConfig("git-p4.host")
     if len(host) > 0:
-        real_cmd += "-h %s " % host
+        real_cmd += ["-h", host]
 
     client = gitConfig("git-p4.client")
     if len(client) > 0:
-        real_cmd += "-c %s " % client
+        real_cmd += ["-c", client]
 
-    real_cmd += "%s" % (cmd)
-    if verbose:
-        print real_cmd
+
+    if isinstance(cmd,basestring):
+        real_cmd = ' '.join(real_cmd) + ' ' + cmd
+    else:
+        real_cmd += cmd
     return real_cmd
 
 def chdir(dir):
-    if os.name == 'nt':
-        os.environ['PWD']=dir
+    # P4 uses the PWD environment variable rather than getcwd(). Since we're
+    # not using the shell, we have to set it ourselves.
+    os.environ['PWD']=dir
     os.chdir(dir)
 
 def die(msg):
@@ -61,29 +64,34 @@ def die(msg):
         sys.stderr.write(msg + "\n")
         sys.exit(1)
 
-def write_pipe(c, str):
+def write_pipe(c, stdin):
     if verbose:
-        sys.stderr.write('Writing pipe: %s\n' % c)
+        sys.stderr.write('Writing pipe: %s\n' % str(c))
 
-    pipe = os.popen(c, 'w')
-    val = pipe.write(str)
-    if pipe.close():
-        die('Command failed: %s' % c)
+    expand = isinstance(c,basestring)
+    p = subprocess.Popen(c, stdin=subprocess.PIPE, shell=expand)
+    pipe = p.stdin
+    val = pipe.write(stdin)
+    pipe.close()
+    if p.wait():
+        die('Command failed: %s' % str(c))
 
     return val
 
-def p4_write_pipe(c, str):
+def p4_write_pipe(c, stdin):
     real_cmd = p4_build_cmd(c)
-    return write_pipe(real_cmd, str)
+    return write_pipe(real_cmd, stdin)
 
 def read_pipe(c, ignore_error=False):
     if verbose:
-        sys.stderr.write('Reading pipe: %s\n' % c)
+        sys.stderr.write('Reading pipe: %s\n' % str(c))
 
-    pipe = os.popen(c, 'rb')
+    expand = isinstance(c,basestring)
+    p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
+    pipe = p.stdout
     val = pipe.read()
-    if pipe.close() and not ignore_error:
-        die('Command failed: %s' % c)
+    if p.wait() and not ignore_error:
+        die('Command failed: %s' % str(c))
 
     return val
 
@@ -93,12 +101,14 @@ def p4_read_pipe(c, ignore_error=False):
 
 def read_pipe_lines(c):
     if verbose:
-        sys.stderr.write('Reading pipe: %s\n' % c)
-    ## todo: check return status
-    pipe = os.popen(c, 'rb')
+        sys.stderr.write('Reading pipe: %s\n' % str(c))
+
+    expand = isinstance(c, basestring)
+    p = subprocess.Popen(c, stdout=subprocess.PIPE, shell=expand)
+    pipe = p.stdout
     val = pipe.readlines()
-    if pipe.close():
-        die('Command failed: %s' % c)
+    if pipe.close() or p.wait():
+        die('Command failed: %s' % str(c))
 
     return val
 
@@ -108,15 +118,37 @@ def p4_read_pipe_lines(c):
     return read_pipe_lines(real_cmd)
 
 def system(cmd):
+    expand = isinstance(cmd,basestring)
     if verbose:
-        sys.stderr.write("executing %s\n" % cmd)
-    if os.system(cmd) != 0:
-        die("command failed: %s" % cmd)
+        sys.stderr.write("executing %s\n" % str(cmd))
+    subprocess.check_call(cmd, shell=expand)
 
 def p4_system(cmd):
     """Specifically invoke p4 as the system command. """
     real_cmd = p4_build_cmd(cmd)
-    return system(real_cmd)
+    expand = isinstance(real_cmd, basestring)
+    subprocess.check_call(real_cmd, shell=expand)
+
+def p4_integrate(src, dest):
+    p4_system(["integrate", "-Dt", src, dest])
+
+def p4_sync(path):
+    p4_system(["sync", path])
+
+def p4_add(f):
+    p4_system(["add", f])
+
+def p4_delete(f):
+    p4_system(["delete", f])
+
+def p4_edit(f):
+    p4_system(["edit", f])
+
+def p4_revert(f):
+    p4_system(["revert", f])
+
+def p4_reopen(type, file):
+    p4_system(["reopen", "-t", type, file])
 
 #
 # Canonicalize the p4 type and return a tuple of the
@@ -167,12 +199,12 @@ def setP4ExecBit(file, mode):
         if p4Type[-1] == "+":
             p4Type = p4Type[0:-1]
 
-    p4_system("reopen -t %s %s" % (p4Type, file))
+    p4_reopen(p4Type, file)
 
 def getP4OpenedType(file):
     # Returns the perforce file type for the given file.
 
-    result = p4_read_pipe("opened %s" % file)
+    result = p4_read_pipe(["opened", file])
     match = re.match(".*\((.+)\)\r?$", result)
     if match:
         return match.group(1)
@@ -228,9 +260,17 @@ def isModeExecChanged(src_mode, dst_mode):
     return isModeExec(src_mode) != isModeExec(dst_mode)
 
 def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
-    cmd = p4_build_cmd("-G %s" % (cmd))
+
+    if isinstance(cmd,basestring):
+        cmd = "-G " + cmd
+        expand = True
+    else:
+        cmd = ["-G"] + cmd
+        expand = False
+
+    cmd = p4_build_cmd(cmd)
     if verbose:
-        sys.stderr.write("Opening pipe: %s\n" % cmd)
+        sys.stderr.write("Opening pipe: %s\n" % str(cmd))
 
     # Use a temporary file to avoid deadlocks without
     # subprocess.communicate(), which would put another copy
@@ -238,11 +278,16 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None):
     stdin_file = None
     if stdin is not None:
         stdin_file = tempfile.TemporaryFile(prefix='p4-stdin', mode=stdin_mode)
-        stdin_file.write(stdin)
+        if isinstance(stdin,basestring):
+            stdin_file.write(stdin)
+        else:
+            for i in stdin:
+                stdin_file.write(i + '\n')
         stdin_file.flush()
         stdin_file.seek(0)
 
-    p4 = subprocess.Popen(cmd, shell=True,
+    p4 = subprocess.Popen(cmd,
+                          shell=expand,
                           stdin=stdin_file,
                           stdout=subprocess.PIPE)
 
@@ -275,7 +320,7 @@ def p4Where(depotPath):
     if not depotPath.endswith("/"):
         depotPath += "/"
     depotPath = depotPath + "..."
-    outputList = p4CmdList("where %s" % depotPath)
+    outputList = p4CmdList(["where", depotPath])
     output = None
     for entry in outputList:
         if "depotFile" in entry:
@@ -477,8 +522,10 @@ def originP4BranchesExist():
 
 def p4ChangesForPaths(depotPaths, changeRange):
     assert depotPaths
-    output = p4_read_pipe_lines("changes " + ' '.join (["%s...%s" % (p, changeRange)
-                                                        for p in depotPaths]))
+    cmd = ['changes']
+    for p in depotPaths:
+        cmd += ["%s...%s" % (p, changeRange)]
+    output = p4_read_pipe_lines(cmd)
 
     changes = {}
     for line in output:
@@ -561,7 +608,7 @@ class P4Debug(Command):
 
     def run(self, args):
         j = 0
-        for output in p4CmdList(" ".join(args)):
+        for output in p4CmdList(args):
             print 'Element: %d' % j
             j += 1
             print output
@@ -715,7 +762,7 @@ class P4Submit(Command, P4UserMap):
                 break
         if not client:
             die("could not get client spec")
-        results = p4CmdList("changes -c %s -m 1" % client)
+        results = p4CmdList(["changes", "-c", client, "-m", "1"])
         for r in results:
             if r.has_key('change'):
                 return r['change']
@@ -778,7 +825,7 @@ class P4Submit(Command, P4UserMap):
         # remove lines in the Files section that show changes to files outside the depot path we're committing into
         template = ""
         inFilesSection = False
-        for line in p4_read_pipe_lines("change -o"):
+        for line in p4_read_pipe_lines(['change', '-o']):
             if line.endswith("\r\n"):
                 line = line[:-2] + "\n"
             if inFilesSection:
@@ -835,7 +882,7 @@ class P4Submit(Command, P4UserMap):
             modifier = diff['status']
             path = diff['src']
             if modifier == "M":
-                p4_system("edit \"%s\"" % path)
+                p4_edit(path)
                 if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
                     filesToChangeExecBit[path] = diff['dst_mode']
                 editedFiles.add(path)
@@ -850,21 +897,21 @@ class P4Submit(Command, P4UserMap):
                     filesToAdd.remove(path)
             elif modifier == "C":
                 src, dest = diff['src'], diff['dst']
-                p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
+                p4_integrate(src, dest)
                 if diff['src_sha1'] != diff['dst_sha1']:
-                    p4_system("edit \"%s\"" % (dest))
+                    p4_edit(dest)
                 if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
-                    p4_system("edit \"%s\"" % (dest))
+                    p4_edit(dest)
                     filesToChangeExecBit[dest] = diff['dst_mode']
                 os.unlink(dest)
                 editedFiles.add(dest)
             elif modifier == "R":
                 src, dest = diff['src'], diff['dst']
-                p4_system("integrate -Dt \"%s\" \"%s\"" % (src, dest))
+                p4_integrate(src, dest)
                 if diff['src_sha1'] != diff['dst_sha1']:
-                    p4_system("edit \"%s\"" % (dest))
+                    p4_edit(dest)
                 if isModeExecChanged(diff['src_mode'], diff['dst_mode']):
-                    p4_system("edit \"%s\"" % (dest))
+                    p4_edit(dest)
                     filesToChangeExecBit[dest] = diff['dst_mode']
                 os.unlink(dest)
                 editedFiles.add(dest)
@@ -887,9 +934,9 @@ class P4Submit(Command, P4UserMap):
             if response == "s":
                 print "Skipping! Good luck with the next patches..."
                 for f in editedFiles:
-                    p4_system("revert \"%s\"" % f);
+                    p4_revert(f)
                 for f in filesToAdd:
-                    system("rm %s" %f)
+                    os.remove(f)
                 return
             elif response == "a":
                 os.system(applyPatchCmd)
@@ -910,10 +957,10 @@ class P4Submit(Command, P4UserMap):
         system(applyPatchCmd)
 
         for f in filesToAdd:
-            p4_system("add \"%s\"" % f)
+            p4_add(f)
         for f in filesToDelete:
-            p4_system("revert \"%s\"" % f)
-            p4_system("delete \"%s\"" % f)
+            p4_revert(f)
+            p4_delete(f)
 
         # Set/clear executable bits
         for f in filesToChangeExecBit.keys():
@@ -935,7 +982,7 @@ class P4Submit(Command, P4UserMap):
                 del(os.environ["P4DIFF"])
             diff = ""
             for editedFile in editedFiles:
-                diff += p4_read_pipe("diff -du %r" % editedFile)
+                diff += p4_read_pipe(['diff', '-du', editedFile])
 
             newdiff = ""
             for newFile in filesToAdd:
@@ -987,7 +1034,7 @@ class P4Submit(Command, P4UserMap):
                 submitTemplate = message[:message.index(separatorLine)]
                 if self.isWindows:
                     submitTemplate = submitTemplate.replace("\r\n", "\n")
-                p4_write_pipe("submit -i", submitTemplate)
+                p4_write_pipe(['submit', '-i'], submitTemplate)
 
                 if self.preserveUser:
                     if p4User:
@@ -998,10 +1045,10 @@ class P4Submit(Command, P4UserMap):
 
             else:
                 for f in editedFiles:
-                    p4_system("revert \"%s\"" % f);
+                    p4_revert(f)
                 for f in filesToAdd:
-                    p4_system("revert \"%s\"" % f);
-                    system("rm %s" %f)
+                    p4_revert(f)
+                    os.remove(f)
 
             os.remove(fileName)
         else:
@@ -1054,8 +1101,7 @@ class P4Submit(Command, P4UserMap):
 
         chdir(self.clientPath)
         print "Synchronizing p4 checkout..."
-        p4_system("sync ...")
-
+        p4_sync("...")
         self.check()
 
         commits = []
@@ -1269,7 +1315,7 @@ class P4Sync(Command, P4UserMap):
             # operations.  utf16 is converted to ascii or utf8, perhaps.
             # But ascii text saved as -t utf16 is completely mangled.
             # Invoke print -o to get the real contents.
-            text = p4_read_pipe('print -q -o - "%s"' % file['depotFile'])
+            text = p4_read_pipe(['print', '-q', '-o', '-', file['depotFile']])
             contents = [ text ]
 
         # Perhaps windows wants unicode, utf16 newlines translated too;
@@ -1365,10 +1411,11 @@ class P4Sync(Command, P4UserMap):
             def streamP4FilesCbSelf(entry):
                 self.streamP4FilesCb(entry)
 
-            p4CmdList("-x - print",
-                '\n'.join(['%s#%s' % (f['path'], f['rev'])
-                                                  for f in filesToRead]),
-                cb=streamP4FilesCbSelf)
+            fileArgs = ['%s#%s' % (f['path'], f['rev']) for f in filesToRead]
+
+            p4CmdList(["-x", "-", "print"],
+                      stdin=fileArgs,
+                      cb=streamP4FilesCbSelf)
 
             # do the last chunk
             if self.stream_file.has_key('depotFile'):
@@ -1429,8 +1476,8 @@ class P4Sync(Command, P4UserMap):
             if self.verbose:
                 print "Change %s is labelled %s" % (change, labelDetails)
 
-            files = p4CmdList("files " + ' '.join (["%s...@%s" % (p, change)
-                                                    for p in branchPrefixes]))
+            files = p4CmdList(["files"] + ["%s...@%s" % (p, change)
+                                                    for p in branchPrefixes])
 
             if len(files) == len(labelRevisions):
 
@@ -1478,9 +1525,9 @@ class P4Sync(Command, P4UserMap):
             newestChange = 0
             if self.verbose:
                 print "Querying files for label %s" % label
-            for file in p4CmdList("files "
-                                  +  ' '.join (["%s...@%s" % (p, label)
-                                                for p in self.depotPaths])):
+            for file in p4CmdList(["files"] +
+                                      ["%s...@%s" % (p, label)
+                                          for p in self.depotPaths]):
                 revisions[file["depotFile"]] = file["rev"]
                 change = int(file["change"])
                 if change > newestChange:
@@ -1735,10 +1782,9 @@ class P4Sync(Command, P4UserMap):
         newestRevision = 0
 
         fileCnt = 0
-        for info in p4CmdList("files "
-                              +  ' '.join(["%s...%s"
-                                           % (p, revision)
-                                           for p in self.depotPaths])):
+        fileArgs = ["%s...%s" % (p,revision) for p in self.depotPaths]
+
+        for info in p4CmdList(["files"] + fileArgs):
 
             if 'code' in info and info['code'] == 'error':
                 sys.stderr.write("p4 returned an error: %s\n"
diff --git a/t/t9803-git-shell-metachars.sh b/t/t9803-git-shell-metachars.sh
new file mode 100755
index 0000000..db04375
--- /dev/null
+++ b/t/t9803-git-shell-metachars.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='git-p4 transparency to shell metachars in filenames'
+
+. ./lib-git-p4.sh
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'init depot' '
+	(
+		cd "$cli" &&
+		echo file1 >file1 &&
+		p4 add file1 &&
+		p4 submit -d "file1"
+	)
+'
+
+test_expect_success 'shell metachars in filenames' '
+	"$GITP4" clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEditCheck true &&
+		echo f1 >foo\$bar &&
+		git add foo\$bar &&
+		echo f2 >"file with spaces" &&
+		git add "file with spaces" &&
+		git commit -m "add files" &&
+		P4EDITOR=touch "$GITP4" submit
+	) &&
+	(
+		cd "$cli" &&
+		p4 sync ... &&
+		test -e "file with spaces" &&
+		test -e "foo\$bar"
+	)
+'
+
+test_expect_success 'deleting with shell metachars' '
+	"$GITP4" clone --dest="$git" //depot &&
+	test_when_finished cleanup_git &&
+	(
+		cd "$git" &&
+		git config git-p4.skipSubmitEditCheck true &&
+		git rm foo\$bar &&
+		git rm file\ with\ spaces &&
+		git commit -m "remove files" &&
+		P4EDITOR=touch "$GITP4" submit
+	) &&
+	(
+		cd "$cli" &&
+		p4 sync ... &&
+		test ! -e "file with spaces" &&
+		test ! -e foo\$bar
+	)
+'
+
+test_expect_success 'kill p4d' '
+	kill_p4d
+'
+
+test_done
-- 
1.7.7
