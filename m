From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 01/10] New StGit core infrastructure: repository
	operations
Date: Sun, 25 Nov 2007 21:51:00 +0100
Message-ID: <20071125205059.7823.79039.stgit@yoghurt>
References: <20071125203717.7823.70046.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 21:52:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwOSN-0003hQ-Nm
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756595AbXKYUvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756591AbXKYUvQ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:51:16 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4113 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491AbXKYUvN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:51:13 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IwORQ-0007ZB-00; Sun, 25 Nov 2007 20:51:00 +0000
In-Reply-To: <20071125203717.7823.70046.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65997>

This is the first part of the New and Improved StGit core
infrastructure. It has functions for manipulating the git repository
(commits, refs, and so on), but doesn't yet touch the index or
worktree.

Currently not used by anything.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 setup.py                 |    2=20
 stgit/lib/__init__.py    |   18 +++
 stgit/lib/git.py         |  253 ++++++++++++++++++++++++++++++++++++++=
++++++++
 stgit/lib/stack.py       |  120 ++++++++++++++++++++++
 stgit/lib/transaction.py |   79 ++++++++++++++
 stgit/utils.py           |   13 ++
 6 files changed, 484 insertions(+), 1 deletions(-)
 create mode 100644 stgit/lib/__init__.py
 create mode 100644 stgit/lib/git.py
 create mode 100644 stgit/lib/stack.py
 create mode 100644 stgit/lib/transaction.py


diff --git a/setup.py b/setup.py
index cf5b1da..cad8f7e 100755
--- a/setup.py
+++ b/setup.py
@@ -14,7 +14,7 @@ setup(name =3D 'stgit',
       description =3D 'Stacked GIT',
       long_description =3D 'Push/pop utility on top of GIT',
       scripts =3D ['stg'],
-      packages =3D ['stgit', 'stgit.commands'],
+      packages =3D ['stgit', 'stgit.commands', 'stgit.lib'],
       data_files =3D [('share/stgit/templates', glob.glob('templates/*=
=2Etmpl')),
                     ('share/stgit/examples', glob.glob('examples/*.tmp=
l')),
                     ('share/stgit/examples', ['examples/gitconfig']),
diff --git a/stgit/__init__.py b/stgit/lib/__init__.py
similarity index 88%
copy from stgit/__init__.py
copy to stgit/lib/__init__.py
index 4b03e3a..45eb307 100644
--- a/stgit/__init__.py
+++ b/stgit/lib/__init__.py
@@ -1,5 +1,7 @@
+# -*- coding: utf-8 -*-
+
 __copyright__ =3D """
-Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
+Copyright (C) 2007, Karl Hasselstr=C3=B6m <kha@treskal.com>
=20
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2 as
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
new file mode 100644
index 0000000..120ea35
--- /dev/null
+++ b/stgit/lib/git.py
@@ -0,0 +1,253 @@
+import os, os.path, re
+from stgit import exception, run, utils
+
+class RepositoryException(exception.StgException):
+    pass
+
+class DetachedHeadException(RepositoryException):
+    def __init__(self):
+        RepositoryException.__init__(self, 'Not on any branch')
+
+class Repr(object):
+    def __repr__(self):
+        return str(self)
+
+class NoValue(object):
+    pass
+
+def make_defaults(defaults):
+    def d(val, attr):
+        if val !=3D NoValue:
+            return val
+        elif defaults !=3D NoValue:
+            return getattr(defaults, attr)
+        else:
+            return None
+    return d
+
+class Person(Repr):
+    """Immutable."""
+    def __init__(self, name =3D NoValue, email =3D NoValue,
+                 date =3D NoValue, defaults =3D NoValue):
+        d =3D make_defaults(defaults)
+        self.__name =3D d(name, 'name')
+        self.__email =3D d(email, 'email')
+        self.__date =3D d(date, 'date')
+    name =3D property(lambda self: self.__name)
+    email =3D property(lambda self: self.__email)
+    date =3D property(lambda self: self.__date)
+    def set_name(self, name):
+        return type(self)(name =3D name, defaults =3D self)
+    def set_email(self, email):
+        return type(self)(email =3D email, defaults =3D self)
+    def set_date(self, date):
+        return type(self)(date =3D date, defaults =3D self)
+    def __str__(self):
+        return '%s <%s> %s' % (self.name, self.email, self.date)
+    @classmethod
+    def parse(cls, s):
+        m =3D re.match(r'^([^<]*)<([^>]*)>\s+(\d+\s+[+-]\d{4})$', s)
+        assert m
+        name =3D m.group(1).strip()
+        email =3D m.group(2)
+        date =3D m.group(3)
+        return cls(name, email, date)
+
+class Tree(Repr):
+    """Immutable."""
+    def __init__(self, sha1):
+        self.__sha1 =3D sha1
+    sha1 =3D property(lambda self: self.__sha1)
+    def __str__(self):
+        return 'Tree<%s>' % self.sha1
+
+class Commitdata(Repr):
+    """Immutable."""
+    def __init__(self, tree =3D NoValue, parents =3D NoValue, author =3D=
 NoValue,
+                 committer =3D NoValue, message =3D NoValue, defaults =
=3D NoValue):
+        d =3D make_defaults(defaults)
+        self.__tree =3D d(tree, 'tree')
+        self.__parents =3D d(parents, 'parents')
+        self.__author =3D d(author, 'author')
+        self.__committer =3D d(committer, 'committer')
+        self.__message =3D d(message, 'message')
+    tree =3D property(lambda self: self.__tree)
+    parents =3D property(lambda self: self.__parents)
+    @property
+    def parent(self):
+        assert len(self.__parents) =3D=3D 1
+        return self.__parents[0]
+    author =3D property(lambda self: self.__author)
+    committer =3D property(lambda self: self.__committer)
+    message =3D property(lambda self: self.__message)
+    def set_tree(self, tree):
+        return type(self)(tree =3D tree, defaults =3D self)
+    def set_parents(self, parents):
+        return type(self)(parents =3D parents, defaults =3D self)
+    def add_parent(self, parent):
+        return type(self)(parents =3D list(self.parents or []) + [pare=
nt],
+                          defaults =3D self)
+    def set_parent(self, parent):
+        return self.set_parents([parent])
+    def set_author(self, author):
+        return type(self)(author =3D author, defaults =3D self)
+    def set_committer(self, committer):
+        return type(self)(committer =3D committer, defaults =3D self)
+    def set_message(self, message):
+        return type(self)(message =3D message, defaults =3D self)
+    def __str__(self):
+        if self.tree =3D=3D None:
+            tree =3D None
+        else:
+            tree =3D self.tree.sha1
+        if self.parents =3D=3D None:
+            parents =3D None
+        else:
+            parents =3D [p.sha1 for p in self.parents]
+        return ('Commitdata<tree: %s, parents: %s, author: %s,'
+                ' committer: %s, message: "%s">'
+                ) % (tree, parents, self.author, self.committer, self.=
message)
+    @classmethod
+    def parse(cls, repository, s):
+        cd =3D cls()
+        lines =3D list(s.splitlines(True))
+        for i in xrange(len(lines)):
+            line =3D lines[i].strip()
+            if not line:
+                return cd.set_message(''.join(lines[i+1:]))
+            key, value =3D line.split(None, 1)
+            if key =3D=3D 'tree':
+                cd =3D cd.set_tree(repository.get_tree(value))
+            elif key =3D=3D 'parent':
+                cd =3D cd.add_parent(repository.get_commit(value))
+            elif key =3D=3D 'author':
+                cd =3D cd.set_author(Person.parse(value))
+            elif key =3D=3D 'committer':
+                cd =3D cd.set_committer(Person.parse(value))
+            else:
+                assert False
+        assert False
+
+class Commit(Repr):
+    """Immutable."""
+    def __init__(self, repository, sha1):
+        self.__sha1 =3D sha1
+        self.__repository =3D repository
+        self.__data =3D None
+    sha1 =3D property(lambda self: self.__sha1)
+    @property
+    def data(self):
+        if self.__data =3D=3D None:
+            self.__data =3D Commitdata.parse(
+                self.__repository,
+                self.__repository.cat_object(self.sha1))
+        return self.__data
+    def __str__(self):
+        return 'Commit<sha1: %s, data: %s>' % (self.sha1, self.__data)
+
+class Refs(object):
+    def __init__(self, repository):
+        self.__repository =3D repository
+        self.__refs =3D None
+    def __cache_refs(self):
+        self.__refs =3D {}
+        for line in self.__repository.run(['git', 'show-ref']).output_=
lines():
+            m =3D re.match(r'^([0-9a-f]{40})\s+(\S+)$', line)
+            sha1, ref =3D m.groups()
+            self.__refs[ref] =3D sha1
+    def get(self, ref):
+        """Throws KeyError if ref doesn't exist."""
+        if self.__refs =3D=3D None:
+            self.__cache_refs()
+        return self.__repository.get_commit(self.__refs[ref])
+    def set(self, ref, commit, msg):
+        if self.__refs =3D=3D None:
+            self.__cache_refs()
+        old_sha1 =3D self.__refs.get(ref, '0'*40)
+        new_sha1 =3D commit.sha1
+        if old_sha1 !=3D new_sha1:
+            self.__repository.run(['git', 'update-ref', '-m', msg,
+                                   ref, new_sha1, old_sha1]).no_output=
()
+            self.__refs[ref] =3D new_sha1
+    def delete(self, ref):
+        if self.__refs =3D=3D None:
+            self.__cache_refs()
+        self.__repository.run(['git', 'update-ref',
+                               '-d', ref, self.__refs[ref]]).no_output=
()
+        del self.__refs[ref]
+
+class ObjectCache(object):
+    """Cache for Python objects, for making sure that we create only o=
ne
+    Python object per git object."""
+    def __init__(self, create):
+        self.__objects =3D {}
+        self.__create =3D create
+    def __getitem__(self, name):
+        if not name in self.__objects:
+            self.__objects[name] =3D self.__create(name)
+        return self.__objects[name]
+    def __contains__(self, name):
+        return name in self.__objects
+    def __setitem__(self, name, val):
+        assert not name in self.__objects
+        self.__objects[name] =3D val
+
+class RunWithEnv(object):
+    def run(self, args, env =3D {}):
+        return run.Run(*args).env(utils.add_dict(self.env, env))
+
+class Repository(RunWithEnv):
+    def __init__(self, directory):
+        self.__git_dir =3D directory
+        self.__refs =3D Refs(self)
+        self.__trees =3D ObjectCache(lambda sha1: Tree(sha1))
+        self.__commits =3D ObjectCache(lambda sha1: Commit(self, sha1)=
)
+    env =3D property(lambda self: { 'GIT_DIR': self.__git_dir })
+    @classmethod
+    def default(cls):
+        """Return the default repository."""
+        try:
+            return cls(run.Run('git', 'rev-parse', '--git-dir'
+                               ).output_one_line())
+        except run.RunException:
+            raise RepositoryException('Cannot find git repository')
+    directory =3D property(lambda self: self.__git_dir)
+    refs =3D property(lambda self: self.__refs)
+    def cat_object(self, sha1):
+        return self.run(['git', 'cat-file', '-p', sha1]).raw_output()
+    def rev_parse(self, rev):
+        try:
+            return self.get_commit(self.run(
+                    ['git', 'rev-parse', '%s^{commit}' % rev]
+                    ).output_one_line())
+        except run.RunException:
+            raise RepositoryException('%s: No such revision' % rev)
+    def get_tree(self, sha1):
+        return self.__trees[sha1]
+    def get_commit(self, sha1):
+        return self.__commits[sha1]
+    def commit(self, commitdata):
+        c =3D ['git', 'commit-tree', commitdata.tree.sha1]
+        for p in commitdata.parents:
+            c.append('-p')
+            c.append(p.sha1)
+        env =3D {}
+        for p, v1 in ((commitdata.author, 'AUTHOR'),
+                       (commitdata.committer, 'COMMITTER')):
+            if p !=3D None:
+                for attr, v2 in (('name', 'NAME'), ('email', 'EMAIL'),
+                                 ('date', 'DATE')):
+                    if getattr(p, attr) !=3D None:
+                        env['GIT_%s_%s' % (v1, v2)] =3D getattr(p, att=
r)
+        sha1 =3D self.run(c, env =3D env).raw_input(commitdata.message
+                                                ).output_one_line()
+        return self.get_commit(sha1)
+    @property
+    def head(self):
+        try:
+            return self.run(['git', 'symbolic-ref', '-q', 'HEAD']
+                            ).output_one_line()
+        except run.RunException:
+            raise DetachedHeadException()
+    def set_head(self, ref, msg):
+        self.run(['git', 'symbolic-ref', '-m', msg, 'HEAD', ref]).no_o=
utput()
diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
new file mode 100644
index 0000000..d5bd488
--- /dev/null
+++ b/stgit/lib/stack.py
@@ -0,0 +1,120 @@
+import os.path
+from stgit import exception, utils
+from stgit.lib import git
+
+class Patch(object):
+    def __init__(self, stack, name):
+        self.__stack =3D stack
+        self.__name =3D name
+    name =3D property(lambda self: self.__name)
+    def __ref(self):
+        return 'refs/patches/%s/%s' % (self.__stack.name, self.__name)
+    @property
+    def commit(self):
+        return self.__stack.repository.refs.get(self.__ref())
+    def set_commit(self, commit, msg):
+        self.__stack.repository.refs.set(self.__ref(), commit, msg)
+    def delete(self):
+        self.__stack.repository.refs.delete(self.__ref())
+    def is_applied(self):
+        return self.name in self.__stack.patchorder.applied
+    def is_empty(self):
+        c =3D self.commit
+        return c.data.tree =3D=3D c.data.parent.data.tree
+
+class PatchOrder(object):
+    """Keeps track of patch order, and which patches are applied.
+    Works with patch names, not actual patches."""
+    __list_order =3D [ 'applied', 'unapplied' ]
+    def __init__(self, stack):
+        self.__stack =3D stack
+        self.__lists =3D {}
+    def __read_file(self, fn):
+        return tuple(utils.read_strings(
+            os.path.join(self.__stack.directory, fn)))
+    def __write_file(self, fn, val):
+        utils.write_strings(os.path.join(self.__stack.directory, fn), =
val)
+    def __get_list(self, name):
+        if not name in self.__lists:
+            self.__lists[name] =3D self.__read_file(name)
+        return self.__lists[name]
+    def __set_list(self, name, val):
+        val =3D tuple(val)
+        if val !=3D self.__lists.get(name, None):
+            self.__lists[name] =3D val
+            self.__write_file(name, val)
+    applied =3D property(lambda self: self.__get_list('applied'),
+                       lambda self, val: self.__set_list('applied', va=
l))
+    unapplied =3D property(lambda self: self.__get_list('unapplied'),
+                         lambda self, val: self.__set_list('unapplied'=
, val))
+
+class Patches(object):
+    """Creates Patch objects."""
+    def __init__(self, stack):
+        self.__stack =3D stack
+        def create_patch(name):
+            p =3D Patch(self.__stack, name)
+            p.commit # raise exception if the patch doesn't exist
+            return p
+        self.__patches =3D git.ObjectCache(create_patch) # name -> Pat=
ch
+    def exists(self, name):
+        try:
+            self.get(name)
+            return True
+        except KeyError:
+            return False
+    def get(self, name):
+        return self.__patches[name]
+    def new(self, name, commit, msg):
+        assert not name in self.__patches
+        p =3D Patch(self.__stack, name)
+        p.set_commit(commit, msg)
+        self.__patches[name] =3D p
+        return p
+
+class Stack(object):
+    def __init__(self, repository, name):
+        self.__repository =3D repository
+        self.__name =3D name
+        try:
+            self.head
+        except KeyError:
+            raise exception.StgException('%s: no such branch' % name)
+        self.__patchorder =3D PatchOrder(self)
+        self.__patches =3D Patches(self)
+    name =3D property(lambda self: self.__name)
+    repository =3D property(lambda self: self.__repository)
+    patchorder =3D property(lambda self: self.__patchorder)
+    patches =3D property(lambda self: self.__patches)
+    @property
+    def directory(self):
+        return os.path.join(self.__repository.directory, 'patches', se=
lf.__name)
+    def __ref(self):
+        return 'refs/heads/%s' % self.__name
+    @property
+    def head(self):
+        return self.__repository.refs.get(self.__ref())
+    def set_head(self, commit, msg):
+        self.__repository.refs.set(self.__ref(), commit, msg)
+    @property
+    def base(self):
+        if self.patchorder.applied:
+            return self.patches.get(self.patchorder.applied[0]
+                                    ).commit.data.parent
+        else:
+            return self.head
+
+class Repository(git.Repository):
+    def __init__(self, *args, **kwargs):
+        git.Repository.__init__(self, *args, **kwargs)
+        self.__stacks =3D {} # name -> Stack
+    @property
+    def current_branch(self):
+        return utils.strip_leading('refs/heads/', self.head)
+    @property
+    def current_stack(self):
+        return self.get_stack(self.current_branch)
+    def get_stack(self, name):
+        if not name in self.__stacks:
+            self.__stacks[name] =3D Stack(self, name)
+        return self.__stacks[name]
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
new file mode 100644
index 0000000..991e64e
--- /dev/null
+++ b/stgit/lib/transaction.py
@@ -0,0 +1,79 @@
+from stgit import exception
+from stgit.out import *
+
+class TransactionException(exception.StgException):
+    pass
+
+def print_current_patch(old_applied, new_applied):
+    def now_at(pn):
+        out.info('Now at patch "%s"' % pn)
+    if not old_applied and not new_applied:
+        pass
+    elif not old_applied:
+        now_at(new_applied[-1])
+    elif not new_applied:
+        out.info('No patch applied')
+    elif old_applied[-1] =3D=3D new_applied[-1]:
+        pass
+    else:
+        now_at(new_applied[-1])
+
+class StackTransaction(object):
+    def __init__(self, stack, msg):
+        self.__stack =3D stack
+        self.__msg =3D msg
+        self.__patches =3D {}
+        self.__applied =3D list(self.__stack.patchorder.applied)
+        self.__unapplied =3D list(self.__stack.patchorder.unapplied)
+    def __set_patches(self, val):
+        self.__patches =3D dict(val)
+    patches =3D property(lambda self: self.__patches, __set_patches)
+    def __set_applied(self, val):
+        self.__applied =3D list(val)
+    applied =3D property(lambda self: self.__applied, __set_applied)
+    def __set_unapplied(self, val):
+        self.__unapplied =3D list(val)
+    unapplied =3D property(lambda self: self.__unapplied, __set_unappl=
ied)
+    def __check_consistency(self):
+        remaining =3D set(self.__applied + self.__unapplied)
+        for pn, commit in self.__patches.iteritems():
+            if commit =3D=3D None:
+                assert self.__stack.patches.exists(pn)
+            else:
+                assert pn in remaining
+    def run(self):
+        self.__check_consistency()
+
+        # Get new head commit.
+        if self.__applied:
+            top_patch =3D self.__applied[-1]
+            try:
+                new_head =3D self.__patches[top_patch]
+            except KeyError:
+                new_head =3D self.__stack.patches.get(top_patch).commi=
t
+        else:
+            new_head =3D self.__stack.base
+
+        # Set branch head.
+        if new_head =3D=3D self.__stack.head:
+            pass # same commit: OK
+        elif new_head.data.tree =3D=3D self.__stack.head.data.tree:
+            pass # same tree: OK
+        else:
+            # We can't handle this case yet.
+            raise TransactionException('Error: HEAD tree changed')
+        self.__stack.set_head(new_head, self.__msg)
+
+        # Write patches.
+        for pn, commit in self.__patches.iteritems():
+            if self.__stack.patches.exists(pn):
+                p =3D self.__stack.patches.get(pn)
+                if commit =3D=3D None:
+                    p.delete()
+                else:
+                    p.set_commit(commit, self.__msg)
+            else:
+                self.__stack.patches.new(pn, commit, self.__msg)
+        print_current_patch(self.__stack.patchorder.applied, self.__ap=
plied)
+        self.__stack.patchorder.applied =3D self.__applied
+        self.__stack.patchorder.unapplied =3D self.__unapplied
diff --git a/stgit/utils.py b/stgit/utils.py
index 3a480c0..b3f6232 100644
--- a/stgit/utils.py
+++ b/stgit/utils.py
@@ -256,3 +256,16 @@ def add_sign_line(desc, sign_str, name, email):
     if not any(s in desc for s in ['\nSigned-off-by:', '\nAcked-by:'])=
:
         desc =3D desc + '\n'
     return '%s\n%s\n' % (desc, sign_str)
+
+def strip_leading(prefix, s):
+    """Strip leading prefix from a string. Blow up if the prefix isn't
+    there."""
+    assert s.startswith(prefix)
+    return s[len(prefix):]
+
+def add_dict(d1, d2):
+    """Return a new dict with the contents of both d1 and d2. In case =
of
+    conflicting mappings, d2 takes precedence."""
+    d =3D dict(d1)
+    d.update(d2)
+    return d
