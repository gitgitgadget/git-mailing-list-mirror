From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Some API documentation for the new infrastructure
Date: Tue, 03 Jun 2008 07:41:03 +0200
Message-ID: <20080603053946.15327.29723.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 07:42:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3PHv-0003wx-4W
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 07:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYFCFlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 01:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751824AbYFCFlM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 01:41:12 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2613 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbYFCFlK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 01:41:10 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K3PGZ-0002iw-00; Tue, 03 Jun 2008 06:41:04 +0100
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83617>

Not all that comprehensive, but better than nothing.

Uses epydoc (http://epydoc.sourceforge.net/) markup.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

I'm not 100% sure that epydoc is the way to go -- there seems to be a
few constructs, such as properties, that it really doesn't handle.

 stgit/lib/git.py         |  120 ++++++++++++++++++++++++++++++++++++++=
--------
 stgit/lib/stack.py       |   11 ++++
 stgit/lib/transaction.py |   49 +++++++++++++++++--
 3 files changed, 154 insertions(+), 26 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index b3181cb..c9f01e3 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -1,26 +1,53 @@
+"""A Python class hierarchy wrapping a git repository and its
+contents."""
+
 import os, os.path, re
 from datetime import datetime, timedelta, tzinfo
=20
 from stgit import exception, run, utils
 from stgit.config import config
=20
+class Immutable(object):
+    """I{Immutable} objects cannot be modified once created. Any
+    modification methods will return a new object, leaving the
+    original object as it was.
+
+    The reason for this is that we want to be able to represent git
+    objects, which are immutable, and want to be able to create new
+    git objects that are just slight modifications of other git
+    objects. (Such as, for example, modifying the commit message of a
+    commit object while leaving the rest of it intact. This involves
+    creating a whole new commit object that's exactly like the old one
+    except for the commit message.)
+
+    The L{Immutable} class doesn't acytually enforce immutability --
+    that is up to the individual immutable subclasses. It just serves
+    as documentation."""
+
 class RepositoryException(exception.StgException):
-    pass
+    """Base class for all exceptions due to failed L{Repository}
+    operations."""
=20
 class DateException(exception.StgException):
+    """Exception raised when a date+time string could not be parsed.""=
"
     def __init__(self, string, type):
         exception.StgException.__init__(
             self, '"%s" is not a valid %s' % (string, type))
=20
 class DetachedHeadException(RepositoryException):
+    """Exception raised when HEAD is detached (that is, there is no
+    current branch)."""
     def __init__(self):
         RepositoryException.__init__(self, 'Not on any branch')
=20
 class Repr(object):
+    """Utility class that defines C{__reps__} in terms of C{__str__}."=
""
     def __repr__(self):
         return str(self)
=20
 class NoValue(object):
+    """A handy default value that is guaranteed to be distinct from an=
y
+    real argument value."""
     pass
=20
 def make_defaults(defaults):
@@ -34,6 +61,9 @@ def make_defaults(defaults):
     return d
=20
 class TimeZone(tzinfo, Repr):
+    """A simple time zone class for static offsets from UTC. (We have =
to
+    define our own since Python's standard library doesn't define any
+    time zone classes.)"""
     def __init__(self, tzstring):
         m =3D re.match(r'^([+-])(\d{2}):?(\d{2})$', tzstring)
         if not m:
@@ -54,8 +84,8 @@ class TimeZone(tzinfo, Repr):
     def __str__(self):
         return self.__name
=20
-class Date(Repr):
-    """Immutable."""
+class Date(Immutable, Repr):
+    """Represents a timestamp used in git commits."""
     def __init__(self, datestring):
         # Try git-formatted date.
         m =3D re.match(r'^(\d+)\s+([+-]\d\d:?\d\d)$', datestring)
@@ -88,12 +118,15 @@ class Date(Repr):
                           self.__time.tzinfo)
     @classmethod
     def maybe(cls, datestring):
+        """Return a new object initialized with the argument if it con=
tains a
+        value (otherwise, just return the argument)."""
         if datestring in [None, NoValue]:
             return datestring
         return cls(datestring)
=20
-class Person(Repr):
-    """Immutable."""
+class Person(Immutable, Repr):
+    """Represents an author or committer in a git commit object. Conta=
ins
+    name, email and timestamp."""
     def __init__(self, name =3D NoValue, email =3D NoValue,
                  date =3D NoValue, defaults =3D NoValue):
         d =3D make_defaults(defaults)
@@ -146,16 +179,16 @@ class Person(Repr):
                 defaults =3D cls.user())
         return cls.__committer
