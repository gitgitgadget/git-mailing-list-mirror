From: Tomas Carnecky <tom@dbservice.com>
Subject: [PATCH 6/6] Add git-remote-svn
Date: Sun,  3 Oct 2010 14:21:51 +0200
Message-ID: <1286108511-55876-6-git-send-email-tom@dbservice.com>
References: <4CA86A12.6080905@dbservice.com>
Cc: Tomas Carnecky <tom@dbservice.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 14:22:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2NaF-0005Mv-Kb
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 14:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab0JCMWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 08:22:23 -0400
Received: from gw.ptr-62-65-141-13.customer.ch.netstream.com ([62.65.141.13]:60854
	"EHLO calvin.caurea.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752883Ab0JCMWL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 08:22:11 -0400
Received: by calvin.caurea.org (Postfix, from userid 501)
	id 0C195245A756; Sun,  3 Oct 2010 14:22:10 +0200 (CEST)
X-Mailer: git-send-email 1.7.3.37.gb6088b
In-Reply-To: <4CA86A12.6080905@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157867>

This is an experimental git remote helper for svn repositories. It uses
the new git fast-import-helper. It only works with local svn repos (not
over network). It uses notes to save the git commit -> svn revision
mapping (refs/notes/svn).

This remote helper serves as a technology preview of what the new type
of remote helpers can do.

It assumes that the svn repo uses the standard layout (trunk, branches).
---
 .gitignore        |    1 +
 Makefile          |    1 +
 git-remote-svn.py |  408 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 410 insertions(+), 0 deletions(-)
 create mode 100644 git-remote-svn.py

diff --git a/.gitignore b/.gitignore
index c8aa8c7..0a6011c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -114,6 +114,7 @@
 /git-remote-ftp
 /git-remote-ftps
 /git-remote-testgit
+/git-remote-svn
 /git-repack
 /git-replace
 /git-repo-config
diff --git a/Makefile b/Makefile
index f8a9c40..eb959c9 100644
--- a/Makefile
+++ b/Makefile
@@ -387,6 +387,7 @@ SCRIPT_PERL += git-send-email.perl
 SCRIPT_PERL += git-svn.perl
 
 SCRIPT_PYTHON += git-remote-testgit.py
+SCRIPT_PYTHON += git-remote-svn.py
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
 	  $(patsubst %.perl,%,$(SCRIPT_PERL)) \
diff --git a/git-remote-svn.py b/git-remote-svn.py
new file mode 100644
index 0000000..c617743
--- /dev/null
+++ b/git-remote-svn.py
@@ -0,0 +1,408 @@
+#!/usr/bin/env python
+
+import sys, os, re, time, subprocess
+import svn.core, svn.repos, svn.fs
+
+ct_short = ['M', 'A', 'D', 'R', 'X']
+
+############################################################################
+# Class which encapsulates the fast import helper. Provides methods to
+# read/write data to it. 
+class FastImportHelper:
+
+	def start(self):
+		PIPE = subprocess.PIPE
+		args = ['git', 'fast-import-helper']
+		self.helper = subprocess.Popen(args, stdin=PIPE, stdout=PIPE)
+
+	def close(self):
+		self.helper.stdin.close()
+		self.helper.wait()
+		del self.helper
+
+	def write(self, data):
+		self.helper.stdin.write(data)
+
+	# Expect the helper to write the mark mapping to its stdout. Verify that
+	# the mark is the same that we've given and return the git object name
+	def response(self, mark):
+		line = self.helper.stdout.readline().strip().split(' ')
+		assert(str(line[1][1:]) == str(mark))
+
+		return line[2]
+
+	# Make a commit from the given arguments, return the git object name
+	# corresponding to that just created commit
+	def commit(self, mark, ref, parents, author, committer, changes, message):
+		self.write("commit %s\n" % ref)
+		self.write("mark :%s\n" % mark)
+		if author:
+			self.write("author %s %s -0000\n" % author)
+		self.write("committer %s %s -0000\n" % committer)
+		self.write("data %s\n" % len(message))
+		self.write(message)
+
+		parent = parents.pop(0)
+		if parent:
+			self.write("from %s\n" % parent)
+		for parent in parents:
+			self.write("merge %s\n", parent)
+	
+		self.write(''.join(changes))
+
+		# Make it happen
+		self.write("\n")
+		return self.response(mark)
+
+	# Create a blob from the given arguments. 'read' is callable object
+	# which returns data. Return the git object name
+	def blob(self, mark, length, read):
+		self.write("blob\nmark :%s\n" % mark)
+		self.write("data %s\n" % length)
+		
+		while length > 0:
+			avail = min(length, 4096)
+			data = read(avail)
+			err = self.write(data)
+			length -= avail
+
+		# Make it happen
+		self.write("\n")
+		return self.response(mark)
+
+
+
+############################################################################
+# Base class for python remote helpers. It handles the main command loop.
+# This class also manages the fast-import-helper and marks. If you want to
+# use the fih, call self.fih.start() first and after you're done call .close()
+class RemoteHelper(object):
+
+	def __init__(self, kind):
+		self.kind = kind
+		self.fih = FastImportHelper()
+		
+		self.notes = []
+		
+		# nfrom is the current notes commit, we'll need that later when
+		# adding new notes. Check if that ref exists, if not set nfrom
+		# to None, if yes, get the object name and store it in nfrom
+		argv = [ 'git', 'rev-parse', 'refs/notes/%s^0' % kind ]
+		PIPE = subprocess.PIPE
+		proc = subprocess.Popen(argv, stdout=PIPE, stderr=PIPE)
+		proc.wait()
+		if proc.returncode == 0:
+			self.nfrom = proc.stdout.readline().strip()
+		else:
+			self.nfrom = None
+
+	# The commands we understand
+	COMMANDS = ( 'capabilities', 'list', 'fetch', )
+
+	# Read next command. Raise an exception if the command is invalid.
+	# Return a tuple (command, args,)
+	def read_next_command(self):
+		line = sys.stdin.readline()
+		if not line:
+			return ( None, None, )
+	
+		cmdline = line.strip().split()
+		if not cmdline:
+			return ( None, None, )
+
+		cmd = cmdline.pop(0)
+		if cmd not in self.COMMANDS:
+			raise Exception("Invalid command '%s'" % cmd)
+		
+		return ( cmd, cmdline, )
+
+	# Run the remote helper, process commands until the end of the world. Or
+	# until we're told to finish.
+	def run(self):
+		while (True):
+			( cmd, args, ) = self.read_next_command()
+			if cmd is None:
+				return
+
+			func = getattr(self, cmd, None)
+			if func is None or not callable(func):
+				raise Exception("Command '%s' not implemented" % cmd)
+
+			result = func(args)
+			sys.stdout.flush()
+
+
+	# Convenience method for writing data back to git
+	def reply(self, data):
+		sys.stdout.write(data)
+
+	# Return all refs and the contents of the note attached to each.
+	# This can be used by the remote helper to find out what the latest
+	# version is that we fetched into this repo.
+	# Returns list of tuples of (sha1, typename, refname, note,)
+	def refs(self):
+		refs = []
+		
+		PIPE = subprocess.PIPE
+		args = [ 'git', 'for-each-ref' ]
+		gfer = subprocess.Popen(args, stdin=PIPE, stdout=PIPE)
+		
+		# Regular expression for matching the output from g-f-e-r
+		pattern = re.compile(r"(.{40}) (\w+)	(.*)")
+		while (True):
+			line = gfer.stdout.readline()
+			if not line:
+				break 
+
+			match = pattern.match(line)
+			
+			# The sha1 and name of the ref
+			sha1 = match.group(1)
+			typename = match.group(2)
+			refname = match.group(3)
+			
+			# Extract the note using `git notes show <sha>`
+			git_notes_show = [ 'git', 'notes', 'show', sha1 ]
+			
+			# Set GIT_NOTES_REF to point to the notes of our kind
+			env = { "GIT_NOTES_REF": "refs/notes/%s" % self.kind }
+			
+			note = subprocess.Popen(git_notes_show, env=env, stdout=PIPE, stderr=PIPE)
+			refs.append(( sha1, typename, refname, note.stdout.readline() ))
+
+		gfer.wait()
+
+		return refs
+
+	# Attach text to an object. objects are currently limited to commits
+	def note(self, obj, text):
+		self.notes.append(( obj, text, ))
+		if len(self.notes) >= 10:
+			self.flush()
+
+	# Commit all outstanding notes. Don't forget to flush the notes before
+	# you close the fih
+	def flush(self):
+		if len(self.notes) == 0:
+			return
+
+		now = int(time.time())
+		mark = "%s-notes" % self.kind
+		ref = "refs/notes/%s" % self.kind
+		parents = [ self.nfrom ]
+		author = ( 'nobody <nobody@localhost>', now, )
+		committer = ( 'nobody <nobody@localhost>', now, )
+		message = "Update notes"
+
+		changes = []
+		for ( obj, text, ) in self.notes:
+			changes.append("N inline %s\ndata %s\n" % (obj, len(text)))
+			changes.append(text)
+			changes.append("\n")
+		
+		self.nfrom = self.fih.commit(mark, ref, parents, author, committer, changes, message)
+		self.notes = []
+
+
+
+############################################################################
+# Remote helper for Subversion
+class RemoteHelperSubversion(RemoteHelper):
+
+	def __init__(self, url):
+		super(RemoteHelperSubversion, self).__init__("svn")
+
+		url = svn.core.svn_path_canonicalize(url)
+		self.repo = svn.repos.svn_repos_open(url)
+		self.fs = svn.repos.svn_repos_fs(self.repo)
+		self.uuid = svn.fs.svn_fs_get_uuid(self.fs)
+
+
+	# Here follow the commands this helper implements
+	
+	# RH command 'capabilities'
+	def capabilities(self, args):
+		self.reply("list\nfetch\n\n")
+
+	# RH command 'list'
+	def list(self, args):
+		rev = svn.fs.svn_fs_youngest_rev(self.fs)
+		root = svn.fs.svn_fs_revision_root(self.fs, rev)
+
+		refs = self.discover(root)
+		for ( name, rev, ) in refs:
+			self.reply(":r%s %s\n" % ( rev, name, ))
+
+		if len(refs) > 0:
+			self.reply("@%s HEAD\n" % refs[0][0])
+		self.reply("\n")
+
+	# RH command 'fetch'
+	def fetch(self, args):
+		# Start the fast-import helper
+		self.fih.start()
+
+		# Fetches are done in batches. Process fetch lines until we see a
+		# blank newline
+		while args:
+			# The revision to fetch, strip the leading 'r' from 'r42'
+			new = int(args[0][1:])
+			
+			# Trailing slash to ensure that it's a directory
+			prefix = "/%s/" % args[1]
+			
+			( sha1, old, ) = self.parent(args[1])
+			sys.stderr.write("Best parent: %s %s\n" % (old, new,))
+			
+			if old != new:
+				sha1 = self.fi(prefix, old, new, sha1)
+			self.reply("map r%s %s\n" % ( new, sha1 ))
+
+			# Read next line, break if it's a newline (ending this fetch batch)
+			( cmd, args, ) = self.read_next_command()
+			if not cmd:
+				break
+
+		self.flush()
+		self.fih.close()
+		
+		# Before finishing this command, make sure to emit the 'silent'
+		# command to register the notes
+		self.reply("silent refs/notes/%s %s\n" % (self.kind, self.nfrom, ))
+		
+		self.reply("\n")
+
+	# Discover all refs (trunk, braches) in the repository
+	def discover(self, root):
+		refs = []
+		
+		# First check /trunk
+		entries = svn.fs.svn_fs_dir_entries(root, "/")
+		names = entries.keys()
+		
+		if 'trunk' in names:
+			refs.append(( 'trunk', self.rev(root, '/trunk'), ))
+		
+		if 'branches' in names:
+			entries = svn.fs.svn_fs_dir_entries(root, "/branches")
+			names = entries.keys()
+			for name in names:
+				refs.append(( 'branches/'+name, self.rev(root, '/branches/%s' % name), ))
+
+		return refs
+
+	# Get the revision when `path` was last modified
+	def rev(self, root, path):
+		history = svn.fs.svn_fs_node_history(root, path)
+		
+		# Yes, this is required.
+		history = svn.fs.svn_fs_history_prev(history, True)
+		if not history:
+			return 1
+
+		( path, rev, ) = svn.fs.svn_fs_history_location(history)		
+		return rev
+
+
+	# Find the git commit we can use as parent when importing from the
+	# repo with the given prefix. All commits imported from svn
+	# have a note attached which contains this information. But to make our
+	# job easier, we only scan ref heads and not the whole history.
+	# Go through all refs, see which one has a note that matches the given
+	# prefix and extract the svn revision number from the note.
+	# Return a tuple (sha1, rev,) which identifies the git commit and svn
+	# revision.
+	def parent(self, prefix):
+		pattern = re.compile(r"([0-9a-h-]+)/([^@]*)@(\d+)")
+		res = []
+		for ( sha1, typename, name, note, ) in self.refs():
+			if typename != "commit":
+				continue
+
+			match = pattern.match(note)
+			if not match:
+				continue
+
+			if match.group(2) == prefix and match.group(1) == self.uuid:
+				rev = int(match.group(3))
+				res.append(( sha1, rev ))
+
+		if len(res) == 0:
+			return ( None, 1, )
+
+		res.sort(lambda a,b: a[1] < b[1])
+		return res[0]
+
+
+	# Run fast import of revision `old` up to `new`, only considering files
+	# under the given prefix. Use `sha1` as the parent of the first commit.
+	# Return the git commit name that corresponds to the last revision so
+	# we can report it back to git.
+	def fi(self, prefix, old, new, sha1):
+		for rev in xrange(old or 1, new + 1):
+			sha1 = self.feed(rev, prefix, sha1)
+
+		return sha1	
+
+
+	# Feed the fast-import helper with the given revision
+	def feed(self, rev, prefix, sha1):
+		# Open the root at that revision and get the changes
+		root = svn.fs.svn_fs_revision_root(self.fs, rev)
+		changes = svn.fs.svn_fs_paths_changed(root)
+
+		i, file_changes = 1, []
+		for path, change_type in changes.iteritems():
+			if svn.fs.svn_fs_is_dir(root, path):
+				continue
+			if not path.startswith(prefix):
+				continue
+		
+			realpath = path.replace(prefix, '')
+
+			c_t = ct_short[change_type.change_kind]
+			if c_t == 'D':
+				file_changes.append("D %s\n" % realpath)
+			else:
+				file_changes.append("M 644 :%s %s\n" % (i, realpath))
+
+				length = int(svn.fs.svn_fs_file_length(root, path))
+				stream = svn.fs.svn_fs_file_contents(root, path)
+				read = lambda x: svn.core.svn_stream_read(stream, x)
+				self.fih.blob(i, length, read)
+				svn.core.svn_stream_close(stream)
+				i += 1
+
+		if len(file_changes) == 0:
+			return sha1
+
+		props = svn.fs.svn_fs_revision_proplist(self.fs, rev)
+
+		# Collect all the needed information to create the commit
+		mark = str(rev)
+		ref = "refs/heads/master"
+		parents = [ sha1 ]
+
+		svndate = props['svn:date'][0:-8]
+		commit_time = time.mktime(time.strptime(svndate, '%Y-%m-%dT%H:%M:%S'))
+		
+		if props.has_key('svn:author'):
+			author = "%s <%s@localhost>" % (props['svn:author'], props['svn:author'])
+		else:
+			author = 'nobody <nobody@localhost>'
+
+		committer = ( author, int(commit_time), )
+		message = props['svn:log']
+		
+		sha1 = self.fih.commit(mark, ref, parents, None, committer, file_changes, message)
+		
+		note = "%s%s@%s\n" % (svn.fs.svn_fs_get_uuid(self.fs), prefix[:-1], rev)
+		self.note(sha1, note)
+		
+		return sha1
+
+
+
+if __name__ == '__main__':
+	helper = RemoteHelperSubversion(sys.argv[2])
+	helper.run()
-- 
1.7.3.37.gb6088b
