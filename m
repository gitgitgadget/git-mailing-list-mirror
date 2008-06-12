From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 02/14] Library functions for tree and blob manipulation
Date: Thu, 12 Jun 2008 07:34:18 +0200
Message-ID: <20080612053418.23549.1299.stgit@yoghurt>
References: <20080612052913.23549.69687.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 07:35:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6fTQ-0004xa-Vx
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 07:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbYFLFez convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 01:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbYFLFey
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 01:34:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2168 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbYFLFew (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 01:34:52 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K6fRy-00013g-00; Thu, 12 Jun 2008 06:34:19 +0100
In-Reply-To: <20080612052913.23549.69687.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84706>

Wrap trees and blobs in Python objects (just like commits were already
wrapped), so that StGit code can read and write them.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/git.py |  188 ++++++++++++++++++++++++++++++++++++++++++++++=
+-------
 1 files changed, 165 insertions(+), 23 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 6ccdfa7..a8881f4 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -182,16 +182,142 @@ class Person(Immutable, Repr):
                 defaults =3D cls.user())
         return cls.__committer
=20
-class Tree(Immutable, Repr):
-    """Represents a git tree object."""
-    def __init__(self, sha1):
+class GitObject(Immutable, Repr):
+    """Base class for all git objects. One git object is represented b=
y at
+    most one C{GitObject}, which makes it possible to compare them
+    using normal Python object comparison; it also ensures we don't
+    waste more memory than necessary."""
+
+class BlobData(Immutable, Repr):
+    """Represents the data contents of a git blob object."""
+    def __init__(self, string):
+        self.__string =3D str(string)
+    str =3D property(lambda self: self.__string)
+    def commit(self, repository):
+        """Commit the blob.
+        @return: The committed blob
+        @rtype: L{Blob}"""
+        sha1 =3D repository.run(['git', 'hash-object', '-w', '--stdin'=
]
+                              ).raw_input(self.str).output_one_line()
+        return repository.get_blob(sha1)
+
+class Blob(GitObject):
+    """Represents a git blob object. All the actual data contents of t=
he
+    blob object is stored in the L{data} member, which is a
+    L{BlobData} object."""
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
+        return BlobData(self.__repository.cat_object(self.sha1))
+
+class ImmutableDict(dict):
+    """A dictionary that cannot be modified once it's been created."""
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
+class TreeData(Immutable, Repr):
+    """Represents the data contents of a git tree object."""
+    @staticmethod
+    def __x(po):
+        if isinstance(po, GitObject):
+            perm, object =3D po.default_perm, po
+        else:
+            perm, object =3D po
+        return perm, object
+    def __init__(self, entries):
+        """Create a new L{TreeData} object from the given mapping from=
 names
+        (strings) to either (I{permission}, I{object}) tuples or just
+        objects."""
+        self.__entries =3D ImmutableDict((name, self.__x(po))
+                                       for (name, po) in entries.iteri=
tems())
+    entries =3D property(lambda self: self.__entries)
+    """Map from name to (I{permission}, I{object}) tuple."""
+    def set_entry(self, name, po):
+        """Create a new L{TreeData} object identical to this one, exce=
pt that
+        it maps C{name} to C{po}.
+
+        @param name: Name of the changed mapping
+        @type name: C{str}
+        @param po: Value of the changed mapping
+        @type po: L{Blob} or L{Tree} or (C{str}, L{Blob} or L{Tree})
+        @return: The new L{TreeData} object
+        @rtype: L{TreeData}"""
+        e =3D dict(self.entries)
+        e[name] =3D self.__x(po)
+        return type(self)(e)
+    def del_entry(self, name):
+        """Create a new L{TreeData} object identical to this one, exce=
pt that
+        it doesn't map C{name} to anything.
+
+        @param name: Name of the deleted mapping
+        @type name: C{str}
+        @return: The new L{TreeData} object
+        @rtype: L{TreeData}"""
+        e =3D dict(self.entries)
+        del e[name]
+        return type(self)(e)
+    def commit(self, repository):
+        """Commit the tree.
+        @return: The committed tree
+        @rtype: L{Tree}"""
+        listing =3D ''.join(
+            '%s %s %s\t%s\0' % (mode, obj.typename, obj.sha1, name)
+            for (name, (mode, obj)) in self.entries.iteritems())
+        sha1 =3D repository.run(['git', 'mktree', '-z']
+                              ).raw_input(listing).output_one_line()
+        return repository.get_tree(sha1)
+    @classmethod
+    def parse(cls, repository, s):
+        """Parse a raw git tree description.
+
+        @return: A new L{TreeData} object
+        @rtype: L{TreeData}"""
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
+    """Represents a git tree object. All the actual data contents of t=
he
+    tree object is stored in the L{data} member, which is a
+    L{TreeData} object."""
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
+            self.__data =3D TreeData.parse(
+                self.__repository,
+                self.__repository.run(['git', 'ls-tree', '-z', self.sh=
a1]
+                                      ).raw_output())
+        return self.__data
+    def __str__(self):
+        return 'Tree<sha1: %s>' % self.sha1
=20
 class CommitData(Immutable, Repr):
-    """Represents the actual data contents of a git commit object."""
+    """Represents the data contents of a git commit object."""
     def __init__(self, tree =3D NoValue, parents =3D NoValue, author =3D=
 NoValue,
                  committer =3D NoValue, message =3D NoValue, defaults =
=3D NoValue):
         d =3D make_defaults(defaults)
@@ -238,8 +364,30 @@ class CommitData(Immutable, Repr):
         return ('CommitData<tree: %s, parents: %s, author: %s,'
                 ' committer: %s, message: "%s">'
                 ) % (tree, parents, self.author, self.committer, self.=
message)
+    def commit(self, repository):
+        """Commit the commit.
+        @return: The committed commit
+        @rtype: L{Commit}"""
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
+        """Parse a raw git commit description.
+        @return: A new L{CommitData} object
+        @rtype: L{CommitData}"""
         cd =3D cls(parents =3D [])
         lines =3D list(s.splitlines(True))
         for i in xrange(len(lines)):
@@ -259,10 +407,11 @@ class CommitData(Immutable, Repr):
                 assert False
         assert False
=20
-class Commit(Immutable, Repr):
+class Commit(GitObject):
     """Represents a git commit object. All the actual data contents of=
 the
     commit object is stored in the L{data} member, which is a
     L{CommitData} object."""
+    typename =3D 'commit'
     def __init__(self, repository, sha1):
         self.__sha1 =3D sha1
         self.__repository =3D repository
@@ -367,7 +516,8 @@ class Repository(RunWithEnv):
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
@@ -429,26 +579,18 @@ class Repository(RunWithEnv):
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
     def head_ref(self):
         try:
