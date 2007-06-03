From: Scott Lamb <slamb@slamb.org>
Subject: [PATCH 2/4] git-p4import: use lists of subcommand arguments
Date: Sat,  2 Jun 2007 20:58:44 -0700
Message-ID: <11808431291938-git-send-email-slamb@slamb.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org>
 <1180843126948-git-send-email-slamb@slamb.org>
Cc: Scott Lamb <slamb@slamb.org>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Jun 03 05:59:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuhF6-0000Db-9B
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 05:59:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763065AbXFCD66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 23:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763443AbXFCD66
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 23:58:58 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:33665 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763065AbXFCD65 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 23:58:57 -0400
Received: from hobbes.slamb.org (localhost [127.0.0.1])
	by hobbes.slamb.org (Postfix) with ESMTP id 4443C980B0;
	Sat,  2 Jun 2007 20:58:49 -0700 (PDT)
X-Spam-Score: -4.3
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on hobbes.slamb.org
X-Spam-Level: 
X-Spam-Hammy: 0.000-+--H*RT:rdns, 0.000-+--H*RT:intl
X-Spam-Status: No, score=-4.3 required=4.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.1.8
X-Spam-Spammy: 
Received: from localhost.localdomain (slamb-linux.vpn.slamb.org [172.16.0.6])
	by hobbes.slamb.org (Postfix) with ESMTP;
	Sat,  2 Jun 2007 20:58:49 -0700 (PDT)
X-Mailer: git-send-email 1.5.2
In-Reply-To: <1180843126948-git-send-email-slamb@slamb.org>
X-Envelope-From: <slamb@slamb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48971>

This fixes problems with spaces in filenames.

Signed-off-by: Scott Lamb <slamb@slamb.org>
---
 git-p4import.py |   84 +++++++++++++++++++++++++++++-------------------------
 1 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/git-p4import.py b/git-p4import.py
index 002f8d8..54e5e9e 100644
--- a/git-p4import.py
+++ b/git-p4import.py
@@ -73,11 +73,12 @@ class p4_command:
         if p4.wait() != 0:
             die("Could not run the \"p4\" command: %r" % (err,))
 
-    def p4(self, cmd, *args):
+    def p4(self, args):
         global logfile
-        cmd = "%s %s" % (cmd, ' '.join(args))
-        cmdlist = ['p4', '-G'] + cmd.split(' ')
+        cmd = ' '.join(args)
         report(2, "P4:", cmd)
+        cmdlist = ['p4', '-G']
+        cmdlist.extend(args)
         p4 = subprocess.Popen(cmdlist,
                               stdout=subprocess.PIPE,
                               stderr=logfile)
@@ -97,13 +98,14 @@ class p4_command:
     def sync(self, id, force=False, trick=False, test=False):
         try:
             if force:
-                self.p4("sync -f %s@%s"%(self.repopath, id))
+                extra = ["-f"]
             elif trick:
-                self.p4("sync -k %s@%s"%(self.repopath, id))
+                extra = ["-k"]
             elif test:
-                self.p4("sync -n %s@%s"%(self.repopath, id))
+                extra = ["-n"]
             else:
-                self.p4("sync    %s@%s"%(self.repopath, id))
+                extra = []
+            self.p4(["sync"] + extra + ["%s@%s"%(self.repopath, id)])
         except P4Exception, e:
             data = e.errmsg.upper()
             if data.find('VIEW') > 0:
@@ -115,7 +117,8 @@ class p4_command:
     def changes(self, since=0):
         try:
             list = []
-            for rec in self.p4("changes %s@%s,#head" % (self.repopath, since+1)):
+            for rec in self.p4(["changes", "%s@%s,#head"
+                               % (self.repopath, since+1)]):
                 list.append(rec['change'])
             list.reverse()
             return list
@@ -134,7 +137,7 @@ class p4_command:
     def _get_user(self, id):
         if not self.userlist.has_key(id):
             try:
-                user = self.p4("users", id)[0]
+                user = self.p4(["users", id])[0]
                 self.userlist[id] = (user['FullName'], user['Email'])
             except P4Exception, e:
                 report(2, "P4: missing user %s" % (id,))
@@ -157,12 +160,12 @@ class p4_command:
 
     def where(self):
         try:
-            return self.p4("where %s" % self.repopath)[-1]['path']
+            return self.p4(["where", self.repopath])[-1]['path']
         except P4Exception, e:
             return ""
 
     def describe(self, num):
-        desc = self.p4("describe -s", num)[0]
+        desc = self.p4(["describe", "-s", num])[0]
         self.msg = desc['desc']
         self.author, self.email = self._get_user(desc['user'])
         self.date = self._format_date(time.localtime(long(desc['time'])))
@@ -173,16 +176,16 @@ class GitException(Exception): pass
 class git_command:
     def __init__(self):
         try:
-            self.version = self.git("--version")[0][12:].rstrip()
+            self.version = self.git(["--version"])[0][12:].rstrip()
         except GitException, e:
             die(e)
         try:
-            self.gitdir = self.get_single("rev-parse --git-dir")
+            self.gitdir = self.get_single(["rev-parse", "--git-dir"])
             report(2, "gdir:", self.gitdir)
         except GitException, e:
             die("Not a git repository... did you forget to \"git init\" ?")
         try:
-            self.cdup = self.get_single("rev-parse --show-cdup")
+            self.cdup = self.get_single(["rev-parse", "--show-cdup"])
             if self.cdup != "":
                 os.chdir(self.cdup)
             self.topdir = os.getcwd()
@@ -190,9 +193,11 @@ class git_command:
         except GitException, e:
             die("Could not find top git directory")
 
-    def git(self, cmd, stdin=None):
+    def git(self, args, stdin=None):
+        cmd = ' '.join(args)
         report(2, "GIT:", cmd)
-        cmdlist = ['git'] + cmd.split(' ')
+        cmdlist = ['git']
+        cmdlist.extend(args)
         git = subprocess.Popen(cmdlist,
                                stdin=subprocess.PIPE,
                                stdout=subprocess.PIPE,
@@ -204,37 +209,37 @@ class git_command:
             report(2, stderr)
         return re.findall(r'.*\n', stdout)
 
-    def get_single(self, cmd):
-        list = self.git(cmd)
+    def get_single(self, args, stdin=None):
+        list = self.git(args, stdin=stdin)
         if len(list) != 1:
-            raise GitException("%r returned %r" % (cmd, list))
+            raise GitException("%r returned %r" % (' '.join(args), list))
         return list[0].rstrip()
 
     def current_branch(self):
         try:
-            testit = self.git("rev-parse --verify HEAD")[0]
-            return self.git("symbolic-ref HEAD")[0][11:].rstrip()
+            testit = self.git(["rev-parse", "--verify", "HEAD"])[0]
+            return self.git(["symbolic-ref", "HEAD"])[0][11:].rstrip()
         except GitException, e:
             return None
 
     def get_config(self, variable):
         try:
-            return self.git("config --get %s" % variable)[0].rstrip()
+            return self.git(["config", "--get", variable])[0].rstrip()
         except GitException, e:
             return None
 
     def set_config(self, variable, value):
         try:
-            self.git("config %s %s"%(variable, value) )
+            self.git(["config", variable, value])
         except GitException, e:
             die(e)
 
     def make_tag(self, name, head):
-        self.git("tag -f %s %s"%(name,head))
+        self.git(["tag", "-f", name, head])
 
     def top_change(self, branch):
         try:
-            a=self.get_single("name-rev --tags refs/heads/%s" % branch)
+            a=self.get_single(["name-rev", "--tags", "refs/heads/%s" % branch])
             loc = a.find(' tags/') + 6
             if a[loc:loc+3] != "p4/":
                 raise
@@ -243,22 +248,23 @@ class git_command:
             return 0
 
     def update_index(self):
-        files = self.git("ls-files -m -d -o -z")
-        self.git("update-index --add --remove -z --stdin", stdin=files)
+        files = self.git("ls-files -m -d -o -z".split(" "))
+        self.git("update-index --add --remove -z --stdin".split(" "),
+                 stdin=files)
 
     def checkout(self, branch):
-        self.git("checkout %s" % branch)
+        self.git(["checkout", branch])
 
     def repoint_head(self, branch):
-        self.git("symbolic-ref HEAD refs/heads/%s" % branch)
+        self.git(["symbolic-ref", "HEAD", "refs/heads/%s" % branch])
 
     def remove_files(self):
-        files = self.git("ls-files")
+        files = self.git(["ls-files"])
         for file in files:
             os.unlink(file)
 
     def clean_directories(self):
-        self.git("clean -d")
+        self.git(["clean", "-d"])
 
     def fresh_branch(self, branch):
         report(1, "Creating new branch", branch)
@@ -269,7 +275,7 @@ class git_command:
             if e.errno != errno.ENOENT:
                 raise
         self.repoint_head(branch)
-        self.git("clean -d")
+        self.clean_directories()
 
     def basedir(self):
         return self.topdir
@@ -277,18 +283,18 @@ class git_command:
     def commit(self, author, email, date, msg, id):
         self.update_index()
         try:
-                current = self.get_single("rev-parse --verify HEAD")
-                head = "-p HEAD"
+                current = [self.get_single(["rev-parse", "--verify", "HEAD"])]
+                head = ["-p", "HEAD"]
         except GitException, e:
-                current = ""
-                head = ""
-        tree = self.get_single("write-tree")
+                current = []
+                head = []
+        tree = self.get_single(["write-tree"])
         for r,l in [('DATE',date),('NAME',author),('EMAIL',email)]:
             os.environ['GIT_AUTHOR_%s'%r] = l
             os.environ['GIT_COMMITTER_%s'%r] = l
-        commit = self.get_single("commit-tree %s %s" % (tree,head), stdin=msg)
+        commit = self.get_single(["commit-tree", tree] + head, stdin=msg)
         self.make_tag("p4/%s"%id, commit)
-        self.git("update-ref HEAD %s %s" % (commit, current) )
+        self.git(["update-ref", "HEAD", commit] + current)
 
 try:
     opts, args = getopt.getopt(sys.argv[1:], "qhvt:",
-- 
1.5.2
