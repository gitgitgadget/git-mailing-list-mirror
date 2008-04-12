From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Don't both change directory and set GIT_WORK_TREE
Date: Sat, 12 Apr 2008 17:47:22 +0200
Message-ID: <20080412154722.19690.87411.stgit@yoghurt>
References: <20080412154427.19690.71877.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Sandberg <mandolaerik@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 17:48:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkhxZ-0008Qk-N8
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 17:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbYDLPr2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Apr 2008 11:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755334AbYDLPr2
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 11:47:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1470 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755092AbYDLPr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 11:47:26 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jkhwm-0004Cb-00; Sat, 12 Apr 2008 16:47:21 +0100
In-Reply-To: <20080412154427.19690.71877.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79367>

We used to both change the working directory and set GIT_WORK_TREE
when calling git merge-recursive. This works with older versions of
git (up to and including 1.5.4.x, or thereabouts) because
merge-recursive ignores GIT_WORK_TREE. It stopped doing that sometime
just before 1.5.5, which broke StGit. (Given both GIT_WORK_TREE=3D".."
and cwd "..", it assumed the work tree was at "../..", instead of just
".." like we intended. This made t2800 fail.)

Just dropping the cd would solve the problem for new gits, but would
break StGit with older gits. But it works in both cases if we keep the
cd, and unconditionally set GIT_WORK_TREE=3D".". So this patch does
precisely that.

(git read-tree -u -m is also called from IndexAndWorktree, and it
 seems to always ignore GIT_WORK_TREE just like merge-recursive used
 to do. The patch fixes all calls made from IndexAndWorktree, so we're
 good if read-tree starts heeding GIT_WORK_TREE in the future.)

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/git.py |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 35b9bbf..c5b048f 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -298,6 +298,10 @@ class RunWithEnv(object):
     def run(self, args, env =3D {}):
         return run.Run(*args).env(utils.add_dict(self.env, env))
=20
+class RunWithEnvCwd(RunWithEnv):
+    def run(self, args, env =3D {}):
+        return RunWithEnv.run(self, args, env).cwd(self.cwd)
+
 class Repository(RunWithEnv):
     def __init__(self, directory):
         self.__git_dir =3D directory
@@ -490,19 +494,20 @@ class Index(RunWithEnv):
 class Worktree(object):
     def __init__(self, directory):
         self.__directory =3D directory
-    env =3D property(lambda self: { 'GIT_WORK_TREE': self.__directory =
})
+    env =3D property(lambda self: { 'GIT_WORK_TREE': '.' })
     directory =3D property(lambda self: self.__directory)
=20
 class CheckoutException(exception.StgException):
     pass
=20
-class IndexAndWorktree(RunWithEnv):
+class IndexAndWorktree(RunWithEnvCwd):
     def __init__(self, index, worktree):
         self.__index =3D index
         self.__worktree =3D worktree
     index =3D property(lambda self: self.__index)
     env =3D property(lambda self: utils.add_dict(self.__index.env,
                                                self.__worktree.env))
+    cwd =3D property(lambda self: self.__worktree.directory)
     def checkout(self, old_tree, new_tree):
         # TODO: Optionally do a 3-way instead of doing nothing when we
         # have a problem. Or maybe we should stash changes in a patch?
@@ -512,7 +517,7 @@ class IndexAndWorktree(RunWithEnv):
             self.run(['git', 'read-tree', '-u', '-m',
                       '--exclude-per-directory=3D.gitignore',
                       old_tree.sha1, new_tree.sha1]
-                     ).cwd(self.__worktree.directory).discard_output()
+                     ).discard_output()
         except run.RunException:
             raise CheckoutException('Index/workdir dirty')
     def merge(self, base, ours, theirs):
@@ -524,8 +529,7 @@ class IndexAndWorktree(RunWithEnv):
                           theirs.sha1],
                          env =3D { 'GITHEAD_%s' % base.sha1: 'ancestor=
',
                                  'GITHEAD_%s' % ours.sha1: 'current',
-                                 'GITHEAD_%s' % theirs.sha1: 'patched'=
}
-                         ).cwd(self.__worktree.directory)
+                                 'GITHEAD_%s' % theirs.sha1: 'patched'=
})
             r.discard_output()
         except run.RunException, e:
             if r.exitcode =3D=3D 1:
