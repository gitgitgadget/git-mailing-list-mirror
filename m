From: Tor Arvid Lund <torarvid@gmail.com>
Subject: [PATCH RFC] git-p4: Support usage of perforce client spec
Date: Mon, 18 Feb 2008 15:22:08 +0100
Message-ID: <1203344528-10981-1-git-send-email-torarvid@gmail.com>
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 15:50:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR7KF-0008NJ-NF
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 15:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbYBROt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 09:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbYBROt7
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 09:49:59 -0500
Received: from lakepoint.domeneshop.no ([194.63.248.54]:38456 "EHLO
	lakepoint.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbYBROt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 09:49:58 -0500
X-Greylist: delayed 1659 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Feb 2008 09:49:57 EST
Received: from localhost.localdomain (194-156-151-213.mtulink.net [213.151.156.194])
	(authenticated bits=0)
	by lakepoint.domeneshop.no (8.13.8/8.13.8) with ESMTP id m1IEM8gY021850;
	Mon, 18 Feb 2008 15:22:08 +0100
X-Mailer: git-send-email 1.5.4.35.g9d0ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74298>

When syncing, git-p4 will only download files that are included in the active
perforce client spec. This does not change the default behaviour - it requires
that the user either supplies the command line argument --use-client-spec, or
sets the git config option p4.useclientspec to "true".

Signed-off-by: Tor Arvid Lund <torarvid@gmail.com>
---

This is something I use personally to help reduce the size downloaded when
cloning and syncing, as the Perforce depot i normally use is littered with
changelists that are much bigger than they should (and thus contain both
interesting and uninteresting files). I thought it might be of use to other
people too.

Note that this is my first attempt at git-related hacking (and that I am also a
Python novice), so it may very well need some tuning/fixing before it is any
good.

 contrib/fast-import/git-p4 |   50 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 781a0cb..e3766c3 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -817,7 +817,9 @@ class P4Sync(Command):
                                      help="Import into refs/heads/ , not refs/remotes"),
                 optparse.make_option("--max-changes", dest="maxChanges"),
                 optparse.make_option("--keep-path", dest="keepRepoPath", action='store_true',
-                                     help="Keep entire BRANCH/DIR/SUBDIR prefix during import")
+                                     help="Keep entire BRANCH/DIR/SUBDIR prefix during import"),
+                optparse.make_option("--use-client-spec", dest="useClientSpec", action='store_true',
+                                     help="Only sync files that are included in the Perforce Client Spec")
         ]
         self.description = """Imports from Perforce into a git repository.\n
     example:
@@ -843,6 +845,8 @@ class P4Sync(Command):
         self.keepRepoPath = False
         self.depotPaths = None
         self.p4BranchesInGit = []
+        self.useClientSpec = False
+        self.clientSpecDirs = []
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
@@ -911,11 +915,21 @@ class P4Sync(Command):
 
     ## Should move this out, doesn't use SELF.
     def readP4Files(self, files):
+        for f in files:
+            for val in self.clientSpecDirs:
+                if f['path'].startswith(val[0]):
+                    if val[1] > 0:
+                        f['include'] = True
+                    else:
+                        f['include'] = False
+                    break
+
         files = [f for f in files
-                 if f['action'] != 'delete']
+                 if f['action'] != 'delete' and
+                 (f.has_key('include') == False or f['include'] == True)]
 
         if not files:
-            return
+            return []
 
         filedata = p4CmdList('-x - print',
                              stdin='\n'.join(['%s#%s' % (f['path'], f['rev'])
@@ -950,6 +964,7 @@ class P4Sync(Command):
         for f in files:
             assert not f.has_key('data')
             f['data'] = contents[f['path']]
+        return files
 
     def commit(self, details, files, branch, branchPrefixes, parent = ""):
         epoch = details["time"]
@@ -966,11 +981,7 @@ class P4Sync(Command):
                 new_files.append (f)
             else:
                 sys.stderr.write("Ignoring file outside of prefix: %s\n" % path)
-        files = new_files
-        self.readP4Files(files)
-
-
-
+        files = self.readP4Files(new_files)
 
         self.gitStream.write("commit %s\n" % branch)
 #        gitStream.write("mark :%s\n" % details["change"])
@@ -1385,6 +1396,26 @@ class P4Sync(Command):
             print self.gitError.read()
 
 
+    def getClientSpec(self):
+        specList = p4CmdList( "client -o" )
+        temp = {}
+        for entry in specList:
+            for k,v in entry.iteritems():
+                if k.startswith("View"):
+                    if v.startswith('"'):
+                        start = 1
+                    else:
+                        start = 0
+                    index = v.find("...")
+                    v = v[start:index]
+                    if v.startswith("-"):
+                        v = v[1:]
+                        temp[v] = -len(v)
+                    else:
+                        temp[v] = len(v)
+        self.clientSpecDirs = temp.items()
+        self.clientSpecDirs.sort( lambda x, y: abs( y[1] ) - abs( x[1] ) )
+
     def run(self, args):
         self.depotPaths = []
         self.changeRange = ""
@@ -1417,6 +1448,9 @@ class P4Sync(Command):
             if not gitBranchExists(self.refPrefix + "HEAD") and self.importIntoRemotes and gitBranchExists(self.branch):
                 system("git symbolic-ref %sHEAD %s" % (self.refPrefix, self.branch))
 
+        if self.useClientSpec or gitConfig("p4.useclientspec") == "true":
+            self.getClientSpec()
+
         # TODO: should always look at previous commits,
         # merge with previous imports, if possible.
         if args == []:
-- 
1.5.4.35.g9d0ca
