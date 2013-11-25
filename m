From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/9] contrib: remove git-p4import
Date: Mon, 25 Nov 2013 12:58:48 -0800
Message-ID: <20131125205847.GU4212@google.com>
References: <20131125205119.GQ4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>,
	Sean Estabrooks <seanlkml@sympatico.ca>,
	Clemens Buchacher <drizzd@aon.at>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 21:59:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl3FG-0002UI-30
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab3KYU64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:58:56 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:62715 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab3KYU6v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:58:51 -0500
Received: by mail-yh0-f43.google.com with SMTP id a41so2756671yho.16
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 12:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Z1/Bl7YlSCYt1YEcU82ja0YVGOwSsx3sN0m6yA22sfw=;
        b=p3Jny1aCoS+/Zh+SIJ8XPoOvL2+PmMiiESeycDveGr1eRoq6b9gcHKvrDF7BHWixKs
         b8y/A3lxBjr35UAe92sv/ov2pz3V6d8661YUygaqiwopMr0AkzCghsfkQsrhN79AERYP
         xy+TDFmP9fYVScdic3m0TpH3+78GOjzm3PapjXm6Bt4KEU8+J7Yaa3ieyBE8TXpL6Tvl
         Xa0pZAsaxR7a+DJTmQn1Ss7ImupK48Oguy92IwljHnlULTkCalT2bM91VLKcnayg7sa0
         U2T2/SJLkpvE7UWnSigvmS100pXMFdmr3xtv4k3VX8tz/wN/g8uGbxeqe4aYZB6tt4X8
         q0Ig==
X-Received: by 10.236.228.137 with SMTP id f9mr29415051yhq.44.1385413130923;
        Mon, 25 Nov 2013 12:58:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id s21sm78029427yhk.9.2013.11.25.12.58.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 12:58:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131125205119.GQ4212@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238351>

