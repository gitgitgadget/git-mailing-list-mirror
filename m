From: Yann Dirson <ydirson@altern.org>
Subject: [RFC PATCH] Add new git-cp command, transposed from stgit.
Date: Thu, 17 May 2007 22:49:00 +0200
Message-ID: <20070517204129.17502.21864.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 22:50:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Homvj-0007Z6-L4
	for gcvg-git@gmane.org; Thu, 17 May 2007 22:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961AbXEQUu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 16:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755126AbXEQUu1
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 16:50:27 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:48121 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754961AbXEQUu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 16:50:26 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 2EAF1601A2
	for <git@vger.kernel.org>; Thu, 17 May 2007 22:50:25 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 261EF1F15F
	for <git@vger.kernel.org>; Thu, 17 May 2007 22:49:01 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47556>

This git-cp command is recursive when acting on directories, but only
copies files under git control.

---

Addition of this command would be along the lines of "move into git
things from stgit that are not specific to stgit".

A known annoying limitation of this version (very quickly adapted) is
that quoted files in the "git ls-files" output trigger the assert()
clause.  I'd use "-z", but it looks like noone wrote a zero-separated
file reader for python (how that makes me regret perl ;).

I can surely write one, but do we want this to be in python after all ?
At least in perl it would be easy to fix this issue, but do we even
accept perl scripts for such features ?  OTOH, I'm not sure it is
worth rewriting in C...

 git-cp.py |  141 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 141 insertions(+), 0 deletions(-)

diff --git a/git-cp.py b/git-cp.py
new file mode 100755
index 0000000..8df2e73
--- /dev/null
+++ b/git-cp.py
@@ -0,0 +1,141 @@
+#!/usr/bin/python
+#
+# This tool is copyright (c) 2007, Yann Dirson.
+# Parts copyright (c) 2005 Catalin Marinas.
+# It is released under the Gnu Public License, version 2.
+#
+
+import os, sys, getopt, popen2, re
+from shutil import copyfile
+
+def usage():
+    print "USAGE: git-cp <source>... <destination>"
+    sys.exit(1)
+
+## functions copied from stgit.git 0.12
+
+def _output_lines(cmd):
+    p=popen2.Popen3(cmd, True)
+    lines = p.fromchild.readlines()
+    if p.wait():
+        raise Exception, '%s failed (%s)' % (str(cmd),
+                                             p.childerr.read().strip())
+    return lines
+
+def __run(cmd, args=None):
+    """__run: runs cmd using spawnvp.
+
+    Runs cmd using spawnvp.  The shell is avoided so it won't mess up
+    our arguments.  If args is very large, the command is run multiple
+    times; args is split xargs style: cmd is passed on each
+    invocation.  Unlike xargs, returns immediately if any non-zero
+    return code is received.  
+    """
+    
+    args_l=cmd.split()
+    if args is None:
+        args = []
+    for i in range(0, len(args)+1, 100):
+        r=os.spawnvp(os.P_WAIT, args_l[0], args_l + args[i:min(i+100, len(args))])
+    if r:
+        return r
+    return 0
+
+# functions adapted from stgit.git 0.12
+
+def addfiles(names):
+    """Add the files
+    """
+    # check the file list
+    for i in names:
+        if not os.path.exists(i):
+            raise Exception, 'Unknown file: %s' % i
+        if not os.path.isfile(i):
+            raise Exception, '%s is not a plain file' % i
+
+    if names:
+        if __run('git-update-index --add --', names):
+            raise Exception, 'Unable to add file'
+
+# core "git-cp" implementation
+
+def __copy_singlefile(source, target, target2=''):
+    """Copy file or dir named 'source' to name target+target2"""
+
+    # "source" (file or dir) must match one or more git-controlled file
+    realfiles = _output_lines(['git-ls-files', source])
+    if len(realfiles) == 0:
+        raise Exception, '"%s" matches no git-controled files' % source
+
+    if os.path.isdir(source):
+        # physically copy the files, and record them to add them in one run
+        newfiles = []
+        re_string='^'+source+'/(.*)$'
+        prefix_regexp = re.compile(re_string)
+        for f in [f.strip() for f in realfiles]:
+            m = prefix_regexp.match(f)
+            if not m:
+                print '"%s" does not match "%s"' % (f, re_string)
+                assert(m)
+            newname = target+target2+'/'+m.group(1)
+            if not os.path.exists(os.path.dirname(newname)):
+                os.makedirs(os.path.dirname(newname))
+            copyfile(f, newname)
+            newfiles.append(newname)
+
+        addfiles(newfiles)
+    else: # files, symlinks, ...
+        newname = target+target2
+        copyfile(source, newname)
+        addfiles([newname])
+
+
+def copy(filespecs, target):
+    if os.path.isdir(target):
+        # target is a directory: copy each entry on the command line,
+        # with the same name, into the target
+        target = target.rstrip('/')
+        
+        # first, check that none of the children of the target
+        # matching the command line aleady exist
+        for filespec in filespecs:
+            entry = target+ '/' + os.path.basename(filespec.rstrip('/'))
+            if os.path.exists(entry):
+                raise Exception, 'Target "%s" already exists' % entry
+        
+        for filespec in filespecs:
+            filespec = filespec.rstrip('/')
+            basename = '/' + os.path.basename(filespec)
+            __copy_singlefile(filespec, target, basename)
+
+    elif os.path.exists(target):
+        raise Exception, 'Target "%s" exists but is not a directory' % target
+    elif len(filespecs) != 1:
+        raise Exception, 'Cannot copy more than one file to non-directory'
+
+    else:
+        # at this point: len(filespecs)==1 and target does not exist
+
+        # check target directory
+        targetdir = os.path.dirname(target)
+        if targetdir != '' and not os.path.isdir(targetdir):
+            raise Exception, 'Target directory "%s" does not exist' % targetdir
+
+        __copy_singlefile(filespecs[0].rstrip('/'), target)
+
+## main
+
+try:
+    opts, args = getopt.getopt(sys.argv[1:], "h", ["help"])
+except getopt.GetoptError:
+    usage()
+
+for o, a in opts:
+    if o in ("-h", "--help"):
+        usage()
+
+try:
+    copy(args[0:-1], args[-1])
+except Exception, ex:
+    print "git-cp error: %s" % ex
+    sys.exit(1)
