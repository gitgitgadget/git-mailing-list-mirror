From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/4] Add new --diff-opts/-O flag to diff- and status-related
	commands.
Date: Fri, 01 Jun 2007 00:34:38 +0200
Message-ID: <20070531223438.6005.76115.stgit@gandelf.nowhere.earth>
References: <20070531222920.6005.74481.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 00:37:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HttGO-0006Nm-GR
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 00:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbXEaWgx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 18:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754038AbXEaWgx
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 18:36:53 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51746 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753976AbXEaWgw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 18:36:52 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7742F7391;
	Fri,  1 Jun 2007 00:36:51 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id D80B91F157;
	Fri,  1 Jun 2007 00:34:38 +0200 (CEST)
In-Reply-To: <20070531222920.6005.74481.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48828>


This new flag allows to pass arbitrary flags to the git-diff calls
underlying several StGIT commands.  It can be used to pass flags
affecting both diff- and status-generating commands (eg. -M or -C), or
flags only affecting diff-generating ones (eg. --color, --binary).

It supercedes --binary for commands where it was allowed,
'-O --binary' is now available for the same functionality.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/diff.py   |    9 ++++-----
 stgit/commands/export.py |    9 ++++-----
 stgit/commands/files.py  |    9 ++++++++-
 stgit/commands/mail.py   |    9 ++++-----
 stgit/commands/show.py   |   11 +++++++++--
 stgit/commands/status.py |   10 +++++++++-
 stgit/git.py             |   21 ++++++++++++---------
 7 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/stgit/commands/diff.py b/stgit/commands/diff.py
index b66c75b..f8b19f8 100644
--- a/stgit/commands/diff.py
+++ b/stgit/commands/diff.py
@@ -44,9 +44,8 @@ shows the specified patch (defaulting to the current one)."""
 options = [make_option('-r', '--range',
                        metavar = 'rev1[..[rev2]]', dest = 'revs',
                        help = 'show the diff between revisions'),
-           make_option('--binary',
-                       help = 'output a diff even for binary files',
-                       action = 'store_true'),
+           make_option('-O', '--diff-opts',
+                       help = 'options to pass to git-diff'),
            make_option('-s', '--stat',
                        help = 'show the stat instead of the diff',
                        action = 'store_true')]
@@ -79,8 +78,8 @@ def func(parser, options, args):
         rev1 = 'HEAD'
         rev2 = None
 
-    if options.binary:
-        diff_flags = [ '--binary' ]
+    if options.diff_opts:
+        diff_flags = options.diff_opts.split()
     else:
         diff_flags = []
 
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index d6b36a9..35851bc 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -62,9 +62,8 @@ options = [make_option('-d', '--dir',
                        help = 'Use FILE as a template'),
            make_option('-b', '--branch',
                        help = 'use BRANCH instead of the default one'),
-           make_option('--binary',
-                       help = 'output a diff even for binary files',
-                       action = 'store_true'),
+           make_option('-O', '--diff-opts',
+                       help = 'options to pass to git-diff'),
            make_option('-s', '--stdout',
                        help = 'dump the patches to the standard output',
                        action = 'store_true')]
@@ -87,8 +86,8 @@ def func(parser, options, args):
             os.makedirs(dirname)
         series = file(os.path.join(dirname, 'series'), 'w+')
 
-    if options.binary:
-        diff_flags = [ '--binary' ]
+    if options.diff_opts:
+        diff_flags = options.diff_opts.split()
     else:
         diff_flags = []
 
diff --git a/stgit/commands/files.py b/stgit/commands/files.py
index 59893d8..659a82b 100644
--- a/stgit/commands/files.py
+++ b/stgit/commands/files.py
@@ -38,6 +38,8 @@ options = [make_option('-s', '--stat',
                        action = 'store_true'),
            make_option('-b', '--branch',
                        help = 'use BRANCH instead of the default one'),
+           make_option('-O', '--diff-opts',
+                       help = 'options to pass to git-diff'),
            make_option('--bare',
                        help = 'bare file names (useful for scripting)',
                        action = 'store_true')]
@@ -61,4 +63,9 @@ def func(parser, options, args):
     elif options.bare:
         out.stdout_raw(git.barefiles(rev1, rev2) + '\n')
     else:
-        out.stdout_raw(git.files(rev1, rev2) + '\n')
+        if options.diff_opts:
+            diff_flags = options.diff_opts.split()
+        else:
+            diff_flags = []
+
+        out.stdout_raw(git.files(rev1, rev2, diff_flags = diff_flags) + '\n')
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index 7113cff..cec1828 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -120,9 +120,8 @@ options = [make_option('-a', '--all',
                        help = 'username for SMTP authentication'),
            make_option('-b', '--branch',
                        help = 'use BRANCH instead of the default one'),
-           make_option('--binary',
-                       help = 'output a diff even for binary files',
-                       action = 'store_true'),
+           make_option('-O', '--diff-opts',
+                       help = 'options to pass to git-diff'),
            make_option('-m', '--mbox',
                        help = 'generate an mbox file instead of sending',
                        action = 'store_true')]
@@ -377,8 +376,8 @@ def __build_message(tmpl, patch, patch_nr, total_nr, msg_id, ref_id, options):
     else:
         prefix_str = ''
         
-    if options.binary:
-        diff_flags = [ '--binary' ]
+    if options.diff_opts:
+        diff_flags = options.diff_opts.split()
     else:
         diff_flags = []
 
diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index a270efd..ea4c874 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -35,7 +35,9 @@ options = [make_option('-a', '--applied',
                        action = 'store_true'),
            make_option('-u', '--unapplied',
                        help = 'show the unapplied patches',
-                       action = 'store_true')]
+                       action = 'store_true'),
+           make_option('-O', '--diff-opts',
+                       help = 'options to pass to git-diff')]
 
 
 def func(parser, options, args):
@@ -58,8 +60,13 @@ def func(parser, options, args):
         else:
             patches = parse_patches(args, applied + unapplied, len(applied))
 
+    if options.diff_opts:
+        diff_flags = options.diff_opts.split()
+    else:
+        diff_flags = []
+
     commit_ids = [git_id(patch) for patch in patches]
-    commit_str = '\n'.join([git.pretty_commit(commit_id)
+    commit_str = '\n'.join([git.pretty_commit(commit_id, diff_flags=diff_flags)
                             for commit_id in commit_ids])
     if commit_str:
         pager(commit_str)
diff --git a/stgit/commands/status.py b/stgit/commands/status.py
index b8f0623..156552b 100644
--- a/stgit/commands/status.py
+++ b/stgit/commands/status.py
@@ -58,6 +58,8 @@ options = [make_option('-m', '--modified',
            make_option('-x', '--noexclude',
                        help = 'do not exclude any files from listing',
                        action = 'store_true'),
+           make_option('-O', '--diff-opts',
+                       help = 'options to pass to git-diff'),
            make_option('--reset',
                        help = 'reset the current tree changes',
                        action = 'store_true')]
@@ -75,5 +77,11 @@ def func(parser, options, args):
             resolved_all()
             git.reset()
     else:
+        if options.diff_opts:
+            diff_flags = options.diff_opts.split()
+        else:
+            diff_flags = []
+
         git.status(args, options.modified, options.new, options.deleted,
-                   options.conflict, options.unknown, options.noexclude)
+                   options.conflict, options.unknown, options.noexclude,
+                   diff_flags = diff_flags)
diff --git a/stgit/git.py b/stgit/git.py
index 7358fae..4bc41aa 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -217,7 +217,7 @@ def __run(cmd, args=None):
     return 0
 
 def __tree_status(files = None, tree_id = 'HEAD', unknown = False,
-                  noexclude = True, verbose = False):
+                  noexclude = True, verbose = False, diff_flags = []):
     """Returns a list of pairs - [status, filename]
     """
     if verbose:
@@ -254,7 +254,8 @@ def __tree_status(files = None, tree_id = 'HEAD', unknown = False,
     cache_files += [('C', filename) for filename in conflicts]
 
     # the rest
-    for line in _output_lines(['git-diff-index', tree_id, '--'] + files):
+    for line in _output_lines(['git-diff-index'] + diff_flags +
+                              [ tree_id, '--'] + files):
         fs = tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
         if fs[1] not in conflicts:
             cache_files.append(fs)
@@ -737,13 +738,15 @@ def merge(base, head1, head2, recursive = False):
         raise GitException, 'GIT index merging failed (possible conflicts)'
 
 def status(files = None, modified = False, new = False, deleted = False,
-           conflict = False, unknown = False, noexclude = False):
+           conflict = False, unknown = False, noexclude = False,
+           diff_flags = []):
     """Show the tree status
     """
     if not files:
         files = []
 
-    cache_files = __tree_status(files, unknown = True, noexclude = noexclude)
+    cache_files = __tree_status(files, unknown = True, noexclude = noexclude,
+                                diff_flags = diff_flags)
     all = not (modified or new or deleted or conflict or unknown)
 
     if not all:
@@ -809,12 +812,12 @@ def diffstat(files = None, rev1 = 'HEAD', rev2 = None):
         raise GitException, 'git.diffstat failed'
     return diff_str
 
-def files(rev1, rev2):
+def files(rev1, rev2, diff_flags = []):
     """Return the files modified between rev1 and rev2
     """
 
     result = ''
-    for line in _output_lines(['git-diff-tree', '-r', rev1, rev2]):
+    for line in _output_lines(['git-diff-tree'] + diff_flags + ['-r', rev1, rev2]):
         result += '%s %s\n' % tuple(line.rstrip().split(' ',4)[-1].split('\t',1))
 
     return result.rstrip()
@@ -829,11 +832,11 @@ def barefiles(rev1, rev2):
 
     return result.rstrip()
 
-def pretty_commit(commit_id = 'HEAD'):
+def pretty_commit(commit_id = 'HEAD', diff_flags = []):
     """Return a given commit (log + diff)
     """
-    return _output(['git-diff-tree', '--cc', '--always', '--pretty', '-r',
-                    commit_id])
+    return _output(['git-diff-tree'] + diff_flags +
+                   ['--cc', '--always', '--pretty', '-r', commit_id])
 
 def checkout(files = None, tree_id = None, force = False):
     """Check out the given or all files
