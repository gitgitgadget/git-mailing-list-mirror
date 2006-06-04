From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Preliminary branch-import support for git in tailor
Date: Sun, 4 Jun 2006 16:59:01 +0200
Message-ID: <20060604145901.GQ6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tjCHc7DPkfUGtrlw"
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 04 16:46:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmtro-0007pD-6m
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 16:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWFDOqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 10:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbWFDOqH
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 10:46:07 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:44005 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751502AbWFDOqH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 10:46:07 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 77FB173102;
	Sun,  4 Jun 2006 16:46:05 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1Fmu4E-0003dr-01; Sun, 04 Jun 2006 16:59:02 +0200
To: lele@nautilus.homeip.net, tailor@lists.zooko.com
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21267>


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here is my first try at working with branches with tailor.
This patch applies to current tailor from the darcs repo.

Attached: the patch, and the sample config I used to test it against a
public repo.

Possible improvements:

- the parent-repo parameter is probably generic enough to be useful
for other targets, but it is currently a git-target parameter only

- the change to tailor.py to avoid loosing the initial commit log on
the imported branch probably breaks all other targets because of the
previous issue

- autodetection of the branchpoint would be great, but that surely
deserves to be done in core tailor

- I'll have a try next to add support for pushing git branches to cvs
ones: that will give us a real 2-way sync between cvs and git


Generic problems noticed:

- not all tags from the cvs repo I tested against were imported
(problem specific to the cvs source ?)

- I could not make the cvsps source work to verify it fetches tags
better than the cvs one

- the "projects" parameter has to be specified explicitely to force
the ordering of branch imports - I would have expected the declaration
order to be used.

- it would probably be cleaner to have the *Repository classes in
repository.py moved into their own files: currently we have to modify
a generic file to add backend-specific options, that's not really
generic.  What about loading the necessary class when it is found
mentionned in the config ?


Comparison with git-cvsimport

- tailor can give strange results in some cases, but I believe it is
more correct than git-cvsimport.  An example is when the cvs branch
you import does not exist in some files for any reason (I had a branch
only for the src/ dir - corrected that now): in that case tailor
correctly shows deletions for those files in the branch initial
commit, whereas git-cvsimport only works on changes, and does not do
anything special (this may be cvsps doing magic behind his back).

- run against a local copy of the repository, tailor is orders of
magnitude slower than git-cvsimport (git-cvsimport returned instantly
on my repo), some profiling has to be done.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>

--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="darcs.diff"

diff -rN -u old-tailor/README new-tailor/README
--- old-tailor/README	2006-06-04 16:42:52.000000000 +0200
+++ new-tailor/README	2006-06-04 16:42:52.000000000 +0200
@@ -661,7 +661,21 @@
 git
 %%%
 