The git p4import documentation has suggested git p4 as a better
alternative for more than 6 years.  (According to the mailing list
discussion when it was moved to contrib/, git-p4import has serious
bugs --- e.g., its incremental mode just doesn't work.) Since then,
git p4 has been actively developed and was promoted to a standard git
command alongside git svn.

Searches on google.com/trends and stackoverflow suggest that no one is
looking for git-p4import any more.  Remove it.

Noticed while considering marking the contrib/p4import/git-p4import.py
script executable as part of a wider sweep.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Following up on
http://thread.gmane.org/gmane.comp.version-control.git/52580

 contrib/p4import/README           |   1 -
 contrib/p4import/git-p4import.py  | 365 --------------------------------------
 contrib/p4import/git-p4import.txt | 167 -----------------
 3 files changed, 533 deletions(-)
 delete mode 100644 contrib/p4import/README
 delete mode 100644 contrib/p4import/git-p4import.py
 delete mode 100644 contrib/p4import/git-p4import.txt

diff --git a/contrib/p4import/README b/contrib/p4import/README
deleted file mode 100644
index b9892b6..0000000
--- a/contrib/p4import/README
+++ /dev/null
@@ -1 +0,0 @@
-Please see contrib/fast-import/git-p4 for a better Perforce importer.
diff --git a/contrib/p4import/git-p4import.py b/contrib/p4import/git-p4import.py
deleted file mode 100644
index 593d6a0..0000000
--- a/contrib/p4import/git-p4import.py
+++ /dev/null
@@ -1,365 +0,0 @@
-#!/usr/bin/env python
-#
-# This tool is copyright (c) 2006, Sean Estabrooks.
-# It is released under the Gnu Public License, version 2.
-#
-# Import Perforce branches into Git repositories.
-# Checking out the files is done by calling the standard p4
-# client which you must have properly configured yourself
-#
-
-import marshal
-import os
-import sys
-import time
-import getopt
-
-if sys.hexversion < 0x02020000:
-   # The behavior of the marshal module changed significantly in 2.2
-   sys.stderr.write("git-p4import.py: requires Python 2.2 or later.\n")
-   sys.exit(1)
-
-from signal import signal, \
-   SIGPIPE, SIGINT, SIG_DFL, \
-   default_int_handler
-
-signal(SIGPIPE, SIG_DFL)
-s = signal(SIGINT, SIG_DFL)
-if s != default_int_handler:
-   signal(SIGINT, s)
-
-def die(msg, *args):
-    for a in args:
-        msg = "%s %s" % (msg, a)
-    print "git-p4import fatal error:", msg
-    sys.exit(1)
-
-def usage():
-    print "USAGE: git-p4import [-q|-v]  [--authors=<file>]  [-t <timezone>]  [//p4repo/path <branch>]"
-    sys.exit(1)
-
-verbosity = 1
-logfile = "/dev/null"
-ignore_warnings = False
-stitch = 0
-tagall = True
-
-def report(level, msg, *args):
-    global verbosity
-    global logfile
-    for a in args:
-        msg = "%s %s" % (msg, a)
-    fd = open(logfile, "a")
-    fd.writelines(msg)
-    fd.close()
-    if level <= verbosity:
-        print msg
-
-class p4_command:
-    def __init__(self, _repopath):
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
-
-    def p4(self, cmd, *args):
-        global logfile
-        cmd = "%s %s" % (cmd, ' '.join(args))
-        report(2, "P4:", cmd)
-        f=os.popen('p4 -G %s 2>>%s' % (cmd,logfile), 'rb')
-        list = []
-        while 1:
-           try:
-                list.append(marshal.load(f))
-           except EOFError:
-                break
-        self.ret = f.close()
-        return list
-
-    def sync(self, id, force=False, trick=False, test=False):
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
-
-    def changes(self, since=0):
-        try:
-            list = []
-            for rec in self.p4("changes %s@%s,#head" % (self.repopath, since+1)):
-                list.append(rec['change'])
-            list.reverse()
-            return list
-        except:
-            return []
-
-    def authors(self, filename):
-        f=open(filename)
-        for l in f.readlines():
-            self.userlist[l[:l.find('=')].rstrip()] = \
-                    (l[l.find('=')+1:l.find('<')].rstrip(),l[l.find('<')+1:l.find('>')])
-        f.close()
-        for f,e in self.userlist.items():
-                report(2, f, ":", e[0], "  <", e[1], ">")
-
-    def _get_user(self, id):
-        if not self.userlist.has_key(id):
-            try:
-                user = self.p4("users", id)[0]
-                self.userlist[id] = (user['FullName'], user['Email'])
-            except:
-                self.userlist[id] = (id, "")
-        return self.userlist[id]
-
-    def _format_date(self, ticks):
-        symbol='+'
-        name = time.tzname[0]
-        offset = time.timezone
-        if ticks[8]:
-            name = time.tzname[1]
-            offset = time.altzone
-        if offset < 0:
-            offset *= -1
-            symbol = '-'
-        localo = "%s%02d%02d %s" % (symbol, offset / 3600, offset % 3600, name)
-        tickso = time.strftime("%a %b %d %H:%M:%S %Y", ticks)
-        return "%s %s" % (tickso, localo)
-
-    def where(self):
-        try:
-            return self.p4("where %s" % self.repopath)[-1]['path']
-        except:
-            return ""
-
-    def describe(self, num):
-        desc = self.p4("describe -s", num)[0]
-        self.msg = desc['desc']
-        self.author, self.email = self._get_user(desc['user'])
-        self.date = self._format_date(time.localtime(long(desc['time'])))
-        return self
-
-class git_command:
-    def __init__(self):
-        try:
-            self.version = self.git("--version")[0][12:].rstrip()
-        except:
-            die("Could not find the \"git\" command")
-        try:
-            self.gitdir = self.get_single("rev-parse --git-dir")
-            report(2, "gdir:", self.gitdir)
-        except:
-            die("Not a git repository... did you forget to \"git init\" ?")
-        try:
-            self.cdup = self.get_single("rev-parse --show-cdup")
-            if self.cdup != "":
-                os.chdir(self.cdup)
-            self.topdir = os.getcwd()
-            report(2, "topdir:", self.topdir)
-        except:
-            die("Could not find top git directory")
-
-    def git(self, cmd):
-        global logfile
-        report(2, "GIT:", cmd)
-        f=os.popen('git %s 2>>%s' % (cmd,logfile), 'rb')
-        r=f.readlines()
-        self.ret = f.close()
-        return r
-
-    def get_single(self, cmd):
-        return self.git(cmd)[0].rstrip()
-
-    def current_branch(self):
-        try:
-            testit = self.git("rev-parse --verify HEAD")[0]
-            return self.git("symbolic-ref HEAD")[0][11:].rstrip()
-        except:
-            return None
-
-    def get_config(self, variable):
-        try:
-            return self.git("config --get %s" % variable)[0].rstrip()
-        except:
-            return None
-
-    def set_config(self, variable, value):
-        try:
-            self.git("config %s %s"%(variable, value) )
-        except:
-            die("Could not set %s to " % variable, value)
-
-    def make_tag(self, name, head):
-        self.git("tag -f %s %s"%(name,head))
-
-    def top_change(self, branch):
-        try:
-            a=self.get_single("name-rev --tags refs/heads/%s" % branch)
-            loc = a.find(' tags/') + 6
-            if a[loc:loc+3] != "p4/":
-                raise
-            return int(a[loc+3:][:-2])
-        except:
-            return 0
-
-    def update_index(self):
-        self.git("ls-files -m -d -o -z | git update-index --add --remove -z --stdin")
-
-    def checkout(self, branch):
-        self.git("checkout %s" % branch)
-
-    def repoint_head(self, branch):
-        self.git("symbolic-ref HEAD refs/heads/%s" % branch)
-
-    def remove_files(self):
-        self.git("ls-files | xargs rm")
-
-    def clean_directories(self):
-        self.git("clean -d")
-
-    def fresh_branch(self, branch):
-        report(1, "Creating new branch", branch)
-        self.git("ls-files | xargs rm")
-        os.remove(".git/index")
-        self.repoint_head(branch)
-        self.git("clean -d")
-
-    def basedir(self):
-        return self.topdir
-
-    def commit(self, author, email, date, msg, id):
-        self.update_index()
-        fd=open(".msg", "w")
-        fd.writelines(msg)
-        fd.close()
-        try:
-                current = self.get_single("rev-parse --verify HEAD")
-                head = "-p HEAD"
-        except:
-                current = ""
-                head = ""
-        tree = self.get_single("write-tree")
-        for r,l in [('DATE',date),('NAME',author),('EMAIL',email)]:
-            os.environ['GIT_AUTHOR_%s'%r] = l
-            os.environ['GIT_COMMITTER_%s'%r] = l
-        commit = self.get_single("commit-tree %s %s < .msg" % (tree,head))
-        os.remove(".msg")
-        self.make_tag("p4/%s"%id, commit)
-        self.git("update-ref HEAD %s %s" % (commit, current) )
-
-try:
-    opts, args = getopt.getopt(sys.argv[1:], "qhvt:",
-            ["authors=","help","stitch=","timezone=","log=","ignore","notags"])
-except getopt.GetoptError:
-    usage()
-
-for o, a in opts:
-    if o == "-q":
-        verbosity = 0
-    if o == "-v":
-        verbosity += 1
-    if o in ("--log"):
-        logfile = a
-    if o in ("--notags"):
-        tagall = False
-    if o in ("-h", "--help"):
-        usage()
-    if o in ("--ignore"):
-        ignore_warnings = True
-
-git = git_command()
-branch=git.current_branch()
-
-for o, a in opts:
-    if o in ("-t", "--timezone"):
-        git.set_config("perforce.timezone", a)
-    if o in ("--stitch"):
-        git.set_config("perforce.%s.path" % branch, a)
-        stitch = 1
-
-if len(args) == 2:
-    branch = args[1]
-    git.checkout(branch)
-    if branch == git.current_branch():
-        die("Branch %s already exists!" % branch)
-    report(1, "Setting perforce to ", args[0])
-    git.set_config("perforce.%s.path" % branch, args[0])
-elif len(args) != 0:
-    die("You must specify the perforce //depot/path and git branch")
-
-p4path = git.get_config("perforce.%s.path" % branch)
-if p4path == None:
-    die("Do not know Perforce //depot/path for git branch", branch)
-
-p4 = p4_command(p4path)
-
-for o, a in opts:
-    if o in ("-a", "--authors"):
-        p4.authors(a)
-
-localdir = git.basedir()
-if p4.where()[:len(localdir)] != localdir:
-    report(1, "**WARNING** Appears p4 client is misconfigured")
-    report(1, "   for sync from %s to %s" % (p4.repopath, localdir))
-    if ignore_warnings != True:
-        die("Reconfigure or use \"--ignore\" on command line")
-
-if stitch == 0:
-    top = git.top_change(branch)
-else:
-    top = 0
-changes = p4.changes(top)
-count = len(changes)
-if count == 0:
-    report(1, "Already up to date...")
-    sys.exit(0)
-
-ptz = git.get_config("perforce.timezone")
-if ptz:
-    report(1, "Setting timezone to", ptz)
-    os.environ['TZ'] = ptz
-    time.tzset()
-
-if stitch == 1:
-    git.remove_files()
-    git.clean_directories()
-    p4.sync(changes[0], force=True)
-elif top == 0 and branch != git.current_branch():
-    p4.sync(changes[0], test=True)
-    report(1, "Creating new initial commit");
-    git.fresh_branch(branch)
-    p4.sync(changes[0], force=True)
-else:
-    p4.sync(changes[0], trick=True)
-
-report(1, "processing %s changes from p4 (%s) to git (%s)" % (count, p4.repopath, branch))
-for id in changes:
-    report(1, "Importing changeset", id)
-    change = p4.describe(id)
-    p4.sync(id)
-    if tagall :
-            git.commit(change.author, change.email, change.date, change.msg, id)
-    else:
-            git.commit(change.author, change.email, change.date, change.msg, "import")
-    if stitch == 1:
-        git.clean_directories()
-        stitch = 0
diff --git a/contrib/p4import/git-p4import.txt b/contrib/p4import/git-p4import.txt
deleted file mode 100644
index 9967587..0000000
--- a/contrib/p4import/git-p4import.txt
+++ /dev/null
@@ -1,167 +0,0 @@
-git-p4import(1)
-===============
-
-NAME
-----
-git-p4import - Import a Perforce repository into git
-
-
-SYNOPSIS
---------
-[verse]
-`git-p4import` [-q|-v] [--notags] [--authors <file>] [-t <timezone>]
-               <//p4repo/path> <branch>
-`git-p4import` --stitch <//p4repo/path>
-`git-p4import`
-
-
-DESCRIPTION
------------
-Import a Perforce repository into an existing git repository.  When
-a <//p4repo/path> and <branch> are specified a new branch with the
-given name will be created and the initial import will begin.
-
-Once the initial import is complete you can do an incremental import
-of new commits from the Perforce repository.  You do this by checking
-out the appropriate git branch and then running `git-p4import` without
-any options.
-
-The standard p4 client is used to communicate with the Perforce
-repository; it must be configured correctly in order for `git-p4import`
-to operate (see below).
-
-
-OPTIONS
--------
--q::
-	Do not display any progress information.
-
--v::
-        Give extra progress information.
-
-\--authors::
-	Specify an authors file containing a mapping of Perforce user
-	ids to full names and email addresses (see Notes below).
-
-\--notags::
-	Do not create a tag for each imported commit.
-
-\--stitch::
-	Import the contents of the given perforce branch into the
-	currently checked out git branch.
-
-\--log::
-	Store debugging information in the specified file.
-
--t::
-	Specify that the remote repository is in the specified timezone.
-	Timezone must be in the format "US/Pacific" or "Europe/London"
-	etc.  You only need to specify this once, it will be saved in
-	the git config file for the repository.
-
-<//p4repo/path>::
-	The Perforce path that will be imported into the specified branch.
-
-<branch>::
-	The new branch that will be created to hold the Perforce imports.
-
-
-P4 Client
----------
-You must make the `p4` client command available in your $PATH and
-configure it to communicate with the target Perforce repository.
-Typically this means you must set the "$P4PORT" and "$P4CLIENT"
-environment variables.
-
-You must also configure a `p4` client "view" which maps the Perforce
-branch into the top level of your git repository, for example:
-
-------------
-Client: myhost
-
-Root:   /home/sean/import
-
-Options:   noallwrite clobber nocompress unlocked modtime rmdir
-
-View:
-        //public/jam/... //myhost/jam/...
-------------
-
-With the above `p4` client setup, you could import the "jam"
-perforce branch into a branch named "jammy", like so:
-
-------------
-$ mkdir -p /home/sean/import/jam
-$ cd /home/sean/import/jam
-$ git init
-$ git p4import //public/jam jammy
-------------
-
-
-Multiple Branches
------------------
-Note that by creating multiple "views" you can use `git-p4import`
-to import additional branches into the same git repository.
-However, the `p4` client has a limitation in that it silently
-ignores all but the last "view" that maps into the same local
-directory.  So the following will *not* work:
-
-------------
-View:
-        //public/jam/... //myhost/jam/...
-        //public/other/... //myhost/jam/...
-        //public/guest/... //myhost/jam/...
-------------
-
-If you want more than one Perforce branch to be imported into the
-same directory you must employ a workaround.  A simple option is
-to adjust your `p4` client before each import to only include a
-single view.
-
-Another option is to create multiple symlinks locally which all
-point to the same directory in your git repository and then use
-one per "view" instead of listing the actual directory.
-
-
-Tags
-----
-A git tag of the form p4/xx is created for every change imported from
-the Perforce repository where xx is the Perforce changeset number.
-Therefore after the import you can use git to access any commit by its
-Perforce number, e.g. git show p4/327.
-
-The tag associated with the HEAD commit is also how `git-p4import`
-determines if there are new changes to incrementally import from the
-Perforce repository.
-
-If you import from a repository with many thousands of changes
-you will have an equal number of p4/xxxx git tags.  Git tags can
-be expensive in terms of disk space and repository operations.
-If you don't need to perform further incremental imports, you
-may delete the tags.
-
-
-Notes
------
-You can interrupt the import (e.g. ctrl-c) at any time and restart it
-without worry.
-
-Author information is automatically determined by querying the
-Perforce "users" table using the id associated with each change.
-However, if you want to manually supply these mappings you can do
-so with the "--authors" option.  It accepts a file containing a list
-of mappings with each line containing one mapping in the format:
-
-------------
-    perforce_id = Full Name <email@address.com>
-------------
-
-
-Author
-------
-Written by Sean Estabrooks <seanlkml@sympatico.ca>
-
-
-GIT
----
-Part of the gitlink:git[7] suite
-- 
1.8.4.1
