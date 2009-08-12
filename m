From: Johan Herland <johan@herland.net>
Subject: [RFCv3 2/4] Add Python support library for CVS remote helper
Date: Wed, 12 Aug 2009 02:13:49 +0200
Message-ID: <1250036031-32272-3-git-send-email-johan@herland.net>
References: <1250036031-32272-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Johan Herland <johan@herland.net>, barkalow@iabervon.org,
	gitster@pobox.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 12 02:14:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb1U8-00078w-7T
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 02:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754867AbZHLAOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2009 20:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754831AbZHLAOW
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 20:14:22 -0400
Received: from smtp.getmail.no ([84.208.15.66]:52206 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754676AbZHLAOR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 20:14:17 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO800DGCLZT8E10@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 12 Aug 2009 02:14:17 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO8000BCLZHU410@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Wed, 12 Aug 2009 02:14:17 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.12.47
X-Mailer: git-send-email 1.6.4.rc3.138.ga6b98.dirty
In-reply-to: <1250036031-32272-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125629>

This patch introduces a Python package called "git_remote_cvs" containing
the building blocks of the CVS remote helper. The CVS remote helper itself
is NOT part of this patch.

The patch includes the necessary Makefile additions to build and install
the git_remote_cvs Python package along with the rest of Git.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Makefile                           |    9 +
 git_remote_cvs/.gitignore          |    2 +
 git_remote_cvs/Makefile            |   27 ++
 git_remote_cvs/changeset.py        |  114 +++++
 git_remote_cvs/commit_states.py    |   52 +++
 git_remote_cvs/cvs.py              |  884 ++++++++++++++++++++++++++++++++++++
 git_remote_cvs/cvs_revision_map.py |  362 +++++++++++++++
 git_remote_cvs/cvs_symbol_cache.py |  283 ++++++++++++
 git_remote_cvs/git.py              |  586 ++++++++++++++++++++++++
 git_remote_cvs/setup.py            |   12 +
 git_remote_cvs/util.py             |  147 ++++++
 11 files changed, 2478 insertions(+), 0 deletions(-)
 create mode 100644 git_remote_cvs/.gitignore
 create mode 100644 git_remote_cvs/Makefile
 create mode 100644 git_remote_cvs/__init__.py
 create mode 100644 git_remote_cvs/changeset.py
 create mode 100644 git_remote_cvs/commit_states.py
 create mode 100644 git_remote_cvs/cvs.py
 create mode 100644 git_remote_cvs/cvs_revision_map.py
 create mode 100644 git_remote_cvs/cvs_symbol_cache.py
 create mode 100644 git_remote_cvs/git.py
 create mode 100644 git_remote_cvs/setup.py
 create mode 100644 git_remote_cvs/util.py

diff --git a/Makefile b/Makefile
index 969cef5..bb5cea2 100644
--- a/Makefile
+++ b/Makefile
@@ -1350,6 +1350,9 @@ endif
 ifndef NO_PERL
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
 endif
+ifndef NO_PYTHON
+	$(QUIET_SUBDIR0)git_remote_cvs $(QUIET_SUBDIR1) PYTHON_PATH='$(PYTHON_PATH_SQ)' prefix='$(prefix_SQ)' all
+endif
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)
 
 please_set_SHELL_PATH_to_a_more_modern_shell:
@@ -1701,6 +1704,9 @@ install: all
 ifndef NO_PERL
 	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
 endif
+ifndef NO_PYTHON
+	$(MAKE) -C git_remote_cvs prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
+endif
 ifndef NO_TCLTK
 	$(MAKE) -C gitk-git install
 	$(MAKE) -C git-gui gitexecdir='$(gitexec_instdir_SQ)' install
@@ -1821,6 +1827,9 @@ ifndef NO_PERL
 	$(RM) gitweb/gitweb.cgi
 	$(MAKE) -C perl clean
 endif
+ifndef NO_PYTHON
+	$(MAKE) -C git_remote_cvs clean
+endif
 	$(MAKE) -C templates/ clean
 	$(MAKE) -C t/ clean
 ifndef NO_TCLTK