=20
-class Tree(Repr):
-    """Immutable."""
+class Tree(Immutable, Repr):
+    """Represents a git tree object."""
     def __init__(self, sha1):
         self.__sha1 =3D sha1
     sha1 =3D property(lambda self: self.__sha1)
     def __str__(self):
         return 'Tree<%s>' % self.sha1
=20
-class CommitData(Repr):
-    """Immutable."""
+class CommitData(Immutable, Repr):
+    """Represents the actual data contents of a git commit object."""
     def __init__(self, tree =3D NoValue, parents =3D NoValue, author =3D=
 NoValue,
                  committer =3D NoValue, message =3D NoValue, defaults =
=3D NoValue):
         d =3D make_defaults(defaults)
@@ -223,8 +256,10 @@ class CommitData(Repr):
                 assert False
         assert False
=20
-class Commit(Repr):
-    """Immutable."""
+class Commit(Immutable, Repr):
+    """Represents a git commit object. All the actual data contents of=
 the
+    commit object is stored in the L{data} member, which is a
+    L{CommitData} object."""
     def __init__(self, repository, sha1):
         self.__sha1 =3D sha1
         self.__repository =3D repository
@@ -241,21 +276,26 @@ class Commit(Repr):
         return 'Commit<sha1: %s, data: %s>' % (self.sha1, self.__data)
=20
 class Refs(object):
+    """Accessor for the refs stored in a git repository. Will
+    transparently cache the values of all refs."""
     def __init__(self, repository):
         self.__repository =3D repository
         self.__refs =3D None
     def __cache_refs(self):
+        """(Re-)Build the cache of all refs in the repository."""
         self.__refs =3D {}
         for line in self.__repository.run(['git', 'show-ref']).output_=
lines():
             m =3D re.match(r'^([0-9a-f]{40})\s+(\S+)$', line)
             sha1, ref =3D m.groups()
             self.__refs[ref] =3D sha1
     def get(self, ref):
-        """Throws KeyError if ref doesn't exist."""
+        """Get the Commit the given ref points to. Throws KeyError if =
ref
+        doesn't exist."""
         if self.__refs =3D=3D None:
             self.__cache_refs()
         return self.__repository.get_commit(self.__refs[ref])
     def exists(self, ref):
+        """Check if the given ref exists."""
         try:
             self.get(ref)
         except KeyError:
@@ -263,6 +303,8 @@ class Refs(object):
         else:
             return True
     def set(self, ref, commit, msg):
+        """Write the sha1 of the given Commit to the ref. The ref may =
or may
+        not already exist."""
         if self.__refs =3D=3D None:
             self.__cache_refs()
         old_sha1 =3D self.__refs.get(ref, '0'*40)
@@ -272,6 +314,7 @@ class Refs(object):
                                    ref, new_sha1, old_sha1]).no_output=
()
             self.__refs[ref] =3D new_sha1
     def delete(self, ref):
