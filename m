From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/5] Create index and worktree objects just once
Date: Tue, 29 Jan 2008 04:02:49 +0100
Message-ID: <20080129030233.926.84197.stgit@yoghurt>
References: <20080129030059.926.29897.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:03:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgkx-00042X-Dq
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034AbYA2DC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753992AbYA2DC4
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:02:56 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1916 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbYA2DCz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:02:55 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JJgkK-0000WO-00; Tue, 29 Jan 2008 03:02:48 +0000
In-Reply-To: <20080129030059.926.29897.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71927>

Create the objects for a repository's default index, worktree, and
index+worktree just once. Both for performance (though the gain is
probably negligible), and for future-proofing if we ever add mutable
state to those objects.

And make them properties while we're at it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/coalesce.py |    2 +-
 stgit/commands/commit.py   |    2 +-
 stgit/commands/goto.py     |    2 +-
 stgit/lib/git.py           |   34 ++++++++++++++++++++++++----------
 4 files changed, 27 insertions(+), 13 deletions(-)


diff --git a/stgit/commands/coalesce.py b/stgit/commands/coalesce.py
index d2cba3e..291a537 100644
--- a/stgit/commands/coalesce.py
+++ b/stgit/commands/coalesce.py
@@ -118,5 +118,5 @@ def func(parser, options, args):
                                           + list(stack.patchorder.unap=
plied)))
     if len(patches) < 2:
         raise common.CmdException('Need at least two patches')
-    return _coalesce(stack, stack.repository.default_iw(), options.nam=
e,
+    return _coalesce(stack, stack.repository.default_iw, options.name,
                      options.message, options.save_template, patches)
diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index 1d741b3..bff94ce 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -68,7 +68,7 @@ def func(parser, options, args):
     if not patches:
         raise common.CmdException('No patches to commit')
=20
-    iw =3D stack.repository.default_iw()
+    iw =3D stack.repository.default_iw
     trans =3D transaction.StackTransaction(stack, 'stg commit')
     try:
         common_prefix =3D 0
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 763a8af..fe13e49 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -35,7 +35,7 @@ def func(parser, options, args):
     patch =3D args[0]
=20
     stack =3D directory.repository.current_stack
-    iw =3D stack.repository.default_iw()
+    iw =3D stack.repository.default_iw
     trans =3D transaction.StackTransaction(stack, 'stg goto')
     if patch in trans.applied:
         to_pop =3D set(trans.applied[trans.applied.index(patch)+1:])
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 118c9b2..2af1844 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -211,6 +211,9 @@ class Repository(RunWithEnv):
         self.__refs =3D Refs(self)
         self.__trees =3D ObjectCache(lambda sha1: Tree(sha1))
         self.__commits =3D ObjectCache(lambda sha1: Commit(self, sha1)=
)
+        self.__default_index =3D None
+        self.__default_worktree =3D None
+        self.__default_iw =3D None
     env =3D property(lambda self: { 'GIT_DIR': self.__git_dir })
     @classmethod
     def default(cls):
@@ -220,21 +223,32 @@ class Repository(RunWithEnv):
                                ).output_one_line())
         except run.RunException:
             raise RepositoryException('Cannot find git repository')
+    @property
     def default_index(self):
-        return Index(self, (os.environ.get('GIT_INDEX_FILE', None)
-                            or os.path.join(self.__git_dir, 'index')))
+        if self.__default_index =3D=3D None:
+            self.__default_index =3D Index(
+                self, (os.environ.get('GIT_INDEX_FILE', None)
+                       or os.path.join(self.__git_dir, 'index')))
+        return self.__default_index
     def temp_index(self):
         return Index(self, self.__git_dir)
+    @property
     def default_worktree(self):
-        path =3D os.environ.get('GIT_WORK_TREE', None)
-        if not path:
-            o =3D run.Run('git', 'rev-parse', '--show-cdup').output_li=
nes()
-            o =3D o or ['.']
-            assert len(o) =3D=3D 1
-            path =3D o[0]
-        return Worktree(path)
+        if self.__default_worktree =3D=3D None:
+            path =3D os.environ.get('GIT_WORK_TREE', None)
+            if not path:
+                o =3D run.Run('git', 'rev-parse', '--show-cdup').outpu=
t_lines()
+                o =3D o or ['.']
+                assert len(o) =3D=3D 1
+                path =3D o[0]
+            self.__default_worktree =3D Worktree(path)
+        return self.__default_worktree
+    @property
     def default_iw(self):
-        return IndexAndWorktree(self.default_index(), self.default_wor=
ktree())
+        if self.__default_iw =3D=3D None:
+            self.__default_iw =3D IndexAndWorktree(self.default_index,
+                                                 self.default_worktree=
)
+        return self.__default_iw
     directory =3D property(lambda self: self.__git_dir)
     refs =3D property(lambda self: self.__refs)
     def cat_object(self, sha1):
