From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/3] Add 'stg cp' command.
Date: Sat, 10 Mar 2007 00:18:38 +0100
Message-ID: <20070309231838.30705.95269.stgit@gandelf.nowhere.earth>
References: <20070309231444.30705.72292.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 00:19:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPoMq-0008M9-CF
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 00:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767637AbXCIXTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 18:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767638AbXCIXTH
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 18:19:07 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:44235 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767639AbXCIXTE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 18:19:04 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C47678167;
	Sat, 10 Mar 2007 00:19:02 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 3AD4F1F095;
	Sat, 10 Mar 2007 00:18:38 +0100 (CET)
In-Reply-To: <20070309231444.30705.72292.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41818>


Supports copying several files and dirs into existing dir, as well as
copying single file or dir with a new name.

In the case of directory copying, only copies files known to git (ie,
no generated files).  Should maybe add --all as alternative.

Does not check whether we're going to lose data (overwriting any
modified file, or any file not tracked by git).  This should probably
be done first, before doing any real change (preparing the changes
in-memory, then do the work if OK).  Will give us --dry-run at no
additional cost.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/stg-cp.txt      |   59 +++++++++++++++++++++++++++++++++++++++++
 Documentation/stg.txt         |    2 +
 contrib/stgit-completion.bash |    1 +
 stgit/commands/copy.py        |   44 +++++++++++++++++++++++++++++++
 stgit/git.py                  |   57 ++++++++++++++++++++++++++++++++++++++++
 stgit/main.py                 |    2 +
 6 files changed, 165 insertions(+), 0 deletions(-)

diff --git a/Documentation/stg-cp.txt b/Documentation/stg-cp.txt
new file mode 100644
index 0000000..f499309
--- /dev/null
+++ b/Documentation/stg-cp.txt
@@ -0,0 +1,59 @@
+stg-cp(1)
+=========
+Yann Dirson <ydirson@altern.org>
+v0.13, March 2007
+
+NAME
+----
+stg-cp - stgdesc:cp[]
+
+SYNOPSIS
+--------
+stg cp [OPTIONS] <file|dir> <newname>
+
+stg cp [OPTIONS] <files|dirs...> <dir>
+
+DESCRIPTION
+-----------
+
+Make git-controlled copies of git-controlled files.  The copies are
+added to the Git index, so you can add them to a patch with
+stglink:refresh[].
+
+In the first form, copy a single file or a single directory, with a
+new name.  The parent directory of <newname> must already exist;
+<newname> itself must not already exist, or the command will be
+interpreted as one of the second form.
+
+In the second form, copy one or several files and/or directories, into
+an existing directory.
+
+Directories are copied recursively.  Only the git-controlled files
+under the named directories are copied and added to the index.  Any
+file not known to Git will not be copied.
+
+CAVEATS
+-------
+
+The first form doesn't allow yet to overwrite an existing file
+(whether it could be recovered from Git or not), and the second form
+does not check before overwriting any file, possibly leading to loss
+of non-committed modifications.
+
+FUTURE OPTIONS
+--------------
+
+--all::
+	Also copy files not known to Git when copying a directory.
+
+--force::
+	Force overwriting of target files, even if overwritten files
+	have non-committed changes or are not known to Git.
+
+--dry-run::
+	Show which files would be added, and which would be modified
+	if --force would be added.
+
+StGIT
+-----
+Part of the StGIT suite - see gitlink:stg[7].
diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index 571e53a..002606f 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -185,6 +185,8 @@ stglink:add[]::
 	stgdesc:add[]
 stglink:rm[]::
 	stgdesc:rm[]
+stglink:cp[]::
+	stgdesc:cp[]
 stglink:status[]::
 	stgdesc:status[]
 stglink:diff[]::
diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.bash
index 18645dc..09614dc 100644
--- a/contrib/stgit-completion.bash
+++ b/contrib/stgit-completion.bash
@@ -20,6 +20,7 @@ _stg_commands="
     clean
     clone
     commit
+    cp
     export
     files
     float
