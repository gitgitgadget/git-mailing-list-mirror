From: Johan Herland <johan@herland.net>
Subject: [RFCv4 2/5] 1/2: Add Python support library for CVS remote helper
Date: Mon, 17 Aug 2009 05:35:58 +0200
Message-ID: <1250480161-21933-3-git-send-email-johan@herland.net>
References: <1250480161-21933-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johannes.Schindelin@gmx.de, Johan Herland <johan@herland.net>,
	barkalow@iabervon.org, davvid@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 05:36:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mct1i-0006ij-7J
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 05:36:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746AbZHQDgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 23:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756740AbZHQDgi
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 23:36:38 -0400
Received: from smtp.getmail.no ([84.208.15.66]:47273 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756720AbZHQDgf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Aug 2009 23:36:35 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOI00CDM4OZ4N60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 17 Aug 2009 05:36:35 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOI00M7C4OTJP20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 17 Aug 2009 05:36:35 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.17.32416
X-Mailer: git-send-email 1.6.4.262.gca66a.dirty
In-reply-to: <1250480161-21933-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126112>

This patch introduces parts of a Python package called "git_remote_cvs"
containing the building blocks of the CVS remote helper.
The CVS remote helper itself is NOT part of this patch.

This patch has been improved by the following contributions:
- David Aguilar: Lots of Python coding style fixes

Cc: David Aguilar <davvid@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---

This patch and the next patch belong together in the same commit, but
the 100K limit (?) on the git mailing list forces me to split this
patch in two.

...Johan

 git_remote_cvs/changeset.py        |  126 +++++
 git_remote_cvs/cvs.py              |  998 ++++++++++++++++++++++++++++++++++++
 git_remote_cvs/cvs_symbol_cache.py |  313 +++++++++++
 git_remote_cvs/util.py             |  186 +++++++
 4 files changed, 1623 insertions(+), 0 deletions(-)
 create mode 100644 git_remote_cvs/changeset.py
 create mode 100644 git_remote_cvs/cvs.py
 create mode 100644 git_remote_cvs/cvs_symbol_cache.py
 create mode 100644 git_remote_cvs/util.py

diff --git a/git_remote_cvs/changeset.py b/git_remote_cvs/changeset.py
new file mode 100644
index 0000000..9eea9d2
--- /dev/null
+++ b/git_remote_cvs/changeset.py
@@ -0,0 +1,126 @@
+#!/usr/bin/env python
+
+"""Code for collecting individual CVS revisions into "changesets"
+
+A changeset is a collection of CVSRev objects that belong together in
+the same "commit".  This is a somewhat artificial construct on top of
+CVS, which only stores changes at the per-file level.  Normally, CVS
+users create several CVS revisions simultaneously by applying the
+"cvs commit" command to several files with related changes.  This
+module tries to reconstruct this notion of related revisions.
+
+"""
+
+from git_remote_cvs.util import debug, error, die
+
+
+class Changeset(object):
+
+    """Encapsulate a single changeset/commit."""
+
+    __slots__ = ('revs', 'date', 'author', 'message')
+
+    # The maximum time between the changeset's date, and the date of a
+    # rev to included in that changeset.
+    MaxSecondsBetweenRevs = 8 * 60 * 60  # 8 hours
+
+    @classmethod
+    def from_rev (cls, rev):
+        """Return a Changeset based on the given CVSRev object."""
+        c = cls(rev.date, rev.author, rev.message)
+        result = c.add(rev)
+        assert result
+        return c
+
+    def __init__ (self, date, author, message):
+        """Create a new Changeset with the given metadata."""
+        self.revs = {}  # dict: path -> CVSRev object
+        self.date = date  # CVSDate object
+        self.author = author
+        self.message = message  # Lines of commit message
+
+    def __str__ (self):
+        """Stringify this Changeset object."""
+        msg = self.message[0]  # First line only
+        # Limit message to 25 chars
+        if len(msg) > 25:
+            msg = msg[:22] + "..."
+        return ("<Changeset @(%s) by %s (%s) updating %i files>" %
+                (self.date, self.author, msg, len(self.revs)))
+
+    def __iter__ (self):
+        """Return iterator traversing the CVSRevs in this Changeset."""
+        return self.revs.itervalues()
+
+    def __getitem__ (self, path):
+        """Look up a specific CVSRev in this Changeset."""
+        return self.revs[path]
+
+    def within_time_window (self, rev):
+        """Return True iff the rev is within the time window of self."""
+        return abs(rev.date.diff(self.date)) <= self.MaxSecondsBetweenRevs
+
+    def add (self, rev):
+        """Add the given CVSRev to this Changeset.
+
+        The addition will only succeed if the following holds:
+          - rev.author == self.author
+          - rev.message == self.message
+          - rev.path is not in self.revs
+          - rev.date is within MaxSecondsBetweenRevs of self.date
+        If the addition succeeds, True is returned; otherwise False.
+
+        """
+        if rev.author != self.author or \
+           rev.message != self.message or \
+           rev.path in self.revs or \
+           not self.within_time_window(rev):
+            return False
+
+        self.revs[rev.path] = rev
+        return True
+
+
+def build_changesets_from_revs (cvs_revs):
+    """Organize CVSRev objects into a chronological list of Changesets."""
+    # Construct chronological list of CVSRev objects
+    chron_revs = []
+    for path, d in cvs_revs.iteritems():
+        i = 0  # Current index into chronRevs
+        for revnum, cvsrev in sorted(d.iteritems()):
+            assert path == cvsrev.path
+            assert revnum == cvsrev.num
+            while i < len(chron_revs) and cvsrev.date > chron_revs[i].date:
+                i += 1
+            # Insert cvsRev at position i in chronRevs
+            chron_revs.insert(i, cvsrev)
+            i += 1
+
+    changesets = []  # Chronological list of Changeset objects
+    while len(chron_revs):
+        # There are still more revs to be added to Changesets
+        # Create Changeset based on the first rev in chronRevs
+        changeset = Changeset.from_rev(chron_revs.pop(0))
+        # Keep adding revs chronologically until MaxSecondsBetweenRevs
+        rejects = []  # Revs that cannot be added to this changeset
+        while len(chron_revs):
+            rev = chron_revs.pop(0)
+            reject = False
+            # First, if we have one of rev's parents in rejects, we
+            # must also reject rev
+            for r in rejects:
+                if r.path == rev.path:
+                    reject = True
+                    break
+            # Next, add rev to changeset, reject if add fails
+            if not reject:
+                reject = not changeset.add(rev)
+            if reject:
+                rejects.append(rev)
+                # stop trying when rev is too far in the future
+                if not changeset.within_time_window(rev):
+                    break
+        chron_revs = rejects + chron_revs  # Reconstruct remaining revs
+        changesets.append(changeset)
+
+    return changesets
diff --git a/git_remote_cvs/cvs.py b/git_remote_cvs/cvs.py
new file mode 100644
index 0000000..f870ae0
--- /dev/null
+++ b/git_remote_cvs/cvs.py
@@ -0,0 +1,998 @@
+#!/usr/bin/env python
+
+"""Functionality for interacting with CVS repositories.
+
+This module provides classes for interrogating a CVS repository via a
+CVS working directory (aka. checkout), or via direct queries using the
+"cvs rlog" command.
+
+Also, classes for encapsulating fundamental CVS concepts (like CVS
+revision/branch numbers) are provided.
+"""
+
+import sys
+import os
+import shutil
+import time
+from calendar import timegm
+import unittest
+
+from git_remote_cvs.util import (debug, error, die, ProgressIndicator,
+                                 start_command, run_command,
+                                 file_reader_method, file_writer_method)
+
+
+class CVSNum(object):
+
+    """Encapsulate a single CVS revision/branch number.
+
+    Provides functionality for common operations on CVS numbers.
+
+    A CVS number consists of a list of components separated by periods
+    ('.'), where each component is a decimal number.  Inspecting the
+    components from left to right, the odd-numbered (1st, 3rd, 5th,
+    etc.) components represent branches in the CVS history tree, while
+    the even-numbered (2nd, 4th, 6th, etc.) components represent
+    revisions on the branch specified in the previous position.
+    Thus "1.2" denotes the second revision on the first branch
+    (aka. trunk), while "1.2.4.6" denotes the sixth revision of the
+    fourth branch started from revision "1.2".
+
+    Therefore, in general, a CVS number with an even number of
+    components denotes a revision (we call this a "revision number"),
+    while an odd number of components denotes a branch (called a
+    "branch number").
+
+    There are a few complicating peculiarities: If there is an even
+    number of components, and the second-last component is 0, the
+    number is not a revision number, but is rather equivalent to the
+    branch number we get by removing the 0-component.  I.e. "1.2.0.4"
+    is equivalent to "1.2.4".
+
+    A branch number (except the trunk: "1") always has a "branch point"
+    revision, i.e. the revision from which the branch was started.
+    This revision is found by removing the last component of the branch
+    number.  For example the branch point of "1.2.4" is "1.2".
+
+    Conversely, all revision numbers belong to a corresponding branch,
+    whose branch number is found by removing the last component.
+    Examples: The "1.2.4.6" revision belong to the "1.2.4" branch,
+    while the "1.2" revision belongs to the "1" branch (the "trunk").
+
+    From this we can programatically determine the ancestry of any
+    revision number, by decrementing the last revision component until
+    it equals 1, and then trim off the last two components to get to
+    the branch point, and repeat the process from there until we reach
+    the initial revision (typically "1.1").  For example, recursively
+    enumerating the parent revisions of "1.2.4.6" yields the following
+    revisions:
+    "1.2.4.5", "1.2.4.4", "1.2.4.3", "1.2.4.2", "1.2.4.1", "1.2", "1.1"
+
+    """
+
+    __slots__ = ('c',)
+
+    @staticmethod
+    def decompose (cvsnum):
+        """Split the given CVS number into a list of int components.
+
+        Branch numbers are normalized to the odd-numbered components
+        form (i.e. removing the second last '0' component)
+
+        Examples:
+          '1.2.4.8' -> [1, 2, 4, 8]
+          '1.2.3'   -> [1, 2, 3]
+          '1.2.0.5' -> [1, 2, 5]
+
+        """
+        if cvsnum:
+            r = map(int, cvsnum.split('.'))
+        else:
+            r = []
+        if len(r) >= 2 and r[-2] == 0:
+            del r[-2]
+        if r[-1] == 0:
+            raise ValueError(cvsnum)
+        return tuple(r)
+
+    @staticmethod
+    def compose (c):
+        """Join the given list of integer components into a CVS number.
+
+        E.g.: (1, 2, 4, 8) -> '1.2.4.8'
+
+        """
+        if c[-1] == 0:
+            raise ValueError(str(c))
+        return ".".join(map(str, c))
+
+    @classmethod
+    def from_components (cls, args):
+        """Create a CVSNum from the given list of numerical components."""
+        return cls(cls.compose(args))
+
+    @classmethod
+    def disjoint (cls, a, b):
+        """Return True iff the CVS numbers are historically disjoint.
+
+        Two CVS numbers are disjoint if they do not share the same
+        historical line back to the initial revision.  In other words:
+        the two numbers are disjoint if the history (i.e. set of parent
+        revisions all the way back to the intial (1.1) revision) of
+        neither number is a superset of the other's history.
+        See test_disjoint() for practical examples:
+
+        """
+        if a.is_branch():
+            a = cls.from_components(a.c + (1,))
+        if b.is_branch():
+            b = cls.from_components(b.c + (1,))
+        if len(a.c) > len(b.c):
+            a, b = b, a  # a is now shortest
+        pairs = zip(a.c, b.c)
+        for pa, pb in pairs[:-1]:
+            if pa != pb:
+                return True
+        if len(a) == len(b):
+            return False
+        common_len = len(a)
+        if a.c[common_len - 1] <= b.c[common_len - 1]:
+            return False
+        return True
+
+
+    def __init__ (self, cvsnum):
+        """Create a CVSNum object from the given CVS number string."""
+        self.c = self.decompose(str(cvsnum))
+
+    def __repr__ (self):
+        """Return a string representation of this object."""
+        return self.compose(self.c)
+
+    def __str__ (self):
+        """Return a string representation of this object."""
+        return repr(self)
+
+    def __hash__ (self):
+        """Create a hash value for this CVS number."""
+        return hash(repr(self))
+
+    def __len__ (self):
+        """Return number of components in this CVS number."""
+        return len(self.c)
+
+    def __cmp__ (self, other):
+        """Comparison method for CVS numbers."""
+        try:
+            return cmp(self.c, other.c)
+        except AttributeError:
+            return 1
+
+    def __getitem__ (self, key):
+        """Return the Xth component of this CVS number."""
+        return self.c[key]
+
+    def is_rev (self):
+        """Return True iff this number is a CVS revision number."""
+        return len(self.c) % 2 == 0 and len(self.c) >= 2 and self.c[-2] != 0
+
+    def is_branch (self):
+        """Return True iff this number is a CVS branch number."""
+        return len(self.c) % 2 != 0 or (len(self.c) >= 2 and self.c[-2] == 0)
+
+    def components (self):
+        """Return a list of integer components in this CVS number."""
+        return list(self.c)
+
+    def branch (self):
+        """Return the branch on which the given number lives.
+
+        Revisions: chop the last component to find the branch, e.g.:
+            1.2.4.6 -> 1.2.4
+            1.1 -> 1
+        Branches: unchanged
+
+        """
+        if self.is_rev():
+            return self.from_components(self.c[:-1])
+        return self
+
+    def parent (self):
+        """Return the parent/previous revision number to this number.
+
+        For revisions, this is the previous revision, e.g.:
+            1.2.4.6 -> 1.2.4.5
+            1.2.4.1 -> 1.2
+            1.1 -> None
+            2.1 -> None
+        For branches, this is the branch point, e.g.:
+            1.2.4 -> 1.2
+            1 -> None
+            2 -> None
+
+        """
+        if len(self.c) < 2:
+            return None
+        elif len(self.c) % 2:  # Branch number
+            return self.from_components(self.c[:-1])
+        else:  # Revision number
+            assert self.c[-1] > 0
+            result = self.components()
+            result[-1] -= 1  # Decrement final component
+            if result[-1] == 0:  # We're at the start of the branch
+                del result[-2:]  # Make into branch point
+                if not result:
+                    return None
+            return self.from_components(result)
+
+    def follows (self, other):
+        """Return True iff self historically follows the given rev.
+
+        This iterates through the parents of self, and returns True iff
+        any of them equals the given rev.  Otherwise, it returns False.
+
+        """
+        assert other.is_rev()
+        cur = self
+        while cur:
+            if cur == other:
+                return True
+            cur = cur.parent()
+        return False
+
+    def on_branch (self, branch):
+        """Return True iff this rev is on the given branch.
+
+        The revs considered to be "on" a branch X also includes the
+        branch point of branch X.
+
+        """
+        return branch == self.branch() or branch.parent() == self
+
+
+class TestCVSNum(unittest.TestCase):
+
+    """CVSNum selftests."""
+
+    def test_basic (self):
+        """CVSNum basic selftests."""
+        self.assertEqual(CVSNum("1.2.4"), CVSNum("1.2.0.4"))
+        self.assert_(CVSNum("1.2.4").is_branch())
+        self.assert_(CVSNum("1.2").is_rev())
+        self.assert_(CVSNum("1").is_branch())
+        self.assert_(CVSNum("1.2.4.6").is_rev())
+        self.assertEqual(CVSNum("1.2.4.6").components(), [1, 2, 4, 6])
+        self.assertEqual(CVSNum.from_components([1, 2, 4, 6]),
+                         CVSNum("1.2.4.6"))
+        self.assertEqual(str(CVSNum.from_components([1, 2, 4, 6])), "1.2.4.6")
+        self.assertEqual(len(CVSNum("1.2.4.6")), 4)
+        self.assertEqual(CVSNum("1.2.4.6").branch(), CVSNum("1.2.4"))
+        self.assertEqual(CVSNum("1.2.4").branch(), CVSNum("1.2.4"))
+        self.assertEqual(CVSNum("1.1").branch(), CVSNum("1"))
+        self.assertEqual(CVSNum("1").branch(), CVSNum("1"))
+        self.assertEqual(CVSNum("1.2.4.6").parent(), CVSNum("1.2.4.5"))
+        self.assertEqual(CVSNum("1.2.4.1").parent(), CVSNum("1.2"))
+        self.assertEqual(CVSNum("1.2").parent(), CVSNum("1.1"))
+        self.assert_(CVSNum("1.1").parent() is None)
+        self.assert_(CVSNum("2.1").parent() is None)
+        self.assertEqual(CVSNum("1.2.4").parent(), CVSNum("1.2"))
+        self.assert_(CVSNum("1").parent() is None)
+        self.assert_(CVSNum("2").parent() is None)
+
+    def test_follows (self):
+        """CVSNum.follows() selftests."""
+        self.assert_(CVSNum("1.2.4.6").follows(CVSNum("1.1")))
+        self.assert_(CVSNum("1.2.4.6").follows(CVSNum("1.2")))
+        self.assert_(CVSNum("1.2.4.6").follows(CVSNum("1.2.4.1")))
+        self.assert_(CVSNum("1.2.4.6").follows(CVSNum("1.2.4.2")))
+        self.assert_(CVSNum("1.2.4.6").follows(CVSNum("1.2.4.3")))
+        self.assert_(CVSNum("1.2.4.6").follows(CVSNum("1.2.4.4")))
+        self.assert_(CVSNum("1.2.4.6").follows(CVSNum("1.2.4.5")))
+        self.assert_(CVSNum("1.2.4.6").follows(CVSNum("1.2.4.6")))
+        self.assertFalse(CVSNum("1.2.4.6").follows(CVSNum("1.2.4.7")))
+        self.assertFalse(CVSNum("1.2.4.6").follows(CVSNum("1.3")))
+        self.assertFalse(CVSNum("1.1").follows(CVSNum("1.2.4.6")))
+
+    def test_disjoint (self):
+        """CVSNum.disjoint() selftests."""
+        tests = [
+            ("1.2", "1.1", False),
+            ("1.2", "1.2", False),
+            ("1.2", "1.3", False),
+            ("1.2", "1.1.2", True),
+            ("1.2", "1.1.2.3", True),
+            ("1.2.4", "1.1", False),
+            ("1.2.4", "1.2", False),
+            ("1.2.4", "1.3", True),
+            ("1.2.4", "1.2.2", True),
+            ("1.2.4", "1.2.4", False),
+            ("1.2.4", "1.2.6", True),
+            ("1.2.4", "1.2.2.4", True),
+            ("1.2.4", "1.2.4.4", False),
+            ("1.2.4", "1.2.6.4", True),
+            ("1.2.4.6", "1.1", False),
+            ("1.2.4.6", "1.2", False),
+            ("1.2.4.6", "1.3", True),
+            ("1.2.4.6", "1.2.2", True),
+            ("1.2.4.6", "1.2.2.1", True),
+            ("1.2.4.6", "1.2.4", False),
+            ("1.2.4.6", "1.2.4.5", False),
+            ("1.2.4.6", "1.2.4.6", False),
+            ("1.2.4.6", "1.2.4.7", False),
+            ("1.2.4.6.8.10", "1.2.4.5", False),
+            ("1.2.4.6.8.10", "1.2.4.6", False),
+            ("1.2.4.6.8.10", "1.2.4.7", True),
+        ]
+        for a, b, result in tests:
+            self.assertEqual(CVSNum.disjoint(CVSNum(a), CVSNum(b)), result)
+            self.assertEqual(CVSNum.disjoint(CVSNum(b), CVSNum(a)), result)
+
+
+class CVSState(object):
+
+    """Encapsulate a historical state in CVS (a set of paths and nums).
+
+    This class is a container of CVS pathnames and associated CVSNum
+    objects.
+
+    No communication with a CVS working directory or repository is done
+    in this class, hence only basic sanity checks are performed:
+      - A path may only appear once in a CVSState.
+      - When adding a path:num pair, path may not already exist in self
+      - When replacing a path:num pair, path must already exist in self
+      - When removing a path:num pair, both path and num must be given
+
+    IMPORTANT: Objects of this class are hash()able (to support being
+    used as keys in a dict), but they are also mutable.  It is
+    therefore up to the caller to make sure that the object is not
+    changed after being stored in a data structure indexed by its hash
+    value.
+
+    """
+
+    __slots__ = ('revs', '_hash')
+
+    def __init__ (self):
+        """Create a new, empty CVSState."""
+        self.revs = {}  # dict: path -> CVSNum object
+        self._hash = None
+
+    def __iter__ (self):
+        """Return iterator traversing the (path, CVSNum)s in this CVSState."""
+        return self.revs.iteritems()
+
+    def __cmp__ (self, other):
+        """Comparison method for CVSState objects."""
+        return cmp(self.revs, other.revs)
+
+    def __str__ (self):
+        """Stringify this CVSState by listing the contained revisions."""
+        return "".join(["%s:%s\n" % (p, n) for p, n in sorted(self)])
+
+    def __hash__ (self):
+        """Create a hash value for this CVSState."""
+        if self._hash is None:
+            self._hash = hash(str(self))
+        return self._hash
+
+    def __getitem__ (self, path):
+        """Return the CVSNum associated with the given path in self."""
+        return self.revs[path]
+
+    def get (self, path, default = None):
+        """Return the CVSNum associated with the given path in self."""
+        return self.revs.get(path, default)
+
+    def paths (self):
+        """Return the path names contained within this CVSState."""
+        return self.revs.iterkeys()
+
+    def add (self, path, revnum):
+        """Add the given path:revnum to this CVSState."""
+        assert path not in self.revs
+        self._hash = None
+        self.revs[path] = revnum
+
+    def replace (self, path, revnum):
+        """Replace the revnum associated with the given path."""
+        assert path in self.revs
+        self._hash = None
+        self.revs[path] = revnum
+
+    def remove (self, path, revnum):
+        """Remove the given path:revnum association from this CVSState."""
+        assert path in self.revs and self.revs[path] == revnum
+        self._hash = None
+        del self.revs[path]
+
+    def copy (self):
+        """Create and return a copy of this object."""
+        ret = CVSState()
+        ret.revs = self.revs.copy()
+        ret._hash = self._hash
+        return ret
+
+    def load_data (self, note_data):
+        """Load note data as formatted by self.__str__()."""
+        for line in note_data.split("\n"):
+            line = line.strip()
+            if not line:
+                continue
+            path, num = line.rsplit(':', 1)
+            self.add(path, CVSNum(num))
+        self._hash = hash(note_data)
+
+    def print_members (self, f = sys.stdout, prefix = ""):
+        """Write the members of this CVSState to the given file object."""
+        for path, num in sorted(self):
+            print >> f, "%s%s:%s" % (prefix, path, num)
+
+    @file_reader_method(missing_ok = True)
+    def load (self, f):
+        """Load CVS state from the given file name/object."""
+        if f:
+            self.load_data(f.read())
+
+    @file_writer_method
+    def save (self, f):
+        """Save CVS state to the given file name/object."""
+        assert f
+        print >> f, str(self),
+
+
+class CVSDate(object):
+
+    """Encapsulate a timestamp, as reported by CVS.
+
+    The internal representation of a timestamp is two integers, the
+    first representing the timestamp as #seconds since epoch (UTC),
+    and the second representing the timezone as #minutes offset from
+    UTC.
+
+    Example: "2007-09-05 17:26:28 -0200" is converted to
+             (1189013188, -120)
+
+    """
+
+    __slots__ = ('ts', 'tz')
+
+    def __init__ (self, date_str = None, in_utc = False):
+        """Convert CVS date string into a CVSDate object.
+
+        A CVS timestamp string has one of the following forms:
+          - "YYYY-MM-DD hh:mm:ss SZZZZ"
+          - "YYYY/MM/DD hh:mm:ss" (with timezone assumed to be UTC)
+        The in_utc parameter determines whether the timestamp part of
+        the given string (the "YYYY-MM-DD hh:mm:ss" part) is given in
+        local time or UTC (normally CVS dates are given in local time.
+        If given in local time, the timezone offset is subtracted from
+        the timestamp in order to make the time in UTC format.
+
+        """
+        if date_str is None:
+            self.ts, self.tz = 0, 0
+            return
+        if date_str == "now":
+            self.ts, self.tz = time.time(), 0
+            return
+        date_str = date_str.strip()
+        # Set up self.ts and self.tz
+        if date_str.count(" ") == 2:
+            # Assume format "YYYY-MM-DD hh:mm:ss SZZZZ"
+            t, z = date_str.rsplit(" ", 1)
+            # Convert timestamp to #secs since epoch (UTC)
+            self.ts = timegm(time.strptime(t, "%Y-%m-%d %H:%M:%S"))
+            # Convert timezone into #mins offset from UTC
+            self.tz = int(z[1:3]) * 60 + int(z[3:5])
+            # Incorporate timezone sign
+            if z[0] == '-':
+                self.tz *= -1
+        else:
+            assert date_str.count(" ") == 1
+            # Assume format "YYYY/MM/DD hh:mm:ss"
+            self.ts = timegm(time.strptime(date_str, "%Y/%m/%d %H:%M:%S"))
+            self.tz = 0
+        # Adjust timestamp if not already in UTC
+        if not in_utc:
+            self.ts -= self.tz * 60
+
+    def tz_str (self):
+        """Return timezone part of self in string format."""
+        sign = '+'
+        if self.tz < 0:
+            sign = '-'
+        hours, minutes = divmod(abs(self.tz), 60)
+        return "%s%02d%02d" % (sign, hours, minutes)
+
+    def __str__ (self):
+        """Reconstruct date string from members."""
+        s = time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime(self.ts))
+        return "%s %s" % (s, self.tz_str())
+
+    def __repr__ (self):
+        """Create a string representation of self."""
+        return "CVSDate('%s')" % (str(self))
+
+    def __hash__ (self):
+        """Create a hash value from self."""
+        return hash((self.ts, self.tz))
+
+    def __nonzero__ (self):
+        """Provide interpretation of self in a boolean context."""
+        return bool(self.ts or self.tz)
+
+    def __cmp__ (self, other):
+        """Comparison method for CVSDate objects."""
+        return cmp(self.ts, other.ts) or cmp(self.tz, other.tz)
+
+    def __eq__ (self, other):
+        """Return True iff self and other is considered equal."""
+        return self.ts == other.ts and self.tz == other.tz
+
+    def diff (self, other):
+        """Return difference between self and other in #seconds.
+
+        Invariant: self == other.add(self.diff(other))
+
+        """
+        return self.ts - other.ts
+
+
+class TestCVSDate(unittest.TestCase):
+
+    """CVSDate selftests."""
+
+    def test_basic (self):
+        """CVSDate basic selftests."""
+        a = CVSDate("2009-05-10 14:34:56 +0200")
+        b = CVSDate("2009/05/10 12:34:56")
+        self.assert_(a)
+        self.assert_(b)
+        self.assertEqual(str(a), "2009-05-10 12:34:56 +0200", str(a))
+        self.assertEqual(str(b), "2009-05-10 12:34:56 +0000", str(b))
+        self.assertNotEqual(a, b)
+        self.assertEqual(a.diff(b), 0)
+        c = CVSDate("2009-05-10 16:34:56 +0200")
+        self.assert_(c)
+        self.assertEqual(str(c), "2009-05-10 14:34:56 +0200", str(c))
+        self.assertNotEqual(c, a)
+        self.assertEqual(c.diff(a), 2 * 60 * 60)
+        self.assertEqual(a.diff(c), -2 * 60 * 60)
+
+
+class CVSRev(object):
+
+    """Encapsulate metadata on a CVS revision."""
+
+    __slots__ = ('path', 'num', 'date', 'author', 'deleted', 'message')
+
+    def __init__ (self, path, num):
+        """Create a CVSRev object for the given path:num revision."""
+        self.path = path
+        self.num = num
+        self.date = None  # CVSDate object
+        self.author = ""
+        self.deleted = None  # True or False
+        self.message = []  # Lines of commit message
+
+    def __str__ (self):
+        """Return a string listing the metadata in this CVS revision."""
+        return ("<%s:%s on %s by %s%s>" %
+                (self.path, self.num, self.date, self.author,
+                 self.deleted and ", deleted" or ""))
+
+    def __cmp__ (self, other):
+        """Comparison method for CVSRev objects."""
+        return cmp(self.path, other.path) or cmp(self.num, other.num)
+
+
+class CVSWorkDir(object):
+
+    """Encapsulate a CVS working directory.
+
+    This class auto-creates a CVS workdir/checkout in the directory
+    given to the constructor, and provides various methods for
+    interacting with this workdir.
+
+    """
+
+    def __init__ (self, workdir, cvs_repo):
+        """Create a new CVSWorkDir.
+
+        The cvs_repo argument must be a (cvs_root, cvs_module) tuple
+
+        """
+        self.d = workdir
+        self.cvs_root, self.cvs_module = cvs_repo
+        parent_dir = os.path.dirname(self.d)
+        if not os.path.isdir(parent_dir):
+            os.makedirs(parent_dir)
+        self._valid = None
+
+    def makepath(self, *args):
+        """Create path relative to working directory."""
+        return os.path.join(self.d, *args)
+
+    def valid (self):
+        """Return True iff this workdir is present and valid."""
+        if self._valid is not None:
+            return self._valid
+        try:
+            f = open(self.makepath("CVS", "Root"), 'r')
+            assert f.read().strip() == self.cvs_root
+            f.close()
+            f = open(self.makepath("CVS", "Repository"), 'r')
+            assert f.read().strip() == self.cvs_module
+            f.close()
+            self._valid = True
+        except (IOError, AssertionError):
+            self._valid = False
+        return self._valid
+
+    def remove (self):
+        """Remove this checkout."""
+        shutil.rmtree(self.d, True)
+        assert not os.path.exists(self.d)
+        self._valid = False
+
+    def checkout (self, revision = "HEAD"):
+        """Create a checkout of the given revision."""
+        self.remove()
+        parent_dir, co_dir = os.path.split(self.d)
+        args = ["cvs", "-f", "-Q", "-d", self.cvs_root, "checkout"]
+        if str(revision) != "HEAD":
+            args.extend(["-r", str(revision)])
+        args.extend(["-d", co_dir, self.cvs_module])
+        exit_code, output, errors = run_command(args, cwd = parent_dir)
+        if exit_code:
+            die("Failed to checkout CVS working directory")
+        assert not errors
+        assert not output, "output = '%s'" % (output)
+        self._valid = None
+        assert self.valid()
+
+    def update (self, revision = "HEAD", paths = None):
+        """Update the given paths to the given revision."""
+        if not self.valid():
+            self.checkout()
+        args = ["cvs", "-f", "-Q", "update", "-kk"]
+        if str(revision) == "HEAD":
+            args.append("-A")
+        else:
+            args.extend(["-r", str(revision)])
+        if paths is not None:
+            args.extend(paths)
+        exit_code, output, errors = run_command(args, cwd = self.d)
+        if exit_code:
+            die("Failed to checkout CVS working directory")
+        assert not errors
+        assert not output, "output = '%s'" % (output)
+
+    def get_revision_data (self, path, revision):
+        """Return the contents of the given CVS path:revision."""
+        if not self.valid():
+            self.checkout()
+        args = ["cvs", "-f", "-Q", "update", "-p", "-kk"]
+        if str(revision) == "HEAD":
+            args.append("-A")
+        else:
+            args.extend(["-r", str(revision)])
+        args.append(path)
+        exit_code, output, errors = run_command(args, cwd = self.d)
+        if exit_code:
+            die("Failed to checkout CVS working directory")
+        assert not errors
+        return output
+
+    def get_modeinfo (self, paths = None):
+        """Return mode information for the given paths.
+
+        Returns a dict of path -> mode number mappings.  If paths are
+        not specified, mode information for all files in the current
+        checkout will be returned.  No checkout/update will be done.
+
+        """
+        result = {}
+        if paths is not None:
+            for path in paths:
+                fullpath = os.path.join(self.d, path)
+                mode = 644
+                if os.access(fullpath, os.X_OK):
+                    mode = 755
+                assert path not in result
+                result[path] = mode
+        else:  # Return mode information for all paths
+            for dirpath, dirnames, filenames in os.walk(self.d):
+                # Don't descend into CVS subdirs
+                try:
+                    dirnames.remove('CVS')
+                except ValueError:
+                    pass
+                assert dirpath.startswith(self.d)
+                directory = dirpath[len(self.d):].lstrip("/")
+                for fname in filenames:
+                    path = os.path.join(directory, fname)
+                    fullpath = os.path.join(dirpath, fname)
+                    mode = 644
+                    if os.access(fullpath, os.X_OK):
+                        mode = 755
+                    assert path not in result
+                    result[path] = mode
+        return result
+
+    @classmethod
+    def parse_entries (cls, entries, prefix, directory = ""):
+        """Recursively parse CVS/Entries files.
+
+        Return a dict of CVS paths found by parsing the CVS/Entries
+        files rooted at the given directory.
+
+        See http://ximbiot.com/cvs/manual/feature/cvs_2.html#SEC19 for
+        information on the format of the CVS/Entries file.
+
+        """
+        fname = os.path.join(prefix, directory, "CVS", "Entries")
+        subdirs = []
+        f = open(fname, 'r')
+        for line in f:
+            line = line.strip()
+            if line == "D":
+                continue  # There are no subdirectories
+            t, path, revnum, date, options, tag = line.split("/")
+            if t == "D":
+                subdirs.append(path)
+                continue
+            assert line.startswith("/")
+            path = os.path.join(directory, path)
+            revnum = CVSNum(revnum)
+            assert path not in entries
+            entries[path] = (revnum, date, options, tag)
+        f.close()
+        for d in subdirs:
+            d = os.path.join(directory, d)
+            cls.parse_entries(entries, prefix, d)
+
+    def get_state (self):
+        """Return CVSState reflecting current state of this checkout.
+
+        Note that the resulting CVSState will never contain any
+        deleted/dead files.  Other CVSStates to be compared to the one
+        returned from here should remove deleted/dead entries first.
+
+        """
+        assert self.valid()
+        entries = {}
+        result = CVSState()
+        self.parse_entries(entries, self.d)
+        for path, info in entries.iteritems():
+            result.add(path, info[0])
+        return result
+
+
+class CVSLogParser(object):
+
+    """Encapsulate the execution of a "cvs rlog" command."""
+
+    def __init__ (self, cvs_repo):
+        """Create a new CVSLogParser.
+
+        The cvs_repo argument must be a (cvs_root, cvs_module) tuple
+
+        """
+        self.cvs_root, self.cvs_module = cvs_repo
+
+    def cleanup_path (self, cvs_path):
+        """Utility method for parsing CVS paths from CVS log."""
+        cvsprefix = "/".join((self.cvs_root[self.cvs_root.index("/"):],
+                              self.cvs_module))
+        assert cvs_path.startswith(cvsprefix)
+        assert cvs_path.endswith(",v")
+        # Drop cvsprefix and ,v-extension
+        cvs_path = cvs_path[len(cvsprefix):-2]
+        # Split the remaining path into components
+        path_comps = filter(None, cvs_path.strip().split('/'))
+        # Remove 'Attic' from CVS paths
+        if len(path_comps) >= 2 and path_comps[-2] == "Attic":
+            del path_comps[-2]
+        # Reconstruct resulting "cleaned" path
+        return "/".join(path_comps)
+
+    def __call__ (self, line):
+        """Parse the given line from the CVS log.
+
+        Must be reimplemented by subclass
+
+        """
+        pass
+
+    def finish (self):
+        """This method is invoked after the last line has been parsed.
+
+        May be reimplemented by subclass
+
+        """
+        pass
+
+    def run (self, paths = None, no_symbols = False, revisions = None):
+        """Execute "cvs rlog" with the given arguments.
+
+        self.__call__() is invoked once for each line in the CVS log.
+        self.finish() is invoked exactly once after the CVS log.
+
+        """
+        args = ["cvs", "-f", "-q", "-d", self.cvs_root, "rlog"]
+        if no_symbols:
+            args.append("-N")
+        if revisions:
+            args.append("-r%s" % (revisions))
+        if paths is not None:
+            for p in paths:
+                args.append("%s/%s" % (self.cvs_module, p))
+        else:
+            args.append(self.cvs_module)
+        proc = start_command(args)
+        proc.stdin.close()
+        while True:
+            for line in proc.stdout:
+                self(line.rstrip())  # Call self's line parser
+            if proc.poll() is not None:
+                break
+        assert proc.stdout.read() == ""
+        self.finish()  # Notify subclass that parsing is finished
+        exit_code = proc.returncode
+        if exit_code:
+            error("'%s' returned exit code %i, and errors:\n---\n%s---",
+                  " ".join(args), exit_code, proc.stderr.read())
+        return exit_code
+
+
+class CVSRevLister(CVSLogParser):
+
+    """Extract CVSRev objects (with revision metadata) from a CVS log."""
+
+    def __init__ (self, cvs_repo, show_progress = False):
+        """Create a new CVSRevLister.
+
+        The cvs_repo argument must be a (cvs_root, cvs_module) tuple
+        show_progress determines whether progress indication is shown.
+
+        """
+        super(CVSRevLister, self).__init__(cvs_repo)
+        self.cur_file = None  # Current CVS file being processed
+        self.cur_file_numrevs = 0  # #revs in current CVS file
+        self.cur_rev = None  # Current CVSRev under construction
+        self.progress = None
+        if show_progress:
+            self.progress = ProgressIndicator("\t", sys.stderr)
+        # Store found revs in a two-level dict structure:
+        # filename -> revnum -> CVSRev
+        self.revs = {}
+        # Possible states:
+        # - BeforeRevs  - waiting for "total revisions:"
+        # - BetweenRevs - waiting for "----------------------------"
+        # - ReadingRev  - reading CVS revision details
+        self.state = 'BeforeRevs'
+
+    def __call__ (self, line):
+        """Line parser; this method is invoked for each line in the log."""
+        if self.state == 'BeforeRevs':
+            if line.startswith("RCS file: "):
+                self.cur_file = self.cleanup_path(line[10:])
+                assert self.cur_file not in self.revs
+                self.revs[self.cur_file] = {}
+            elif line.startswith("total revisions: "):
+                assert self.cur_file
+                totalrevs_unused, selectedrevs = line.split(";")
+                self.cur_file_numrevs = int(selectedrevs.split(":")[1].strip())
+                self.state = 'BetweenRevs'
+        elif self.state == 'BetweenRevs':
+            if (line == "----------------------------" or
+                line == "======================================"
+                        "======================================="):
+                if self.cur_rev:
+                    # Finished current revision
+                    f = self.revs[self.cur_file]
+                    assert self.cur_rev.num not in f
+                    f[self.cur_rev.num] = self.cur_rev
+                    self.cur_rev = None
+                    if self.progress:
+                        self.progress()
+                if line == "----------------------------":
+                    self.state = 'ReadingRev'
+                else:
+                    # Finalize current CVS file
+                    assert len(self.revs[self.cur_file]) == \
+                           self.cur_file_numrevs
+                    self.cur_file = None
+                    self.state = 'BeforeRevs'
+            elif self.cur_rev:
+                # Currently in the middle of a revision.
+                if line.startswith("branches:  %s" % (self.cur_rev.num)) and \
+                   line.endswith(";"):
+                    return  # Skip 'branches:' lines
+                # This line is part of the commit message.
+                self.cur_rev.message.append(line)
+        elif self.state == 'ReadingRev':
+            if line.startswith("revision "):
+                self.cur_rev = CVSRev(self.cur_file, CVSNum(line.split()[1]))
+            else:
+                date, author, state, dummy = line.split(";", 3)
+                assert date.startswith("date: ")
+                self.cur_rev.date = CVSDate(date[6:])
+                assert author.strip().startswith("author: ")
+                self.cur_rev.author = author.strip()[8:]
+                assert state.strip().startswith("state: ")
+                state = state.strip()[7:]
+                self.cur_rev.deleted = state == "dead"
+                self.state = 'BetweenRevs'
+
+    def finish (self):
+        """This method is invoked after the last line has been parsed."""
+        assert self.state == 'BeforeRevs'
+        if self.progress:
+            self.progress.finish("Parsed %i revs in %i files" %
+                                 (self.progress.n, len(self.revs)))
+
+
+def fetch_revs (path, from_rev, to_rev, symbol, cvs_repo):
+    """Fetch CVSRevs for each rev in <path:from_rev, path:symbol].
+
+    Return a dict of CVSRev objects (revnum -> CVSRev), where each
+    CVSRev encapsulates a CVS revision in the range from
+    path:from_rev to path:symbol (inclusive).  If symbol currently
+    refers to from_rev (i.e. nothing has happened since the last
+    import), the returned dict will have exactly one entry (from_rev).
+    If there is no valid revision range between from_rev and symbol,
+    the returned dict will be empty.  Situations in which an empty dict
+    is returned, include:
+    - symbol is no longer defined on this path
+    - symbol refers to a revision that is disjoint from from_rev
+
+    from_rev may be None, meaning that all revisions from the initial
+    version of path up to the revision currently referenced by symbol
+    should be fetched.
+
+    If the revision currently referenced by symbol is disjoint from
+    from_rev, the returned dict will be empty.
+
+    Note that there is lots of unexpected behaviour in the handling of
+    the 'cvs rlog -r' parameter: Say you have a branch, called
+    'my_branch', that points to branch number 1.1.2 of a file.  Say
+    there are 3 revisions on this branch: 1.1.2.1 -> 1.1.2.3 (in
+    additions to the branch point 1.1).  Now, observe the following
+    'cvs rlog' executions:
+    - cvs rlog -r0:my_branch ... returns 1.1, 1.1.2.1, 1.1.2.2, 1.1.2.3
+    - cvs rlog -r1.1:my_branch ... returns the same revs
+    - cvs rlog -rmy_branch ... returns 1.1.2.1, 1.1.2.2, 1.1.2.3
+    - cvs rlog -rmy_branch: ... returns the same revs
+    - cvs rlog -r:my_branch ... returns the same revs
+    - cvs rlog -r::my_branch ... returns the same revs
+    - cvs rlog -r1.1.2.1: ... returns the same revs
+    Here is where it gets really weird:
+    - cvs rlog -r1.1.2.1:my_branch ... returns 1.1.2.1 only
+    - cvs rlog -r1.1.2.2:my_branch ... returns 1.1.2.1, 1.1.2.2
+    - cvs rlog -r1.1.2.3:my_branch ... returns 1.1.2.1, 1.1.2.2, 1.1.2.3
+
+    In other words the 'cvs rlog -rfrom_rev:symbol' scheme that we
+    normally use will not work in the case where from_rev is _on_ the
+    branch pointed at by the symbol.
+
+    Therefore, we need an extra parameter, to_rev, which we can use to:
+    1. Detect when this situation is present.
+    2. Work around by using 'cvs rlog -rfrom_ref:to_rev' instead.
+
+    """
+    if from_rev is None:  # Initial import
+        from_rev = "0"  # "cvs rlog -r0:X" fetches from initial revision
+    elif to_rev and to_rev.branch() == from_rev.branch():
+        symbol = to_rev  # Use to_rev instead of given symbol
+    # Run 'cvs rlog' on range [from_rev, symbol] and parse CVSRev objects
+    parser = CVSRevLister(cvs_repo)
+    parser.run((path,), True, "%s:%s" % (from_rev, symbol))
+    assert len(parser.revs) == 1
+    assert path in parser.revs
+    return parser.revs[path]
+
+
+if __name__ == '__main__':
+    unittest.main()
diff --git a/git_remote_cvs/cvs_symbol_cache.py b/git_remote_cvs/cvs_symbol_cache.py
new file mode 100644
index 0000000..cc8d88b
--- /dev/null
+++ b/git_remote_cvs/cvs_symbol_cache.py
@@ -0,0 +1,313 @@
+#!/usr/bin/env python
+
+"""Implementation of a local CVS symbol cache.
+
+A CVS symbol cache stores a list of CVS symbols and the CVS state
+associated with each of those CVS symbols at some point in time.
+
+Keeping a local cache of CVS symbols is often needed because the
+design of CVS makes it potentially very expensive to query the CVS
+server directly for CVS symbols and associated states.
+
+In these cases, a local CVS symbol cache can provide equivalent
+(although possibly out-of-date) information immediatele.
+
+Synchronization with the current state on the CVS server can be
+done on a symbol-by-symbol basis (by checking out a given symbol
+and extracting the CVS state from the CVS work tree), or by
+synchronizing _all_ CVS symbols in one operation (by executing
+'cvs rlog' and parsing CVS states from its output).
+
+"""
+
+import sys
+import os
+
+from git_remote_cvs.util import debug, error, die, ProgressIndicator
+from git_remote_cvs.cvs import CVSNum, CVSState, CVSLogParser
+
+
+class CVSSymbolStateLister(CVSLogParser):
+
+    """Extract current CVSStates for all CVS symbols from a CVS log."""
+
+    def __init__ (self, cvs_repo, show_progress = False):
+        """Create a new CVSSymbolStateLister.
+
+        The cvs_repo argument must be a (cvs_root, cvs_module) tuple
+        show_progress determines whether a progress indicator should
+        be displayed.
+
+        """
+        super(CVSSymbolStateLister, self).__init__(cvs_repo)
+        self.symbols = {}  # CVS symbol name -> CVSState object
+        self.cur_file = None  # current CVS file being processed
+        self.cur_file_numrevs = 0  # #revs in current CVS file
+        self.cur_revnum = None  # current revision number
+        self.rev2syms = {}  # CVSNum -> [CVS symbol names]
+        self.cur_revs = {}  # CVSNum -> True/False (deleted)
+        self.head_num = None  # CVSNum of the HEAD rev or branch
+
+        # Possible states:
+        # - BeforeSymbols - waiting for "symbolic names:"
+        # - WithinSymbols - reading CVS symbol names
+        # - BeforeRevs  - waiting for "total revisions:"
+        # - BetweenRevs - waiting for "----------------------------"
+        # - ReadingRev  - reading CVS revision details
+        self.state = 'BeforeSymbols'
+
+        self.progress = None
+        if show_progress:
+            self.progress = ProgressIndicator("\t", sys.stderr)
+
+    def finalize_symbol_states (self):
+        """Adjust CVSStates in self.symbols based on revision data.
+
+        Based on the information found in self.rev2syms and
+        self.cur_revs, remove deleted revisions and turn branch numbers
+        into corresponding revisions in the CVSStates found in
+        self.symbols.
+
+        """
+        # Create a mapping from branch numbers to the last existing
+        # revision number on those branches
+        branch2lastrev = {}  # branch number -> revision number
+        for revnum in self.cur_revs.iterkeys():
+            branchnum = revnum.branch()
+            if (branchnum not in branch2lastrev) or \
+               (revnum > branch2lastrev[branchnum]):
+                branch2lastrev[branchnum] = revnum
+
+        for cvsnum, symbols in self.rev2syms.iteritems():
+            if cvsnum.is_branch():
+                # Turn into corresponding revision number
+                revnum = branch2lastrev.get(cvsnum, cvsnum.parent())
+                for s in symbols:
+                    state = self.symbols[s]
+                    assert state[self.cur_file] == cvsnum
+                    state.replace(self.cur_file, revnum)
+                cvsnum = revnum
+            assert cvsnum.is_rev()
+            assert cvsnum in self.cur_revs
+            if self.cur_revs[cvsnum]:  # cvsnum is a deleted rev
+                # Remove from CVSStates
+                for s in symbols:
+                    state = self.symbols[s]
+                    state.remove(self.cur_file, cvsnum)
+
+        self.rev2syms = {}
+        self.cur_revs = {}
+        self.cur_file = None
+
+    def __call__ (self, line):
+        """Line parser; this method is invoked for each line in the log."""
+        if self.state == 'BeforeSymbols':
+            if line.startswith("RCS file: "):
+                self.cur_file = self.cleanup_path(line[10:])
+                if self.progress:
+                    self.progress("%5i symbols found - Parsing CVS file #%i: "
+                                  "%s " % (len(self.symbols), self.progress.n,
+                                           self.cur_file,))
+            if line.startswith("head: "):
+                self.head_num = CVSNum(line[6:])
+            if line.startswith("branch: "):
+                self.head_num = CVSNum(line[8:])
+            elif line == "symbolic names:":
+                assert self.head_num
+                s = self.symbols.setdefault("HEAD", CVSState())
+                s.add(self.cur_file, self.head_num)
+                r = self.rev2syms.setdefault(self.head_num, [])
+                r.append("HEAD")
+                self.head_num = None
+                self.state = 'WithinSymbols'
+        elif self.state == 'WithinSymbols':
+            if line.startswith("\t"):
+                symbol, cvsnum = line.split(":", 1)
+                symbol = symbol.strip()
+                cvsnum = CVSNum(cvsnum)
+                s = self.symbols.setdefault(symbol, CVSState())
+                s.add(self.cur_file, cvsnum)
+                r = self.rev2syms.setdefault(cvsnum, [])
+                r.append(symbol)
+            else:
+                self.state = 'BeforeRevs'
+        elif self.state == 'BeforeRevs':
+            if line.startswith("total revisions: "):
+                assert self.cur_file
+                totalrevs_unused, selectedrevs = line.split(";")
+                self.cur_file_numrevs = int(selectedrevs.split(":")[1].strip())
+                self.state = 'BetweenRevs'
+        elif self.state == 'BetweenRevs':
+            if (line == "----------------------------" or
+                line == "======================================"
+                        "======================================="):
+                if self.cur_revnum:
+                    assert self.cur_revnum in self.cur_revs
+                    self.cur_revnum = None
+                if line == "----------------------------":
+                    self.state = 'ReadingRev'
+                else:
+                    # Finalize current CVS file
+                    assert len(self.cur_revs) == self.cur_file_numrevs
+                    self.finalize_symbol_states()
+                    self.state = 'BeforeSymbols'
+        elif self.state == 'ReadingRev':
+            if line.startswith("revision "):
+                self.cur_revnum = CVSNum(line.split()[1])
+            else:
+                date, author, state, dummy = line.split(";", 3)
+                assert date.startswith("date: ")
+                assert author.strip().startswith("author: ")
+                assert state.strip().startswith("state: ")
+                state = state.strip()[7:]
+                assert self.cur_revnum not in self.cur_revs
+                deleted = state == "dead"
+                self.cur_revs[self.cur_revnum] = deleted
+                self.state = 'BetweenRevs'
+
+    def finish (self):
+        """This method is invoked after the last line has been parsed."""
+        assert self.state == 'BeforeSymbols'
+        if self.progress:
+            self.progress.finish("Parsed %i symbols in %i files" %
+                                 (len(self.symbols), self.progress.n))
+
+
+class CVSSymbolCache(object):
+
+    """Local cache of the current CVSState of CVS symbols.
+
+    Simulates a dictionary of CVS symbol -> CVSState mappings.
+
+    """
+
+    def __init__ (self, symbols_dir):
+        """Create a new CVS symbol cache, located in the given directory."""
+        self.symbols_dir = symbols_dir
+        if not os.path.isdir(self.symbols_dir):
+            os.makedirs(self.symbols_dir)
+
+    def __len__ (self):
+        """Return the number of CVS symbols stored in this cache."""
+        return len(os.listdir(self.symbols_dir))
+
+    def __iter__ (self):
+        """Return an iterator traversing symbol names stored in this cache."""
+        for filename in os.listdir(self.symbols_dir):
+            yield filename
+
+    def __contains__ (self, symbol):
+        """Return True if the given symbol is present in this cache."""
+        return os.access(os.path.join(self.symbols_dir, symbol),
+                         os.F_OK | os.R_OK)
+
+    def __getitem__ (self, symbol):
+        """Return the cached CVSState of the given CVS symbol."""
+        try:
+            f = open(os.path.join(self.symbols_dir, symbol), 'r')
+        except IOError:
+            raise KeyError("'%s'" % (symbol))
+        ret = CVSState()
+        ret.load(f)
+        f.close()
+        return ret
+
+    def __setitem__ (self, symbol, cvs_state):
+        """Store the given CVS symbol and CVSState into the cache."""
+        cvs_state.save(os.path.join(self.symbols_dir, symbol))
+
+    def __delitem__ (self, symbol):
+        """Remove the the given CVS symbol from the cache."""
+        os.remove(os.path.join(self.symbols_dir, symbol))
+
+    def get (self, symbol, default = None):
+        """Return the cached CVSState of the given CVS symbol."""
+        try:
+            return self[symbol]
+        except KeyError:
+            return default
+
+    def items (self):
+        """Return list of (CVS symbol, CVSState) tuples saved in this cache."""
+        for filename in self:
+            yield (filename, self[filename])
+
+    def clear (self):
+        """Remove all entries from this CVS symbol cache."""
+        for filename in os.listdir(self.symbols_dir):
+            os.remove(os.path.join(self.symbols_dir, filename))
+
+    def sync_symbol (self, symbol, cvs, progress):
+        """Synchronize the given CVS symbol with the CVS server.
+
+        The given CVS workdir is used for the synchronization.
+        The retrieved CVSState is also returned
+
+        """
+        progress("Retrieving state of CVS symbol '%s'..." % (symbol))
+        cvs.update(symbol)
+        state = cvs.get_state()
+
+        progress("Saving state of '%s' to symbol cache..." % (symbol))
+        self[symbol] = state
+
+    def sync_all_symbols (self, cvs_repo, progress, symbol_filter = None):
+        """Synchronize this entire CVS symbol cache with the CVS server.
+
+        This may be very expensive if the CVS repository is large, or
+        has many symbols.  After this method returns, the symbol cache
+        will be in sync with the current state on the server.
+
+        This method returns a dict with the keys 'unchanged',
+        'changed', 'added', and 'deleted', where each map to a list of
+        CVS symbols.  Each CVS symbol appears in exactly one of these
+        lists.
+
+        If symbol_filter is given, it specifies functions that takes
+        one parameter - a CVS symbol name - and returns True if that
+        symbol should be synchronized, and False if that symbol should
+        be skipped.  Otherwise all CVS symbols are synchronized.
+
+        """
+        if symbol_filter is None:
+            symbol_filter = lambda symbol: True
+
+        # Run cvs rlog to fetch current CVSState for all CVS symbols
+        progress("Retrieving current state of all CVS symbols from CVS "
+                 "server...", lf = True)
+        parser = CVSSymbolStateLister(cvs_repo, True)
+        retcode = parser.run()
+        if retcode:
+            raise EnvironmentError(retcode, "cvs rlog exit code %i" % retcode)
+
+        # Update symbol cache with new states from the CVS server
+        progress("Updating symbol cache with current CVS state...")
+        results = {}
+        result_keys = ("unchanged", "changed", "added", "deleted")
+        for k in result_keys:
+            results[k] = []
+        # Classify existing symbols as unchanged, changed, or deleted
+        for symbol in filter(symbol_filter, self):
+            if symbol not in parser.symbols:  # Deleted
+                results["deleted"].append(symbol)
+                del self[symbol]
+            elif self[symbol] != parser.symbols[symbol]:  # Changed
+                results["changed"].append(symbol)
+                self[symbol] = parser.symbols[symbol]
+            else:  # Unchanged
+                results["unchanged"].append(symbol)
+            progress()
+        # Add symbols that are not in self
+        for symbol, state in parser.symbols.iteritems():
+            if not symbol_filter(symbol):
+                debug("Skipping CVS symbol '%s'...", symbol)
+            elif symbol in self:
+                assert state == self[symbol]
+            else:  # Added
+                results["added"].append(symbol)
+                self[symbol] = state
+            progress()
+        progress("Synchronized local symbol cache (%s)" %
+                 (", ".join(["%i %s" % (len(results[k]), k)
+                             for k in result_keys])), True)
+        return results
diff --git a/git_remote_cvs/util.py b/git_remote_cvs/util.py
new file mode 100644
index 0000000..7d6adb4
--- /dev/null
+++ b/git_remote_cvs/util.py
@@ -0,0 +1,186 @@
+#!/usr/bin/env python
+
+"""Misc. useful functionality used by the rest of this package.
+
+This module provides common functionality used by the other modules in
+this package.
+
+"""
+
+import sys
+import os
+import subprocess
+
+
+# Whether or not to show debug messages
+DEBUG = False
+
+def debug (msg, *args):
+    """Print a debug message to stderr when DEBUG is enabled."""
+    if DEBUG:
+        print >> sys.stderr, msg % args
+
+def error (msg, *args):
+    """Print an error message to stderr."""
+    print >> sys.stderr, "ERROR:", msg % args
+
+def die (msg, *args):
+    """Print as error message to stderr and exit the program."""
+    error(msg, *args)
+    sys.exit(1)
+
+
+class ProgressIndicator(object):
+
+    """Simple progress indicator.
+
+    Displayed as a spinning character by default, but can be customized
+    by passing custom messages that overrides the spinning character.
+
+    """
+
+    States = ("|", "/", "-", "\\")
+
+    def __init__ (self, prefix = "", f = sys.stdout):
+        """Create a new ProgressIndicator, bound to the given file object."""
+        self.n = 0  # Simple progress counter
+        self.f = f  # Progress is written to this file object
+        self.prev_len = 0  # Length of previous msg (to be overwritten)
+        self.prefix = prefix  # Prefix prepended to each progress message
+        self.prefix_lens = [] # Stack of prefix string lengths
+
+    def pushprefix (self, prefix):
+        """Append the given prefix onto the prefix stack."""
+        self.prefix_lens.append(len(self.prefix))
+        self.prefix += prefix
+
+    def popprefix (self):
+        """Remove the last prefix from the prefix stack."""
+        prev_len = self.prefix_lens.pop()
+        self.prefix = self.prefix[:prev_len]
+
+    def __call__ (self, msg = None, lf = False):
+        """Indicate progress, possibly with a custom message."""
+        if msg is None:
+            msg = self.States[self.n % len(self.States)]
+        msg = self.prefix + msg
+        print >> self.f, "\r%-*s" % (self.prev_len, msg),
+        self.prev_len = len(msg.expandtabs())
+        if lf:
+            print >> self.f
+            self.prev_len = 0
+        self.n += 1
+
+    def finish (self, msg = "done", noprefix = False):
+        """Finalize progress indication with the given message."""
+        if noprefix:
+            self.prefix = ""
+        self(msg, True)
+
+
+def start_command (args, cwd = None, shell = False, add_env = None,
+                   stdin = subprocess.PIPE, stdout = subprocess.PIPE,
+                   stderr = subprocess.PIPE):
+    """Start the given command, and return a subprocess object.
+
+    This provides a simpler interface to the subprocess module.
+
+    """
+    env = None
+    if add_env is not None:
+        env = os.environ.copy()
+        env.update(add_env)
+    return subprocess.Popen(args, bufsize = 1, stdin = stdin, stdout = stdout,
+                            stderr = stderr, cwd = cwd, shell = shell,
+                            env = env, universal_newlines = True)
+
+
+def run_command (args, cwd = None, shell = False, add_env = None,
+                 flag_error = True):
+    """Run the given command to completion, and return its results.
+
+    This provides a simpler interface to the subprocess module.
+
+    The results are formatted as a 3-tuple: (exit_code, output, errors)
+
+    If flag_error is enabled, Error messages will be produced if the
+    subprocess terminated with a non-zero exit code and/or stderr
+    output.
+
+    The other arguments are passed on to start_command().
+
+    """
+    process = start_command(args, cwd, shell, add_env)
+    (output, errors) = process.communicate()
+    exit_code = process.returncode
+    if flag_error and errors:
+        error("'%s' returned errors:\n---\n%s---", " ".join(args), errors)
+    if flag_error and exit_code:
+        error("'%s' returned exit code %i", " ".join(args), exit_code)
+    return (exit_code, output, errors)
+
+
+def file_reader_method (missing_ok = False):
+    """Decorator for simplifying reading of files.
+
+    If missing_ok is True, a failure to open a file for reading will
+    not raise the usual IOError, but instead the wrapped method will be
+    called with f == None.  The method must in this case properly
+    handle f == None.
+
+    """
+    def _wrap (method):
+        """Teach given method to handle both filenames and file objects.
+
+        The given method must take a file object as its second argument
+        (the first argument being 'self', of course).  This decorator
+        will take a filename given as the second argument and promote
+        it to a file object.
+
+        """
+        def _wrapped_method (self, filename, *args, **kwargs):
+            if isinstance(filename, file):
+                f = filename
+            else:
+                try:
+                    f = open(filename, 'r')
+                except IOError:
+                    if missing_ok:
+                        f = None
+                    else:
+                        raise
+            try:
+                return method(self, f, *args, **kwargs)
+            finally:
+                if not isinstance(filename, file) and f:
+                    f.close()
+        return _wrapped_method
+    return _wrap
+
+
+def file_writer_method (method):
+    """Decorator for simplifying writing of files.
+
+    Enables the given method to handle both filenames and file objects.
+
+    The given method must take a file object as its second argument
+    (the first argument being 'self', of course).  This decorator will
+    take a filename given as the second argument and promote it to a
+    file object.
+
+    """
+    def _new_method (self, filename, *args, **kwargs):
+        if isinstance(filename, file):
+            f = filename
+        else:
+            # Make sure the containing directory exists
+            parent_dir = os.path.dirname(filename)
+            if not os.path.isdir(parent_dir):
+                os.makedirs(parent_dir)
+            f = open(filename, 'w')
+        try:
+            return method(self, f, *args, **kwargs)
+        finally:
+            if not isinstance(filename, file):
+                f.close()
+    return _new_method
-- 
1.6.4.262.gca66a.dirty