+        """Delete the given ref. Throws KeyError if ref doesn't exist.=
"""
         if self.__refs =3D=3D None:
             self.__cache_refs()
         self.__repository.run(['git', 'update-ref',
@@ -280,7 +323,8 @@ class Refs(object):
=20
 class ObjectCache(object):
     """Cache for Python objects, for making sure that we create only o=
ne
-    Python object per git object."""
+    Python object per git object. This reduces memory consumption and
+    makes object comparison very cheap."""
     def __init__(self, create):
         self.__objects =3D {}
         self.__create =3D create
@@ -296,13 +340,27 @@ class ObjectCache(object):
=20
 class RunWithEnv(object):
     def run(self, args, env =3D {}):
+        """Run the given command with an environment given by self.env=
=2E
+
+        @type args: list of strings
+        @param args: Command and argument vector
+        @type env: dict
+        @param env: Extra environment"""
         return run.Run(*args).env(utils.add_dict(self.env, env))
=20
 class RunWithEnvCwd(RunWithEnv):
     def run(self, args, env =3D {}):
+        """Run the given command with an environment given by self.env=
, and
+        current working directory given by self.cwd.
+
+        @type args: list of strings
+        @param args: Command and argument vector
+        @type env: dict
+        @param env: Extra environment"""
         return RunWithEnv.run(self, args, env).cwd(self.cwd)
=20
 class Repository(RunWithEnv):
+    """Represents a git repository."""
     def __init__(self, directory):
         self.__git_dir =3D directory
         self.__refs =3D Refs(self)
@@ -322,15 +380,20 @@ class Repository(RunWithEnv):
             raise RepositoryException('Cannot find git repository')
     @property
     def default_index(self):
+        """An L{Index} object representing the default index file for =
the
+        repository."""
         if self.__default_index =3D=3D None:
             self.__default_index =3D Index(
                 self, (os.environ.get('GIT_INDEX_FILE', None)
                        or os.path.join(self.__git_dir, 'index')))
         return self.__default_index
     def temp_index(self):
+        """Return an L{Index} object representing a new temporary inde=
x file
+        for the repository."""
         return Index(self, self.__git_dir)
     @property
     def default_worktree(self):
+        """A L{Worktree} object representing the default work tree."""
         if self.__default_worktree =3D=3D None:
             path =3D os.environ.get('GIT_WORK_TREE', None)
             if not path:
@@ -342,6 +405,8 @@ class Repository(RunWithEnv):
         return self.__default_worktree
     @property
     def default_iw(self):
+        """An L{IndexAndWorktree} object representing the default inde=
x and
+        work tree for this repository."""
         if self.__default_iw =3D=3D None:
             self.__default_iw =3D IndexAndWorktree(self.default_index,
                                                  self.default_worktree=
)
@@ -387,9 +452,9 @@ class Repository(RunWithEnv):
     def set_head(self, ref, msg):
         self.run(['git', 'symbolic-ref', '-m', msg, 'HEAD', ref]).no_o=
utput()
     def simple_merge(self, base, ours, theirs):
-        """Given three trees, tries to do an in-index merge in a tempo=
rary
-        index with a temporary index. Returns the result tree, or None=
 if
-        the merge failed (due to conflicts)."""
+        """Given three L{Tree}s, tries to do an in-index merge with a
+        temporary index. Returns the result L{Tree}, or None if the
+        merge failed (due to conflicts)."""
         assert isinstance(base, Tree)
         assert isinstance(ours, Tree)
         assert isinstance(theirs, Tree)
@@ -412,8 +477,8 @@ class Repository(RunWithEnv):
         finally:
             index.delete()
     def apply(self, tree, patch_text):
-        """Given a tree and a patch, will either return the new tree t=
hat
-        results when the patch is applied, or None if the patch
+        """Given a L{Tree} and a patch, will either return the new L{T=
ree}
+        that results when the patch is applied, or None if the patch
         couldn't be applied."""
         assert isinstance(tree, Tree)
         if not patch_text:
@@ -429,18 +494,26 @@ class Repository(RunWithEnv):
         finally:
             index.delete()
     def diff_tree(self, t1, t2, diff_opts):
+        """Given two L{Tree}s C{t1} and C{t2}, return the patch that t=
akes
+        C{t1} to C{t2}.
+
+        @type diff_opts: list of strings
+        @param diff_opts: Extra diff options
+        @rtype: String
+        @return: Patch text"""
         assert isinstance(t1, Tree)
         assert isinstance(t2, Tree)
         return self.run(['git', 'diff-tree', '-p'] + list(diff_opts)
                         + [t1.sha1, t2.sha1]).raw_output()
=20
 class MergeException(exception.StgException):
-    pass
+    """Exception raised when a merge fails for some reason."""
=20
 class MergeConflictException(MergeException):
-    pass
+    """Exception raised when a merge fails due to conflicts."""
=20
 class Index(RunWithEnv):
+    """Represents a git index file."""
     def __init__(self, repository, filename):
         self.__repository =3D repository
         if os.path.isdir(filename):
@@ -492,15 +565,20 @@ class Index(RunWithEnv):
         return paths
=20
 class Worktree(object):
+    """Represents a git worktree (that is, a checked-out file tree).""=
"
     def __init__(self, directory):
         self.__directory =3D directory
     env =3D property(lambda self: { 'GIT_WORK_TREE': '.' })
     directory =3D property(lambda self: self.__directory)
=20
 class CheckoutException(exception.StgException):
-    pass
+    """Exception raised when a checkout fails."""
=20
 class IndexAndWorktree(RunWithEnvCwd):
+    """Represents a git index and a worktree. Anything that an index o=
r
+    worktree can do on their own are handled by the L{Index} and
+    L{Worktree} classes; this class concerns itself with the
+    operations that require both."""
     def __init__(self, index, worktree):
         self.__index =3D index
         self.__worktree =3D worktree
diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index 6a2b40d..f9e750e 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -1,8 +1,12 @@
+"""A Python class hierarchy wrapping the StGit on-disk metadata."""
+
 import os.path
 from stgit import exception, utils
 from stgit.lib import git, stackupgrade
=20
 class Patch(object):
+    """Represents an StGit patch. This class is mainly concerned with
+    reading and writing the on-disk representation of a patch."""
     def __init__(self, stack, name):
         self.__stack =3D stack
         self.__name =3D name
@@ -102,7 +106,8 @@ class PatchOrder(object):
     all =3D property(lambda self: self.applied + self.unapplied)
=20
 class Patches(object):
-    """Creates Patch objects."""
+    """Creates L{Patch} objects. Makes sure there is only one such obj=
ect
+    per patch."""
     def __init__(self, stack):
         self.__stack =3D stack
         def create_patch(name):
@@ -126,6 +131,8 @@ class Patches(object):
         return p
=20
 class Stack(object):
+    """Represents an StGit stack (that is, a git branch with some extr=
a
+    metadata)."""
     def __init__(self, repository, name):
         self.__repository =3D repository
         self.__name =3D name
@@ -164,6 +171,8 @@ class Stack(object):
         return self.head =3D=3D self.patches.get(self.patchorder.appli=
ed[-1]).commit
=20
 class Repository(git.Repository):
+    """A git L{Repository<git.Repository>} with some added StGit-speci=
fic
+    operations."""
     def __init__(self, *args, **kwargs):
         git.Repository.__init__(self, *args, **kwargs)
         self.__stacks =3D {} # name -> Stack
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 874f81b..e47997e 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -1,13 +1,19 @@
+"""The L{StackTransaction} class makes it possible to make complex
+updates to an StGit stack in a safe and convenient way."""
+
 from stgit import exception, utils
 from stgit.utils import any, all
 from stgit.out import *
 from stgit.lib import git
=20
 class TransactionException(exception.StgException):
-    pass
+    """Exception raised when something goes wrong with a
+    L{StackTransaction}."""
=20
 class TransactionHalted(TransactionException):
-    pass
+    """Exception raised when a L{StackTransaction} stops part-way thro=
ugh.
+    Used to make a non-local jump from the transaction setup to the
+    part of the transaction code where the transaction is run."""
=20
 def _print_current_patch(old_applied, new_applied):
     def now_at(pn):
@@ -24,6 +30,7 @@ def _print_current_patch(old_applied, new_applied):
         now_at(new_applied[-1])
=20
 class _TransPatchMap(dict):
+    """Maps patch names to sha1 strings."""
     def __init__(self, stack):
         dict.__init__(self)
         self.__stack =3D stack
@@ -34,6 +41,36 @@ class _TransPatchMap(dict):
             return self.__stack.patches.get(pn).commit
=20
 class StackTransaction(object):
+    """A stack transaction, used for making complex updates to an StGi=
t
+    stack in one single operation that will either succeed or fail
+    cleanly.
+
+    The basic theory of operation is the following:
+
+      1. Create a transaction object.
+
+      2. Inside a::
+
+         try
+           ...
+         except TransactionHalted:
+           pass
+
+      block, update the transaction with e.g. methods like
+      L{pop_patches} and L{push_patch}. This may create new git
+      objects such as commits, but will not write any refs; this means
+      that in case of a fatal error we can just walk away, no clean-up
+      required.
+
+      (Some operations may need to touch your index and working tree,
+      though. But they are cleaned up when needed.)
+
+      3. After the C{try} block -- wheher or not the setup ran to
+      completion or halted part-way through by raising a
+      L{TransactionHalted} exception -- call the transaction's L{run}
+      method. This will either succeed in writing the updated state to
+      your refs and index+worktree, or fail without having done
+      anything."""
     def __init__(self, stack, msg, allow_conflicts =3D False):
         self.__stack =3D stack
         self.__msg =3D msg
@@ -102,6 +139,8 @@ class StackTransaction(object):
         if iw:
             self.__checkout(self.__stack.head.data.tree, iw)
     def run(self, iw =3D None):
+        """Execute the transaction. Will either succeed, or fail (with=
 an
+        exception) and do nothing."""
         self.__check_consistency()
         new_head =3D self.__head
=20
@@ -152,7 +191,8 @@ class StackTransaction(object):
=20
     def pop_patches(self, p):
         """Pop all patches pn for which p(pn) is true. Return the list=
 of
-        other patches that had to be popped to accomplish this."""
+        other patches that had to be popped to accomplish this. Always
+        succeeds."""
         popped =3D []
         for i in xrange(len(self.applied)):
             if p(self.applied[i]):
@@ -167,7 +207,8 @@ class StackTransaction(object):
=20
     def delete_patches(self, p):
         """Delete all patches pn for which p(pn) is true. Return the l=
ist of
-        other patches that had to be popped to accomplish this."""
+        other patches that had to be popped to accomplish this. Always
+        succeeds."""
         popped =3D []
         all_patches =3D self.applied + self.unapplied
         for i in xrange(len(self.applied)):