diff --git a/stgit/commands/copy.py b/stgit/commands/copy.py
new file mode 100644
index 0000000..76e3bf9
--- /dev/null
+++ b/stgit/commands/copy.py
@@ -0,0 +1,44 @@
+
+__copyright__ = """
+Copyright (C) 2007, Yann Dirson <ydirson@altern.org>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License version 2 as
+published by the Free Software Foundation.
+
+This program is distributed in the hope that it will be useful,
+but WITHOUT ANY WARRANTY; without even the implied warranty of
+MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+GNU General Public License for more details.
+
+You should have received a copy of the GNU General Public License
+along with this program; if not, write to the Free Software
+Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+"""
+
+import sys, os
+from optparse import OptionParser, make_option
+
+from stgit.commands.common import *
+from stgit.utils import *
+from stgit import stack, git
+
+
+help = 'copy files inside the repository'
+usage = """%prog [options] [<file/dir> <newname> | <files/dirs...> <dir>]
+
+Copy of the files and dirs passed as arguments under another name or
+location inside the same repository."""
+
+options = []
+
+def func(parser, options, args):
+    """Copy files inside the repository
+    """
+    if len(args) < 1:
+        parser.error('incorrect number of arguments')
+
+    if not crt_series.get_current():
+        raise CmdException, 'No patches applied'
+
+    git.copy(args[0:-1], args[-1])
diff --git a/stgit/git.py b/stgit/git.py
index f9094cd..9129c92 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -19,6 +19,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
 import sys, os, popen2, re, gitmergeonefile
+from shutil import copyfile
 
 from stgit import basedir
 from stgit.utils import *
@@ -428,6 +429,62 @@ def add(names):
         if __run('git-update-index --add --', files):
             raise GitException, 'Unable to add file'
 
+def __copy_single(source, target, target2=''):
+    """Copy file or dir named 'source' to name target+target2"""
+
+    # "source" (file or dir) must match one or more git-controlled file
+    realfiles = _output_lines(['git-ls-files', source])
+    if len(realfiles) == 0:
+        raise GitException, '"%s" matches no git-controled files' % source
+
+    if os.path.isdir(source):
+        # physically copy the files, and record them to add them in one run
+        newfiles = []
+        re_string='^'+source+'/(.*)$'
+        prefix_regexp = re.compile(re_string)
+        for f in [f.strip() for f in realfiles]:
+            m = prefix_regexp.match(f)
+            if not m:
+                print '"%s" does not match "%s"' % (f, re_string)
+                assert(m)
+            newname = target+target2+'/'+m.group(1)
+            if not os.path.exists(os.path.dirname(newname)):
+                os.makedirs(os.path.dirname(newname))
+            copyfile(f, newname)
+            newfiles.append(newname)
+
+        add(newfiles)
+    else: # files, symlinks, ...
+        newname = target+target2
+        copyfile(source, newname)
+        add([newname])
+
+
+def copy(filespecs, target):
+    if os.path.isdir(target):
+        # target is a directory: copy each entry on the command line,
+        # with the same name, into the target
+        for filespec in filespecs:
+            filespec = filespec.rstrip('/')
+            basename = '/' + os.path.basename(filespec)
+            __copy_single(filespec, target, basename)
+
+    elif os.path.exists(target):
+        raise GitException, 'Target "%s" exists but is not a directory' % target
+    elif len(filespecs) != 1:
+        raise GitException, 'Cannot copy more than one file to non-directory'
+
+    else:
+        # at this point: len(filespecs)==1 and target does not exist
+
+        # check target directory
+        targetdir = os.path.dirname(target)
+        if targetdir != '' and not os.path.isdir(targetdir):
+            raise GitException, 'Target directory "%s" does not exist' % targetdir
+
+        __copy_single(filespecs[0].rstrip('/'), target)
+        
+
 def rm(files, force = False):
     """Remove a file from the repository
     """
diff --git a/stgit/main.py b/stgit/main.py
index 9fcbbc2..856b868 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -68,6 +68,7 @@ commands = Commands({
     'clean':            'clean',
     'clone':            'clone',
     'commit':           'commit',
+    'cp':		'copy',
     'export':           'export',
     'files':            'files',
     'float':            'float',
@@ -143,6 +144,7 @@ patchcommands = (
     )
 wccommands = (
     'add',
+    'cp',
     'diff',
     'resolved',
     'rm',