diff --git a/git_remote_cvs/.gitignore b/git_remote_cvs/.gitignore
new file mode 100644
index 0000000..2247d5f
--- /dev/null
+++ b/git_remote_cvs/.gitignore
@@ -0,0 +1,2 @@
+/build
+/dist
diff --git a/git_remote_cvs/Makefile b/git_remote_cvs/Makefile
new file mode 100644
index 0000000..8dbf3fa
--- /dev/null
+++ b/git_remote_cvs/Makefile
@@ -0,0 +1,27 @@
+#
+# Makefile for the git_remote_cvs python support modules
+#
+pysetupfile:=setup.py
+
+ifndef PYTHON_PATH
+	PYTHON_PATH = /usr/bin/python
+endif
+ifndef prefix
+	prefix = $(HOME)
+endif
+ifndef V
+	QUIET = @
+	QUIETSETUP = --quiet
+endif
+
+PYLIBDIR=`$(PYTHON_PATH) -c "import sys; print 'lib/python%i.%i/site-packages' % sys.version_info[:2]"`
+
+all: $(pysetupfile)
+	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
+install: $(pysetupfile)
+	$(PYTHON_PATH) $(pysetupfile) install --prefix $(prefix)
+instlibdir: $(pysetupfile)
+	@echo "$(prefix)/$(PYLIBDIR)"
+clean:
+	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) clean -a
+	$(RM) *.pyo *.pyc
diff --git a/git_remote_cvs/__init__.py b/git_remote_cvs/__init__.py
new file mode 100644
index 0000000..e69de29
diff --git a/git_remote_cvs/changeset.py b/git_remote_cvs/changeset.py
new file mode 100644
index 0000000..27c4129
--- /dev/null
+++ b/git_remote_cvs/changeset.py
@@ -0,0 +1,114 @@
+#!/usr/bin/env python
+
+"""Functionality for collecting individual CVS revisions into "changesets"
+
+A changeset is a collection of CvsRev objects that belong together in the same
+"commit". This is a somewhat artificial construct on top of CVS, which only
+stores changes at the per-file level. Normally, CVS users create several CVS
+revisions simultaneously by applying the "cvs commit" command to several files
+with related changes. This module tries to reconstruct this notion of related
+revisions.
+"""
+
+from util import *
+
+
+class Changeset (object):
+	"""Encapsulate a single changeset/commit"""
+
+	__slots__ = ('revs', 'date', 'author', 'message')
+
+	# The maximum time between the changeset's date, and the date of a rev
+	# to included in that changeset.
+	MaxSecondsBetweenRevs = 8 * 60 * 60 # 8 hours
+
+	@classmethod
+	def from_rev (cls, rev):
+		"""Return a Changeset based on the given CvsRev object"""
+		c = cls(rev.date, rev.author, rev.message)
+		result = c.add(rev)
+		assert result
+		return c
+
+	def __init__ (self, date, author, message):
+		self.revs    = {}      # dict: path -> CvsRev object
+		self.date    = date    # CvsDate object
+		self.author  = author
+		self.message = message # Lines of commit message
+
+	def __str__ (self):
+		msg = self.message[0] # First line only
+		if len(msg) > 25: msg = msg[:22] + "..." # Max 25 chars long
+		return "<Changeset @(%s) by %s (%s) updating %i files>" % (
+			self.date, self.author, msg, len(self.revs))
+
+	def __iter__ (self):
+		return self.revs.itervalues()
+
+	def __getitem__ (self, path):
+		return self.revs[path]
+
+	def within_time_window (self, rev):
+		"""Return True iff the rev is within the time window of self"""
+		return abs(rev.date.diff(self.date)) <= \
+		       self.MaxSecondsBetweenRevs
+
+	def add (self, rev):
+		"""Add the given CvsRev to this Changeset
+
+		The addition will only succeed if the following holds:
+		  - rev.author == self.author
+		  - rev.message == self.message
+		  - rev.path is not in self.revs
+		  - rev.date is within MaxSecondsBetweenRevs of self.date
+		If the addition succeeds, True is returned; otherwise False.
+		"""
+		if rev.author != self.author: return False
+		if rev.message != self.message: return False
+		if rev.path in self.revs: return False
+		if not self.within_time_window(rev): return False
+
+		self.revs[rev.path] = rev
+		return True
+
+
+def build_changesets_from_revs (cvs_revs):
+	"""Organize CvsRev objects into a chronological list of Changesets"""
+
+	# Construct chronological list of CvsRev objects
+	chron_revs = []
+	for path, d in cvs_revs.iteritems():
+		i = 0 # Current index into chronRevs
+		for revnum, cvsrev in sorted(d.iteritems()):
+			while i < len(chron_revs) \
+			  and cvsrev.date > chron_revs[i].date:
+				i += 1
+			# Insert cvsRev at position i in chronRevs
+			chron_revs.insert(i, cvsrev)
+			i += 1
+
+	changesets = [] # Chronological list of Changeset objects
+	while len(chron_revs): # There are still revs to be added to Changesets
+		# Create Changeset based on the first rev in chronRevs
+		changeset = Changeset.from_rev(chron_revs.pop(0))
+		# Keep adding revs chronologically until MaxSecondsBetweenRevs
+		rejects = [] # Revs that cannot be added to this changeset
+		while len(chron_revs):
+			rev = chron_revs.pop(0)
+			reject = False
+			# First, if we have one of rev's parents in rejects, we
+			# must also reject rev
+			for r in rejects:
+				if r.path == rev.path:
+					reject = True
+					break
+			# Next, add rev to changeset, reject if add fails
+			if not reject: reject = not changeset.add(rev)
+			if reject:
+				rejects.append(rev)
+				# stop trying when rev is too far in the future
+				if not changeset.within_time_window(rev): break
+		chron_revs = rejects + chron_revs # Reconstruct remaining revs
+		changesets.append(changeset)
+
+	return changesets
diff --git a/git_remote_cvs/commit_states.py b/git_remote_cvs/commit_states.py
new file mode 100644
index 0000000..f4b769b
--- /dev/null
+++ b/git_remote_cvs/commit_states.py
@@ -0,0 +1,52 @@
+#!/usr/bin/env python
+
+"""Functionality for relating Git commits to corresponding CvsState objects"""
+
+from util import *
+from cvs  import CvsState
+
+
+class CommitStates (object):
+	"""Provide a mapping from Git commits to CvsState objects
+
+	Behaves like a dictionary of Git commit names -> CvsState mappings.
+
+	Every Git commit converted from CVS has a corresponding CvsState, which
+	describes exactly which CVS revisions are present in a checkout of that
+	commit.
+
+	This class provides the interface to map from a Git commit to its
+	corresponding CvsState. The mapping uses GitNotes as a persistent
+	storage backend.
+	"""
+
+	def __init__ (self, notes):
+		self.notes = notes
+		self._cache = {} # commitname -> CvsState
+
+	def _load (self, commit):
+		if commit is None: return None
+		if commit in self._cache: return self._cache[commit]
+		notedata = self.notes.get(commit)
+		if notedata is None: # Given commit has no associated note
+			return None
+		state = CvsState()
+		state.load_data(notedata)
+		self._cache[commit] = state
+		return state
+
+	def add (self, commit, state, gfi):
+		assert commit not in self._cache
+		self._cache[commit] = state
+		self.notes.import_note(commit, str(state), gfi)
+
+	def __getitem__ (self, commit):
+		state = self._load(commit)
+		if state is None:
+			raise KeyError, "Unknown commit '%s'" % (commit)
+		return state
+
+	def get (self, commit, default = None):
+		state = self._load(commit)
+		if state is None: return default
+		return state
diff --git a/git_remote_cvs/cvs.py b/git_remote_cvs/cvs.py
new file mode 100644
index 0000000..cc2e13f
--- /dev/null
+++ b/git_remote_cvs/cvs.py
@@ -0,0 +1,884 @@
+#!/usr/bin/env python
+
+"""Functionality for interacting with CVS repositories
+
+This module provides classes for interrogating a CVS repository via a CVS
+working directory (aka. checkout), or via direct queries using the "cvs rlog"
+command.
+
+Also, classes for encapsulating fundamental CVS concepts (like CVS numbers)
+are provided.
+"""
+
+import sys, time, shutil
+from calendar import timegm
+
+from util import *
+
+
+class CvsNum (object):
+	"""Encapsulate a single CVS revision/branch number
+
+	Provides functionality for common operations on CVS numbers.
+
+	A CVS number consists of a list of components separated by dots ('.'),
+	where each component is a decimal number. Inspecting the components
+	from left to right, the odd-numbered (1st, 3rd, 5th, etc.) components
+	represent branches in the CVS history tree, while the even-numbered
+	(2nd, 4th, 6th, etc.) components represent revisions on the branch
+	specified in the previous position. Thus "1.2" denotes the second
+	revision on the first branch (aka. trunk), while "1.2.4.6" denotes the
+	sixth revision of the fourth branch started from revision "1.2".
+
+	Therefore, in general, a CVS number with an even number of components
+	denotes a revision (we call this a "revision number"), while an odd
+	number of components denotes a branch (called a "branch number").
+
+	There are a few complicating peculiarities: If there is an even number
+	of components, and the second-last component is 0, the number is not
+	a revision number, but is rather equivalent to the branch number we get
+	by removing the 0-component. I.e. "1.2.0.4" is equivalent to "1.2.4".
+
+	A branch number (except the trunk: "1") always has a "branch point"
+	revision, i.e. the revision from which the branch was started. This
+	revision is found by removing the last component of the branch number.
+	For example the branch point of "1.2.4" is "1.2".
+
+	Conversely, all revision numbers belong to a corresponding branch,
+	whose branch number is found by removing the last component. Examples:
+	The "1.2.4.6" revision belong to the "1.2.4" branch, while the "1.2"
+	revision belongs to the "1" branch (the "trunk").
+
+	From this we can programatically determine the ancestry of any revision
+	number, by decrementing the last revision component until it equals 1,
+	and then trim off the last two components to get to the branch point,
+	and repeat the process from there until we reach the initial revision
+	(typically "1.1"). For example, recursively enumerating the parent
+	revisions of "1.2.4.6" yields the following revisions:
+	  "1.2.4.5", "1.2.4.4", "1.2.4.3", "1.2.4.2", "1.2.4.1", "1.2", "1.1"
+	"""
+
+	__slots__ = ('l',)
+
+	@staticmethod
+	def decompose (cvsnum):
+		"""Split the given CVS number into a list of integer components
+
+		Branch numbers are normalized to the odd-numbered components
+		form (i.e. removing the second last '0' component)
+
+		Examples:
+		  '1.2.4.8' -> [1, 2, 4, 8]
+		  '1.2.3'   -> [1, 2, 3]
+		  '1.2.0.5' -> [1, 2, 5]
+		"""
+		if cvsnum: r = map(int, cvsnum.split('.'))
+		else:      r = []
+		if len(r) >= 2 and r[-2] == 0: del r[-2]
+		return tuple(r)
+
+	@staticmethod
+	def compose (l):
+		"""Join the given list of integer components into a CVS number
+
+		E.g.: (1, 2, 4, 8) -> '1.2.4.8'
+		"""
+		return ".".join(map(str, l))
+
+	@classmethod
+	def from_components (cls, args):
+		return cls(cls.compose(args))
+
+	def __init__ (self, cvsnum):
+		self.l = self.decompose(str(cvsnum))
+
+	def __repr__ (self):
+		return self.compose(self.l)
+
+	def __str__ (self):
+		return repr(self)
+
+	def __hash__ (self):
+		return hash(repr(self))
+
+	def __len__ (self):
+		return len(self.l)
+
+	def __cmp__ (self, other):
+		try: return cmp(self.l, other.l)
+		except AttributeError: return 1
+
+	def __getitem__ (self, key):
+		return self.l[key]
+
+	def is_rev (self):
+		"""Return True iff this number is a CVS revision number"""
+		return len(self.l) % 2 == 0 \
+	           and len(self.l) >= 2 \
+		   and self.l[-2] != 0
+
+	def is_branch (self):
+		"""Return True iff this number is a CVS branch number"""
+		return len(self.l) % 2 != 0 \
+	            or (len(self.l) >= 2 and self.l[-2] == 0)
+
+	def enumerate (self):
+		"""Return a list of integer components in this CVS number"""
+		return list(self.l)
+
+	def branch (self):
+		"""Return the branch on which the given number lives.
+
+		Revisions: chop the last component to find the branch, e.g.:
+			1.2.4.6 -> 1.2.4
+			1.1 -> 1
+		Branches: unchanged
+		"""
+		if self.is_rev():
+			return self.from_components(self.l[:-1])
+		return self
+
+	def parent (self):
+		"""Return the parent/previous revision number to this number.
+
+		For revisions, this is the previous revision, e.g.:
+			1.2.4.6 -> 1.2.4.5
+			1.2.4.1 -> 1.2
+			1.1 -> None
+			2.1 -> None
+		For branches, this is the branch point, e.g.:
+			1.2.4 -> 1.2
+			1 -> None
+			2 -> None
+		"""
+		if len(self.l) < 2: return None
+		elif len(self.l) % 2: # branch number
+			return self.from_components(self.l[:-1])
+		else: # revision number
+			assert self.l[-1] > 0
+			result = self.enumerate()
+			result[-1] -= 1 # Decrement final component
+			if result[-1] == 0: # We're at the start of the branch
+				del result[-2:] # Make into branch point
+				if not result: return None
+			return self.from_components(result)
+
+	def follows (self, other):
+		"""Return True iff self historically follows the given rev
+
+		This iterates through the parents of self, and returns True iff
+		any of them equals the given rev. Otherwise, False is returned.
+		"""
+		assert other.is_rev()
+		cur = self
+		while cur:
+			if cur == other: return True
+			cur = cur.parent()
+		return False
+
+	def on_branch (self, branch):
+		"""Return True iff this rev is on the given branch.
+
+		The revs considered to be "on" a branch X also includes the
+		branch point of branch X.
+		"""
+		return branch == self.branch() or branch.parent() == self
+
+	@classmethod
+	def disjoint (self, a, b):
+		"""Return True iff the CVS numbers are historically disjoint
+
+		Two CVS numbers are disjoint if they do not share the same
+		historical line back to the initial revision. In other words:
+		the two numbers are disjoint if the history (i.e. set of parent
+		revisions all the way back to the intial (1.1) revision) of
+		neither number is a superset of the other's history.
+		See test_disjoint() for practical examples:
+		"""
+		if a.is_branch(): a = self.from_components(a.l + (1,))
+		if b.is_branch(): b = self.from_components(b.l + (1,))
+		if len(a.l) > len(b.l): a, b = b, a # a is now shortest
+		pairs = zip(a.l, b.l)
+		for pa, pb in pairs[:-1]:
+			if pa != pb: return True
+		if len(a) == len(b): return False
+		common_len = len(a)
+		if a.l[common_len - 1] <= b.l[common_len - 1]: return False
+		return True
+
+	@classmethod
+	def test_disjoint (cls):
+		tests = [
+			("1.2", "1.1", False),
+			("1.2", "1.2", False),
+			("1.2", "1.3", False),
+			("1.2", "1.1.2", True),
+			("1.2", "1.1.2.3", True),
+			("1.2.4", "1.1", False),
+			("1.2.4", "1.2", False),
+			("1.2.4", "1.3", True),
+			("1.2.4", "1.2.2", True),
+			("1.2.4", "1.2.4", False),
+			("1.2.4", "1.2.6", True),
+			("1.2.4", "1.2.2.4", True),
+			("1.2.4", "1.2.4.4", False),
+			("1.2.4", "1.2.6.4", True),
+			("1.2.4.6", "1.1", False),
+			("1.2.4.6", "1.2", False),
+			("1.2.4.6", "1.3", True),
+			("1.2.4.6", "1.2.2", True),
+			("1.2.4.6", "1.2.2.1", True),
+			("1.2.4.6", "1.2.4", False),
+			("1.2.4.6", "1.2.4.5", False),
+			("1.2.4.6", "1.2.4.6", False),
+			("1.2.4.6", "1.2.4.7", False),
+			("1.2.4.6.8.10", "1.2.4.5", False),
+			("1.2.4.6.8.10", "1.2.4.6", False),
+			("1.2.4.6.8.10", "1.2.4.7", True),
+		]
+		for a, b, result in tests:
+			a, b = map(cls, (a, b))
+			assert cls.disjoint(a, b) == result, \
+				"disjoint(%s, %s) is not %s" % (a, b, result)
+			assert cls.disjoint(b, a) == result, \
+				"disjoint(%s, %s) is not %s" % (a, b, result)
+
+	@classmethod
+	def test (cls):
+		assert cls("1.2.4") == cls("1.2.0.4")
+		assert cls("1.2.4").is_branch()
+		assert cls("1.2").is_rev()
+		assert cls("1").is_branch()
+		assert cls("1.2.4.6").is_rev()
+		assert cls("1.2.4.6").enumerate() == [1, 2, 4, 6]
+		assert cls.from_components([1, 2, 4, 6]) == cls("1.2.4.6")
+		assert str(cls.from_components([1, 2, 4, 6])) == "1.2.4.6"
+		assert len(cls("1.2.4.6")) == 4
+		assert cls("1.2.4.6").branch() == cls("1.2.4")
+		assert cls("1.2.4").branch() == cls("1.2.4")
+		assert cls("1.1").branch() == cls("1")
+		assert cls("1").branch() == cls("1")
+		assert cls("1.2.4.6").parent() == cls("1.2.4.5")
+		assert cls("1.2.4.1").parent() == cls("1.2")
+		assert cls("1.2").parent() == cls("1.1")
+		assert cls("1.1").parent() == None
+		assert cls("2.1").parent() == None
+		assert cls("1.2.4").parent() == cls("1.2")
+		assert cls("1").parent() == None
+		assert cls("2").parent() == None
+		assert cls("1.2.4.6").follows(cls("1.1"))
+		assert cls("1.2.4.6").follows(cls("1.2"))
+		assert cls("1.2.4.6").follows(cls("1.2.4.1"))
+		assert cls("1.2.4.6").follows(cls("1.2.4.2"))
+		assert cls("1.2.4.6").follows(cls("1.2.4.3"))
+		assert cls("1.2.4.6").follows(cls("1.2.4.4"))
+		assert cls("1.2.4.6").follows(cls("1.2.4.5"))
+		assert cls("1.2.4.6").follows(cls("1.2.4.6"))
+		assert not cls("1.2.4.6").follows(cls("1.2.4.7"))
+		assert not cls("1.2.4.6").follows(cls("1.3"))
+		assert not cls("1.1").follows(cls("1.2.4.6"))
+
+		cls.test_disjoint()
+
+
+class CvsState (object):
+	"""Encapsulate a historical state in CVS (a set of paths and nums)
+
+	This class is a container of CVS pathnames and associated CvsNum
+	objects.
+
+	No communication with a CVS working directory or repository is done in
+	this class, hence only basic sanity checks are performed:
+	  - A path may only appear once in a CvsState.
+	  - When adding a path:num pair, path may not already exist in self
+	  - When replacing a path:num pair, path must already exist in self
+	  - When removing a path:num pair, both path and num must be given
+
+	IMPORTANT: Objects of this class are hash()able (to support being used
+	as keys in a dict), but they are also mutable. It is therefore up to
+	the caller to make sure that the object is not changed after being
+	stored in a data structure indexed by its hash value.
+	"""
+
+	__slots__ = ('revs', '_hash')
+
+	def __init__ (self):
+		self.revs = {} # dict: path -> CvsNum object
+		self._hash = None
+
+	def __iter__ (self):
+		return self.revs.iteritems()
+
+	def __getitem__ (self, path):
+		return self.revs[path]
+
+	def __cmp__ (self, other):
+		return cmp(self.revs, other.revs)
+
+	def __str__ (self):
+		return "".join(["%s:%s\n" % (p, n) for p, n in sorted(self)])
+
+	def __hash__ (self):
+		if self._hash is None:
+			self._hash = hash(str(self))
+		return self._hash
+
+	def paths (self):
+		return self.revs.iterkeys()
+
+	def get (self, path, default = None):
+		return self.revs.get(path, default)
+
+	def add (self, path, revnum):
+		assert path not in self.revs
+		self._hash = None
+		self.revs[path] = revnum
+
+	def replace (self, path, revnum):
+		assert path in self.revs
+		self._hash = None
+		self.revs[path] = revnum
+
+	def remove (self, path, revnum):
+		assert path in self.revs and self.revs[path] == revnum
+		self._hash = None
+		del self.revs[path]
+
+	def copy (self):
+		"""Create and return a copy of this object"""
+		ret = CvsState()
+		ret.revs = self.revs.copy()
+		ret._hash = self._hash
+		return ret
+
+	def load_data (self, note_data):
+		"""Load note data as formatted by self.__str__()"""
+		for line in note_data.split("\n"):
+			line = line.strip()
+			if not line: continue
+			path, num = line.rsplit(':', 1)
+			self.add(path, CvsNum(num))
+		self._hash = hash(note_data)
+
+	def print_members (self, f = sys.stdout, prefix = ""):
+		for path, num in sorted(self):
+			print >>f, "%s%s:%s" % (prefix, path, num)
+
+	@file_reader_method(missing_ok = True)
+	def load (self, f):
+		"""Load CVS state from the given file name/object"""
+		if not f: return
+		self.load_data(f.read())
+
+	@file_writer_method
+	def save (self, f):
+		"""Save CVS state to the given file name/object"""
+		assert f
+		print >>f, str(self),
+
+
+class CvsDate (object):
+	"""Encapsulate a timestamp, as reported by CVS
+
+	The internal representation of a timestamp is two integers, the first
+	representing the timestamp as #seconds since epoch (UTC), and the
+	second representing the timezone as #minutes offset from UTC.
+	E.g.: "2007-09-05 17:26:28 -0200" is converted to (1189013188, -120)
+	"""
+
+	__slots__ = ('ts', 'tz')
+
+	def __init__ (self, date_str = None, in_utc = False):
+		"""Convert CVS date string into a CvsDate object
+
+		A CVS timestamp string has one of the following forms:
+		  - "YYYY-MM-DD hh:mm:ss SZZZZ"
+		  - "YYYY/MM/DD hh:mm:ss" (with timezone assumed to be UTC)
+		The in_utc parameter determines whether the timestamp part of
+		the given string (the "YYYY-MM-DD hh:mm:ss" part) is given in
+		local time or UTC (normally CVS dates are given in local time.
+		If given in local time, the timezone offset is subtracted from
+		the timestamp in order to make the time in UTC format.
+		"""
+		if date_str is None:
+			self.ts, self.tz = 0, 0
+			return
+		if date_str == "now":
+			self.ts, self.tz = time.time(), 0
+			return
+		date_str = date_str.strip()
+		# Set up self.ts and self.tz
+		if date_str.count(" ") == 2:
+			# Assume format "YYYY-MM-DD hh:mm:ss SZZZZ"
+			t, z = date_str.rsplit(" ", 1)
+			# Convert timestamp to #secs since epoch (UTC)
+			self.ts = timegm(time.strptime(t, "%Y-%m-%d %H:%M:%S"))
+			# Convert timezone into #mins offset from UTC
+			self.tz = int(z[1:3]) * 60 + int(z[3:5])
+			# Incorporate timezone sign
+			if z[0] == '-': self.tz *= -1
+		else:
+			assert date_str.count(" ") == 1
+			# Assume format "YYYY/MM/DD hh:mm:ss"
+			self.ts = timegm(time.strptime(
+				date_str, "%Y/%m/%d %H:%M:%S"))
+			self.tz = 0
+		# Adjust timestamp if not already in UTC
+		if not in_utc: self.ts -= self.tz * 60
+
+	def tz_str (self):
+		"""Return timezone part of self in string format"""
+		sign = '+'
+		if self.tz < 0: sign = '-'
+		(hours, minutes) = divmod(abs(self.tz), 60)
+		return "%s%02d%02d" % (sign, hours, minutes)
+
+	def __str__ (self):
+		"""Reconstruct date string from members"""
+		s = time.strftime("%Y-%m-%d %H:%M:%S", time.gmtime(self.ts))
+		return "%s %s" % (s, self.tz_str())
+
+	def __repr__ (self):
+		return "CvsDate('%s')" % (str(self))
+
+	def __hash__ (self):
+		return hash((self.ts, self.tz))
+
+	def __nonzero__ (self):
+		return bool(self.ts or self.tz)
+
+	def __cmp__ (self, other):
+		return cmp(self.ts, other.ts) or cmp(self.tz, other.tz)
+
+	def __eq__ (self, other):
+		return self.ts == other.ts and self.tz == other.tz
+
+	def diff (self, other):
+		"""Return difference between self and other in #seconds
+
+		Invariant: self == other.add(self.diff(other))
+		"""
+		return self.ts - other.ts
+
+	@classmethod
+	def test (cls):
+		a = cls("2009-05-10 14:34:56 +0200")
+		b = cls("2009/05/10 12:34:56")
+		assert a
+		assert b
+		assert str(a) == "2009-05-10 12:34:56 +0200", str(a)
+		assert str(b) == "2009-05-10 12:34:56 +0000", str(b)
+		assert a != b
+		assert a.diff(b) == 0
+		c = cls("2009-05-10 16:34:56 +0200")
+		assert c
+		assert str(c) == "2009-05-10 14:34:56 +0200", str(c)
+		assert c != a
+		assert c.diff(a) == 2 * 60 * 60
+		assert a.diff(c) == -2 * 60 * 60
+
+
+class CvsRev (object):
+	"""Encapsulate metadata on a CVS revision"""
+	__slots__ = ('path', 'num', 'date', 'author', 'deleted', 'message')
+
+	def __init__ (self, path, num):
+		self.path    = path
+		self.num     = num
+		self.date    = None # CvsDate object
+		self.author  = ""
+		self.deleted = None # True or False
+		self.message = []   # Lines of commit message
+
+	def __str__ (self):
+		return "<%s:%s on %s by %s%s>" % (
+			self.path, self.num, self.date, self.author,
+			self.deleted and ", deleted" or "")
+
+	def __cmp__ (self, other):
+		return cmp(self.path, other.path) or cmp(self.num, other.num)
+
+
+class CvsWorkDir (object):
+	"""Encapsulate a CVS working directory
+
+	This class auto-creates a CVS workdir/checkout in the directory given
+	to the constructor, and provides various methods for interacting with
+	this workdir.
+	"""
+
+	def __init__ (self, workdir, cvs_repo):
+		"""Create a new CvsWorkDir
+
+		The cvs_repo argument must be a (cvs_root, cvs_module) tuple
+		"""
+		self.d = workdir
+		self.cvs_root, self.cvs_module = cvs_repo
+		parent_dir = os.path.dirname(self.d)
+		if not os.path.isdir(parent_dir): os.makedirs(parent_dir)
+		self._valid = None
+
+	def makepath(self, *args):
+		"""Create path relative to working directory"""
+		return os.path.join(self.d, *args)
+
+	def valid (self):
+		"""Return True iff this workdir is present and valid"""
+		if self._valid is not None: return True
+		try:
+			f = open(self.makepath("CVS", "Root"), 'r')
+			assert f.read().strip() == self.cvs_root
+			f.close()
+			f = open(self.makepath("CVS", "Repository"), 'r')
+			assert f.read().strip() == self.cvs_module
+			f.close()
+			self._valid = True
+		except:
+			self._valid = False
+		return self._valid
+
+	def remove (self):
+		"""Remove this checkout"""
+		shutil.rmtree(self.d, True)
+		assert not os.path.exists(self.d)
+		self._valid = False
+
+	def checkout (self, revision = "HEAD"):
+		"""Create a checkout of the given revision"""
+		self.remove()
+		parent_dir, co_dir = os.path.split(self.d)
+		args = ["cvs", "-f", "-Q", "-d", self.cvs_root, "checkout"]
+		if str(revision) != "HEAD": args.extend(["-r", str(revision)])
+		args.extend(["-d", co_dir, self.cvs_module])
+		exit_code, output, errors = run_command(args, cwd = parent_dir)
+		if exit_code:
+			die("Failed to checkout CVS working directory")
+		assert not errors
+		assert not output, "output = '%s'" % (output)
+		self._valid = None
+		assert self.valid()
+
+	def update (self, revision = "HEAD", paths = []):
+		"""Update the given paths to the given revision"""
+		if not self.valid(): self.checkout()
+		args = ["cvs", "-f", "-Q", "update", "-kk"]
+		if str(revision) == "HEAD": args.append("-A")
+		else: args.extend(["-r", str(revision)])
+		args.extend(paths)
+		exit_code, output, errors = run_command(args, cwd = self.d)
+		if exit_code:
+			die("Failed to checkout CVS working directory")
+		assert not errors
+		assert not output, "output = '%s'" % (output)
+
+	def get_revision_data (self, path, revision):
+		"""Return the contents of the given CVS path:revision"""
+		if not self.valid(): self.checkout()
+		args = ["cvs", "-f", "-Q", "update", "-p", "-kk"]
+		if str(revision) == "HEAD": args.append("-A")
+		else: args.extend(["-r", str(revision)])
+		args.append(path)
+		exit_code, output, errors = run_command(args, cwd = self.d)
+		if exit_code:
+			die("Failed to checkout CVS working directory")
+		assert not errors
+		return output
+
+	def get_modeinfo (self, paths = []):
+		"""Return mode information for the given paths.
+
+		Returns a dict of path -> mode number mappings. If paths are
+		not specified, mode information for all files in the current
+		checkout will be returned. No checkout/update will be done.
+		"""
+		result = {}
+		if paths:
+			for path in paths:
+				fullpath = os.path.join(self.d, path)
+				mode = 644
+				if os.access(fullpath, os.X_OK):
+					mode = 755
+				assert path not in result
+				result[path] = mode
+		else: # Return mode information for all paths
+			for dirpath, dirnames, filenames in os.walk(self.d):
+				# Don't descend into CVS subdirs
+				try: dirnames.remove('CVS')
+				except ValueError: pass
+
+				assert dirpath.startswith(self.d)
+				directory = dirpath[len(self.d):].lstrip("/")
+
+				for fname in filenames:
+					path = os.path.join(directory, fname)
+					fullpath = os.path.join(dirpath, fname)
+					mode = 644
+					if os.access(fullpath, os.X_OK):
+						mode = 755
+					assert path not in result
+					result[path] = mode
+		return result
+
+	@classmethod
+	def parse_entries (cls, entries, prefix, directory = ""):
+		"""Recursively parse CVS/Entries files
+
+		Return a dict of CVS paths found by parsing the CVS/Entries
+		files rooted at the given directory.
+
+		See http://ximbiot.com/cvs/manual/feature/cvs_2.html#SEC19 for
+		information on the format of the CVS/Entries file.
+		"""
+		fname = os.path.join(prefix, directory, "CVS", "Entries")
+		subdirs = []
+		f = open(fname, 'r')
+		for line in f:
+			line = line.strip()
+			if line == "D": continue # There are no subdirectories
+			t, path, revnum, date, options, tag = line.split("/")
+			if t == "D":
+				subdirs.append(path)
+				continue
+			assert line.startswith("/")
+			path = os.path.join(directory, path)
+			revnum = CvsNum(revnum)
+			assert path not in entries
+			entries[path] = (revnum, date, options, tag)
+		f.close()
+
+		for d in subdirs:
+			d = os.path.join(directory, d)
+			cls.parse_entries(entries, prefix, d)
+
+	def get_state (self):
+		"""Return CvsState reflecting current state of this checkout
+
+		Note that the resulting CvsState will never contain any
+		deleted/dead files. Other CvsStates to be compared to the one
+		returned from here should remove deleted/dead entries first.
+		"""
+		assert self.valid()
+		entries = {}
+		result = CvsState()
+		self.parse_entries(entries, self.d)
+		for path, info in entries.iteritems():
+			result.add(path, info[0])
+		return result
+
+
+class CvsLogParser (object):
+	"""Encapsulate the execution of a "cvs rlog" command"""
+
+	def __init__ (self, cvs_repo):
+		"""Create a new CvsLogParser
+
+		The cvs_repo argument must be a (cvs_root, cvs_module) tuple
+		"""
+		self.cvs_root, self.cvs_module = cvs_repo
+
+	def cleanup_path (self, cvs_path):
+		"""Utility method for parsing CVS paths from CVS log"""
+		cvsprefix = "/".join((self.cvs_root[self.cvs_root.index("/"):],
+				self.cvs_module))
+		assert cvs_path.startswith(cvsprefix)
+		assert cvs_path.endswith(",v")
+		# Drop cvsprefix and ,v-extension
+		cvs_path = cvs_path[len(cvsprefix):-2]
+		# Split the remaining path into components
+		components = filter(None, cvs_path.strip().split('/'))
+		# Remove 'Attic' from CVS paths
+		if len(components) >= 2 and components[-2] == "Attic":
+			del components[-2]
+		# Reconstruct resulting "cleaned" path
+		return "/".join(components)
+
+	def __call__ (self, line):
+		"""Line parser; this method is invoked for each line in the log
+
+		Must be reimplemented by subclass
+		"""
+		pass
+
+	def finish (self):
+		"""This method is invoked after the last line has been parsed
+
+		May be reimplemented by subclass
+		"""
+		pass
+
+	def run (self, paths = [], no_symbols = False, revisions = None):
+		args = ["cvs", "-f", "-q", "-d", self.cvs_root, "rlog"]
+		if no_symbols: args.append("-N")
+		if revisions: args.append("-r%s" % (revisions))
+		if paths:
+			for p in paths:
+				args.append("%s/%s" % (self.cvs_module, p))
+		else:
+			args.append(self.cvs_module)
+
+		proc = start_command(args)
+		proc.stdin.close()
+		while True:
+			for line in proc.stdout:
+				self(line.rstrip()) # Call subclass line parser
+			if proc.poll() is not None:
+				break
+
+		assert proc.stdout.read() == ""
+		self.finish() # Notify subclass that parsing is finished
+		exit_code = proc.returncode
+		if exit_code:
+			error("'%s' returned exit code %i, and errors:\n" \
+				"---\n%s---", " ".join(args), exit_code,
+				proc.stderr.read())
+		return exit_code
+
+
+class CvsRevLister (CvsLogParser):
+	"""Extract CvsRev objects (with revision metadata) from a CVS log"""
+
+	def __init__ (self, cvs_repo, show_progress = False):
+		super(CvsRevLister, self).__init__(cvs_repo)
+		self.cur_file = None      # current CVS file being processed
+		self.cur_file_numrevs = 0 # #revs in current CVS file
+		self.cur_rev = None       # Current CvsRev under construction
+
+		self.progress = None
+		if show_progress:
+			self.progress = ProgressIndicator("\t", sys.stderr)
+
+		# Store found revs in a two-level dict structure:
+		# filename -> revnum -> CvsRev
+		self.revs = {}
+
+		# Possible states:
+		# - BeforeRevs  - waiting for "total revisions:"
+		# - BetweenRevs - waiting for "----------------------------"
+		# - ReadingRev  - reading CVS revision details
+		self.state = 'BeforeRevs'
+
+	def __call__ (self, line):
+		if self.state == 'BeforeRevs':
+			if line.startswith("RCS file: "):
+				self.cur_file = self.cleanup_path(line[10:])
+				assert self.cur_file not in self.revs
+				self.revs[self.cur_file] = {}
+			elif line.startswith("total revisions: "):
+				assert self.cur_file
+				totalrevs, selectedrevs = line.split(";")
+				self.cur_file_numrevs = \
+					int(selectedrevs.split(":")[1].strip())
+				self.state = 'BetweenRevs'
+		elif self.state == 'BetweenRevs':
+			if line == "----------------------------" or \
+			   line == "======================================" \
+			           "=======================================":
+				if self.cur_rev:
+					# Finished current revision
+					f = self.revs[self.cur_file]
+					assert self.cur_rev.num not in f
+					f[self.cur_rev.num] = self.cur_rev
+					self.cur_rev = None
+					if self.progress: self.progress()
+				if line == "----------------------------":
+					self.state = 'ReadingRev'
+				else:
+					# Finalize current CVS file
+					assert len(self.revs[self.cur_file]) \
+						== self.cur_file_numrevs
+					self.cur_file = None
+					self.state = 'BeforeRevs'
+			elif self.cur_rev:
+				# Currently in the middle of a revision.
+
+				if line.startswith("branches:  %s" \
+				                   % (self.cur_rev.num)) \
+				   and line.endswith(";"):
+					return # Skip 'branches:' lines
+				# This line is part of the commit message.
+				self.cur_rev.message.append(line)
+		elif self.state == 'ReadingRev':
+			if line.startswith("revision "):
+				self.cur_rev = CvsRev(
+					self.cur_file, CvsNum(line.split()[1]))
+			else:
+				date, author, state, dummy = line.split(";", 3)
+				assert date.startswith("date: ")
+				self.cur_rev.date = CvsDate(date[6:])
+				assert author.strip().startswith("author: ")
+				self.cur_rev.author = author.strip()[8:]
+				assert state.strip().startswith("state: ")
+				state = state.strip()[7:]
+				self.cur_rev.deleted = state == "dead"
+				self.state = 'BetweenRevs'
+
+	def finish (self):
+		assert self.state == 'BeforeRevs'
+		if self.progress:
+			self.progress.finish("Parsed %i revs in %i files" % (
+				self.progress.n, len(self.revs)))
+
+
+def fetch_revs (path, from_rev, to_rev, symbol, cvs_repo):
+	"""Fetch CvsRev objects for each rev in <path:from_rev, path:symbol]
+
+	Return a dict of CvsRev objects (revnum -> CvsRev), where each CvsRev
+	encapsulates a CVS revision in the range from path:from_rev to
+	path:symbol (inclusive). If symbol currently refers to from_rev (i.e.
+	nothing has happened since the last import), the returned dict will
+	have exactly one entry (from_rev). If there is no valid revision range
+	between from_rev and symbol, the returned dict will be empty.
+	Situations in which an empty dict is returned, include:
+	- symbol is no longer defined on this path
+	- symbol refers to a revision that is disjoint from from_rev
+
+	from_rev may be None, meaning that all revisions from the initial
+	version of path up to the revision currently referenced by symbol
+	should be fetched.
+
+	If the revision currently referenced by symbol is disjoint from
+	from_rev, the returned dict will be empty.
+
+	Note that there is lots of unexpected behaviour in the handling of the
+	'cvs rlog -r' parameter: Say you have a branch, called 'my_branch',
+	that points to branch number 1.1.2 of a file. Say there are 3 revisions
+	on this branch: 1.1.2.1 -> 1.1.2.3. (in additions to the branch point
+	1.1). Now, observe the following 'cvs rlog' executions:
+	- cvs rlog -r0:my_branch ... returns 1.1, 1.1.2.1, 1.1.2.2, 1.1.2.3
+	- cvs rlog -r1.1:my_branch ... returns the same revs
+	- cvs rlog -rmy_branch ... returns 1.1.2.1, 1.1.2.2, 1.1.2.3
+	- cvs rlog -rmy_branch: ... returns the same revs
+	- cvs rlog -r:my_branch ... returns the same revs
+	- cvs rlog -r::my_branch ... returns the same revs
+	- cvs rlog -r1.1.2.1: ... returns the same revs
+	Here is where it gets really weird:
+	- cvs rlog -r1.1.2.1:my_branch ... returns 1.1.2.1 only
+	- cvs rlog -r1.1.2.2:my_branch ... returns 1.1.2.1, 1.1.2.2
+	- cvs rlog -r1.1.2.3:my_branch ... returns 1.1.2.1, 1.1.2.2, 1.1.2.3
+
+	In other words the 'cvs rlog -rfrom_rev:symbol' scheme that we normally
+	use will not work in the case where from_rev is _on_ the branch pointed
+	at by the symbol.
+
+	Therefore, we need an extra parameter, to_rev, which we can use to:
+	1. Detect when this situation is present.
+	2. Work around by using 'cvs rlog -rfrom_ref:to_rev' instead.
+	"""
+
+	if from_rev is None: # Initial import
+		from_rev = "0" # cvs rlog -r0:X fetches from initial revision
+	elif to_rev and to_rev.branch() == from_rev.branch():
+		symbol = to_rev # Use to_rev instead of given symbol
+
+	# Run 'cvs rlog' on range [from_rev, symbol] and parse CvsRev objects
+	parser = CvsRevLister(cvs_repo)
+	parser.run((path,), True, "%s:%s" % (from_rev, symbol))
+	assert len(parser.revs) == 1
+	assert path in parser.revs
+	return parser.revs[path]
+
+
+if __name__ == '__main__':
+	# Run selftests
+	CvsNum.test()
+	CvsDate.test()
diff --git a/git_remote_cvs/cvs_revision_map.py b/git_remote_cvs/cvs_revision_map.py
new file mode 100644
index 0000000..7d7810f
--- /dev/null
+++ b/git_remote_cvs/cvs_revision_map.py
@@ -0,0 +1,362 @@
+#!/usr/bin/env python
+
+"""Functionality for mapping CVS revisions to associated metainformation"""
+
+from util import *
+from cvs  import CvsNum, CvsDate
+from git  import GitFICommit, GitFastImport, GitObjectFetcher
+
+
+class CvsPathInfo (object):
+	"""Information on a single CVS path"""
+	__slots__ = ('revs', 'mode')
+
+	def __init__ (self, mode = None):
+		self.revs = {}
+		self.mode = mode
+
+class CvsRevInfo (object):
+	"""Information on a single CVS revision"""
+	__slots__ = ('blob', 'commits')
+
+	def __init__ (self, blob):
+		self.blob = blob
+		self.commits = []
+
+class CvsRevisionMap (object):
+	"""Encapsulate the mapping of CVS revisions to associated metainfo
+
+	This container maps CVS revisions (a combination of a CVS path and a
+	CVS revision number) into Git blob names, Git commit names, and CVS
+	path information. Git object (blob/commit) names are either 40-char
+	SHA1 strings, or "git fast-import" mark numbers if the form ":<num>".
+
+	The data structure is organized as follows:
+	- A CvsRevisionMap instance knows about a set of CVS paths.
+	  For each CVS path, the following is known:
+	  - The mode (permission bits) of that CVS path (644 or 755)
+	  - The CVS revision numbers that exist for that CVS path.
+	    For each revision number, the following is known:
+	    - Exactly 1 blob name; the Git blob containing the contents of the
+	      revision (the contents of the CVS path at that CVS revision).
+	    - One or more commit names; the Git commits which encapsulate a
+	      CVS state in which this CVS revision
+
+	To store this data structure persistently, this class uses a Git ref
+	that points to a tree structure containing the above information. When
+	changes to the structure are made, this class will produce
+	git-fast-import commands to update that tree structure accordingly.
+
+	IMPORTANT: No changes to the CvsRevisionMap will be stored unless
+	.commit() is called with a valid GitFastImport instance
+
+	NOTES: Mark numbers are only transient references bound to the current
+	"git fast-import" process (assumed to be running alongside this
+	process). Therefore, when the "git fast-import" process ends, it must
+	write out a mark number -> SHA1 mapping (see the "--export-marks"
+	argument to "git fast-import"). Subsequently, this mapping must be
+	parsed, and the mark numbers in this CvsRevisionMap must be resolved
+	into persistent SHA1 names. In order to quickly find all the unresolved
+	mark number entries in the data structure, and index mapping mark
+	numbers to revisions is kept in a separate file in the tree structure.
+	See the loadMarksFile() method for more details.
+	"""
+
+	MarkNumIndexFile = "CVS/marks" # invalid CVS path name
+
+	def __init__ (self, git_ref, obj_fetcher):
+		self.git_ref = git_ref
+		self.obj_fetcher = obj_fetcher
+
+		# The following data structure is a cache of the persistent
+		# data structure found at self.git_ref.
+		# It is structured as follows:
+		# - self.d is a dict, mapping CVS paths to CvsPathInfo objects.
+		#   CvsPathInfo object have two fields: revs, mode:
+		#   - mode is either 644 (non-executable) or 755 (executable).
+		#   - revs is a dict, mapping CVS revision numbers (CvsNum
+		#     instances) to CvsRevInfo objects. CvsRevInfo objects have
+		#     two fields: blob, commits:
+		#     - blob is the name of the Git blob object holding the
+		#       contents of that revision.
+		#     - commits is a collection of zero or more Git commit
+		#       names where the commit contains this revision.
+		self.d = {} # dict: path -> CvsPathInfo
+		self.mods = set() # (path, revnum) pairs for all modified revs
+		self.marknum_idx = {} # dict: mark num -> [(path, revnum), ...]
+		self._load_marknum_idx()
+
+	def __del__ (self):
+		if self.mods:
+			error("Missing call to self.commit().")
+			error("%i revision changes are lost!", len(self.mods))
+
+	def __nonzero__ (self):
+		"""Return True iff any information is currently stored here"""
+		return bool(self.d)
+
+	# Private methods:
+
+	def _add_to_marknum_idx(self, marknum, path, revnum):
+		"""Add the given marknum -> (path, revnum) association"""
+		entry = self.marknum_idx.setdefault(marknum, [])
+		entry.append((path, revnum))
+
+	def _load_marknum_idx(self):
+		"""Load contents of MarkNumIndexFile into self.marknum_idx"""
+		blobspec = "%s:%s" % (self.git_ref, self.MarkNumIndexFile)
+		try: f = self.obj_fetcher.open_obj(blobspec)
+		except KeyError: return # missing object; nothing to do
+
+		for line in f:
+			# Format of line is "<marknum> <path>:<revnum>"
+			mark, rest = line.strip().split(' ', 1)
+			path, rev = rest.rsplit(':', 1)
+			self._add_to_marknum_idx(int(mark), path, CvsNum(rev))
+		f.close()
+
+	def _save_marknum_idx(self):
+		"""Prepare data for storage into MarkNumIndexFile
+
+		The returned string contains the current contents of
+		self.marknum_idx, formatted to be stored verbatim in
+		self.MarkNumIndexFile.
+		"""
+		lines = []
+		for marknum, revs in sorted(self.marknum_idx.iteritems()):
+			for path, revnum in revs:
+				# Format of line is "<marknum> <path>:<revnum>"
+				line = "%i %s:%s\n" % (marknum, path, revnum)
+				lines.append(line)
+		return "".join(lines)
+
+	def _save_rev(self, path, revnum):
+		"""Return blob data for storing the given revision persistently
+
+		Generate the blob contents that will reconstitute the same
+		revision entry when read back in with _fetch_path().
+		"""
+		lines = []
+		rev_info = self.d[path].revs[revnum]
+		lines.append("blob %s\n" % (rev_info.blob))
+		for commit in rev_info.commits:
+			lines.append("commit %s\n" % (commit))
+		return "".join(lines)
+
+	@staticmethod
+	def _valid_objname (objname):
+		"""Return the argument as a SHA1 (string) or mark num (int)"""
+		# Blob names are either 40-char SHA1 strings, or mark numbers
+		if isinstance(objname, int) or len(objname) != 40: # mark num
+			return int(objname)
+		return objname
+
+	def _load (self, path, mode, data):
+		"""GitObjectFetcher.walk_tree() callback"""
+		assert mode in (644, 755)
+		cvsPath, revnum = os.path.split(path)
+		revnum = CvsNum(revnum)
+		if cvsPath in self.d:
+			assert mode == self.d[cvsPath].mode
+		else:
+			self.d[cvsPath] = CvsPathInfo(mode)
+		assert revnum not in self.d[cvsPath].revs
+		rev_info = None
+		for line in data.split("\n"):
+			if not line: continue
+			t, objname = line.split()
+			objname = self._valid_objname(objname)
+			if t == "blob":
+				assert rev_info is None
+				rev_info = CvsRevInfo(objname)
+			elif t == "commit":
+				assert rev_info is not None
+				rev_info.commits.append(objname)
+			else:
+				assert False, "Unknown type '%s'" % (t)
+		assert rev_info.commits # each rev is in at least one commit
+		self.d[cvsPath].revs[revnum] = rev_info
+
+	def _fetch_path (self, path):
+		"""If the given path exists, create a path entry in self.d"""
+		tree_spec = "%s:%s" % (self.git_ref, path)
+		self.obj_fetcher.walk_tree(tree_spec, self._load, path) # *** Don't load entire tree at once?
+
+	# Public methods:
+
+	def has_path (self, path):
+		"""Return True iff the given path is present"""
+		if path not in self.d: self._fetch_path(path)
+		return path in self.d
+
+	def has_rev (self, path, revnum):
+		"""Return True iff the given path:revnum is present"""
+		if path not in self.d: self._fetch_path(path)
+		return path in self.d and revnum in self.d[path].revs
+
+	def get_mode (self, path):
+		"""Return mode bits for the given path"""
+		if path not in self.d: self._fetch_path(path)
+		return self.d[path].mode
+
+	def get_blob (self, path, revnum):
+		"""Return the blob name for the given revision"""
+		if path not in self.d: self._fetch_path(path)
+		return self.d[path].revs[revnum].blob
+
+	def get_commits (self, path, revnum):
+		"""Return the commit names containing the given revision"""
+		if path not in self.d: self._fetch_path(path)
+		return self.d[path].revs[revnum].commits
+
+	def has_unresolved_marks (self):
+		"""Return True iff there are mark nums in the data structure"""
+		return self.marknum_idx
+
+	# Public methods that change/add information:
+
+	def add_path (self, path, mode):
+		"""Add the given path and associated mode bits to this map"""
+		if path not in self.d: self._fetch_path(path)
+		if path in self.d:
+			if self.d[path].mode:
+				assert mode == self.d[path].mode, \
+					"The mode of %s has changed from %s " \
+					"to %s since the last import. This " \
+					"is not supported." % (
+						path, self.d[path].mode, mode)
+			else:
+				self.d[path].mode = mode
+		else:
+			self.d[path] = CvsPathInfo(mode)
+		# Do not add to self.mods yet, as we expect revisions to be
+		# added before commit() is called
+
+	def add_blob (self, path, revnum, blobname):
+		"""Add the given path:revnum -> blobname association"""
+		assert blobname
+		if path not in self.d: self._fetch_path(path)
+		blobname = self._valid_objname(blobname)
+		if isinstance(blobname, int): # mark num
+			self._add_to_marknum_idx(blobname, path, revnum)
+		entry = self.d.setdefault(path, CvsPathInfo())
+		assert revnum not in entry.revs
+		entry.revs[revnum] = CvsRevInfo(blobname)
+		self.mods.add((path, revnum))
+
+	def add_commit (self, path, revnum, commitname):
+		"""Add the given path:revnum -> commitname association"""
+		if path not in self.d: self._fetch_path(path)
+		commitname = self._valid_objname(commitname)
+		if isinstance(commitname, int): # mark num
+			self._add_to_marknum_idx(commitname, path, revnum)
+		assert revnum in self.d[path].revs
+		assert commitname not in self.d[path].revs[revnum].commits
+		self.d[path].revs[revnum].commits.append(commitname)
+		self.mods.add((path, revnum))
+
+	@file_reader_method(missing_ok = True)
+	def load_marks_file (self, f):
+		"""Load mark -> SHA1 mappings from git-fast-import marks file
+
+		Replace all mark numbers with proper SHA1 names in this data
+		structure (using self.marknum_idx to find them quickly).
+		"""
+		if not f: return 0
+		marks = {}
+		last_mark = 0
+		for line in f:
+			(mark, sha1) = line.strip().split()
+			assert mark.startswith(":")
+			mark = int(mark[1:])
+			assert mark not in marks
+			marks[mark] = sha1
+			if mark > last_mark: last_mark = mark
+		for marknum, revs in self.marknum_idx.iteritems():
+			sha1 = marks[marknum]
+			for path, revnum in revs:
+				if path not in self.d: self._fetch_path(path)
+				rev_info = self.d[path].revs[revnum]
+				if rev_info.blob == marknum: # replace blobname
+					rev_info.blob = sha1
+				else: # replace commitname
+					assert marknum in rev_info.commits
+					i = rev_info.commits.index(marknum)
+					rev_info.commits[i] = sha1
+					assert marknum not in rev_info.commits
+				self.mods.add((path, revnum))
+		self.marknum_idx = {} # resolved all transient mark numbers
+		return last_mark
+
+	def sync_modeinfo_from_cvs (self, cvs):
+		"""Update with mode information from current CVS checkout
+
+		This method will retrieve mode information on all paths in the
+		current CVS checkout, and update this data structure
+		correspondingly. In the case where mode information is already
+		present for a given CVS path, this method will verify that such
+		information is correct.
+		"""
+		for path, mode in cvs.get_modeinfo().iteritems():
+			self.add_path(path, mode)
+
+	def commit_map (self, gfi, author, message):
+		"""Produce git-fast-import commands for storing changes
+
+		The given GitFastImport object is used to produce a commit
+		making the changes done to this data structure persistent.
+		"""
+		now = CvsDate("now")
+		commitdata = GitFICommit(
+			author[0], author[1], now.ts, now.tz_str(), message)
+
+		# Add updated MarkNumIndexFile to commit
+		mark = gfi.blob(self._save_marknum_idx())
+		commitdata.modify(644, mark, self.MarkNumIndexFile)
+
+		for path, revnum in self.mods:
+			mark = gfi.blob(self._save_rev(path, revnum))
+			mode = self.d[path].mode
+			assert mode in (644, 755)
+			commitdata.modify(mode, mark, "%s/%s" % (path, revnum))
+
+		gfi.commit(self.git_ref, commitdata)
+		self.mods = set()
+
+
+class CvsStateMap (object):
+	"""Map CvsState object to the commit names which produces that state"""
+	def __init__ (self, cvs_rev_map):
+		self.cvs_rev_map = cvs_rev_map
+
+	def get_commits (self, state):
+		"""Map the given CvsState to commits that contain this state
+
+		Return all commits where the given state is a subset of the
+		state produced by that commit.
+
+		Returns a set of commit names. The set may be empty.
+		"""
+		candidate_commits = None
+		for path, revnum in state:
+			commits = self.cvs_rev_map.get_commits(path, revnum)
+			if candidate_commits is None:
+				candidate_commits = set(commits)
+			else:
+				candidate_commits.intersection_update(commits)
+		return candidate_commits
+
+	def get_exact_commit (self, state, commit_map):
+		"""Map the given CvsState to the commit with this exact state
+
+		The given commit_map must be a CommitStates object.
+
+		Return the only commit (if any) that produces the exact given
+		CvsState.
+
+		Returns a commit name, or None if no matching commit is found.
+		"""
+		commits = self.get_commits(state)
+		for c in commits:
+			if state == commit_map.get(c): return c
+		return None
diff --git a/git_remote_cvs/cvs_symbol_cache.py b/git_remote_cvs/cvs_symbol_cache.py
new file mode 100644
index 0000000..a8ec18a
--- /dev/null
+++ b/git_remote_cvs/cvs_symbol_cache.py
@@ -0,0 +1,283 @@
+#!/usr/bin/env python
+
+"""Functionality for interacting with the local CVS symbol cache"""
+
+import os
+
+from util import *
+from cvs  import *
+
+
+class CvsSymbolStateLister (CvsLogParser):
+	"""Extract current CvsStates for all CVS symbols from a CVS log"""
+
+	def __init__ (self, cvs_repo, show_progress = False):
+		super(CvsSymbolStateLister, self).__init__(cvs_repo)
+		self.symbols = {} # CVS symbol name -> CvsState object
+
+		self.cur_file = None      # current CVS file being processed
+		self.cur_file_numrevs = 0 # #revs in current CVS file
+		self.cur_revnum = None    # current revision number
+		self.rev2syms = {}        # CvsNum -> [CVS symbol names]
+		self.cur_revs = {}        # CvsNum -> True/False (deleted)
+		self.head_num = None      # CvsNum of the HEAD rev or branch
+
+		# Possible states:
+		# - BeforeSymbols - waiting for "symbolic names:"
+		# - WithinSymbols - reading CVS symbol names
+		# - BeforeRevs  - waiting for "total revisions:"
+		# - BetweenRevs - waiting for "----------------------------"
+		# - ReadingRev  - reading CVS revision details
+		self.state = 'BeforeSymbols'
+
+		self.progress = None
+		if show_progress:
+			self.progress = ProgressIndicator("\t", sys.stderr)
+
+	def finalize_symbol_states (self):
+		"""Adjust CvsStates in self.symbols based on revision data
+
+		Based on the information found in self.rev2syms and
+		self.cur_revs, remove deleted revisions and turn branch numbers
+		into corresponding revisions in the CvsStates found in
+		self.symbols.
+		"""
+		# Create a mapping from branch numbers to the last existing
+		# revision number on those branches
+		branch2lastrev = {} # branch number -> revision number
+		for revnum in self.cur_revs.iterkeys():
+			branchnum = revnum.branch()
+			if (branchnum not in branch2lastrev) or \
+			   (revnum > branch2lastrev[branchnum]):
+				branch2lastrev[branchnum] = revnum
+
+		for cvsnum, symbols in self.rev2syms.iteritems():
+			if cvsnum.is_branch():
+				# Turn into corresponding revision number
+				revnum = branch2lastrev.get(
+					cvsnum, cvsnum.parent())
+				for s in symbols:
+					state = self.symbols[s]
+					assert state[self.cur_file] == cvsnum
+					state.replace(self.cur_file, revnum)
+				cvsnum = revnum
+			assert cvsnum.is_rev()
+			assert cvsnum in self.cur_revs
+			if self.cur_revs[cvsnum]: # cvsnum is a deleted rev
+				# Remove from CvsStates
+				for s in symbols:
+					state = self.symbols[s]
+					state.remove(self.cur_file, cvsnum)
+
+		self.rev2syms = {}
+		self.cur_revs= {}
+		self.cur_file = None
+
+	def __call__ (self, line):
+		if self.state == 'BeforeSymbols':
+			if line.startswith("RCS file: "):
+				self.cur_file = self.cleanup_path(line[10:])
+				if self.progress:
+					self.progress("%5i symbols found - " \
+						"Parsing CVS file #%i: %s " \
+						% (
+							len(self.symbols),
+							self.progress.n,
+							self.cur_file,
+						))
+			if line.startswith("head: "):
+				self.head_num = CvsNum(line[6:])
+			if line.startswith("branch: "):
+				self.head_num = CvsNum(line[8:])
+			elif line == "symbolic names:":
+				assert self.head_num
+				s = self.symbols.setdefault("HEAD", CvsState())
+				s.add(self.cur_file, self.head_num)
+				r = self.rev2syms.setdefault(self.head_num, [])
+				r.append("HEAD")
+				self.head_num = None
+				self.state = 'WithinSymbols'
+		elif self.state == 'WithinSymbols':
+			if line.startswith("\t"):
+				symbol, cvsnum = line.split(":", 1)
+				symbol = symbol.strip()
+				cvsnum = CvsNum(cvsnum)
+				s = self.symbols.setdefault(symbol, CvsState())
+				s.add(self.cur_file, cvsnum)
+				r = self.rev2syms.setdefault(cvsnum, [])
+				r.append(symbol)
+			else:
+				self.state = 'BeforeRevs'
+		elif self.state == 'BeforeRevs':
+			if line.startswith("total revisions: "):
+				assert self.cur_file
+				totalrevs, selectedrevs = line.split(";")
+				self.cur_file_numrevs = \
+					int(selectedrevs.split(":")[1].strip())
+				self.state = 'BetweenRevs'
+		elif self.state == 'BetweenRevs':
+			if line == "----------------------------" or \
+			   line == "======================================" \
+			           "=======================================":
+				if self.cur_revnum:
+					assert self.cur_revnum in self.cur_revs
+					self.cur_revnum = None
+				if line == "----------------------------":
+					self.state = 'ReadingRev'
+				else:
+					# Finalize current CVS file
+					assert len(self.cur_revs) \
+						== self.cur_file_numrevs
+					self.finalize_symbol_states()
+					self.state = 'BeforeSymbols'
+		elif self.state == 'ReadingRev':
+			if line.startswith("revision "):
+				self.cur_revnum = CvsNum(line.split()[1])
+			else:
+				date, author, state, dummy = line.split(";", 3)
+				assert date.startswith("date: ")
+				assert author.strip().startswith("author: ")
+				assert state.strip().startswith("state: ")
+				state = state.strip()[7:]
+				assert self.cur_revnum not in self.cur_revs
+				deleted = state == "dead"
+				self.cur_revs[self.cur_revnum] = deleted
+				self.state = 'BetweenRevs'
+
+	def finish (self):
+		assert self.state == 'BeforeSymbols'
+		if self.progress:
+			self.progress.finish("Parsed %i symbols in %i files" \
+				% (len(self.symbols), self.progress.n))
+
+
+class CvsSymbolCache (object):
+	"""Local cache of the current CvsState of CVS symbols
+
+	Behaves like a dictionary of CVS symbol -> CvsState mappings.
+	"""
+
+	def __init__ (self, symbols_dir):
+		self.symbols_dir = symbols_dir
+		if not os.path.isdir(self.symbols_dir):
+			os.makedirs(self.symbols_dir)
+
+	def __len__ (self):
+		return len(os.listdir(self.symbols_dir))
+
+	def __iter__ (self):
+		for filename in os.listdir(self.symbols_dir):
+			yield filename
+
+	def items (self):
+		for filename in self:
+			yield (filename, self[filename])
+
+	def __contains__ (self, symbol):
+		"""Return True if the given symbol is present in this cache"""
+		return os.access(os.path.join(self.symbols_dir, symbol),
+		                 os.F_OK | os.R_OK)
+
+	def __getitem__ (self, symbol):
+		"""Return the cached CvsState of the given CVS symbol"""
+		try:
+			f = open(os.path.join(self.symbols_dir, symbol), 'r')
+		except IOError:
+			raise KeyError, "'%s'" % (symbol)
+		ret = CvsState()
+		ret.load(f)
+		f.close()
+		return ret
+
+	def __setitem__ (self, symbol, cvs_state):
+		"""Store the given CVS symbol and CvsState into the cache"""
+		cvs_state.save(os.path.join(self.symbols_dir, symbol))
+
+	def __delitem__ (self, symbol):
+		"""Remove the the given CVS symbol from the cache"""
+		os.remove(os.path.join(self.symbols_dir, symbol))
+
+	def get (self, symbol, default = None):
+		try:
+			return self[symbol]
+		except KeyError:
+			return default
+
+	def clear (self):
+		"""Remove all entries from the symbol cache"""
+		for filename in os.listdir(self.symbols_dir):
+			os.remove(os.path.join(self.symbols_dir, filename))
+
+	def sync_symbol (self, symbol, cvs, progress):
+		"""Synchronize the given CVS symbol with the CVS server
+
+		The given CVS workdir is used for the synchronization.
+		The retrieved CvsState is also returned
+		"""
+		progress("Retrieving state of CVS symbol '%s'..." % (symbol))
+		cvs.update(symbol)
+		state = cvs.get_state()
+
+		progress("Saving state of '%s' to symbol cache..." % (symbol))
+		self[symbol] = state
+
+	def sync_all_symbols (self, cvs_repo, progress, symbol_filter = None):
+		"""Synchronize this symbol cache with the CVS server
+
+		This may be very expensive if the CVS repository is large, or
+		has many symbols. After this method returns, the symbol cache
+		will be in sync with the current state on the server.
+
+		This method returns a dict with the keys 'unchanged',
+		'changed', 'added', and 'deleted', where each map to a list of
+		CVS symbols. Each CVS symbol appears in exactly one of these
+		lists.
+
+		If symbol_filter is given, it specifies functions that takes
+		one parameter - a CVS symbol name - and returns True if that
+		symbol should be synchronized, and False if that symbol should
+		be skipped. Otherwise all CVS symbols are synchronized.
+		"""
+		if symbol_filter is None: symbol_filter = lambda symbol: True
+
+		# 1. Run cvs rlog to fetch current CvsState for all CVS symbols
+		progress("Retrieving current state of all CVS symbols from " \
+		         "CVS server...", lf = True)
+		parser = CvsSymbolStateLister(cvs_repo, True)
+		retcode = parser.run()
+		if retcode:
+			raise EnvironmentError, (retcode,
+				"cvs rlog returned exit code %i" % (retcode))
+
+		# 2. Update symbol cache with new states from the CVS server
+		progress("Updating symbol cache with current CVS state...")
+		results = {}
+		result_keys = ("unchanged", "changed", "added", "deleted")
+		for k in result_keys: results[k] = []
+		# Classify existing symbols as unchanged, changed, or deleted
+		for symbol in filter(symbol_filter, self):
+			if symbol not in parser.symbols: # deleted
+				results["deleted"].append(symbol)
+				del self[symbol]
+			elif self[symbol] != parser.symbols[symbol]: # changed
+				results["changed"].append(symbol)
+				self[symbol] = parser.symbols[symbol]
+			else: # unchanged
+				results["unchanged"].append(symbol)
+			progress()
+		# Add symbols that are not in self
+		for symbol, state in parser.symbols.iteritems():
+			if not symbol_filter(symbol):
+				debug("Skipping CVS symbol '%s'...", symbol)
+			elif symbol in self:
+				assert state == self[symbol]
+			else: # added
+				results["added"].append(symbol)
+				self[symbol] = state
+			progress()
+
+		progress("Synchronized local symbol cache (%s)" % (
+			", ".join(["%i %s" % (len(results[k]), k) \
+				for k in result_keys])), True)
+
+		return results
diff --git a/git_remote_cvs/git.py b/git_remote_cvs/git.py
new file mode 100644
index 0000000..0696962
--- /dev/null
+++ b/git_remote_cvs/git.py
@@ -0,0 +1,586 @@
+#!/usr/bin/env python
+
+"""Functionality for interacting with Git repositories
+
+This module provides classes for interfacing with a Git repository.
+"""
+
+import os, re
+from binascii import hexlify
+from cStringIO import StringIO
+
+from util import *
+
+def get_git_dir ():
+	"""Return the path to the GIT_DIR for this repo"""
+	args = ("git", "rev-parse", "--git-dir")
+	exit_code, output, errors = run_command(args)
+	if exit_code:
+		die("Failed to retrieve git dir")
+	assert not errors
+	return output.strip()
+
+def parse_git_config ():
+	"""Return a dict containing the parsed version of 'git config -l'"""
+	exit_code, output, errors = run_command(("git", "config", "-z", "-l"))
+	if exit_code:
+		die("Failed to retrieve git configuration")
+	assert not errors
+	return dict([e.split('\n', 1) for e in output.split("\0") if e])
+
+def git_config_bool (value):
+	"""Convert the given git config string value to either True or False
+
+	Raise ValueError if the given string was not recognized as a boolean
+	value.
+	"""
+	norm_value = str(value).strip().lower()
+	if norm_value in ("true", "1", "yes", "on", ""): return True
+	if norm_value in ("false", "0", "no", "off", "none"): return False
+	raise ValueError, "Failed to parse '%s' into a boolean value" % (value)
+
+def valid_git_ref (ref_name):
+	"""Return True iff the given ref name is a valid git ref name"""
+	# The following is a reimplementation of the git check-ref-format
+	# command. The rules were derived from the git check-ref-format(1)
+	# manual page. This code should be replaced by a call to
+	# check_ref_format() in the git library, when such is available.
+	if ref_name.endswith('/')   or \
+	   ref_name.startswith('.') or \
+	   ref_name.count('/.')     or \
+	   ref_name.count('..')     or \
+	   ref_name.endswith('.lock'):
+		return False
+	for c in ref_name:
+		if ord(c) < 0x20 or ord(c) == 0x7f or c in " ~^:?*[":
+			return False
+	return True
+
+
+class GitObjectFetcher (object):
+	"""Provide parsed access to 'git cat-file --batch'"""
+	def __init__ (self):
+		"""Initiate a 'git cat-file --batch' session"""
+		self.queue = [] # list of object names to be submitted
+		self.in_transit = None # object name currently in transit
+
+		# 'git cat-file --batch' produces binary output which is likely
+		# to be corrupted by the default "rU"-mode pipe opened by
+		# start_command. (Mode == "rU" does universal new-line
+		# conversion, which mangles carriage returns.) Therefore, we
+		# open an explicitly binary-safe pipe for transferring the
+		# output from 'git cat-file --batch'.
+		pipe_r_fd, pipe_w_fd = os.pipe()
+		pipe_r = os.fdopen(pipe_r_fd, "rb")
+		pipe_w = os.fdopen(pipe_w_fd, "wb")
+		self.proc = start_command(
+			("git", "cat-file", "--batch"), stdout = pipe_w)
+		self.f = pipe_r
+
+	def __del__ (self):
+		assert not self.queue
+		assert self.in_transit is None
+		self.proc.stdin.close()
+		assert self.proc.wait() == 0 # zero exit code
+		assert self.f.read() == "" # no remaining output
+
+	def _submit_next_object (self):
+		"""Submit queue items to the 'git cat-file --batch' process
+
+		If there are items in the queue, and there is currently no item
+		currently in 'transit', then pop the first item off the queue,
+		and submit it.
+		"""
+		if self.queue and self.in_transit is None:
+			self.in_transit = self.queue.pop(0)
+			print >>self.proc.stdin, self.in_transit[0]
+
+	def push (self, obj, callback):
+		"""Push the given object name onto the queue
+
+		The given callback function will at some point in the future
+		be called exactly once with the following arguments:
+		- self   (this GitObjectFetcher instance)
+		- obj    (the object name provided to push())
+		- sha1   (the SHA1 of the object, if 'None' obj is missing)
+		- t      (the type of the object (tag/commit/tree/blob))
+		- size   (the size of the object in bytes)
+		- data   (the object contents)
+		"""
+		self.queue.append((obj, callback))
+		self._submit_next_object() # (re)start queue processing
+
+	def process_next_entry (self):
+		"""Read the next entry off the queue and invoke callback"""
+		obj, cb = self.in_transit
+		self.in_transit = None
+		header = self.f.readline()
+		if header == "%s missing\n" % (obj):
+			cb(self, obj, None, None, None, None)
+			return
+		sha1, t, size = header.split(" ")
+		assert len(sha1) == 40
+		assert t in ("tag", "commit", "tree", "blob")
+		assert size.endswith("\n")
+		size = int(size.strip())
+		data = self.f.read(size)
+		assert self.f.read(1) == "\n"
+		cb(self, obj, sha1, t, size, data)
+		self._submit_next_object()
+
+	def process (self):
+		"""Process the current queue until empty"""
+		while self.in_transit is not None:
+			self.process_next_entry()
+
+	# High-level convenience methods:
+
+	def get_sha1 (self, objspec):
+		"""Return the SHA1 of the object specified by 'objspec'
+
+		Return None if 'objspec' does not specify an existing object.
+		"""
+		class ObjHandler (object):
+			def __init__ (self, parser):
+				self.parser = parser
+				self.sha1 = None
+
+			def __call__ (self, parser, obj, sha1, t, size, data):
+				assert parser == self.parser
+				self.sha1 = sha1
+
+		handler = ObjHandler(self)
+		self.push(objspec, handler)
+		self.process()
+		return handler.sha1
+
+	def open_obj (self, objspec):
+		"""Return a file object wrapping the contents of a named object
+
+		The caller is responsible for calling .close() on the returned
+		file object.
+
+		Raise KeyError if 'objspec' does not exist in the repo.
+		"""
+		class ObjHandler (object):
+			def __init__ (self, parser):
+				self.parser = parser
+				self.contents = StringIO()
+				self.err = None
+
+			def __call__ (self, parser, obj, sha1, t, size, data):
+				assert parser == self.parser
+				if not sha1: # missing object
+					self.err = "Missing object '%s'" % obj
+					return
+				assert size == len(data)
+				self.contents.write(data)
+
+		handler = ObjHandler(self)
+		self.push(objspec, handler)
+		self.process()
+		if handler.err: raise KeyError, handler.err
+		handler.contents.seek(0)
+		return handler.contents
+
+	def walk_tree (self, tree_objspec, callback, prefix = ""):
+		"""Recursively walk the given Git tree object
+
+		Recursively walks all subtrees of the given tree object, and
+		invokes the given callback passing three arguments:
+		(path, mode, data) with the path, permission bits, and contents
+		of all the blobs found in the entire tree structure.
+		"""
+
+		class ObjHandler (object):
+			"""Helper class for walking a git tree structure"""
+			def __init__ (self, parser, cb, path, mode = None):
+				self.parser = parser
+				self.cb = cb
+				self.path = path
+				self.mode = mode
+				self.err = None
+
+			def parse_tree (self, treedata):
+				"""Parse tree object data, yield tree entries
+
+				Each tree entry is a 3-tuple (mode, sha1, path)
+
+				self.path is prepended to all paths yielded
+				from this method.
+				"""
+				while treedata:
+					mode = int(treedata[:6], 10)
+					# Turn 100xxx into xxx
+					if mode > 100000: mode -= 100000
+					assert treedata[6] == " "
+					i = treedata.find("\0", 7)
+					assert i > 0
+					path = treedata[7:i]
+					sha1 = hexlify(treedata[i + 1: i + 21])
+					yield (mode, sha1, self.path + path)
+					treedata = treedata[i + 21:]
+
+			def __call__ (self, parser, obj, sha1, t, size, data):
+				assert parser == self.parser
+				if not sha1: # missing object
+					self.err = "Missing object '%s'" % obj
+					return
+				assert size == len(data)
+				if t == "tree":
+					if self.path: self.path += "/"
+					# recurse into all blobs and subtrees
+					for m, s, p in self.parse_tree(data):
+						parser.push(s, self.__class__(
+							self.parser, self.cb,
+							p, m))
+				elif t == "blob":
+					self.cb(self.path, self.mode, data)
+				else:
+					raise ValueError, "Unknown object " \
+						"type '%s'" % (t)
+
+		self.push(tree_objspec, ObjHandler(self, callback, prefix))
+		self.process()
+
+
+class GitRefMap (object):
+	"""Map Git ref names to the Git object names they currently point to
+
+	Behaves like a dictionary of Git ref names -> Git object names.
+	"""
+
+	def __init__ (self, obj_fetcher):
+		self.obj_fetcher = obj_fetcher
+		self._cache = {} # dict: refname -> objname
+
+	def _load (self, ref):
+		if ref not in self._cache:
+			self._cache[ref] = self.obj_fetcher.get_sha1(ref)
+		return self._cache[ref]
+
+	def __contains__ (self, refname):
+		"""Return True if the given refname is present in this cache"""
+		return bool(self._load(refname))
+
+	def __getitem__ (self, refname):
+		"""Return the CvsState of the given refname"""
+		commit = self._load(refname)
+		if commit is None:
+			raise KeyError, "Unknown ref '%s'" % (refname)
+		return commit
+
+	def get (self, refname, default = None):
+		commit = self._load(refname)
+		if commit is None: return default
+		return commit
+
+
+class GitFICommit (object):
+	"""Encapsulate the data in a Git fast-import commit command"""
+
+	SHA1RE = re.compile(r'^[0-9a-f]{40}$')
+
+	@classmethod
+	def parse_mode (cls, mode):
+		assert mode in (644, 755, 100644, 100755, 120000)
+		return "%i" % (mode)
+
+	@classmethod
+	def parse_objname (cls, objname):
+		if isinstance(objname, int): # object name is a mark number
+			assert objname > 0
+			return ":%i" % (objname)
+
+		# No existence check is done, only checks for valid format
+		assert cls.SHA1RE.match(objname) # object name is valid SHA1
+		return objname
+
+	@classmethod
+	def quote_path (cls, path):
+		path = path.replace("\\", "\\\\")
+		path = path.replace("\n", "\\n")
+		path = path.replace('"', '\\"')
+		return '"%s"' % (path)
+
+	@classmethod
+	def parse_path (cls, path):
+		assert not isinstance(path, int) # cannot be a mark number
+
+		# These checks verify the rules on the fast-import man page
+		assert not path.count("//")
+		assert not path.endswith("/")
+		assert not path.startswith("/")
+		assert not path.count("/./")
+		assert not path.count("/../")
+		assert not path.endswith("/.")
+		assert not path.endswith("/..")
+		assert not path.startswith("./")
+		assert not path.startswith("../")
+
+		if path.count('"') + path.count('\n') + path.count('\\'):
+			return cls.quote_path(path)
+		return path
+
+	@classmethod
+	def test (cls):
+		def expect_fail (method, data):
+			try: method(data)
+			except AssertionError: return
+			raise AssertionError, "Failed test for invalid data " \
+				"'%s(%s)'" % (method.__name__, repr(data))
+
+		# Test parse_mode()
+		assert cls.parse_mode(644) == "644"
+		assert cls.parse_mode(755) == "755"
+		assert cls.parse_mode(100644) == "100644"
+		assert cls.parse_mode(100755) == "100755"
+		assert cls.parse_mode(120000) == "120000"
+		expect_fail(cls.parse_mode, 0)
+		expect_fail(cls.parse_mode, 123)
+		expect_fail(cls.parse_mode, 600)
+		expect_fail(cls.parse_mode, "644")
+		expect_fail(cls.parse_mode, "abc")
+
+		# Test parse_objname()
+		assert cls.parse_objname(1) == ":1"
+		expect_fail(cls.parse_objname, 0)
+		expect_fail(cls.parse_objname, -1)
+		assert cls.parse_objname("0123456789" * 4) == "0123456789" * 4
+		assert cls.parse_objname("2468abcdef" * 4) == "2468abcdef" * 4
+		expect_fail(cls.parse_objname, "abcdefghij" * 4)
+
+		# Test parse_path()
+		assert cls.parse_path("foo/bar") == "foo/bar"
+		assert cls.parse_path(1) == ":1"
+		assert cls.parse_path("path/with\n and \" in it") \
+			== '"path/with\\n and \\" in it"'
+		expect_fail(cls.parse_path, 0)
+		expect_fail(cls.parse_path, -1)
+		expect_fail(cls.parse_path, "foo//bar")
+		expect_fail(cls.parse_path, "foo/bar/")
+		expect_fail(cls.parse_path, "/foo/bar")
+		expect_fail(cls.parse_path, "foo/./bar")
+		expect_fail(cls.parse_path, "foo/../bar")
+		expect_fail(cls.parse_path, "foo/bar/.")
+		expect_fail(cls.parse_path, "foo/bar/..")
+		expect_fail(cls.parse_path, "./foo/bar")
+		expect_fail(cls.parse_path, "../foo/bar")
+
+	def __init__ (self, name, email, timestamp, timezone, message):
+		self.name      = name
+		self.email     = email
+		self.timestamp = timestamp
+		self.timezone  = timezone
+		self.message   = message
+		self.pathops   = [] # List of path operations in this commit
+
+	def modify (self, mode, blobname, path):
+		self.pathops.append(("M",
+			self.parse_mode(mode),
+			self.parse_objname(blobname),
+			self.parse_path(path)))
+
+	def delete (self, path):
+		self.pathops.append(("D", self.parse_path(path)))
+
+	def copy (self, path, newpath):
+		self.pathops.append(("C",
+			self.parse_path(path),
+			self.parse_path(newpath)))
+
+	def rename (self, path, newpath):
+		self.pathops.append(("R",
+			self.parse_path(path),
+			self.parse_path(newpath)))
+
+	def note (self, blobname, commit):
+		self.pathops.append(("N",
+			self.parse_objname(blobname),
+			self.parse_objname(commit)))
+
+	def deleteall (self):
+		self.pathops.append("deleteall")
+
+
+class GitFastImport (object):
+	"""Encapsulate communication with git fast-import"""
+
+	def __init__ (self, f, obj_fetcher, last_mark = 0):
+		self.f = f # File object where fast-import stream is written
+		self.obj_fetcher = obj_fetcher # GitObjectFetcher instance
+		self.next_mark = last_mark + 1 # Next mark number
+		self.refs = set() # keep track of the refnames we've seen
+
+	def comment (self, s):
+		"""Write the given comment in the fast-import stream"""
+		assert "\n" not in s, "Malformed comment: '%s'" % (s)
+		self.f.write("# %s\n" % (s))
+
+	def commit (self, ref, commitdata):
+		"""Make a commit on the given ref, with the given GitFICommit
+
+		Return the mark number identifying this commit.
+		"""
+		self.f.write("""\
+commit %(ref)s
+mark :%(mark)i
+committer %(name)s <%(email)s> %(timestamp)i %(timezone)s
+data %(msgLength)i
+%(msg)s
+"""% {
+	'ref':       ref,
+	'mark':      self.next_mark,
+	'name':      commitdata.name,
+	'email':     commitdata.email,
+	'timestamp': commitdata.timestamp,
+	'timezone':  commitdata.timezone,
+	'msgLength': len(commitdata.message),
+	'msg':       commitdata.message,
+})
+
+		if ref not in self.refs:
+			self.refs.add(ref)
+			parent = ref + "^0"
+			if self.obj_fetcher.get_sha1(parent):
+				self.f.write("from %s\n" % (parent))
+
+		for op in commitdata.pathops:
+			self.f.write(" ".join(op))
+			self.f.write("\n")
+		self.f.write("\n")
+		retval = self.next_mark
+		self.next_mark += 1
+		return retval
+
+	def blob (self, data):
+		"""Import the given blob
+
+		Return the mark number identifying this blob.
+		"""
+		self.f.write("blob\nmark :%i\ndata %i\n%s\n" \
+			% (self.next_mark, len(data), data))
+		retval = self.next_mark
+		self.next_mark += 1
+		return retval
+
+	def reset (self, ref, objname):
+		self.f.write("reset %s\nfrom %s\n\n" % \
+			(ref, GitFICommit.parse_objname(objname)))
+		if ref not in self.refs:
+			self.refs.add(ref)
+
+
+class GitNotes (object):
+	"""Encapsulate access to Git notes
+
+	Behaves like a dictionary of object name (SHA1) -> Git note mappings.
+	"""
+	def __init__ (self, notes_ref, obj_fetcher):
+		self.notes_ref = notes_ref
+		self.obj_fetcher = obj_fetcher # used to get objects from repo
+		self.imports = [] # list: (objname, note data blob name) tuples
+
+	def __del__ (self):
+		if self.imports:
+			error("Missing call to self.commit_notes().")
+			error("%i notes are not committed!", len(self.imports))
+
+	def _load (self, objname):
+		try:
+			f = self.obj_fetcher.open_obj(
+				"%s:%s" % (self.notes_ref, objname))
+			ret = f.read()
+			f.close()
+		except KeyError:
+			ret = None
+		return ret
+
+	def __getitem__ (self, objname):
+		"""Return the note contents associated with the given object
+
+		Raise KeyError if given object has no associated note.
+		"""
+		blobdata = self._load(objname)
+		if blobdata is None:
+			raise KeyError, "Object '%s' has no note" % (objname)
+		return blobdata
+
+	def get (self, objname, default = None):
+		"""Return the note contents associated with the given object
+
+		Return given default if given object has no associated note.
+		"""
+		blobdata = self._load(objname)
+		if blobdata is None: return default
+		return blobdata
+
+	def import_note (self, objname, data, gfi):
+		"""Tell git fast-import to store data as a note for objname
+
+		This method uses the given GitFastImport object to create a
+		blob containing the given note data. Also an entry mapping the
+		given object name to the created blob is stored until
+		commit_notes() is called.
+
+		Note that this method only works if later followed with a call
+		to commit_notes() (which produces the note commit that refers
+		to the blob produced here).
+		"""
+		if not data.endswith("\n"): data += "\n"
+		gfi.comment("Importing note for object %s" % (objname))
+		mark = gfi.blob(data)
+		self.imports.append((objname, mark))
+
+	def commit_notes (self, gfi, author, message):
+		"""Produce a git fast-import note commit for the imported notes
+
+		This method uses the given GitFastImport object to create a
+		commit on the notes ref, introducing the notes previously
+		submitted to import_note().
+		"""
+		if not self.imports: return # Nothing to do
+
+		from cvs import CvsDate
+		now = CvsDate("now")
+		commitdata = GitFICommit(
+			author[0], author[1], now.ts, now.tz_str(), message)
+
+		for objname, blobname in self.imports:
+			assert isinstance(objname,  int) and objname  > 0
+			assert isinstance(blobname, int) and blobname > 0
+			commitdata.note(blobname, objname)
+
+		gfi.commit(self.notes_ref, commitdata)
+		self.imports = []
+
+
+class GitCachedNotes (GitNotes):
+	"""Encapsulate access to Git notes (cached version)
+
+	Only use this class if no caching is done at a higher level.
+
+	Behaves like a dictionary of object name (SHA1) -> Git note mappings.
+	"""
+	def __init__ (self, notes_ref, obj_fetcher):
+		GitNotes.__init__(self, notes_ref, obj_fetcher)
+		self._cache = {} # cache: object name -> note data
+
+	def __del__ (self):
+		GitNotes.__del__(self)
+
+	def _load (self, objname):
+		if objname not in self._cache:
+			self._cache[objname] = GitNotes._load(self, objname)
+		return self._cache[objname]
+
+	def import_note (self, objname, data, gfi):
+		if not data.endswith("\n"): data += "\n"
+		assert objname not in self._cache
+		self._cache[objname] = data
+		GitNotes.import_note(self, objname, data, gfi)
+
+
+if __name__ == '__main__':
+	# Run selftests
+	GitFICommit.test()
diff --git a/git_remote_cvs/setup.py b/git_remote_cvs/setup.py
new file mode 100644
index 0000000..64c9209
--- /dev/null
+++ b/git_remote_cvs/setup.py
@@ -0,0 +1,12 @@
+from distutils.core import setup
+setup(
+	name         = 'git_remote_cvs',
+	version      = '0.1.0',
+	description  = 'Git remote helper program for CVS repositories',
+	license      = 'GPLv2',
+	author       = 'The Git Community',
+	author_email = 'git@vger.kernel.org',
+	url          = 'http://www.git-scm.com/',
+	package_dir  = {'git_remote_cvs': ''},
+	packages     = ['git_remote_cvs'],
+)
diff --git a/git_remote_cvs/util.py b/git_remote_cvs/util.py
new file mode 100644
index 0000000..6877454
--- /dev/null
+++ b/git_remote_cvs/util.py
@@ -0,0 +1,147 @@
+#!/usr/bin/env python
+
+"""Misc. useful functionality used by the rest of this package
+
+This module provides common functionality used by the other modules in this
+package.
+"""
+
+import sys, os, subprocess
+
+
+# Whether or not to show debug messages
+Debug = False
+
+def debug (msg, *args):
+	if Debug: print >>sys.stderr, msg % args
+
+def error (msg, *args):
+	print >>sys.stderr, "ERROR:", msg % args
+
+def die (msg, *args):
+	error(msg, *args)
+	sys.exit(1)
+
+
+class ProgressIndicator (object):
+	"""Simple progress indicator
+
+	Displayed as a spinning character by default, but can be customized by
+	passing custom messages that will override the spinning character.
+	"""
+
+	States = ("|", "/", "-", "\\")
+
+	def __init__ (self, prefix = "", f = sys.stdout):
+		self.n = 0        # Simple progress counter
+		self.f = f        # Progress is written to this file object
+		self.prev_len = 0 # Length of previous msg (to be overwritten)
+		self.prefix = prefix
+		self.prefix_lens = []
+
+	def pushprefix (self, prefix):
+		self.prefix_lens.append(len(self.prefix))
+		self.prefix += prefix
+
+	def popprefix (self):
+		prev_len = self.prefix_lens.pop()
+		self.prefix = self.prefix[:prev_len]
+
+	def __call__ (self, msg = None, lf = False):
+		if msg is None: msg = self.States[self.n % len(self.States)]
+		msg = self.prefix + msg
+		print >>self.f, "\r%-*s" % (self.prev_len, msg),
+		self.prev_len = len(msg.expandtabs())
+		if lf:
+			print >>self.f
+			self.prev_len = 0
+		self.n += 1
+
+	def finish (self, msg = "done", noprefix = False):
+		if noprefix: self.prefix = ""
+		self(msg, True)
+
+
+def start_command (args, cwd = None, shell = False, add_env = None,
+                   stdin = subprocess.PIPE,
+                   stdout = subprocess.PIPE,
+                   stderr = subprocess.PIPE):
+	env = None
+	if add_env is not None:
+		env = os.environ.copy()
+		env.update(add_env)
+	return subprocess.Popen(args, # run command
+		bufsize            = 1, # line buffered
+		stdin              = stdin,  # write to process
+		stdout             = stdout, # read from process
+		stderr             = stderr,
+		cwd                = cwd,
+		shell              = shell,
+		env                = env,
+		universal_newlines = True,
+	)
+
+def run_command (args, cwd = None, shell = False, add_env = None,
+                 flag_error = True):
+	process = start_command(args, cwd, shell, add_env)
+	(output, errors) = process.communicate()
+	exit_code = process.returncode
+	if flag_error and errors:
+		error("'%s' returned errors:\n---\n%s---",
+		      " ".join(args), errors)
+	if flag_error and exit_code:
+		error("'%s' returned exit code %i", " ".join(args), exit_code)
+	return (exit_code, output, errors)
+
+
+def file_reader_method (missing_ok = False):
+	"""Decorator for simplifying reading of files.
+
+	If missing_ok is True, a failure to open a file for reading will not
+	raise the usual IOError, but instead the wrapped method will be called
+	with f == None. The method must in this case properly handle f == None.
+	"""
+	def wrap (method):
+		"""Teach given method to handle both filenames and file objects
+
+		The given method must take a file object as its second argument
+		(the first argument being 'self', of course). This decorator
+		will take a filename given as the second argument and promote
+		it to a file object.
+		"""
+		def wrapped_method (self, filename, *args, **kwargs):
+			if isinstance(filename, file): f = filename # No-op
+			else:
+				try:
+					f = open(filename, 'r')
+				except IOError:
+					if missing_ok: f = None
+					else: raise
+			try:
+				return method(self, f, *args, **kwargs)
+			finally:
+				if not isinstance(filename, file) and f:
+					f.close()
+		return wrapped_method
+	return wrap
+
+def file_writer_method (method):
+	"""Enable the given method to handle both filenames and file objects
+
+	The given method must take a file object as its second argument (the
+	first argument being 'self', of course). This decorator will take a
+	filename given as the second argument and promote it to a file object.
+	"""
+	def new_method (self, filename, *args, **kwargs):
+		if isinstance(filename, file): f = filename # Nothing to do
+		else:
+			# Make sure the containing directory exists
+			parent_dir = os.path.dirname(filename)
+			if not os.path.isdir(parent_dir):
+				os.makedirs(parent_dir)
+			f = open(filename, 'w')
+		try:
+			return method(self, f, *args, **kwargs)
+		finally:
+			if not isinstance(filename, file): f.close()
+	return new_method
-- 
1.6.4.rc3.138.ga6b98.dirty
