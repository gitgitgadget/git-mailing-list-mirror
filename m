From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Make "stg goto" subdirectory safe
Date: Wed, 19 Dec 2007 23:24:49 +0100
Message-ID: <20071219221957.29455.27315.stgit@yoghurt>
References: <20071219221848.29455.50676.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 23:25:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J57Lp-0004Do-Si
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 23:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbXLSWYz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 17:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428AbXLSWYz
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 17:24:55 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3449 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412AbXLSWYy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 17:24:54 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J57LN-0003yE-00; Wed, 19 Dec 2007 22:24:49 +0000
In-Reply-To: <20071219221848.29455.50676.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68947>

This is not specific to "stg goto" -- it affects all commands that use
the new infrastructure. (But of those, only goto and coalesce were
subdirectory unsafe.)

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

On 2007-12-18 10:24:19 +0100, Karl Hasselstr=C3=B6m wrote:

> On 2007-12-18 09:11:00 +0000, Catalin Marinas wrote:
>=20
> > On 17/12/2007, Karl Hasselstr=C3=B6m <kha@treskal.com> wrote:
> >
> > > Be careful about merging past the "goto" patch -- I'm pretty
> > > sure it breaks when called from a subdirectory, and I don't have
> > > time to fix that right now. (It should be a clean fix, though --
> > > just adjust the cwd for precisely those git subprocesses that
> > > need it, which is very few. I think.)
> >
> > Why not just change the cwd when the command starts and it should
> > be safe for all the git subprocesses.
>=20
> It doesn't feel very clean to require the caller of some unspecified
> subset of git calls to remember to set the correct piece of global
> state.
>=20
> And the correct solution should really be very simple, since it's
> precisely the worktree operations (specifically, the subset thereof
> that have to operate on the whole tree) that require setting cwd.
> And those are very clearly separated out from the rest in the new
> infrastructure.

And here it is! Note that not counting the cwd support in run.py and
changing the test to expect success, I had to change just three lines
to fix this problem for _all_ "new infrastructure" commands. And no
unintended side effects, since the cwd is changed only where it's
necessary.

 stgit/lib/git.py       |    5 +++--
 stgit/run.py           |    9 ++++++---
 t/t2800-goto-subdir.sh |    4 ++--
 3 files changed, 11 insertions(+), 7 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 6aba966..118c9b2 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -344,6 +344,7 @@ class Worktree(object):
     def __init__(self, directory):
         self.__directory =3D directory
     env =3D property(lambda self: { 'GIT_WORK_TREE': self.__directory =
})
+    directory =3D property(lambda self: self.__directory)
=20
 class CheckoutException(exception.StgException):
     pass
@@ -364,7 +365,7 @@ class IndexAndWorktree(RunWithEnv):
             self.run(['git', 'read-tree', '-u', '-m',
                       '--exclude-per-directory=3D.gitignore',
                       old_tree.sha1, new_tree.sha1]
-                     ).discard_output()
+                     ).cwd(self.__worktree.directory).discard_output()
         except run.RunException:
             raise CheckoutException('Index/workdir dirty')
     def merge(self, base, ours, theirs):
@@ -377,7 +378,7 @@ class IndexAndWorktree(RunWithEnv):
                      env =3D { 'GITHEAD_%s' % base.sha1: 'ancestor',
                              'GITHEAD_%s' % ours.sha1: 'current',
                              'GITHEAD_%s' % theirs.sha1: 'patched'}
-                     ).discard_output()
+                     ).cwd(self.__worktree.directory).discard_output()
         except run.RunException, e:
             raise MergeException('Index/worktree dirty')
     def changed_files(self):
diff --git a/stgit/run.py b/stgit/run.py
index 78537db..77f2e65 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -42,7 +42,7 @@ class Run:
             if type(c) !=3D str:
                 raise Exception, 'Bad command: %r' % (cmd,)
         self.__good_retvals =3D [0]
-        self.__env =3D None
+        self.__env =3D self.__cwd =3D None
         self.__indata =3D None
         self.__discard_stderr =3D False
     def __log_start(self):
@@ -67,7 +67,7 @@ class Run:
         """Run with captured IO."""
         self.__log_start()
         try:
-            p =3D subprocess.Popen(self.__cmd, env =3D self.__env,
+            p =3D subprocess.Popen(self.__cmd, env =3D self.__env, cwd=
 =3D self.__cwd,
                                  stdin =3D subprocess.PIPE,
                                  stdout =3D subprocess.PIPE,
                                  stderr =3D subprocess.PIPE)
@@ -85,7 +85,7 @@ class Run:
         assert self.__indata =3D=3D None
         self.__log_start()
         try:
-            p =3D subprocess.Popen(self.__cmd, env =3D self.__env)
+            p =3D subprocess.Popen(self.__cmd, env =3D self.__env, cwd=
 =3D self.__cwd)
             self.exitcode =3D p.wait()
         except OSError, e:
             raise self.exc('%s failed: %s' % (self.__cmd[0], e))
@@ -104,6 +104,9 @@ class Run:
         self.__env =3D dict(os.environ)
         self.__env.update(env)
         return self
+    def cwd(self, cwd):
+        self.__cwd =3D cwd
+        return self
     def raw_input(self, indata):
         self.__indata =3D indata
         return self
diff --git a/t/t2800-goto-subdir.sh b/t/t2800-goto-subdir.sh
index 9f3ab26..fcad7da 100755
--- a/t/t2800-goto-subdir.sh
+++ b/t/t2800-goto-subdir.sh
@@ -24,7 +24,7 @@ EOF
 cat > expected2.txt <<EOF
 bar
 EOF
-test_expect_failure 'Goto in subdirectory (just pop)' '
+test_expect_success 'Goto in subdirectory (just pop)' '
     (cd foo && stg goto p1) &&
     cat foo/bar > actual.txt &&
     diff -u expected1.txt actual.txt &&
@@ -47,7 +47,7 @@ EOF
 cat > expected2.txt <<EOF
 bar
 EOF
-test_expect_failure 'Goto in subdirectory (conflicting push)' '
+test_expect_success 'Goto in subdirectory (conflicting push)' '
     (cd foo && stg goto p3) ;
     [ $? -eq 3 ] &&
     cat foo/bar > actual.txt &&
