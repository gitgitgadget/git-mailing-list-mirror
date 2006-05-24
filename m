From: Sean <seanlkml@sympatico.ca>
Subject: [PATCH] A Perforce importer for git.
Date: Wed, 24 May 2006 18:04:38 -0400
Message-ID: <BAYC1-PASMTP117796558F3B42B2C18DBCAE980@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu May 25 00:10:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj1Yt-0001vK-2q
	for gcvg-git@gmane.org; Thu, 25 May 2006 00:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWEXWKg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 18:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWEXWKg
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 18:10:36 -0400
Received: from bayc1-pasmtp11.bayc1.hotmail.com ([65.54.191.171]:51674 "EHLO
	BAYC1-PASMTP11.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S964776AbWEXWKf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 18:10:35 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP11.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 24 May 2006 15:15:28 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 86BB6644C17
	for <git@vger.kernel.org>; Wed, 24 May 2006 18:10:32 -0400 (EDT)
To: git@vger.kernel.org
Message-Id: <20060524180438.1537641c.seanlkml@sympatico.ca>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 24 May 2006 22:15:29.0375 (UTC) FILETIME=[90CFCEF0:01C67F7F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
---
 Documentation/git-p4import.txt |  165 ++++++++++++++++++
 git-p4import.py                |  357 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 522 insertions(+), 0 deletions(-)


diff --git a/Documentation/git-p4import.txt b/Documentation/git-p4import.txt
new file mode 100644
index 0000000..b8ff1e9
--- /dev/null
+++ b/Documentation/git-p4import.txt
@@ -0,0 +1,165 @@
+git-p4import(1)
+===============
+
+NAME
+----
+git-p4import - Import a Perforce repository into git
+
+
+SYNOPSIS
+--------
+`git-p4import` [-q|-v] [--authors <file>] [-t <timezone>] <//p4repo/path> <branch>
+
+`git-p4import` --stitch <//p4repo/path>
+
+`git-p4import`
+
+
+DESCRIPTION
+-----------
+Import a Perforce repository into an existing git repository.  When
+a <//p4repo/path> and <branch> are specified a new branch with the
+given name will be created and the initial import will begin.
+
+Once the initial import is complete you can do an incremental import
+of new commits from the Perforce repository.  You do this by checking
+out the appropriate git branch and then running `git-p4import` without
+any options.
+
+The standard p4 client is used to communicate with the Perforce
+repository; it must be configured correctly in order for `git-p4import`
+to operate (see below).
+
+
+OPTIONS
+-------
+-q::
+	Do not display any progress information.
+
+-v::
+        Give extra progress information.
+
+\--authors::
+	Specify an authors file containing a mapping of Perforce user
+	ids to full names and email addresses (see Notes below).
+
+\--stitch::
+	Import the contents of the given perforce branch into the
+	currently checked out git branch.
+
+\--log::
+	Store debugging information in the specified file.
+
+-t::
+	Specify that the remote repository is in the specified timezone.
+	Timezone must be in the format "US/Pacific" or "Europe/London"
+	etc.  You only need to specify this once, it will be saved in
+	the git config file for the repository.
+
+<//p4repo/path>::
+	The Perforce path that will be imported into the specified branch.
+
+<branch>::
+	The new branch that will be created to hold the Perforce imports.
+
+
+P4 Client
+---------
+You must make the `p4` client command available in your $PATH and
+configure it to communicate with the target Perforce repository.
+Typically this means you must set the "$P4PORT" and "$P4CLIENT"
+environment variables.
+
+You must also configure a `p4` client "view" which maps the Perforce
+branch into the top level of your git repository, for example:
+
+------------
+Client: myhost
+
+Root:   /home/sean/import
+
+Options:   noallwrite clobber nocompress unlocked modtime rmdir
+
+View:
+        //public/jam/... //myhost/jam/...
+------------
+
+With the above `p4` client setup, you could import the "jam"
+perforce branch into a branch named "jammy", like so:
+
+------------
+$ mkdir -p /home/sean/import/jam
+$ cd /home/sean/import/jam
+$ git init-db
+$ git p4import //public/jam jammy
+------------
+
+
+Multiple Branches
+-----------------
+Note that by creating multiple "views" you can use `git-p4import`
+to import additional branches into the same git repository.
+However, the `p4` client has a limitation in that it silently
+ignores all but the last "view" that maps into the same local
+directory.  So the following will *not* work:
+
+------------
+View:
+        //public/jam/... //myhost/jam/...
+        //public/other/... //myhost/jam/...
+        //public/guest/... //myhost/jam/...
+------------
+
+If you want more than one Perforce branch to be imported into the
+same directory you must employ a workaround.  A simple option is
+to adjust your `p4` client before each import to only include a
+single view.
+
+Another option is to create multiple symlinks locally which all
+point to the same directory in your git repository and then use
+one per "view" instead of listing the actual directory.
+
+
+Tags
+----
+A git tag of the form p4/xx is created for every change imported from
+the Perforce repository where xx is the Perforce changeset number.
+Therefore after the import you can use git to access any commit by its
+Perforce number, eg. git show p4/327.
+
+The tag associated with the HEAD commit is also how `git-p4import`
+determines if their are new changes to incrementally import from the
+Perforce repository.
+
+If you import from a repository with many thousands of changes
+you will have an equal number of p4/xxxx git tags.  Git tags can
+be expensive in terms of disk space and repository operations.
+If you don't need to perform further incremental imports, you
+may delete the tags.
+
+
+Notes
+-----
+You can interrupt the import (eg. ctrl-c) at any time and restart it
+without worry.
+
+Author information is automatically determined by querying the
+Perforce "users" table using the id associated with each change.
+However, if you want to manually supply these mappings you can do
+so with the "--authors" option.  It accepts a file containing a list
+of mappings with each line containing one mapping in the format:
+
+------------
+    perforce_id = Full Name <email@address.com>
+------------
+
+
+Author
+------
+Written by Sean Estabrooks <seanlkml@sympatico.ca>
+
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/git-p4import.py b/git-p4import.py
new file mode 100644
index 0000000..74172ab
--- /dev/null
+++ b/git-p4import.py
@@ -0,0 +1,357 @@
+#!/usr/bin/python
+#
+# This tool is copyright (c) 2006, Sean Estabrooks.
+# It is released under the Gnu Public License, version 2.
+#
+# Import Perforce branches into Git repositories.
+# Checking out the files is done by calling the standard p4
+# client which you must have properly configured yourself
+#
+
+import marshal
+import os
+import sys
+import time
+import getopt
+
+from signal import signal, \
+   SIGPIPE, SIGINT, SIG_DFL, \
+   default_int_handler
+
+signal(SIGPIPE, SIG_DFL)
+s = signal(SIGINT, SIG_DFL)
+if s != default_int_handler:
+   signal(SIGINT, s)
+
+
+def die(msg, *args):
+    for a in args:
+        msg = "%s %s" % (msg, a)
+    print "git-p4import fatal error:", msg
+    sys.exit(1)
+
+def usage():
+    print "USAGE: git-p4import [-q|-v]  [--authors=<file>]  [-t <timezone>]  [//p4repo/path <branch>]"
+    sys.exit(1)
+
+verbosity = 1
+logfile = "/dev/null"
+ignore_warnings = False
+stitch = 0
+
+def report(level, msg, *args):
+    global verbosity
+    global logfile
+    for a in args:
+        msg = "%s %s" % (msg, a)
+    fd = open(logfile, "a")
+    fd.writelines(msg)
+    fd.close()
+    if level <= verbosity:
+        print msg
+
+class p4_command:
+    def __init__(self, _repopath):
+        try:
+            global logfile
+            self.userlist = {}
+            if _repopath[-1] == '/':
+                self.repopath = _repopath[:-1]
+            else:
+                self.repopath = _repopath
+            if self.repopath[-4:] != "/...":
+                self.repopath= "%s/..." % self.repopath
+            f=os.popen('p4 -V 2>>%s'%logfile, 'rb')
+            a = f.readlines()
+            if f.close():
+                raise
+        except:
+                die("Could not find the \"p4\" command")
+
+    def p4(self, cmd, *args):
+        global logfile
+        cmd = "%s %s" % (cmd, ' '.join(args))
+        report(2, "P4:", cmd)
+        f=os.popen('p4 -G %s 2>>%s' % (cmd,logfile), 'rb')
+        list = []
+        while 1:
+           try:
+                list.append(marshal.load(f))
+           except EOFError:
+                break
+        self.ret = f.close()
+        return list
+
+    def sync(self, id, force=False, trick=False, test=False):
+        if force:
+            ret = self.p4("sync -f %s@%s"%(self.repopath, id))[0]
+        elif trick:
+            ret = self.p4("sync -k %s@%s"%(self.repopath, id))[0]
+        elif test:
+            ret = self.p4("sync -n %s@%s"%(self.repopath, id))[0]
+        else:
+            ret = self.p4("sync    %s@%s"%(self.repopath, id))[0]
+        if ret['code'] == "error":
+             data = ret['data'].upper()
+             if data.find('VIEW') > 0:
+                 die("Perforce reports %s is not in client view"% self.repopath)
+             elif data.find('UP-TO-DATE') < 0:
+                 die("Could not sync files from perforce", self.repopath)
+
+    def changes(self, since=0):
+        try:
+            list = []
+            for rec in self.p4("changes %s@%s,#head" % (self.repopath, since+1)):
+                list.append(rec['change'])
+            list.reverse()
+            return list
+        except:
+            return []
+
+    def authors(self, filename):
+        f=open(filename)
+        for l in f.readlines():
+            self.userlist[l[:l.find('=')].rstrip()] = \
+                    (l[l.find('=')+1:l.find('<')].rstrip(),l[l.find('<')+1:l.find('>')])
+        f.close()
+        for f,e in self.userlist.items():
+                report(2, f, ":", e[0], "  <", e[1], ">")
+
+    def _get_user(self, id):
+        if not self.userlist.has_key(id):
+            try:
+                user = self.p4("users", id)[0]
+                self.userlist[id] = (user['FullName'], user['Email'])
+            except:
+                self.userlist[id] = (id, "")
+        return self.userlist[id]
+
+    def _format_date(self, ticks):
+        symbol='+'
+        name = time.tzname[0]
+        offset = time.timezone
+        if ticks[8]:
+            name = time.tzname[1]
+            offset = time.altzone
+        if offset < 0:
+            offset *= -1
+            symbol = '-'
+        localo = "%s%02d%02d %s" % (symbol, offset / 3600, offset % 3600, name)
+        tickso = time.strftime("%a %b %d %H:%M:%S %Y", ticks)
+        return "%s %s" % (tickso, localo)
+
+    def where(self):
+        try:
+            return self.p4("where %s" % self.repopath)[-1]['path']
+        except:
+            return ""
+
+    def describe(self, num):
+        desc = self.p4("describe -s", num)[0]
+        self.msg = desc['desc']
+        self.author, self.email = self._get_user(desc['user'])
+        self.date = self._format_date(time.localtime(long(desc['time'])))
+        return self
+
+class git_command:
+    def __init__(self):
+        try:
+            self.version = self.git("--version")[0][12:].rstrip()
+        except:
+            die("Could not find the \"git\" command")
+        try:
+            self.gitdir = self.get_single("rev-parse --git-dir")
+            report(2, "gdir:", self.gitdir)
+        except:
+            die("Not a git repository... did you forget to \"git init-db\" ?")
+        try:
+            self.cdup = self.get_single("rev-parse --show-cdup")
+            if self.cdup != "":
+                os.chdir(self.cdup)
+            self.topdir = os.getcwd()
+            report(2, "topdir:", self.topdir)
+        except:
+            die("Could not find top git directory")
+
+    def git(self, cmd):
+        global logfile
+        report(2, "GIT:", cmd)
+        f=os.popen('git %s 2>>%s' % (cmd,logfile), 'rb')
+        r=f.readlines()
+        self.ret = f.close()
+        return r
+
+    def get_single(self, cmd):
+        return self.git(cmd)[0].rstrip()
+
+    def current_branch(self):
+        try:
+            testit = self.git("rev-parse --verify HEAD")[0]
+            return self.git("symbolic-ref HEAD")[0][11:].rstrip()
+        except:
+            return None
+
+    def get_config(self, variable):
+        try:
+            return self.git("repo-config --get %s" % variable)[0].rstrip()
+        except:
+            return None
+
+    def set_config(self, variable, value):
+        try:
+            self.git("repo-config %s %s"%(variable, value) )
+        except:
+            die("Could not set %s to " % variable, value)
+
+    def make_tag(self, name, head):
+        self.git("tag -f %s %s"%(name,head))
+
+    def top_change(self, branch):
+        try:
+            a=self.get_single("name-rev --tags refs/heads/%s" % branch)
+            loc = a.find(' tags/') + 6
+            if a[loc:loc+3] != "p4/":
+                raise
+            return int(a[loc+3:][:-2])
+        except:
+            return 0
+
+    def update_index(self):
+        self.git("ls-files -m -d -o -z | git update-index --add --remove -z --stdin")
+
+    def checkout(self, branch):
+        self.git("checkout %s" % branch)
+
+    def repoint_head(self, branch):
+        self.git("symbolic-ref HEAD refs/heads/%s" % branch)
+
+    def remove_files(self):
+        self.git("ls-files | xargs rm")
+
+    def clean_directories(self):
+        self.git("clean -d")
+
+    def fresh_branch(self, branch):
+        report(1, "Creating new branch", branch)
+        self.git("ls-files | xargs rm")
+        os.remove(".git/index")
+        self.repoint_head(branch)
+        self.git("clean -d")
+
+    def basedir(self):
+        return self.topdir
+
+    def commit(self, author, email, date, msg, id):
+        self.update_index()
+        fd=open(".msg", "w")
+        fd.writelines(msg)
+        fd.close()
+        try:
+                current = self.get_single("rev-parse --verify HEAD")
+                head = "-p HEAD"
+        except:
+                current = ""
+                head = ""
+        tree = self.get_single("write-tree")
+        for r,l in [('DATE',date),('NAME',author),('EMAIL',email)]:
+            os.environ['GIT_AUTHOR_%s'%r] = l
+            os.environ['GIT_COMMITTER_%s'%r] = l
+        commit = self.get_single("commit-tree %s %s < .msg" % (tree,head))
+        os.remove(".msg")
+        self.make_tag("p4/%s"%id, commit)
+        self.git("update-ref HEAD %s %s" % (commit, current) )
+
+
+try:
+    opts, args = getopt.getopt(sys.argv[1:], "qhvt:",
+                    ["authors=","help","stitch=","timezone=","log=","ignore"])
+except getopt.GetoptError:
+    usage()
+
+for o, a in opts:
+    if o == "-q":
+        verbosity = 0
+    if o == "-v":
+        verbosity += 1
+    if o in ("--log"):
+        logfile = a
+    if o in ("-h", "--help"):
+        usage()
+    if o in ("--ignore"):
+        ignore_warnings = True
+
+git = git_command()
+branch=git.current_branch()
+
+for o, a in opts:
+    if o in ("-t", "--timezone"):
+        git.set_config("perforce.timezone", a)
+    if o in ("--stitch"):
+        git.set_config("perforce.%s.path" % branch, a)
+        stitch = 1
+
+if len(args) == 2:
+    branch = args[1]
+    git.checkout(branch)
+    if branch == git.current_branch():
+        die("Branch %s already exists!" % branch)
+    report(1, "Setting perforce to ", args[0])
+    git.set_config("perforce.%s.path" % branch, args[0])
+elif len(args) != 0:
+    die("You must specify the perforce //depot/path and git branch")
+
+p4path = git.get_config("perforce.%s.path" % branch)
+if p4path == None:
+    die("Do not know Perforce //depot/path for git branch", branch)
+
+p4 = p4_command(p4path)
+
+for o, a in opts:
+    if o in ("-a", "--authors"):
+        p4.authors(a)
+
+localdir = git.basedir()
+if p4.where()[:len(localdir)] != localdir:
+    report(1, "**WARNING** Appears p4 client is misconfigured")
+    report(1, "   for sync from %s to %s" % (p4.repopath, localdir))
+    if ignore_warnings != True:
+        die("Reconfigure or use \"--ignore\" on command line")
+
+if stitch == 0:
+    top = git.top_change(branch)
+else:
+    top = 0
+changes = p4.changes(top)
+count = len(changes)
+if count == 0:
+    report(1, "Already up to date...")
+    sys.exit(0)
+
+ptz = git.get_config("perforce.timezone")
+if ptz:
+    report(1, "Setting timezone to", ptz)
+    os.environ['TZ'] = ptz
+    time.tzset()
+
+if stitch == 1:
+    git.remove_files()
+    git.clean_directories()
+    p4.sync(changes[0], force=True)
+elif top == 0 and branch != git.current_branch():
+    p4.sync(changes[0], test=True)
+    report(1, "Creating new initial commit");
+    git.fresh_branch(branch)
+    p4.sync(changes[0], force=True)
+else:
+    p4.sync(changes[0], trick=True)
+
+report(1, "processing %s changes from p4 (%s) to git (%s)" % (count, p4.repopath, branch))
+for id in changes:
+    report(1, "Importing changeset", id)
+    change = p4.describe(id)
+    p4.sync(id)
+    git.commit(change.author, change.email, change.date, change.msg, id)
+    if stitch == 1:
+        git.clean_directories()
+        stitch = 0
+
-- 
1.3.3.g17cf3
