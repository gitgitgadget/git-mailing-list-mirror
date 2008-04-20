From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 03/10] Library functions for tree and blob manipulation
Date: Mon, 21 Apr 2008 00:10:38 +0200
Message-ID: <20080420221038.5837.75890.stgit@yoghurt>
References: <20080420215625.5837.82896.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:11:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnhl2-0007vt-1q
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 00:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbYDTWKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008 18:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbYDTWKw
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 18:10:52 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3187 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbYDTWKu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 18:10:50 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jnhk4-000820-00; Sun, 20 Apr 2008 23:10:36 +0100
In-Reply-To: <20080420215625.5837.82896.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79991>

Wrap trees and blobs in Python objects (just like commits were already
wrapped), so that StGit code can read and write them.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/git.py |  139 ++++++++++++++++++++++++++++++++++++++++++++++=
--------
 1 files changed, 118 insertions(+), 21 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index f046e12..5bb1c93 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -146,13 +146,100 @@ class Person(Repr):
                 defaults =3D cls.user())
         return cls.__committer
=20
-class Tree(Repr):
+class GitObject(Repr):
+    """Base class for all git objects."""
+
+class Blobdata(Repr):
+    def __init__(self, string):
+        self.__string =3D str(string)
+    str =3D property(lambda self: self.__string)
+    def commit(self, repository):
+        sha1 =3D repository.run(['git', 'hash-object', '-w', '--stdin'=
]
+                              ).raw_input(self.str).output_one_line()
+        return repository.get_blob(sha1)
+
+class Blob(GitObject):
     """Immutable."""
-    def __init__(self, sha1):
+    typename =3D 'blob'
+    default_perm =3D '100644'
+    def __init__(self, repository, sha1):
+        self.__repository =3D repository
         self.__sha1 =3D sha1
     sha1 =3D property(lambda self: self.__sha1)
     def __str__(self):
-        return 'Tree<%s>' % self.sha1
+        return 'Blob<%s>' % self.sha1
+    @property
+    def data(self):
+        return Blobdata(self.__repository.cat_object(self.sha1))
+
+class ImmutableDict(dict):
+    def error(*args, **kwargs):
+        raise TypeError('Cannot modify immutable dict')
+    __delitem__ =3D error
+    __setitem__ =3D error
+    clear =3D error
+    pop =3D error
+    popitem =3D error
+    setdefault =3D error
+    update =3D error
+
+class Treedata(Repr):
+    """Immutable."""
+    @staticmethod
+    def __x(po):
+        if isinstance(po, GitObject):
+            perm, object =3D po.default_perm, po
+        else:
+            perm, object =3D po
+        return perm, object
+    def __init__(self, entries):
+        self.__entries =3D ImmutableDict((name, self.__x(po))
+                                       for (name, po) in entries.iteri=
tems())
+    entries =3D property(lambda self: self.__entries)
+    def set_entry(self, name, po):
+        e =3D dict(self.entries)
+        e[name] =3D self.__x(po)
+        return type(self)(e)
+    def del_entry(self, name):
+        e =3D dict(self.entries)
+        del e[name]
+        return type(self)(e)
+    def commit(self, repository):
+        listing =3D ''.join(
+            '%s %s %s\t%s\0' % (mode, obj.typename, obj.sha1, name)
+            for (name, (mode, obj)) in self.entries.iteritems())
+        sha1 =3D repository.run(['git', 'mktree', '-z']
+                              ).raw_input(listing).output_one_line()
+        return repository.get_tree(sha1)
+    @classmethod
+    def parse(cls, repository, s):
+        entries =3D {}
+        for line in s.split('\0')[:-1]:
+            m =3D re.match(r'^([0-7]{6}) ([a-z]+) ([0-9a-f]{40})\t(.*)=
$', line)
+            assert m
+            perm, type, sha1, name =3D m.groups()
+            entries[name] =3D (perm, repository.get_object(type, sha1)=
)
+        return cls(entries)
+
+class Tree(GitObject):
+    """Immutable."""
+    typename =3D 'tree'
+    default_perm =3D '040000'
+    def __init__(self, repository, sha1):
+        self.__sha1 =3D sha1
+        self.__repository =3D repository
+        self.__data =3D None
+    sha1 =3D property(lambda self: self.__sha1)
+    @property
+    def data(self):
+        if self.__data =3D=3D None:
+            self.__data =3D Treedata.parse(
+                self.__repository,
+                self.__repository.run(['git', 'ls-tree', '-z', self.sh=
a1]
+                                      ).raw_output())
+        return self.__data
+    def __str__(self):
+        return 'Tree<sha1: %s>' % self.sha1
=20
 class Commitdata(Repr):
     """Immutable."""
@@ -202,6 +289,22 @@ class Commitdata(Repr):
         return ('Commitdata<tree: %s, parents: %s, author: %s,'
                 ' committer: %s, message: "%s">'
                 ) % (tree, parents, self.author, self.committer, self.=
message)
+    def commit(self, repository):
+        c =3D ['git', 'commit-tree', self.tree.sha1]
+        for p in self.parents:
+            c.append('-p')
+            c.append(p.sha1)
+        env =3D {}
+        for p, v1 in ((self.author, 'AUTHOR'),
+                       (self.committer, 'COMMITTER')):
+            if p !=3D None:
+                for attr, v2 in (('name', 'NAME'), ('email', 'EMAIL'),
+                                 ('date', 'DATE')):
+                    if getattr(p, attr) !=3D None:
+                        env['GIT_%s_%s' % (v1, v2)] =3D str(getattr(p,=
 attr))
+        sha1 =3D repository.run(c, env =3D env).raw_input(self.message
+                                                      ).output_one_lin=
e()
+        return repository.get_commit(sha1)
     @classmethod
     def parse(cls, repository, s):
         cd =3D cls(parents =3D [])
@@ -223,8 +326,9 @@ class Commitdata(Repr):
                 assert False
         assert False
=20
-class Commit(Repr):
+class Commit(GitObject):
     """Immutable."""
+    typename =3D 'commit'
     def __init__(self, repository, sha1):
         self.__sha1 =3D sha1
         self.__repository =3D repository
@@ -306,7 +410,8 @@ class Repository(RunWithEnv):
     def __init__(self, directory):
         self.__git_dir =3D directory
         self.__refs =3D Refs(self)
-        self.__trees =3D ObjectCache(lambda sha1: Tree(sha1))
+        self.__blobs =3D ObjectCache(lambda sha1: Blob(self, sha1))
+        self.__trees =3D ObjectCache(lambda sha1: Tree(self, sha1))
         self.__commits =3D ObjectCache(lambda sha1: Commit(self, sha1)=
)
         self.__default_index =3D None
         self.__default_worktree =3D None
@@ -357,26 +462,18 @@ class Repository(RunWithEnv):
                     ).output_one_line())
         except run.RunException:
             raise RepositoryException('%s: No such revision' % rev)
+    def get_blob(self, sha1):
+        return self.__blobs[sha1]
     def get_tree(self, sha1):
         return self.__trees[sha1]
     def get_commit(self, sha1):
         return self.__commits[sha1]
-    def commit(self, commitdata):
-        c =3D ['git', 'commit-tree', commitdata.tree.sha1]
-        for p in commitdata.parents:
-            c.append('-p')
-            c.append(p.sha1)
-        env =3D {}
-        for p, v1 in ((commitdata.author, 'AUTHOR'),
-                       (commitdata.committer, 'COMMITTER')):
-            if p !=3D None:
-                for attr, v2 in (('name', 'NAME'), ('email', 'EMAIL'),
-                                 ('date', 'DATE')):
-                    if getattr(p, attr) !=3D None:
-                        env['GIT_%s_%s' % (v1, v2)] =3D str(getattr(p,=
 attr))
-        sha1 =3D self.run(c, env =3D env).raw_input(commitdata.message
-                                                ).output_one_line()
-        return self.get_commit(sha1)
+    def get_object(self, type, sha1):
+        return { Blob.typename: self.get_blob,
+                 Tree.typename: self.get_tree,
+                 Commit.typename: self.get_commit }[type](sha1)
+    def commit(self, objectdata):
+        return objectdata.commit(self)
     @property
     def head(self):
         try:
