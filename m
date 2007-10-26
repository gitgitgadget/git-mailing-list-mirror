From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: [StGit RFC] A more structured way of calling git
Date: Fri, 26 Oct 2007 21:24:18 +0200
Message-ID: <20071026192418.GA19774@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	Git Mailing List <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 21:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlUnj-0008AO-47
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 21:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbXJZTYh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Oct 2007 15:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXJZTYh
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 15:24:37 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1948 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbXJZTYe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 15:24:34 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IlUn4-00059z-00; Fri, 26 Oct 2007 20:24:18 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62437>

I wanted to build an StGit command that coalesced adjacent patches to
a single patch. Because the end result tree would still be the same,
this should be doable without ever involving HEAD, the index, or the
worktree. StGit's existing infrastructure for manipulating patches
didn't lend itself to doing this kind of thing, though: it's not
modular enough. So I started to design a replacement low-level
interface to git, and things got slightly out of hand ... and I ended
up with a much bigger refactoring than I'd planned.

It's all outlined below, and all the code I currently have is
attached. Unless there's opposition, my plan is to convert one command
at a time to use the new infrastructure -- this can be done since the
on-disk format is unaffected.

Comments?


Python wrapping of git objects (gitlib.py)
----------------------------------------------------------------------

To make it easier to work with git objects, I've built a more
high-level interface than just calling git commands directly. Some of
it is trivial:

  * Blobs and tags aren't covered (yet), since StGit never uses them.
    I think. If they are needed in the future, they can easily be
    wrapped.

  * Trees are represented by the Python class Tree. They are
    immutable, and have only one property: the sha1 of the tree. More
    could be added if we need to look inside trees.

The interesting case is for commit objects:

  * Commits are represented by the Python class Commit. They are
    immutable, and have two properties: sha1 and commit data.

  * Commit data is represented by the Python class CommitData. These
    objects are also immutable, and have properties for author,
    committer, commit message, tree, and list of parent commits. They
    also have setter functions for these properties, which (since
    CommitData objects are immutable) return a modified copy of the
    original object.

  * Author and committer are represented by a Person class, also
    immutable with setter functions.

The user may create new CommitData objects, but never creates Tree or
Commit objects herself. Instead, she asks her Repository object to
create them for her:

  * Repository.get_tree and Repository.get_commit take sha1
    parameters, and returns the corresponding objects. They must
    already exist.

  * Repository.commit takes a CommitData parameter, and returns a
    corresponding Commit object representing the new commit.
    Internally, it runs git-commit-tree.

This has the nice property that Tree and Commit objects always
represent objects that git knows about. It also makes it trivial to
create new commits that have arbitrary existing commits as parents and
an existing tree. For example, my coalesce-adjacent-patches command
could be built on top of this.

The Repository object also has methods for reading and writing (and
caching) refs, but it lacks any method for creating new trees. This is
the job of the Index object. It has read_tree and write_tree methods
for getting Trees in to and out of the current index state. It also
has a merge method that does a 3-way merge between arbitrary Trees,
without ever touching the worktree (if the merge cannot be resolved
automatically, it simply fails).

The user is free to create as many Repository and Index objects as she
wants; their constructors take a git repository path and an index file
path as argumentes, respectively. This means that it's very easy to
work with a temporary index, which is neat in combination with the
Index.merge method: it lets you merge three trees to create a fourth
without ever touching the worktree or the default index.

=46or operations that involve a worktree as well, we have the
IndexAndWorktree class. It has methods for e.g. checkout and
update-index; this is also where a full, possibly conflicting merge
will go when I get around to implementing it.


Low-level StGit on top of the git wrappers (stacklib.py)
----------------------------------------------------------------------

That was all about git. We need an StGit layer on top of it.

There's a Stack object that represents a branch. It has two important
properties:

  * A PatchOrder object. This keeps track of the list of applied and
    unapplied patches, by name.

  * A store of Patch objects. This can look up Patch objects by name,
    and create new patches.

Patch objects represent patches, and are very simple. Basically the
only thing you can do with them is get their commit object, set their
commit object, and delete them. Author, commit message, top and
bottom, and all those things aren't a property of the patch; they are
properties of its commit.

(In the future, Patch objects should write stuff to the patch log.
They could also during a gradual transition to this new infrastructure
write out the per-patch metadata files that StGit currently uses.)

Importantly, unlike the current StGit stack class, there are no
high-level stack operations =E0 la push and pop here. This is all
low-level manipulation of patch refs and the applied/unapplied files.
But in combination with the stuff in gitlib.py, lots of higher-level
StGit operations can be built on top of this.


Transactions (translib.py)
----------------------------------------------------------------------

I started to implement a few StGit commands on top of gitlib.py and
stacklib.py, and then realized something very appealing:

  Just about every StGit command can be accomplished by first creating
  a bunch of new commit objects with gitlib.py, then trying to check
  out the new HEAD, and then rewriting refs with stacklib.py. Only the
  first and second steps can possibly fail, and if they do, they do so
  without leaving any user-visible junk behind. This can be used to
  make all commands either succeed completely, or do nothing at all.

As an example (which I've not yet implemented), consider how push
would work:

  1. Create the new commit objects that the patches to be pushed will
     use. For each patch:

       a. Check if it's a fast forward. If so, just reuse the old
          commit object.

       b. Try the in-index merge with a temp index. If it succeeds,
          create a new commit object with that tree.

       c. Otherwise, stop trying to push any more patches.

  2. Check out the new HEAD tree. This may fail if the worktree and/or
     index contain conflicting changes. If so, we just abort the whole
     operation and tell the user which files she needs to clean up.

       a. If we had a patch that we couldn't push in (1.c), and then
          do a full 3-way merge with its original tree. This may fail
          if the worktree and/or index is dirty; if so, we don't try
          to push that patch.

       b. If the merge succeeds but with conflicts, create a new
          commit for it with the same tree as its parent (i.e. an
          empty commit) and leave the conflicts for the user to
          resolve.

       c. Otherwise, the merge autoresolved. Go back to (1) and try to
          push the remaining patches too. But remember that if we
          later need to abort the push due to dirty worktree/index, we
          have already pushed a few of the patches.

  3. Use stacklib.py to rewrite the branch ref and the patch refs.

This will end up pushing some subset of the requested patches. The
only way we'll ever get a result that isn't all-or-nothing is if a
merge conflicts. Note also how (except for the irritating (2.c)) we
never touch the index and worktree until we're already done, which
should make things both robust and fast.

(Step (2.c) is irritating, in that we actually have to check out a new
tree in order to use merge-recursive, and merge-recursive might
autoresolve a merge that the in-index merge failed to resolve, so that
we have checked out an intermediate tree even though there didn't end
up being any conflict for the user to resolve.)

The code in translib.py is a simple class that can hold a record of
everything that needs to be done in step (3), and then does it when
and if we get there.

The killer feature of transactions (apart from their use as a utility
when writing commands) is that we could build transaction logging.
Since every StGit command performs exatly one transaction, if we
simply logged the before and after values of the patch refs, branch
ref, and patch appliedness, we could build a generic StGit undo/redo
command.


Example commands (utillib.py)
----------------------------------------------------------------------

This file has sample implementations of some StGit commands: clean,
pop, push, and refresh. They don't have any bells and whistles, and
the push is fundamentally limited in that it doesn't handle conflicts
-- it'll complain and do nothing.

These were mostly done to excercise the new infrastructure and make
sure that I hadn't forgotten anything. The plan is not to replace the
existing commands, just make them use the new infrastructure.




diff --git a/stgit/gitlib.py b/stgit/gitlib.py
new file mode 100644
index 0000000..46911d5
--- /dev/null
+++ b/stgit/gitlib.py
@@ -0,0 +1,360 @@
+import os, os.path, re
+from exception import *
+import run
+
+class DetachedHeadException(StgException):
+    pass
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
+        for line in self.__repository.run(['git-show-ref']).output_lin=
es():
+            m =3D re.match(r'^([0-9a-f]{40})\s+(\S+)$', line)
+            sha1, ref =3D m.groups()
+            self.__refs[ref] =3D sha1
+    def get(self, ref):
+        if self.__refs =3D=3D None:
+            self.__cache_refs()
+        return self.__repository.get_commit(self.__refs[ref])
+    def set(self, ref, commit, msg):
+        if self.__refs =3D=3D None:
+            self.__cache_refs()
+        old_sha1 =3D self.__refs.get(ref, '0'*40)
+        new_sha1 =3D commit.sha1
+        if old_sha1 !=3D new_sha1:
+            self.__repository.run(['git-update-ref', '-m', msg,
+                                   ref, new_sha1, old_sha1]).no_output=
()
+            self.__refs[ref] =3D new_sha1
+    def delete(self, ref):
+        if self.__refs =3D=3D None:
+            self.__cache_refs()
+        self.__repository.run(['git-update-ref',
+                               '-d', ref, self.__refs[ref]]).no_output=
()
+        del self.__refs[ref]
+
+class ObjectCache(object):
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
+def add_dict(d1, d2):
+    d =3D dict(d1)
+    d.update(d2)
+    return d
+
+class RunWithEnv(object):
+    def run(self, args, env =3D {}):
+        return run.Run(*args).env(add_dict(self.env, env))
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
+        return cls(run.Run('git-rev-parse', '--git-dir').output_one_li=
ne())
+    def default_index(self):
+        return Index(self, (os.environ.get('GIT_INDEX_FILE', None)
+                            or os.path.join(self.__git_dir, 'index')))
+    def temp_index(self):
+        return Index(self, self.__git_dir)
+    def default_worktree(self):
+        path =3D os.environ.get('GIT_WORK_TREE', None)
+        if not path:
+            o =3D run.Run('git-rev-parse', '--show-cdup').output_lines=
()
+            o =3D o or ['.']
+            assert len(o) =3D=3D 1
+            path =3D o[0]
+        return Worktree(path)
+    def default_iw(self):
+        return IndexAndWorktree(self.default_index(), self.default_wor=
ktree())
+    directory =3D property(lambda self: self.__git_dir)
+    refs =3D property(lambda self: self.__refs)
+    def cat_object(self, sha1):
+        return self.run(['git-cat-file', '-p', sha1]).raw_output()
+    def get_tree(self, sha1):
+        return self.__trees[sha1]
+    def get_commit(self, sha1):
+        return self.__commits[sha1]
+    def commit(self, commitdata):
+        c =3D ['git-commit-tree', commitdata.tree.sha1]
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
+            return self.run(['git-symbolic-ref', '-q', 'HEAD']
+                            ).output_one_line()
+        except run.RunException:
+            raise DetachedHeadException()
+    def set_head(self, ref, msg):
+        self.run(['git-symbolic-ref', '-m', msg, 'HEAD', ref]).no_outp=
ut()
+    @property
+    def head_commit(self):
+        return self.get_commit(self.run(['git-rev-parse', 'HEAD']
+                                        ).output_one_line())
+
+class MergeException(StgException):
+    pass
+
+class Index(RunWithEnv):
+    def __init__(self, repository, filename):
+        self.__repository =3D repository
+        if os.path.isdir(filename):
+            # Create a temp index in the given directory.
+            self.__filename =3D os.path.join(
+                filename, 'index.temp-%d-%x' % (os.getpid(), id(self))=
)
+            self.delete()
+        else:
+            self.__filename =3D filename
+    env =3D property(lambda self: add_dict(self.__repository.env,
+                                         { 'GIT_INDEX_FILE': self.__fi=
lename }))
+    def read_tree(self, tree):
+        self.run(['git-read-tree', tree.sha1]).no_output()
+    def write_tree(self):
+        return self.__repository.get_tree(
+            self.run(['git-write-tree']).output_one_line())
+    def is_clean(self):
+        try:
+            self.run(['git-update-index', '--refresh']).discard_output=
()
+        except run.RunException:
+            return False
+        else:
+            return True
+    def merge(self, base, ours, theirs):
+        """In-index merge, no worktree involved."""
+        self.run(['git-read-tree', '-m', '-i', '--aggressive',
+                  base.sha1, ours.sha1, theirs.sha1]).no_output()
+        try:
+            self.run(['git-merge-index', 'git-merge-one-file', '-a']
+                     ).no_output()
+        except run.RunException:
+            raise MergeException('In-index merge failed due to conflic=
ts')
+    def delete(self):
+        if os.path.isfile(self.__filename):
+            os.remove(self.__filename)
+
+class Worktree(object):
+    def __init__(self, directory):
+        self.__directory =3D directory
+    env =3D property(lambda self: { 'GIT_WORK_TREE': self.__directory =
})
+
+class CheckoutException(StgException):
+    pass
+
+class IndexAndWorktree(RunWithEnv):
+    def __init__(self, index, worktree):
+        self.__index =3D index
+        self.__worktree =3D worktree
+    index =3D property(lambda self: self.__index)
+    env =3D property(lambda self: add_dict(self.__index.env, self.__wo=
rktree.env))
+    def checkout(self, old_commit, new_commit):
+        # TODO: Optionally do a 3-way instead of doing nothing when we
+        # have a problem. Or maybe we should stash changes in a patch?
+        try:
+            self.run(['git-read-tree', '-u', '-m',
+                      '--exclude-per-directory=3D.gitignore',
+                      old_commit.sha1, new_commit.sha1]
+                     ).discard_output()
+        except run.RunException:
+            raise CheckoutException('Index/workdir dirty')
+    def changed_files(self):
+        return self.run(['git-diff-files', '--name-only']).output_line=
s()
+    def update_index(self, files):
+        self.run(['git-update-index', '--remove', '-z', '--stdin']
+                 ).input_nulterm(files).discard_output()
+
+if __name__ =3D=3D '__main__':
+    testdir =3D '/tmp/stgtest'
+    os.system('rm -rf %s' % testdir)
+    os.makedirs(testdir)
+    os.chdir(testdir)
+    for c in ['git init',
+              'echo foo >> foo',
+              'git add foo',
+              'git commit -m foo',
+              'echo bar >> foo',
+              'git commit -a -m foo']:
+        os.system(c)
+    r =3D Repository(os.path.join(testdir, '.git'))
+    head =3D r.head
+    c =3D r.refs.get(head)
+    print 'HEAD is', head, 'which is', c
+    c.data
+    print 'Expanded:', c
+    maja =3D Person(name =3D 'Maja', email =3D 'maja@example.com')
+    nisse =3D Person(name =3D 'Nisse', email =3D 'nisse@example.com')
+    c2 =3D r.commit(c.data.set_parents([c]).set_author(maja))
+    c3 =3D r.commit(c.data.set_parents([c]).set_author(nisse))
+    c4 =3D r.commit(c.data.set_parents([c2, c3]))
+    r.refs.set(head, c4, 'made a cool merge')
+    c5 =3D r.commit(c.data.set_parents([c4]).set_tree(
+        c.data.parents[0].data.tree))
+    head =3D 'refs/heads/foobar'
+    r.refs.set(head, c5, 'committed a revert')
+    r.set_head(head, 'switched to other branch')
diff --git a/stgit/run.py b/stgit/run.py
index 924e59a..43c3a23 100644
--- a/stgit/run.py
+++ b/stgit/run.py
@@ -105,7 +105,7 @@ class Run:
     def input_lines(self, lines):
         self.__indata =3D ''.join(['%s\n' % line for line in lines])
         return self
-    def input_nulterm(self, items):
+    def input_nulterm(self, lines):
         self.__indata =3D ''.join('%s\0' % line for line in lines)
         return self
     def no_output(self):
diff --git a/stgit/stacklib.py b/stgit/stacklib.py
new file mode 100644
index 0000000..06ba007
--- /dev/null
+++ b/stgit/stacklib.py
@@ -0,0 +1,120 @@
+import os.path
+import gitlib, utils
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
+        self.__patches =3D gitlib.ObjectCache(create_patch) # name -> =
Patch
+    def exists(self, name):
+        return name in self.__patches
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
+def strip_leading(prefix, s):
+    assert s.startswith(prefix)
+    return s[len(prefix):]
+
+class Repository(gitlib.Repository):
+    def __init__(self, *args, **kwargs):
+        gitlib.Repository.__init__(self, *args, **kwargs)
+        self.__stacks =3D {} # name -> Stack
+    @property
+    def current_branch(self):
+        return strip_leading('refs/heads/', self.head)
+    @property
+    def current_stack(self):
+        return self.get_stack(self.current_branch)
+    def get_stack(self, name):
+        if not name in self.__stacks:
+            if name =3D=3D None:
+                s =3D None # detached HEAD
+            else:
+                # TODO: verify that the branch exists
+                s =3D Stack(self, name)
+            self.__stacks[name] =3D s
+        return self.__stacks[name]
diff --git a/stgit/translib.py b/stgit/translib.py
new file mode 100644
index 0000000..deb3420
--- /dev/null
+++ b/stgit/translib.py
@@ -0,0 +1,70 @@
+import gitlib
+from exception import *
+from out import *
+
+class TransactionException(StgException):
+    pass
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
+    def run(self, iw =3D None):
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
+            out.info('Head remains at %s' % new_head.sha1[:8])
+        elif new_head.data.tree =3D=3D self.__stack.head.data.tree:
+            out.info('Head %s -> %s (same tree)' % (self.__stack.head.=
sha1[:8],
+                                                    new_head.sha1[:8])=
)
+        elif iw !=3D None:
+            try:
+                iw.checkout(self.__stack.head, new_head)
+            except gitlib.CheckoutException, e:
+                raise TransactionException(e)
+            out.info('Head %s -> %s' % (self.__stack.head.sha1[:8],
+                                        new_head.sha1[:8]))
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
+        self.__stack.patchorder.applied =3D self.__applied
+        self.__stack.patchorder.unapplied =3D self.__unapplied
diff --git a/stgit/utillib.py b/stgit/utillib.py
new file mode 100644
index 0000000..d09ecc4
--- /dev/null
+++ b/stgit/utillib.py
@@ -0,0 +1,139 @@
+import gitlib, translib
+from out import *
+
+def head_top_equal(repository):
+    head =3D repository.head_commit
+    try:
+        s =3D repository.current_stack
+    except gitlib.DetachedHeadException:
+        out.error('Not on any branch (detached HEAD)')
+        return False
+    applied =3D s.patchorder.applied
+    if not applied:
+        return True
+    top =3D s.patches.get(applied[-1])
+    if top.commit =3D=3D head:
+        return True
+    out.error('The top patch (%s, %s)' % (top.name, top.commit.sha1),
+              'and HEAD (%s) are not the same.' % head.sha1)
+    return False
+
+def simple_merge(repository, base, ours, theirs):
+    """Given three trees, tries to do an in-index merge in a temporary
+    index with a temporary index. Returns the result tree, or None if
+    the merge failed (due to conflicts)."""
+    assert isinstance(base, gitlib.Tree)
+    assert isinstance(ours, gitlib.Tree)
+    assert isinstance(theirs, gitlib.Tree)
+    if base =3D=3D ours:
+        # Fast forward: theirs is a descendant of ours.
+        return theirs
+    if base =3D=3D theirs:
+        # Fast forward: ours is a descendant of theirs.
+        return ours
+    index =3D repository.temp_index()
+    try:
+        try:
+            index.merge(base, ours, theirs)
+        except gitlib.MergeException:
+            return None
+        return index.write_tree()
+    finally:
+        index.delete()
+
+def clean(stack):
+    t =3D translib.StackTransaction(stack, 'stg clean')
+    t.unapplied =3D []
+    for pn in stack.patchorder.unapplied:
+        p =3D stack.patches.get(pn)
+        if p.is_empty():
+            t.patches[pn] =3D None
+        else:
+            t.unapplied.append[pn]
+    t.applied =3D []
+    parent =3D stack.base
+    for pn in stack.patchorder.applied:
+        p =3D stack.patches.get(pn)
+        if p.is_empty():
+            t.patches[pn] =3D None
+            out.info('Deleting %s' % pn)
+        else:
+            if parent !=3D p.commit.data.parent:
+                parent =3D t.patches[pn] =3D stack.repository.commit(
+                    p.commit.data.set_parent(parent))
+            else:
+                parent =3D p.commit
+            t.applied.append(pn)
+            out.info('Keeping %s' % pn)
+    t.run()
+
+def pop(stack, iw =3D None):
+    t =3D translib.StackTransaction(stack, 'stg pop')
+    pn =3D t.applied.pop()
+    t.unapplied.insert(0, pn)
+    t.run(iw)
+
+def push(stack, pn, iw =3D None):
+    t =3D translib.StackTransaction(stack, 'stg push')
+    t.unapplied.remove(pn)
+    t.applied.append(pn)
+    p =3D stack.patches.get(pn)
+    if stack.head !=3D p.commit.data.parent:
+        tree =3D simple_merge(stack.repository, p.commit.data.parent.d=
ata.tree,
+                            stack.head.data.tree, p.commit.data.tree)
+        assert tree
+        t.patches[pn] =3D stack.repository.commit(
+            p.commit.data.set_parent(stack.head).set_tree(tree))
+    t.run(iw)
+
+def refresh(stack, iw):
+    iw.update_index(iw.changed_files())
+    tree =3D iw.index.write_tree()
+    t =3D translib.StackTransaction(stack, 'stg refresh')
+    p =3D stack.patches.get(t.applied[-1])
+    t.patches[p.name] =3D stack.repository.commit(
+        p.commit.data.set_tree(tree))
+    t.run()
+
+if __name__ =3D=3D '__main__':
+    import os
+    import stacklib
+    testdir =3D '/tmp/stgtest'
+    os.system('rm -rf %s' % testdir)
+    os.makedirs(testdir)
+    os.chdir(testdir)
+    for c in ['git init',
+              'echo foo >> foo',
+              'git add foo',
+              'git commit -m foo',
+              'stg init']:
+        os.system(c)
+    for i in range(3):
+        for c in ['stg new p%d -m p%d' % (i, i),
+                  'echo %s >> foo%d' % (str(i)*4, i),
+                  'git add foo%d' % i,
+                  'stg refresh',
+                  'stg new q%d -m q%d' % (i, i)]:
+            os.system(c)
+    r =3D stacklib.Repository.default()
+    print 'Current branch:', r.current_branch
+    s =3D r.current_stack
+    print 'Applied:', s.patchorder.applied
+    print 'Unapplied:', s.patchorder.unapplied
+    os.system('git checkout HEAD^')
+    head_top_equal(r)
+    os.system('git checkout master')
+    head_top_equal(r)
+    clean(s)
+    iw =3D r.default_iw()
+    pop(s, iw)
+    pop(s, iw)
+    os.system('stg series')
+    os.system('stg status')
+    push(s, 'p2', iw)
+    os.system('stg series')
+    os.system('stg status')
+    os.system('echo 333 >> foo0')
+    refresh(s, iw)
+    os.system('stg series')
+    os.system('stg status')

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