-.. no specific options
+parent-repo : string
+  Relative path to a git directory to use as a parent.  This is useful
+  to import repository branches.  If this parameter is empty, the
+  branch has no parent (default behaviour).
+
+parent-rev : string
+  A reference to the git commit which is the parent for the first
+  revision on the branch to be imported (ie, the branch point).  It
+  can be a tag name or any syntax acceptable by git (eg. something
+  like "tag~2", if you want to correct the idea of where the
+  branchpoint is.
+
+  Since tailor generates mostly-stable SHA1 revisions, you can also
+  use a SHA1 as branchpoint.  Just import your trunk first, find the
+  correct SHA1, and setup and import your branch.
 
 hg
 %%
diff -rN -u old-tailor/vcpx/git.py new-tailor/vcpx/git.py
--- old-tailor/vcpx/git.py	2006-06-04 16:42:52.000000000 +0200
+++ new-tailor/vcpx/git.py	2006-06-04 16:42:52.000000000 +0200
@@ -298,19 +298,39 @@
 
     def _prepareTargetRepository(self):
         """
-        Execute ``git init-db``.
+        Initialize .git through ``git init-db`` or ``git-clone``.
         """
 
+        from os import renames
         from os.path import join, exists
 
         if not exists(join(self.basedir, self.repository.METADIR)):
-            init = ExternalCommand(cwd=self.basedir,
-                                   command=self.repository.command("init-db"))
-            init.execute()
-
-            if init.exit_status:
-                raise TargetInitializationFailure(
-                    "%s returned status %s" % (str(init), init.exit_status))
+            if self.repository.PARENT_REPO == '':
+                cmd = self.repository.command("init-db")
+                init = ExternalCommand(cwd=self.basedir, command=cmd)
+                init.execute()
+                if init.exit_status:
+                    raise TargetInitializationFailure(
+                        "%s returned status %s" % (str(init), init.exit_status))
+            else:
+                cmd = self.repository.command("clone", "--shared", "-n",
+                                              self.repository.PARENT_REPO, 'tmp')
+                clone = ExternalCommand(cwd=self.basedir, command=cmd)
+                clone.execute()
+                if clone.exit_status:
+                    raise TargetInitializationFailure(
+                        "%s returned status %s" % (str(clone), clone.exit_status))
+
+                renames('%s/%s/tmp/.git' % (self.repository.rootdir, self.repository.subdir),
+                        '%s/%s/.git' % (self.repository.rootdir, self.repository.subdir))
+                
+                cmd = self.repository.command("reset", "--soft", self.repository.PARENT_REV)
+                reset = ExternalCommand(cwd=self.basedir, command=cmd)
+                reset.execute()
+                if reset.exit_status:
+                    raise TargetInitializationFailure(
+                        "%s returned status %s" % (str(reset), reset.exit_status))
+
 
     def _prepareWorkingDirectory(self, source_repo):
         """
diff -rN -u old-tailor/vcpx/repository.py new-tailor/vcpx/repository.py
--- old-tailor/vcpx/repository.py	2006-06-04 16:42:52.000000000 +0200
+++ new-tailor/vcpx/repository.py	2006-06-04 16:42:52.000000000 +0200
@@ -287,6 +287,8 @@
     def _load(self, project):
         Repository._load(self, project)
         self.EXECUTABLE = project.config.get(self.name, 'git-command', 'git')
+        self.PARENT_REPO = project.config.get(self.name, 'parent-repo', '')
+        self.PARENT_REV = project.config.get(self.name, 'parent-rev', 'HEAD')
 
 
 class HgRepository(Repository):
diff -rN -u old-tailor/vcpx/tailor.py new-tailor/vcpx/tailor.py
--- old-tailor/vcpx/tailor.py	2006-06-04 16:42:52.000000000 +0200
+++ new-tailor/vcpx/tailor.py	2006-06-04 16:42:52.000000000 +0200
@@ -74,7 +74,9 @@
             raise
 
         try:
-            dwd.importFirstRevision(self.source, actual, 'INITIAL'==revision)
+            dwd.importFirstRevision(self.source, actual,
+                                    self.target.PARENT_REPO != '' or
+                                    'INITIAL'==revision)
         except:
             self.log.critical('Could not import checked out tree in "%s"!',
                               self.rootdir)


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bigdiesel.tailor"

[DEFAULT]
#verbose=yes
patch-name-format=%(firstlogline)s
remove-first-log-line=True
# that one seems necessary to force ordering
projects = trunk-pull, branch-pull

[trunk-pull]
root-directory = /export/work/yann/tailor/test/root
source = cvs:bigdiesel
target = git:bigdiesel
start-revision = INITIAL
state-file = trunk-pull.state
subdir = trunk

[branch-pull]
root-directory = /export/work/yann/tailor/test/root
source = cvs:bigdiesel
target = git:bigdiesel-branch
start-revision = bigloo-parser INITIAL
state-file = branch-pull.state
subdir = bigloo-parser

[cvs:bigdiesel]
repository = :pserver:anonymous@cvs.savannah.nongnu.org:/sources/dsssl-utils
#repository = /export/work/yann/tailor/test/cvsroot
module = dsssl-utils/bigdiesel

[git:bigdiesel]

[git:bigdiesel-branch]
parent-repo = ../trunk
#parent-rev = 0bbd4b84fce498793db7fdf01388dcb5ed9ada88
parent-rev = bigloo-parser_branchpoint

--tjCHc7DPkfUGtrlw--
