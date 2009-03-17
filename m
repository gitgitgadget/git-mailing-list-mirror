From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 1/4] Add mergetool support to the classic StGit
	infrastructure
Date: Tue, 17 Mar 2009 11:08:53 +0000
Message-ID: <20090317110853.27748.70157.stgit@pc1117.cambridge.arm.com>
References: <20090317110721.27748.10295.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 12:11:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjXCk-0004sL-90
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 12:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755970AbZCQLJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 07:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755932AbZCQLJZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 07:09:25 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:47533 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755888AbZCQLJY (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 07:09:24 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n2HB7ZZm019800;
	Tue, 17 Mar 2009 11:07:35 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Mar 2009 11:09:18 +0000
In-Reply-To: <20090317110721.27748.10295.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.353.gf255
X-OriginalArrivalTime: 17 Mar 2009 11:09:18.0818 (UTC) FILETIME=[D127D420:01C9A6F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113464>

Since Git already has a tool for interactively solving conflicts which
is highly customisable, there is no need to duplicate this feature via
the i3merge and i2merge configuration options. The user-visible change
is that now mergetool is invoked rather than the previously customised
interactive merging tool.

The stgit.keeporig option is no longer available to be more consistent
with the Git behaviour.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 examples/gitconfig         |   21 +-----
 stgit/commands/resolved.py |    5 -
 stgit/config.py            |    1 
 stgit/git.py               |   31 +++++----
 stgit/gitmergeonefile.py   |  150 --------------------------------------------
 t/t0002-status.sh          |    3 -
 6 files changed, 20 insertions(+), 191 deletions(-)
 delete mode 100644 stgit/gitmergeonefile.py

diff --git a/examples/gitconfig b/examples/gitconfig
index 2fc5f52..f6e3a79 100644
--- a/examples/gitconfig
+++ b/examples/gitconfig
@@ -64,27 +64,10 @@
 	# To support local parent branches:
 	#pull-policy = rebase
 
-	# Interactive two/three-way merge tool. It is executed by the
-	# 'resolved --interactive' command
-	#i3merge = xxdiff --title1 current --title2 ancestor --title3 patched \
-	#	--show-merged-pane -m -E -O -X -M \"%(output)s\" \
-	#	\"%(branch1)s\" \"%(ancestor)s\" \"%(branch2)s\"
-	#i2merge = xxdiff --title1 current --title2 patched \
-	#	--show-merged-pane -m -E -O -X -M \"%(output)s\" \
-	#	\"%(branch1)s\" \"%(branch2)s\"
-	#i3merge = emacs --eval '(ediff-merge-files-with-ancestor \
-	#	\"%(branch1)s\" \"%(branch2)s\" \"%(ancestor)s\" nil \
-	#	\"%(output)s\")'
-	#i2merge = emacs --eval '(ediff-merge-files \
-	#	\"%(branch1)s\" \"%(branch2)s\" nil \"%(output)s\")'
-
-	# Automatically invoke the interactive merger in case of conflicts
+	# Automatically invoke the interactive merger (git mergetool) in case
+	# of conflicts
 	#autoimerge = no
 
-	# Leave the original files in the working tree in case of a
-	# merge conflict
-	#keeporig = yes
-
 	# Optimize (repack) the object store after every pull
 	#keepoptimized = yes
 
diff --git a/stgit/commands/resolved.py b/stgit/commands/resolved.py
index 2ce7ec3..eba778d 100644
--- a/stgit/commands/resolved.py
+++ b/stgit/commands/resolved.py
@@ -22,7 +22,6 @@ from stgit.commands.common import *
 from stgit.utils import *
 from stgit import argparse, stack, git, basedir
 from stgit.config import config, file_extensions
-from stgit.gitmergeonefile import interactive_merge
 
 help = 'Mark a file conflict as solved'
 kind = 'wc'
@@ -78,8 +77,6 @@ def func(parser, options, args):
 
     # resolved
     if options.interactive:
-        for filename in files:
-            interactive_merge(filename)
-            git.resolved([filename])
+        git.mergetool(files)
     else:
         git.resolved(files, options.reset)
diff --git a/stgit/config.py b/stgit/config.py
index 05ef624..efce097 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -35,7 +35,6 @@ class GitConfig:
         'stgit.fetchcmd':	'git fetch',
         'stgit.pull-policy':	'pull',
         'stgit.autoimerge':	'no',
-        'stgit.keeporig':	'yes',
         'stgit.keepoptimized':	'no',
         'stgit.extensions':	'.ancestor .current .patched',
         'stgit.shortnr':	 '5'
diff --git a/stgit/git.py b/stgit/git.py
index 4d01fc2..cbdefe8 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -18,7 +18,7 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os, re, gitmergeonefile
+import sys, os, re
 from shutil import copyfile
 
 from stgit.exception import *
@@ -632,19 +632,23 @@ def merge_recursive(base, head1, head2):
     output = p.output_lines()
     if p.exitcode:
         # There were conflicts
-        conflicts = [l.strip() for l in output if l.startswith('CONFLICT')]
+        if config.get('stgit.autoimerge') == 'yes':
+            mergetool()
+        else:
+            conflicts = [l for l in output if l.startswith('CONFLICT')]
+            out.info(*conflicts)
+            raise GitException, "%d conflict(s)" % len(conflicts)
+
+def mergetool(files = ()):
+    """Invoke 'git mergetool' to resolve any outstanding conflicts. If 'not
+    files', all the files in an unmerged state will be processed."""
+    GRun('mergetool', *list(files)).returns([0, 1]).run()
+    # check for unmerged entries (prepend 'CONFLICT ' for consistency with
+    # merge_recursive())
+    conflicts = ['CONFLICT ' + f for f in get_conflicts()]
+    if conflicts:
         out.info(*conflicts)
-
-        # try the interactive merge or stage checkout (if enabled)
-        for filename in get_conflicts():
-            if (gitmergeonefile.merge(filename)):
-                # interactive merge succeeded
-                resolved([filename])
-
-        # any conflicts left unsolved?
-        cn = len(get_conflicts())
-        if cn:
-            raise GitException, "%d conflict(s)" % cn
+        raise GitException, "%d conflict(s)" % len(conflicts)
 
 def diff(files = None, rev1 = 'HEAD', rev2 = None, diff_flags = [],
          binary = True):
@@ -754,7 +758,6 @@ def resolved(filenames, reset = None):
              '--stdin', '-z').input_nulterm(filenames).no_output()
     GRun('update-index', '--add', '--').xargs(filenames)
     for filename in filenames:
-        gitmergeonefile.clean_up(filename)
         # update the access and modificatied times
         os.utime(filename, None)
 
diff --git a/stgit/gitmergeonefile.py b/stgit/gitmergeonefile.py
deleted file mode 100644
index 1fe226e..0000000
--- a/stgit/gitmergeonefile.py
+++ /dev/null
@@ -1,150 +0,0 @@
-"""Performs a 3-way merge for GIT files
-"""
-
-__copyright__ = """
-Copyright (C) 2006, Catalin Marinas <catalin.marinas@gmail.com>
-
-This program is free software; you can redistribute it and/or modify
-it under the terms of the GNU General Public License version 2 as
-published by the Free Software Foundation.
-
-This program is distributed in the hope that it will be useful,
-but WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-GNU General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; if not, write to the Free Software
-Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
-"""
-
-import sys, os
-from stgit.exception import *
-from stgit import basedir
-from stgit.config import config, file_extensions, ConfigOption
-from stgit.utils import append_string
-from stgit.out import *
-from stgit.run import *
-
-class GitMergeException(StgException):
-    pass
-
-
-#
-# Options
-#
-autoimerge = ConfigOption('stgit', 'autoimerge')
-keeporig = ConfigOption('stgit', 'keeporig')
-
-#
-# Utility functions
-#
-def __str2none(x):
-    if x == '':
-        return None
-    else:
-        return x
-
-class MRun(Run):
-    exc = GitMergeException # use a custom exception class on errors
-
-def __checkout_stages(filename):
-    """Check-out the merge stages in the index for the give file
-    """
-    extensions = file_extensions()
-    line = MRun('git', 'checkout-index', '--stage=all', '--', filename
-                ).output_one_line()
-    stages, path = line.split('\t')
-    stages = dict(zip(['ancestor', 'current', 'patched'],
-                      stages.split(' ')))
-
-    for stage, fn in stages.iteritems():
-        if stages[stage] == '.':
-            stages[stage] = None
-        else:
-            newname = filename + extensions[stage]
-            if os.path.exists(newname):
-                # remove the stage if it is already checked out
-                os.remove(newname)
-            os.rename(stages[stage], newname)
-            stages[stage] = newname
-
-    return stages
-
-def __remove_stages(filename):
-    """Remove the merge stages from the working directory
-    """
-    extensions = file_extensions()
-    for ext in extensions.itervalues():
-        fn = filename + ext
-        if os.path.isfile(fn):
-            os.remove(fn)
-
-def interactive_merge(filename):
-    """Run the interactive merger on the given file. Stages will be
-    removed according to stgit.keeporig. If successful and stages
-    kept, they will be removed via git.resolved().
-    """
-    stages = __checkout_stages(filename)
-
-    try:
-        # Check whether we have all the files for the merge.
-        if not (stages['current'] and stages['patched']):
-            raise GitMergeException('Cannot run the interactive merge')
-
-        if stages['ancestor']:
-            three_way = True
-            files_dict = {'branch1': stages['current'],
-                          'ancestor': stages['ancestor'],
-                          'branch2': stages['patched'],
-                          'output': filename}
-            imerger = config.get('stgit.i3merge')
-        else:
-            three_way = False
-            files_dict = {'branch1': stages['current'],
-                          'branch2': stages['patched'],
-                          'output': filename}
-            imerger = config.get('stgit.i2merge')
-
-        if not imerger:
-            raise GitMergeException, 'No interactive merge command configured'
-
-        mtime = os.path.getmtime(filename)
-
-        out.start('Trying the interactive %s merge'
-                  % (three_way and 'three-way' or 'two-way'))
-        err = os.system(imerger % files_dict)
-        out.done()
-        if err != 0:
-            raise GitMergeException, 'The interactive merge failed'
-        if not os.path.isfile(filename):
-            raise GitMergeException, 'The "%s" file is missing' % filename
-        if mtime == os.path.getmtime(filename):
-            raise GitMergeException, 'The "%s" file was not modified' % filename
-    finally:
-        # keep the merge stages?
-        if str(keeporig) != 'yes':
-            __remove_stages(filename)
-
-def clean_up(filename):
-    """Remove merge conflict stages if they were generated.
-    """
-    if str(keeporig) == 'yes':
-        __remove_stages(filename)
-
-def merge(filename):
-    """Merge one file if interactive is allowed or check out the stages
-    if keeporig is set.
-    """
-    if str(autoimerge) == 'yes':
-        try:
-            interactive_merge(filename)
-        except GitMergeException, ex:
-            out.error(str(ex))
-            return False
-        return True
-
-    if str(keeporig) == 'yes':
-        __checkout_stages(filename)
-
-    return False
diff --git a/t/t0002-status.sh b/t/t0002-status.sh
index ac92aa8..d95a83b 100755
--- a/t/t0002-status.sh
+++ b/t/t0002-status.sh
@@ -107,9 +107,6 @@ test_expect_success 'Make a conflicting patch' '
 '
 
 cat > expected.txt <<EOF
-? foo/bar.ancestor
-? foo/bar.current
-? foo/bar.patched
 A fie
 C foo/bar
 EOF
