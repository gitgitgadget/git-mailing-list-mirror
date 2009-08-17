From: Johan Herland <johan@herland.net>
Subject: [RFCv4 3/5] 2/2: Add Python support library for CVS remote helper
Date: Mon, 17 Aug 2009 05:35:59 +0200
Message-ID: <1250480161-21933-4-git-send-email-johan@herland.net>
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
	id 1Mct1j-0006ij-T3
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 05:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756751AbZHQDgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 23:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756747AbZHQDgn
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 23:36:43 -0400
Received: from smtp.getmail.no ([84.208.15.66]:47299 "EHLO
	get-mta-out03.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756743AbZHQDgj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Aug 2009 23:36:39 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOI00CDR4P34N60@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 17 Aug 2009 05:36:39 +0200 (MEST)
Received: from localhost.localdomain ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KOI00M7C4OTJP20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 17 Aug 2009 05:36:39 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.17.32416
X-Mailer: git-send-email 1.6.4.262.gca66a.dirty
In-reply-to: <1250480161-21933-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126111>

This patch introduces the rest of a Python package called "git_remote_cvs"
containing the building blocks of the CVS remote helper. The CVS remote
helper itself is NOT part of this patch.

The patch includes the necessary Makefile additions to build and install
the git_remote_cvs Python package along with the rest of Git.

This patch has been improved by the following contributions:
- David Aguilar: Lots of Python coding style fixes
- David Aguilar: DESTDIR support in Makefile

Cc: David Aguilar <davvid@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---

This patch and the previous patch belong together in the same commit,
but the 100K limit (?) on the git mailing list forces me to split this
patch in two.

...Johan

 Makefile                           |    9 +
 git_remote_cvs/.gitignore          |    2 +
 git_remote_cvs/Makefile            |   35 ++
 git_remote_cvs/__init__.py         |   27 ++
 git_remote_cvs/commit_states.py    |   62 ++++
 git_remote_cvs/cvs_revision_map.py |  418 ++++++++++++++++++++++
 git_remote_cvs/git.py              |  680 ++++++++++++++++++++++++++++++++++++
 git_remote_cvs/setup.py            |   17 +
 8 files changed, 1250 insertions(+), 0 deletions(-)
 create mode 100644 git_remote_cvs/.gitignore
 create mode 100644 git_remote_cvs/Makefile
 create mode 100644 git_remote_cvs/__init__.py
 create mode 100644 git_remote_cvs/commit_states.py
 create mode 100644 git_remote_cvs/cvs_revision_map.py
 create mode 100644 git_remote_cvs/git.py
 create mode 100644 git_remote_cvs/setup.py

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
index 0000000..061c247
--- /dev/null
+++ b/git_remote_cvs/Makefile
@@ -0,0 +1,35 @@
+#
+# Makefile for the git_remote_cvs python support modules
+#
+pysetupfile:=setup.py
+
+# Shell quote (do not use $(call) to accommodate ancient setups);
+DESTDIR_SQ = $(subst ','\'',$(DESTDIR))
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
+PYLIBDIR=$(shell $(PYTHON_PATH) -c \
+	 "import sys; \
+	 print 'lib/python%i.%i/site-packages' % sys.version_info[:2]")
+
+all: $(pysetupfile)
+	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
+
+install: $(pysetupfile)
+	$(PYTHON_PATH) $(pysetupfile) install --prefix $(DESTDIR_SQ)$(prefix)
+
+instlibdir: $(pysetupfile)
+	@echo "$(prefix)/$(PYLIBDIR)"
+
+clean:
+	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) clean -a
+	$(RM) *.pyo *.pyc
diff --git a/git_remote_cvs/__init__.py b/git_remote_cvs/__init__.py
new file mode 100644
index 0000000..4956d2d
--- /dev/null
+++ b/git_remote_cvs/__init__.py
@@ -0,0 +1,27 @@
+#!/usr/bin/env python
+
+"""Support library package for git-remote-cvs.
+
+git-remote-cvs is a Git remote helper command that interfaces with a
+CVS repository to provide automatic import of CVS history into a Git
+repository.
+
+This package provides the support library needed by git-remote-cvs.
+The following modules are included:
+
+- cvs - Interaction with CVS repositories
+
+- cvs_symbol_cache - Local CVS symbol cache
+
+- changeset - Collect individual CVS revisions into commits
+
+- git - Interaction with Git repositories
+
+- commit_states - Map Git commits to CVS states
+
+- cvs_revision_map - Map CVS revisions to various metainformation
+
+- util - General utility functionality use by the other modules in
+         this package, and also used directly by git-remote-cvs.
+
+"""
diff --git a/git_remote_cvs/commit_states.py b/git_remote_cvs/commit_states.py
new file mode 100644
index 0000000..2e0af6c
--- /dev/null
+++ b/git_remote_cvs/commit_states.py
@@ -0,0 +1,62 @@
+#!/usr/bin/env python
+
+"""Code for relating Git commits to corresponding CVSState objects."""
+
+from git_remote_cvs.util import debug, error, die
+from git_remote_cvs.cvs import CVSState
+
+
+class CommitStates(object):
+
+    """Provide a mapping from Git commits to CVSState objects.
+
+    Behaves like a dictionary of Git commit names -> CVSState mappings.
+
+    Every Git commit converted from CVS has a corresponding CVSState,
+    which describes exactly which CVS revisions are present in a
+    checkout of that commit.
+
+    This class provides the interface to map from a Git commit to its
+    corresponding CVSState.  The mapping uses GitNotes as a persistent
+    storage backend.
+
+    """
+
+    def __init__ (self, notes):
+        """Create a new Git commit -> CVSState map."""
+        self.notes = notes
+        self._cache = {}  # commitname -> CVSState
+
+    def _load (self, commit):
+        """Retrieve the CVSState associated with the given Git commit."""
+        if commit is None:
+            return None
+        if commit in self._cache:
+            return self._cache[commit]
+        notedata = self.notes.get(commit)
+        if notedata is None:  # Given commit has no associated note
+            return None
+        state = CVSState()
+        state.load_data(notedata)
+        self._cache[commit] = state
+        return state
+
+    def add (self, commit, state, gfi):
+        """Add the given Git commit -> CVSState mapping."""
+        assert commit not in self._cache
+        self._cache[commit] = state
+        self.notes.import_note(commit, str(state), gfi)
+
+    def __getitem__ (self, commit):
+        """Return the CVSState associated with the given commit."""
+        state = self._load(commit)
+        if state is None:
+            raise KeyError("Unknown commit '%s'" % (commit))
+        return state
+
+    def get (self, commit, default = None):
+        """Return the CVSState associated with the given commit."""
+        state = self._load(commit)
+        if state is None:
+            return default
+        return state
diff --git a/git_remote_cvs/cvs_revision_map.py b/git_remote_cvs/cvs_revision_map.py
new file mode 100644
index 0000000..0e65ba6
--- /dev/null
+++ b/git_remote_cvs/cvs_revision_map.py
@@ -0,0 +1,418 @@
+#!/usr/bin/env python
+
+"""Functionality for mapping CVS revisions to associated metainfo.
+
+This modules provides the following main classes:
+
+CVSRevisionMap - provides a mapping from CVS revisions to the
+                 the following associated metainfo:
+                 - Mode/permission of the associated CVS path
+                 - The Git blob holding the revision data
+                 - The Git commits that correspond to the CVS
+                   states in which this CVS revision is present
+
+CVSStateMap - provides a mapping from CVS states to corresponding
+              Git commits (i.e. Git commits, whose tree state is
+              identical to a given CVS state)
+"""
+
+import os
+
+from git_remote_cvs.util import debug, error, die, file_reader_method
+from git_remote_cvs.cvs import CVSNum, CVSDate
+from git_remote_cvs.git import GitFICommit
+
+
+class _CVSPathInfo(object):
+
+    """Information on a single CVS path."""
+
+    __slots__ = ('revs', 'mode')
+
+    def __init__ (self, mode = None):
+        self.revs = {}
+        self.mode = mode
+
+
+class _CVSRevInfo(object):
+
+    """Information on a single CVS revision."""
+
+    __slots__ = ('blob', 'commits')
+
+    def __init__ (self, blob):
+        self.blob = blob
+        self.commits = []
+
+
+class CVSRevisionMap(object):
+
+    """Encapsulate the mapping of CVS revisions to associated metainfo.
+
+    This container maps CVS revisions (a combination of a CVS path and
+    a CVS revision number) into Git blob names, Git commit names, and
+    CVS path information.  Git object (blob/commit) names are either
+    40-char SHA1 strings, or "git fast-import" mark numbers if the form
+    ":<num>".
+
+    The data structure is organized as follows:
+    - A CVSRevisionMap instance knows about a set of CVS paths.
+      For each CVS path, the following is known:
+      - The mode (permission bits) of that CVS path (644 or 755)
+      - The CVS revision numbers that exist for that CVS path.
+        For each revision number, the following is known:
+        - Exactly 1 blob name; the Git blob containing the contents of
+          the revision (the contents of the CVS path at that CVS
+          revision).
+        - One or more commit names; the Git commits which encapsulate a
+          CVS state in which this CVS revision
+
+    To store this data structure persistently, this class uses a Git
+    ref that points to a tree structure containing the above
+    information.  When changes to the structure are made, this class
+    will produce git-fast-import commands to update that tree structure
+    accordingly.
+
+    IMPORTANT: No changes to the CVSRevisionMap will be stored unless
+    self.commit_map() is called with a valid GitFastImport instance.
+
+    NOTES: Mark numbers are only transient references bound to the
+    current "git fast-import" process (assumed to be running alongside
+    this process).  Therefore, when the "git fast-import" process ends,
+    it must write out a mark number -> SHA1 mapping (see the
+    "--export-marks" argument to "git fast-import").  Subsequently,
+    this mapping must be parsed, and the mark numbers in this
+    CVSRevisionMap must be resolved into persistent SHA1 names.
+    In order to quickly find all the unresolved mark number entries in
+    the data structure, and index mapping mark numbers to revisions is
+    kept in a separate file in the tree structure.
+    See the loadMarksFile() method for more details.
+
+    """
+
+    MarkNumIndexFile = "CVS/marks"  # Invalid CVS path name
+
+    def __init__ (self, git_ref, obj_fetcher):
+        """Create a new CVS revision map bound to the given Git ref."""
+        self.git_ref = git_ref
+        self.obj_fetcher = obj_fetcher
+
+        # The following data structure is a cache of the persistent
+        # data structure found at self.git_ref.
+        # It is structured as follows:
+        # - self.d is a mapping from CVS paths to _CVSPathInfo objects.
+        #   _CVSPathInfo object have two fields: revs, mode:
+        #   - mode is either 644 (non-executable) or 755 (executable).
+        #   - revs is a dict, mapping CVS revision numbers (CVSNum
+        #     instances) to _CVSRevInfo objects.  _CVSRevInfo objects
+        #     have two fields: blob, commits:
+        #     - blob is the name of the Git blob object holding the
+        #       contents of that revision.
+        #     - commits is a collection of zero or more Git commit
+        #       names where the commit contains this revision.
+        self.d = {}  # dict: path -> _CVSPathInfo
+        self.mods = set()  # (path, revnum) pairs for all modified revs
+        self.marknum_idx = {}  # dict: mark num -> [(path, revnum), ...]
+        self._load_marknum_idx()
+
+    def __del__ (self):
+        """Verify that self.commit_map() was called before destruction."""
+        if self.mods:
+            error("Missing call to self.commit_map().")
+            error("%i revision changes are lost!", len(self.mods))
+
+    def __nonzero__ (self):
+        """Return True iff any information is currently stored here."""
+        return bool(self.d)
+
+    # Private methods:
+
+    def _add_to_marknum_idx(self, marknum, path, revnum):
+        """Add the given marknum -> (path, revnum) association."""
+        entry = self.marknum_idx.setdefault(marknum, [])
+        entry.append((path, revnum))
+
+    def _load_marknum_idx(self):
+        """Load contents of MarkNumIndexFile into self.marknum_idx."""
+        blobspec = "%s:%s" % (self.git_ref, self.MarkNumIndexFile)
+        try:
+            f = self.obj_fetcher.open_obj(blobspec)
+        except KeyError:
+            return  # Missing object; nothing to do
+
+        for line in f:
+            # Format of line is "<marknum> <path>:<revnum>"
+            mark, rest = line.strip().split(' ', 1)
+            path, rev = rest.rsplit(':', 1)
+            self._add_to_marknum_idx(int(mark), path, CVSNum(rev))
+        f.close()
+
+    def _save_marknum_idx(self):
+        """Prepare data for storage into MarkNumIndexFile.
+
+        The returned string contains the current contents of
+        self.marknum_idx, formatted to be stored verbatim in
+        self.MarkNumIndexFile.
+
+        """
+        lines = []
+        for marknum, revs in sorted(self.marknum_idx.iteritems()):
+            for path, revnum in revs:
+                # Format of line is "<marknum> <path>:<revnum>"
+                line = "%i %s:%s\n" % (marknum, path, revnum)
+                lines.append(line)
+        return "".join(lines)
+
+    def _save_rev(self, path, revnum):
+        """Return blob data for storing the given revision persistently.
+
+        Generate the blob contents that will reconstitute the same
+        revision entry when read back in with _fetch_path().
+
+        """
+        lines = []
+        rev_info = self.d[path].revs[revnum]
+        lines.append("blob %s\n" % (rev_info.blob))
+        for commit in rev_info.commits:
+            lines.append("commit %s\n" % (commit))
+        return "".join(lines)
+
+    @staticmethod
+    def _valid_objname (objname):
+        """Return the argument as a SHA1 (string) or mark num (int)."""
+        # Blob names are either 40-char SHA1 strings, or mark numbers
+        if isinstance(objname, int) or len(objname) != 40:  # Mark number
+            return int(objname)
+        return objname
+
+    def _load (self, path, mode, data):
+        """GitObjectFetcher.walk_tree() callback."""
+        assert mode in (644, 755)
+        cvs_path, revnum = os.path.split(path)
+        revnum = CVSNum(revnum)
+        if cvs_path in self.d:
+            assert mode == self.d[cvs_path].mode
+        else:
+            self.d[cvs_path] = _CVSPathInfo(mode)
+        assert revnum not in self.d[cvs_path].revs
+        rev_info = None
+        for line in data.split("\n"):
+            if not line:
+                continue
+            t, objname = line.split()
+            objname = self._valid_objname(objname)
+            if t == "blob":
+                assert rev_info is None
+                rev_info = _CVSRevInfo(objname)
+            elif t == "commit":
+                assert rev_info is not None
+                rev_info.commits.append(objname)
+            else:
+                assert False, "Unknown type '%s'" % (t)
+        assert rev_info.commits  # Each rev is in at least one commit
+        self.d[cvs_path].revs[revnum] = rev_info
+
+    def _fetch_path (self, path):
+        """If the given path exists, create a path entry in self.d."""
+        tree_spec = "%s:%s" % (self.git_ref, path)
+        self.obj_fetcher.walk_tree(tree_spec, self._load, path)
+        # TODO: Don't load entire tree at once?
+
+    # Public methods:
+
+    def has_path (self, path):
+        """Return True iff the given path is present."""
+        if path not in self.d:
+            self._fetch_path(path)
+        return path in self.d
+
+    def has_rev (self, path, revnum):
+        """Return True iff the given path:revnum is present."""
+        if path not in self.d:
+            self._fetch_path(path)
+        return path in self.d and revnum in self.d[path].revs
+
+    def get_mode (self, path):
+        """Return mode bits for the given path."""
+        if path not in self.d:
+            self._fetch_path(path)
+        return self.d[path].mode
+
+    def get_blob (self, path, revnum):
+        """Return the blob name for the given revision."""
+        if path not in self.d:
+            self._fetch_path(path)
+        return self.d[path].revs[revnum].blob
+
+    def get_commits (self, path, revnum):
+        """Return the commit names containing the given revision."""
+        if path not in self.d:
+            self._fetch_path(path)
+        return self.d[path].revs[revnum].commits
+
+    def has_unresolved_marks (self):
+        """Return True iff there are mark numbers in the data structure."""
+        return self.marknum_idx
+
+    # Public non-const methods
+
+    def add_path (self, path, mode):
+        """Add the given path and associated mode bits to this map."""
+        if path not in self.d:
+            self._fetch_path(path)
+        if path in self.d:
+            if self.d[path].mode:
+                assert mode == self.d[path].mode, \
+                    "The mode of %s has changed from %s " \
+                    "to %s since the last import.  This " \
+                    "is not supported." % (
+                        path, self.d[path].mode, mode)
+            else:
+                self.d[path].mode = mode
+        else:
+            self.d[path] = _CVSPathInfo(mode)
+        # Do not add to self.mods yet, as we expect revisions to be
+        # added before commit_map() is called
+
+    def add_blob (self, path, revnum, blobname):
+        """Add the given path:revnum -> blobname association."""
+        assert blobname
+        if path not in self.d:
+            self._fetch_path(path)
+        blobname = self._valid_objname(blobname)
+        if isinstance(blobname, int):  # Mark number
+            self._add_to_marknum_idx(blobname, path, revnum)
+        entry = self.d.setdefault(path, _CVSPathInfo())
+        assert revnum not in entry.revs
+        entry.revs[revnum] = _CVSRevInfo(blobname)
+        self.mods.add((path, revnum))
+
+    def add_commit (self, path, revnum, commitname):
+        """Add the given path:revnum -> commitname association."""
+        if path not in self.d:
+            self._fetch_path(path)
+        commitname = self._valid_objname(commitname)
+        if isinstance(commitname, int):  # Mark number
+            self._add_to_marknum_idx(commitname, path, revnum)
+        assert revnum in self.d[path].revs
+        assert commitname not in self.d[path].revs[revnum].commits
+        self.d[path].revs[revnum].commits.append(commitname)
+        self.mods.add((path, revnum))
+
+    @file_reader_method(missing_ok = True)
+    def load_marks_file (self, f):
+        """Load mark -> SHA1 mappings from git-fast-import marks file.
+
+        Replace all mark numbers with proper SHA1 names in this data
+        structure (using self.marknum_idx to find them quickly).
+
+        """
+        if not f:
+            return 0
+        marks = {}
+        last_mark = 0
+        for line in f:
+            (mark, sha1) = line.strip().split()
+            assert mark.startswith(":")
+            mark = int(mark[1:])
+            assert mark not in marks
+            marks[mark] = sha1
+            if mark > last_mark:
+                last_mark = mark
+        for marknum, revs in self.marknum_idx.iteritems():
+            sha1 = marks[marknum]
+            for path, revnum in revs:
+                if path not in self.d:
+                    self._fetch_path(path)
+                rev_info = self.d[path].revs[revnum]
+                if rev_info.blob == marknum:  # Replace blobname
+                    rev_info.blob = sha1
+                else:  # Replace commitname
+                    assert marknum in rev_info.commits
+                    i = rev_info.commits.index(marknum)
+                    rev_info.commits[i] = sha1
+                    assert marknum not in rev_info.commits
+                self.mods.add((path, revnum))
+        self.marknum_idx = {}  # Resolved all transient mark numbers
+        return last_mark
+
+    def sync_modeinfo_from_cvs (self, cvs):
+        """Update with mode information from current CVS checkout.
+
+        This method will retrieve mode information on all paths in the
+        current CVS checkout, and update this data structure
+        correspondingly.  In the case where mode information is already
+        present for a given CVS path, this method will verify that such
+        information is correct.
+
+        """
+        for path, mode in cvs.get_modeinfo().iteritems():
+            self.add_path(path, mode)
+
+    def commit_map (self, gfi, author, message):
+        """Produce git-fast-import commands for storing changes.
+
+        The given GitFastImport object is used to produce a commit
+        making the changes done to this data structure persistent.
+
+        """
+        now = CVSDate("now")
+        commitdata = GitFICommit(
+            author[0], author[1], now.ts, now.tz_str(), message)
+
+        # Add updated MarkNumIndexFile to commit
+        mark = gfi.blob(self._save_marknum_idx())
+        commitdata.modify(644, mark, self.MarkNumIndexFile)
+
+        for path, revnum in self.mods:
+            mark = gfi.blob(self._save_rev(path, revnum))
+            mode = self.d[path].mode
+            assert mode in (644, 755)
+            commitdata.modify(mode, mark, "%s/%s" % (path, revnum))
+
+        gfi.commit(self.git_ref, commitdata)
+        self.mods = set()
+
+
+class CVSStateMap(object):
+
+    """Map CVSState object to the commit names which produces that state."""
+
+    def __init__ (self, cvs_rev_map):
+        """Create a CVSStateMap object, bound to the given CVS revision map."""
+        self.cvs_rev_map = cvs_rev_map
+
+    def get_commits (self, state):
+        """Map the given CVSState to commits that contain this state.
+
+        Return all commits where the given state is a subset of the
+        state produced by that commit.
+
+        Returns a set of commit names.  The set may be empty.
+
+        """
+        candidate_commits = None
+        for path, revnum in state:
+            commits = self.cvs_rev_map.get_commits(path, revnum)
+            if candidate_commits is None:
+                candidate_commits = set(commits)
+            else:
+                candidate_commits.intersection_update(commits)
+        return candidate_commits
+
+    def get_exact_commit (self, state, commit_map):
+        """Map the given CVSState to the commit with this exact state.
+
+        The given commit_map must be a CommitStates object.
+
+        Return the only commit (if any) that produces the exact given
+        CVSState.
+
+        Returns a commit name, or None if no matching commit is found.
+
+        """
+        commits = self.get_commits(state)
+        for c in commits:
+            if state == commit_map.get(c):
+                return c
+        return None
diff --git a/git_remote_cvs/git.py b/git_remote_cvs/git.py
new file mode 100644
index 0000000..cf037e3
--- /dev/null
+++ b/git_remote_cvs/git.py
@@ -0,0 +1,680 @@
+#!/usr/bin/env python
+
+"""Functionality for interacting with Git repositories.
+
+This module provides classes for interfacing with a Git repository.
+
+"""
+
+import os
+import re
+from binascii import hexlify
+from cStringIO import StringIO
+import unittest
+
+from git_remote_cvs.util import debug, error, die, start_command, run_command
+from git_remote_cvs.cvs import CVSDate
+
+
+def get_git_dir ():
+    """Return the path to the GIT_DIR for this repo."""
+    args = ("git", "rev-parse", "--git-dir")
+    exit_code, output, errors = run_command(args)
+    if exit_code:
+        die("Failed to retrieve git dir")
+    assert not errors
+    return output.strip()
+
+
+def parse_git_config ():
+    """Return a dict containing the parsed version of 'git config -l'."""
+    exit_code, output, errors = run_command(("git", "config", "-z", "-l"))
+    if exit_code:
+        die("Failed to retrieve git configuration")
+    assert not errors
+    return dict([e.split('\n', 1) for e in output.split("\0") if e])
+
+
+def git_config_bool (value):
+    """Convert the given git config string value to True or False.
+
+    Raise ValueError if the given string was not recognized as a
+    boolean value.
+
+    """
+    norm_value = str(value).strip().lower()
+    if norm_value in ("true", "1", "yes", "on", ""):
+        return True
+    if norm_value in ("false", "0", "no", "off", "none"):
+        return False
+    raise ValueError("Failed to parse '%s' into a boolean value" % (value))
+
+
+def valid_git_ref (ref_name):
+    """Return True iff the given ref name is a valid git ref name."""
+    # The following is a reimplementation of the git check-ref-format
+    # command.  The rules were derived from the git check-ref-format(1)
+    # manual page.  This code should be replaced by a call to
+    # check_ref_format() in the git library, when such is available.
+    if ref_name.endswith('/') or \
+       ref_name.startswith('.') or \
+       ref_name.count('/.') or \
+       ref_name.count('..') or \
+       ref_name.endswith('.lock'):
+        return False
+    for c in ref_name:
+        if ord(c) < 0x20 or ord(c) == 0x7f or c in " ~^:?*[":
+            return False
+    return True
+
+
+class GitObjectFetcher(object):
+
+    """Provide parsed access to 'git cat-file --batch'.
+
+    This provides a read-only interface to the Git object database.
+
+    """
+
+    def __init__ (self):
+        """Initiate a 'git cat-file --batch' session."""
+        self.queue = []  # List of object names to be submitted
+        self.in_transit = None  # Object name currently in transit
+
+        # 'git cat-file --batch' produces binary output which is likely
+        # to be corrupted by the default "rU"-mode pipe opened by
+        # start_command.  (Mode == "rU" does universal new-line
+        # conversion, which mangles carriage returns.) Therefore, we
+        # open an explicitly binary-safe pipe for transferring the
+        # output from 'git cat-file --batch'.
+        pipe_r_fd, pipe_w_fd = os.pipe()
+        pipe_r = os.fdopen(pipe_r_fd, "rb")
+        pipe_w = os.fdopen(pipe_w_fd, "wb")
+        self.proc = start_command(("git", "cat-file", "--batch"),
+                                  stdout = pipe_w)
+        self.f = pipe_r
+
+    def __del__ (self):
+        """Verify completed communication with 'git cat-file --batch'."""
+        assert not self.queue
+        assert self.in_transit is None
+        self.proc.stdin.close()
+        assert self.proc.wait() == 0  # Zero exit code
+        assert self.f.read() == ""  # No remaining output
+
+    def _submit_next_object (self):
+        """Submit queue items to the 'git cat-file --batch' process.
+
+        If there are items in the queue, and there is currently no item
+        currently in 'transit', then pop the first item off the queue,
+        and submit it.
+
+        """
+        if self.queue and self.in_transit is None:
+            self.in_transit = self.queue.pop(0)
+            print >> self.proc.stdin, self.in_transit[0]
+
+    def push (self, obj, callback):
+        """Push the given object name onto the queue.
+
+        The given callback function will at some point in the future
+        be called exactly once with the following arguments:
+        - self - this GitObjectFetcher instance
+        - obj  - the object name provided to push()
+        - sha1 - the SHA1 of the object, if 'None' obj is missing
+        - t    - the type of the object (tag/commit/tree/blob)
+        - size - the size of the object in bytes
+        - data - the object contents
+
+        """
+        self.queue.append((obj, callback))
+        self._submit_next_object()  # (Re)start queue processing
+
+    def process_next_entry (self):
+        """Read the next entry off the queue and invoke callback."""
+        obj, cb = self.in_transit
+        self.in_transit = None
+        header = self.f.readline()
+        if header == "%s missing\n" % (obj):
+            cb(self, obj, None, None, None, None)
+            return
+        sha1, t, size = header.split(" ")
+        assert len(sha1) == 40
+        assert t in ("tag", "commit", "tree", "blob")
+        assert size.endswith("\n")
+        size = int(size.strip())
+        data = self.f.read(size)
+        assert self.f.read(1) == "\n"
+        cb(self, obj, sha1, t, size, data)
+        self._submit_next_object()
+
+    def process (self):
+        """Process the current queue until empty."""
+        while self.in_transit is not None:
+            self.process_next_entry()
+
+    # High-level convenience methods:
+
+    def get_sha1 (self, objspec):
+        """Return the SHA1 of the object specified by 'objspec'.
+
+        Return None if 'objspec' does not specify an existing object.
+
+        """
+        class _ObjHandler(object):
+            """Helper class for getting the returned SHA1."""
+            def __init__ (self, parser):
+                self.parser = parser
+                self.sha1 = None
+
+            def __call__ (self, parser, obj, sha1, t, size, data):
+                # FIXME: Many unused arguments. Could this be cheaper?
+                assert parser == self.parser
+                self.sha1 = sha1
+
+        handler = _ObjHandler(self)
+        self.push(objspec, handler)
+        self.process()
+        return handler.sha1
+
+    def open_obj (self, objspec):
+        """Return a file object wrapping the contents of a named object.
+
+        The caller is responsible for calling .close() on the returned
+        file object.
+
+        Raise KeyError if 'objspec' does not exist in the repo.
+
+        """
+        class _ObjHandler(object):
+            """Helper class for parsing the returned git object."""
+            def __init__ (self, parser):
+                """Set up helper."""
+                self.parser = parser
+                self.contents = StringIO()
+                self.err = None
+
+            def __call__ (self, parser, obj, sha1, t, size, data):
+                """Git object callback (see GitObjectFetcher documentation)."""
+                assert parser == self.parser
+                if not sha1:  # Missing object
+                    self.err = "Missing object '%s'" % obj
+                else:
+                    assert size == len(data)
+                    self.contents.write(data)
+
+        handler = _ObjHandler(self)
+        self.push(objspec, handler)
+        self.process()
+        if handler.err:
+            raise KeyError(handler.err)
+        handler.contents.seek(0)
+        return handler.contents
+
+    def walk_tree (self, tree_objspec, callback, prefix = ""):
+        """Recursively walk the given Git tree object.
+
+        Recursively walk all subtrees of the given tree object, and
+        invoke the given callback passing three arguments:
+        (path, mode, data) with the path, permission bits, and contents
+        of all the blobs found in the entire tree structure.
+
+        """
+        class _ObjHandler(object):
+            """Helper class for walking a git tree structure."""
+            def __init__ (self, parser, cb, path, mode = None):
+                """Set up helper."""
+                self.parser = parser
+                self.cb = cb
+                self.path = path
+                self.mode = mode
+                self.err = None
+
+            def parse_tree (self, treedata):
+                """Parse tree object data, yield tree entries.
+
+                Each tree entry is a 3-tuple (mode, sha1, path)
+
+                self.path is prepended to all paths yielded
+                from this method.
+
+                """
+                while treedata:
+                    mode = int(treedata[:6], 10)
+                    # Turn 100xxx into xxx
+                    if mode > 100000:
+                        mode -= 100000
+                    assert treedata[6] == " "
+                    i = treedata.find("\0", 7)
+                    assert i > 0
+                    path = treedata[7:i]
+                    sha1 = hexlify(treedata[i + 1: i + 21])
+                    yield (mode, sha1, self.path + path)
+                    treedata = treedata[i + 21:]
+
+            def __call__ (self, parser, obj, sha1, t, size, data):
+                """Git object callback (see GitObjectFetcher documentation)."""
+                assert parser == self.parser
+                if not sha1:  # Missing object
+                    self.err = "Missing object '%s'" % (obj)
+                    return
+                assert size == len(data)
+                if t == "tree":
+                    if self.path:
+                        self.path += "/"
+                    # Recurse into all blobs and subtrees
+                    for m, s, p in self.parse_tree(data):
+                        parser.push(s,
+                                    self.__class__(self.parser, self.cb, p, m))
+                elif t == "blob":
+                    self.cb(self.path, self.mode, data)
+                else:
+                    raise ValueError("Unknown object type '%s'" % (t))
+
+        self.push(tree_objspec, _ObjHandler(self, callback, prefix))
+        self.process()
+
+
+class GitRefMap(object):
+
+    """Map Git ref names to the Git object names they currently point to.
+
+    Behaves like a dictionary of Git ref names -> Git object names.
+
+    """
+
+    def __init__ (self, obj_fetcher):
+        """Create a new Git ref -> object map."""
+        self.obj_fetcher = obj_fetcher
+        self._cache = {}  # dict: refname -> objname
+
+    def _load (self, ref):
+        """Retrieve the object currently bound to the given ref.
+
+        The name of the object pointed to by the given ref is stored
+        into this mapping, and also returned.
+
+        """
+        if ref not in self._cache:
+            self._cache[ref] = self.obj_fetcher.get_sha1(ref)
+        return self._cache[ref]
+
+    def __contains__ (self, refname):
+        """Return True if the given refname is present in this cache."""
+        return bool(self._load(refname))
+
+    def __getitem__ (self, refname):
+        """Return the git object name pointed to by the given refname."""
+        commit = self._load(refname)
+        if commit is None:
+            raise KeyError("Unknown ref '%s'" % (refname))
+        return commit
+
+    def get (self, refname, default = None):
+        """Return the git object name pointed to by the given refname."""
+        commit = self._load(refname)
+        if commit is None:
+            return default
+        return commit
+
+
+class GitFICommit(object):
+
+    """Encapsulate the data in a Git fast-import commit command."""
+
+    SHA1RE = re.compile(r'^[0-9a-f]{40}$')
+
+    @classmethod
+    def parse_mode (cls, mode):
+        """Verify the given git file mode, and return it as a string."""
+        assert mode in (644, 755, 100644, 100755, 120000)
+        return "%i" % (mode)
+
+    @classmethod
+    def parse_objname (cls, objname):
+        """Return the given object name (or mark number) as a string."""
+        if isinstance(objname, int):  # Object name is a mark number
+            assert objname > 0
+            return ":%i" % (objname)
+
+        # No existence check is done, only checks for valid format
+        assert cls.SHA1RE.match(objname)  # Object name is valid SHA1
+        return objname
+
+    @classmethod
+    def quote_path (cls, path):
+        """Return a quoted version of the given path."""
+        path = path.replace("\\", "\\\\")
+        path = path.replace("\n", "\\n")
+        path = path.replace('"', '\\"')
+        return '"%s"' % (path)
+
+    @classmethod
+    def parse_path (cls, path):
+        """Verify that the given path is valid, and quote it, if needed."""
+        assert not isinstance(path, int)  # Cannot be a mark number
+
+        # These checks verify the rules on the fast-import man page
+        assert not path.count("//")
+        assert not path.endswith("/")
+        assert not path.startswith("/")
+        assert not path.count("/./")
+        assert not path.count("/../")
+        assert not path.endswith("/.")
+        assert not path.endswith("/..")
+        assert not path.startswith("./")
+        assert not path.startswith("../")
+
+        if path.count('"') + path.count('\n') + path.count('\\'):
+            return cls.quote_path(path)
+        return path
+
+    def __init__ (self, name, email, timestamp, timezone, message):
+        """Create a new Git fast-import commit, with the given metadata."""
+        self.name = name
+        self.email = email
+        self.timestamp = timestamp
+        self.timezone = timezone
+        self.message = message
+        self.pathops = []  # List of path operations in this commit
+
+    def modify (self, mode, blobname, path):
+        """Add a file modification to this Git fast-import commit."""
+        self.pathops.append(("M",
+                             self.parse_mode(mode),
+                             self.parse_objname(blobname),
+                             self.parse_path(path)))
+
+    def delete (self, path):
+        """Add a file deletion to this Git fast-import commit."""
+        self.pathops.append(("D", self.parse_path(path)))
+
+    def copy (self, path, newpath):
+        """Add a file copy to this Git fast-import commit."""
+        self.pathops.append(("C",
+                             self.parse_path(path),
+                             self.parse_path(newpath)))
+
+    def rename (self, path, newpath):
+        """Add a file rename to this Git fast-import commit."""
+        self.pathops.append(("R",
+                             self.parse_path(path),
+                             self.parse_path(newpath)))
+
+    def note (self, blobname, commit):
+        """Add a note object to this Git fast-import commit."""
+        self.pathops.append(("N",
+                             self.parse_objname(blobname),
+                             self.parse_objname(commit)))
+
+    def deleteall (self):
+        """Delete all files in this Git fast-import commit."""
+        self.pathops.append("deleteall")
+
+
+class TestGitFICommit(unittest.TestCase):
+
+    """GitFICommit selftests."""
+
+    def test_basic (self):
+        """GitFICommit basic selftests."""
+
+        def expect_fail (method, data):
+            """Verify that the method(data) raises an AssertionError."""
+            try:
+                method(data)
+            except AssertionError:
+                return
+            raise AssertionError("Failed test for invalid data '%s(%s)'" %
+                                 (method.__name__, repr(data)))
+
+    def test_parse_mode (self):
+        """GitFICommit.parse_mode() selftests."""
+        self.assertEqual(GitFICommit.parse_mode(644), "644")
+        self.assertEqual(GitFICommit.parse_mode(755), "755")
+        self.assertEqual(GitFICommit.parse_mode(100644), "100644")
+        self.assertEqual(GitFICommit.parse_mode(100755), "100755")
+        self.assertEqual(GitFICommit.parse_mode(120000), "120000")
+        self.assertRaises(AssertionError, GitFICommit.parse_mode, 0)
+        self.assertRaises(AssertionError, GitFICommit.parse_mode, 123)
+        self.assertRaises(AssertionError, GitFICommit.parse_mode, 600)
+        self.assertRaises(AssertionError, GitFICommit.parse_mode, "644")
+        self.assertRaises(AssertionError, GitFICommit.parse_mode, "abc")
+
+    def test_parse_objname (self):
+        """GitFICommit.parse_objname() selftests."""
+        self.assertEqual(GitFICommit.parse_objname(1), ":1")
+        self.assertRaises(AssertionError, GitFICommit.parse_objname, 0)
+        self.assertRaises(AssertionError, GitFICommit.parse_objname, -1)
+        self.assertEqual(GitFICommit.parse_objname("0123456789" * 4),
+                         "0123456789" * 4)
+        self.assertEqual(GitFICommit.parse_objname("2468abcdef" * 4),
+                         "2468abcdef" * 4)
+        self.assertRaises(AssertionError, GitFICommit.parse_objname,
+                          "abcdefghij" * 4)
+
+    def test_parse_path (self):
+        """GitFICommit.parse_path() selftests."""
+        self.assertEqual(GitFICommit.parse_path("foo/bar"), "foo/bar")
+        self.assertEqual(GitFICommit.parse_path("path/with\n and \" in it"),
+                         '"path/with\\n and \\" in it"')
+        self.assertRaises(AssertionError, GitFICommit.parse_path, 1)
+        self.assertRaises(AssertionError, GitFICommit.parse_path, 0)
+        self.assertRaises(AssertionError, GitFICommit.parse_path, -1)
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo//bar")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/bar/")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "/foo/bar")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/./bar")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/../bar")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/bar/.")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "foo/bar/..")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "./foo/bar")
+        self.assertRaises(AssertionError, GitFICommit.parse_path, "../foo/bar")
+
+
+class GitFastImport(object):
+
+    """Encapsulate communication with git fast-import."""
+
+    def __init__ (self, f, obj_fetcher, last_mark = 0):
+        """Set up self to communicate with a fast-import process through f."""
+        self.f = f  # File object where fast-import stream is written
+        self.obj_fetcher = obj_fetcher  # GitObjectFetcher instance
+        self.next_mark = last_mark + 1  # Next mark number
+        self.refs = set()  # Keep track of the refnames we've seen
+
+    def comment (self, s):
+        """Write the given comment in the fast-import stream."""
+        assert "\n" not in s, "Malformed comment: '%s'" % (s)
+        self.f.write("# %s\n" % (s))
+
+    def commit (self, ref, commitdata):
+        """Make a commit on the given ref, with the given GitFICommit.
+
+        Return the mark number identifying this commit.
+
+        """
+        self.f.write("""\
+commit %(ref)s
+mark :%(mark)i
+committer %(name)s <%(email)s> %(timestamp)i %(timezone)s
+data %(msgLength)i
+%(msg)s
+""" % {
+    'ref': ref,
+    'mark': self.next_mark,
+    'name': commitdata.name,
+    'email': commitdata.email,
+    'timestamp': commitdata.timestamp,
+    'timezone': commitdata.timezone,
+    'msgLength': len(commitdata.message),
+    'msg': commitdata.message,
+})
+
+        if ref not in self.refs:
+            self.refs.add(ref)
+            parent = ref + "^0"
+            if self.obj_fetcher.get_sha1(parent):
+                self.f.write("from %s\n" % (parent))
+
+        for op in commitdata.pathops:
+            self.f.write(" ".join(op))
+            self.f.write("\n")
+        self.f.write("\n")
+        retval = self.next_mark
+        self.next_mark += 1
+        return retval
+
+    def blob (self, data):
+        """Import the given blob.
+
+        Return the mark number identifying this blob.
+
+        """
+        self.f.write("blob\nmark :%i\ndata %i\n%s\n" %
+                     (self.next_mark, len(data), data))
+        retval = self.next_mark
+        self.next_mark += 1
+        return retval
+
+    def reset (self, ref, objname):
+        """Reset the given ref to point at the given Git object."""
+        self.f.write("reset %s\nfrom %s\n\n" %
+                     (ref, GitFICommit.parse_objname(objname)))
+        if ref not in self.refs:
+            self.refs.add(ref)
+
+
+class GitNotes(object):
+
+    """Encapsulate access to Git notes.
+
+    Simulates a dictionary of object name (SHA1) -> Git note mappings.
+
+    """
+
+    def __init__ (self, notes_ref, obj_fetcher):
+        """Create a new Git notes interface, bound to the given notes ref."""
+        self.notes_ref = notes_ref
+        self.obj_fetcher = obj_fetcher  # Used to get objects from repo
+        self.imports = []  # list: (objname, note data blob name) tuples
+
+    def __del__ (self):
+        """Verify that self.commit_notes() was called before destruction."""
+        if self.imports:
+            error("Missing call to self.commit_notes().")
+            error("%i notes are not committed!", len(self.imports))
+
+    def _load (self, objname):
+        """Return the note data associated with the given git object.
+
+        The note data is returned in string form. If no note is found
+        for the given object, None is returned.
+
+        """
+        try:
+            f = self.obj_fetcher.open_obj("%s:%s" % (self.notes_ref, objname))
+            ret = f.read()
+            f.close()
+        except KeyError:
+            ret = None
+        return ret
+
+    def __getitem__ (self, objname):
+        """Return the note contents associated with the given object.
+
+        Raise KeyError if given object has no associated note.
+
+        """
+        blobdata = self._load(objname)
+        if blobdata is None:
+            raise KeyError("Object '%s' has no note" % (objname))
+        return blobdata
+
+    def get (self, objname, default = None):
+        """Return the note contents associated with the given object.
+
+        Return given default if given object has no associated note.
+
+        """
+        blobdata = self._load(objname)
+        if blobdata is None:
+            return default
+        return blobdata
+
+    def import_note (self, objname, data, gfi):
+        """Tell git fast-import to store data as a note for objname.
+
+        This method uses the given GitFastImport object to create a
+        blob containing the given note data.  Also an entry mapping the
+        given object name to the created blob is stored until
+        commit_notes() is called.
+
+        Note that this method only works if it is later followed by a
+        call to self.commit_notes() (which produces the note commit
+        that refers to the blob produced here).
+
+        """
+        if not data.endswith("\n"):
+            data += "\n"
+        gfi.comment("Importing note for object %s" % (objname))
+        mark = gfi.blob(data)
+        self.imports.append((objname, mark))
+
+    def commit_notes (self, gfi, author, message):
+        """Produce a git fast-import note commit for the imported notes.
+
+        This method uses the given GitFastImport object to create a
+        commit on the notes ref, introducing the notes previously
+        submitted to import_note().
+
+        """
+        if not self.imports:
+            return
+        now = CVSDate("now")
+        commitdata = GitFICommit(author[0], author[1],
+                                 now.ts, now.tz_str(), message)
+        for objname, blobname in self.imports:
+            assert isinstance(objname, int) and objname > 0
+            assert isinstance(blobname, int) and blobname > 0
+            commitdata.note(blobname, objname)
+        gfi.commit(self.notes_ref, commitdata)
+        self.imports = []
+
+
+class GitCachedNotes(GitNotes):
+
+    """Encapsulate access to Git notes (cached version).
+
+    Only use this class if no caching is done at a higher level.
+
+    Simulates a dictionary of object name (SHA1) -> Git note mappings.
+
+    """
+
+    def __init__ (self, notes_ref, obj_fetcher):
+        """Set up a caching wrapper around GitNotes."""
+        GitNotes.__init__(self, notes_ref, obj_fetcher)
+        self._cache = {}  # Cache: object name -> note data
+
+    def __del__ (self):
+        """Verify that GitNotes' destructor is called."""
+        GitNotes.__del__(self)
+
+    def _load (self, objname):
+        """Extend GitNotes._load() with a local objname -> note cache."""
+        if objname not in self._cache:
+            self._cache[objname] = GitNotes._load(self, objname)
+        return self._cache[objname]
+
+    def import_note (self, objname, data, gfi):
+        """Extend GitNotes.import_note() with a local objname -> note cache."""
+        if not data.endswith("\n"):
+            data += "\n"
+        assert objname not in self._cache
+        self._cache[objname] = data
+        GitNotes.import_note(self, objname, data, gfi)
+
+
+if __name__ == '__main__':
+    unittest.main()
diff --git a/git_remote_cvs/setup.py b/git_remote_cvs/setup.py
new file mode 100644
index 0000000..21f521a
--- /dev/null
+++ b/git_remote_cvs/setup.py
@@ -0,0 +1,17 @@
+#!/usr/bin/env python
+
+"""Distutils build/install script for the git_remote_cvs package."""
+
+from distutils.core import setup
+
+setup(
+    name = 'git_remote_cvs',
+    version = '0.1.0',
+    description = 'Git remote helper program for CVS repositories',
+    license = 'GPLv2',
+    author = 'The Git Community',
+    author_email = 'git@vger.kernel.org',
+    url = 'http://www.git-scm.com/',
+    package_dir = {'git_remote_cvs': ''},
+    packages = ['git_remote_cvs'],
+)
-- 
1.6.4.262.gca66a.dirty
