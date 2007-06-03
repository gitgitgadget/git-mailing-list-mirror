From: Scott Lamb <slamb@slamb.org>
Subject: [PATCH 1/4] git-p4import: fix subcommand error handling
Date: Sat,  2 Jun 2007 20:58:43 -0700
Message-ID: <1180843126948-git-send-email-slamb@slamb.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org>
Cc: Scott Lamb <slamb@slamb.org>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 05:59:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuhF5-0000Db-IT
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 05:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763141AbXFCD6v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 23:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763143AbXFCD6v
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 23:58:51 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:33661 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763065AbXFCD6u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 23:58:50 -0400
Received: from hobbes.slamb.org (localhost [127.0.0.1])
	by hobbes.slamb.org (Postfix) with ESMTP id C5381980AA;
	Sat,  2 Jun 2007 20:58:46 -0700 (PDT)
X-Spam-Score: -4.3
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on hobbes.slamb.org
X-Spam-Level: 
X-Spam-Hammy: 0.000-+--H*RT:intl, 0.000-+--H*RT:ident
X-Spam-Status: No, score=-4.3 required=4.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.1.8
X-Spam-Spammy: 0.987-+--H*r:sk:hobbes.
Received: from localhost.localdomain (slamb-linux.vpn.slamb.org [172.16.0.6])
	by hobbes.slamb.org (Postfix) with ESMTP;
	Sat,  2 Jun 2007 20:58:46 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
In-Reply-To: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org>
X-Envelope-From: <slamb@slamb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48970>

Use the Python "subcommand" module to properly handle the subcommand
pipeline and raise exceptions on error.

Signed-off-by: Scott Lamb <slamb@slamb.org>
---
I folded the elimination of the shell pipelines into this patch - the error
handling couldn't work otherwise.

The difference between exceptions paths with "die" and ones with an exception
thrown to the top is somewhat arbitrary; I tried to use it to distinguish
between user error and bugs.

 git-p4import.py |  166 +++++++++++++++++++++++++++++++++----------------------
 1 files changed, 99 insertions(+), 67 deletions(-)

diff --git a/git-p4import.py b/git-p4import.py
index 60a758b..002f8d8 100644
--- a/git-p4import.py
+++ b/git-p4import.py
@@ -13,6 +13,9 @@ import os
 import sys
 import time
 import getopt
+import subprocess
+import re
+import errno
 
 from signal import signal, \
    SIGPIPE, SIGINT, SIG_DFL, \
@@ -34,7 +37,7 @@ def usage():
     sys.exit(1)
 
 verbosity = 1
-logfile = "/dev/null"
+logfile = file("/dev/null", "a")
 ignore_warnings = False
 stitch = 0
 tagall = True
@@ -44,59 +47,70 @@ def report(level, msg, *args):
     global logfile
     for a in args:
         msg = "%s %s" % (msg, a)
-    fd = open(logfile, "a")
-    fd.writelines(msg)
-    fd.close()
+    logfile.writelines(msg)
     if level <= verbosity:
         print msg
 
+class P4Exception(Exception):
+    def __init__(self, cmd, errmsg):
+        Exception.__init__(self, '%r: %s' % (cmd, errmsg))
+        self.cmd = cmd
+        self.errmsg = errmsg
+
 class p4_command:
     def __init__(self, _repopath):
-        try:
-            global logfile
-            self.userlist = {}
-            if _repopath[-1] == '/':
-                self.repopath = _repopath[:-1]
-            else:
-                self.repopath = _repopath
-            if self.repopath[-4:] != "/...":
-                self.repopath= "%s/..." % self.repopath
-            f=os.popen('p4 -V 2>>%s'%logfile, 'rb')
-            a = f.readlines()
-            if f.close():
-                raise
-        except:
-                die("Could not find the \"p4\" command")
+        self.userlist = {}
+        if _repopath[-1] == '/':
+            self.repopath = _repopath[:-1]
+        else:
+            self.repopath = _repopath
+        if self.repopath[-4:] != "/...":
+            self.repopath= "%s/..." % self.repopath
+        p4 = subprocess.Popen(['p4', '-V'],
+                              stdout=file('/dev/null', 'a'),
+                              stderr=subprocess.PIPE)
+        err = p4.stderr.read()
+        if p4.wait() != 0:
+            die("Could not run the \"p4\" command: %r" % (err,))
 
     def p4(self, cmd, *args):
         global logfile
         cmd = "%s %s" % (cmd, ' '.join(args))
+        cmdlist = ['p4', '-G'] + cmd.split(' ')
         report(2, "P4:", cmd)
-        f=os.popen('p4 -G %s 2>>%s' % (cmd,logfile), 'rb')
+        p4 = subprocess.Popen(cmdlist,
+                              stdout=subprocess.PIPE,
+                              stderr=logfile)
         list = []
         while 1:
            try:
-                list.append(marshal.load(f))
+                elem = marshal.load(p4.stdout)
            except EOFError:
                 break
-        self.ret = f.close()
+           if elem['code'] == 'error':
+                raise P4Exception(cmd, elem['data'])
+           list.append(elem)
+        if p4.wait() != 0:
+            raise Exception("'p4 %s' failed" % (cmd,))
         return list
 
     def sync(self, id, force=False, trick=False, test=False):
-        if force:
-            ret = self.p4("sync -f %s@%s"%(self.repopath, id))[0]
-        elif trick:
-            ret = self.p4("sync -k %s@%s"%(self.repopath, id))[0]
-        elif test:
-            ret = self.p4("sync -n %s@%s"%(self.repopath, id))[0]
-        else:
-            ret = self.p4("sync    %s@%s"%(self.repopath, id))[0]
-        if ret['code'] == "error":
-             data = ret['data'].upper()
-             if data.find('VIEW') > 0:
-                 die("Perforce reports %s is not in client view"% self.repopath)
-             elif data.find('UP-TO-DATE') < 0:
-                 die("Could not sync files from perforce", self.repopath)
+        try:
+            if force:
+                self.p4("sync -f %s@%s"%(self.repopath, id))
+            elif trick:
+                self.p4("sync -k %s@%s"%(self.repopath, id))
+            elif test:
+                self.p4("sync -n %s@%s"%(self.repopath, id))
+            else:
+                self.p4("sync    %s@%s"%(self.repopath, id))
+        except P4Exception, e:
+            data = e.errmsg.upper()
+            if data.find('VIEW') > 0:
+                die("Perforce reports %s is not in client view: %s"
+                    % (self.repopath, e))
+            elif data.find('UP-TO-DATE') < 0:
+                die(e)
 
     def changes(self, since=0):
         try:
@@ -105,8 +119,8 @@ class p4_command:
                 list.append(rec['change'])
             list.reverse()
             return list
-        except:
-            return []
+        except P4Exception, e:
+            die(e)
 
     def authors(self, filename):
         f=open(filename)
@@ -122,7 +136,8 @@ class p4_command:
             try:
                 user = self.p4("users", id)[0]
                 self.userlist[id] = (user['FullName'], user['Email'])
-            except:
+            except P4Exception, e:
+                report(2, "P4: missing user %s" % (id,))
                 self.userlist[id] = (id, "")
         return self.userlist[id]
 
@@ -143,7 +158,7 @@ class p4_command:
     def where(self):
         try:
             return self.p4("where %s" % self.repopath)[-1]['path']
-        except:
+        except P4Exception, e:
             return ""
 
     def describe(self, num):
@@ -153,16 +168,18 @@ class p4_command:
         self.date = self._format_date(time.localtime(long(desc['time'])))
         return self
 
+class GitException(Exception): pass
+
 class git_command:
     def __init__(self):
         try:
             self.version = self.git("--version")[0][12:].rstrip()
-        except:
-            die("Could not find the \"git\" command")
+        except GitException, e:
+            die(e)
         try:
             self.gitdir = self.get_single("rev-parse --git-dir")
             report(2, "gdir:", self.gitdir)
-        except:
+        except GitException, e:
             die("Not a git repository... did you forget to \"git init\" ?")
         try:
             self.cdup = self.get_single("rev-parse --show-cdup")
@@ -170,38 +187,47 @@ class git_command:
                 os.chdir(self.cdup)
             self.topdir = os.getcwd()
             report(2, "topdir:", self.topdir)
-        except:
+        except GitException, e:
             die("Could not find top git directory")
 
-    def git(self, cmd):
-        global logfile
+    def git(self, cmd, stdin=None):
         report(2, "GIT:", cmd)
-        f=os.popen('git %s 2>>%s' % (cmd,logfile), 'rb')
-        r=f.readlines()
-        self.ret = f.close()
-        return r
+        cmdlist = ['git'] + cmd.split(' ')
+        git = subprocess.Popen(cmdlist,
+                               stdin=subprocess.PIPE,
+                               stdout=subprocess.PIPE,
+                               stderr=subprocess.PIPE)
+        stdout, stderr = git.communicate(stdin)
+        if git.wait() != 0:
+            raise GitException("'git %s' failed: %s" % (cmd, stderr))
+        if stderr != '':
+            report(2, stderr)
+        return re.findall(r'.*\n', stdout)
 
     def get_single(self, cmd):
-        return self.git(cmd)[0].rstrip()
+        list = self.git(cmd)
+        if len(list) != 1:
+            raise GitException("%r returned %r" % (cmd, list))
+        return list[0].rstrip()
 
     def current_branch(self):
         try:
             testit = self.git("rev-parse --verify HEAD")[0]
             return self.git("symbolic-ref HEAD")[0][11:].rstrip()
-        except:
+        except GitException, e:
             return None
 
     def get_config(self, variable):
         try:
             return self.git("config --get %s" % variable)[0].rstrip()
-        except:
+        except GitException, e:
             return None
 
     def set_config(self, variable, value):
         try:
             self.git("config %s %s"%(variable, value) )
-        except:
-            die("Could not set %s to " % variable, value)
+        except GitException, e:
+            die(e)
 
     def make_tag(self, name, head):
         self.git("tag -f %s %s"%(name,head))
@@ -217,7 +243,8 @@ class git_command:
             return 0
 
     def update_index(self):
-        self.git("ls-files -m -d -o -z | git update-index --add --remove -z --stdin")
+        files = self.git("ls-files -m -d -o -z")
+        self.git("update-index --add --remove -z --stdin", stdin=files)
 
     def checkout(self, branch):
         self.git("checkout %s" % branch)
@@ -226,15 +253,21 @@ class git_command:
         self.git("symbolic-ref HEAD refs/heads/%s" % branch)
 
     def remove_files(self):
-        self.git("ls-files | xargs rm")
+        files = self.git("ls-files")
+        for file in files:
+            os.unlink(file)
 
     def clean_directories(self):
         self.git("clean -d")
 
     def fresh_branch(self, branch):
         report(1, "Creating new branch", branch)
-        self.git("ls-files | xargs rm")
-        os.remove(".git/index")
+        self.remove_files()
+        try:
+            os.remove(".git/index")
+        except OSError, e:
+            if e.errno != errno.ENOENT:
+                raise
         self.repoint_head(branch)
         self.git("clean -d")
 
@@ -243,21 +276,17 @@ class git_command:
 
     def commit(self, author, email, date, msg, id):
         self.update_index()
-        fd=open(".msg", "w")
-        fd.writelines(msg)
-        fd.close()
         try:
                 current = self.get_single("rev-parse --verify HEAD")
                 head = "-p HEAD"
-        except:
+        except GitException, e:
                 current = ""
                 head = ""
         tree = self.get_single("write-tree")
         for r,l in [('DATE',date),('NAME',author),('EMAIL',email)]:
             os.environ['GIT_AUTHOR_%s'%r] = l
             os.environ['GIT_COMMITTER_%s'%r] = l
-        commit = self.get_single("commit-tree %s %s < .msg" % (tree,head))
-        os.remove(".msg")
+        commit = self.get_single("commit-tree %s %s" % (tree,head), stdin=msg)
         self.make_tag("p4/%s"%id, commit)
         self.git("update-ref HEAD %s %s" % (commit, current) )
 
@@ -273,7 +302,7 @@ for o, a in opts:
     if o == "-v":
         verbosity += 1
     if o in ("--log"):
-        logfile = a
+        logfile = file(a, "a")
     if o in ("--notags"):
         tagall = False
     if o in ("-h", "--help"):
@@ -293,7 +322,10 @@ for o, a in opts:
 
 if len(args) == 2:
     branch = args[1]
-    git.checkout(branch)
+    try:
+        git.checkout(branch)
+    except GitException, e:
+        pass
     if branch == git.current_branch():
         die("Branch %s already exists!" % branch)
     report(1, "Setting perforce to ", args[0])
-- 
1.5.2
