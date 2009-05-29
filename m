From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH] Remove the resolved command
Date: Fri, 29 May 2009 22:30:13 +0100
Message-ID: <20090529213013.8908.45041.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri May 29 23:35:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MA9ji-0007VI-Fv
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 23:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbZE2VfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 17:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752104AbZE2VfY
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 17:35:24 -0400
Received: from queueout01-winn.ispmail.ntl.com ([81.103.221.31]:37564 "EHLO
	queueout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752430AbZE2VfW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 May 2009 17:35:22 -0400
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2009 17:35:20 EDT
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20090529213015.SYJN6742.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Fri, 29 May 2009 22:30:15 +0100
Received: from localhost.localdomain ([86.9.126.106])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20090529213015.CUEG21638.aamtaout02-winn.ispmail.ntl.com@localhost.localdomain>;
          Fri, 29 May 2009 22:30:15 +0100
User-Agent: StGit/0.14.3.340.ge799
X-Cloudmark-Analysis: v=1.0 c=1 a=jM_PeXI2IywA:10 a=7CQSdrXTAAAA:8 a=pGLkceISAAAA:8 a=j7wr7-tgU26FNkBVIgEA:9 a=lvY4HIhyj2wd7WtXN2wA:7 a=RjzJXwGhrNJ5jpnTcQVpp4Tli-YA:4 a=ESTKKtUg-DoA:10 a=MSl-tDqOz04A:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120318>

From: Catalin Marinas <catalin.marinas@arm.com>

This command simply duplicates the "git add" or "git mergetool" commands
for handling conflicts.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/tutorial.txt |    2 +
 examples/gitconfig         |    4 --
 stgit/commands/common.py   |    2 +
 stgit/commands/push.py     |    4 +-
 stgit/commands/rebase.py   |    2 +
 stgit/commands/resolved.py |   82 --------------------------------------------
 stgit/config.py            |    1 -
 t/t0002-status.sh          |    2 +
 t/t2000-sync.sh            |    4 +-
 9 files changed, 8 insertions(+), 95 deletions(-)
 delete mode 100644 stgit/commands/resolved.py

diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 8e0adbf..4aa7629 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -313,7 +313,7 @@ markers.
 Now that we've resolved the conflict, we just need to tell StGit about
 it:
 
-  $ stg resolved TODO
+  $ git add TODO
   $ stg status
   M TODO
 
diff --git a/examples/gitconfig b/examples/gitconfig
index e235e14..4f56918 100644
--- a/examples/gitconfig
+++ b/examples/gitconfig
@@ -17,10 +17,6 @@
 	# Automatically sign newly created patches
 	#autosign = Signed-off-by
 
-	# Set to 'yes' if you don't want to use the 'resolved' command.
-	# 'refresh' will automatically mark the conflicts as resolved
-	#autoresolved = no
-
 	# SMTP server for sending patches
 	#smtpserver = /usr/sbin/sendmail -t -i
 	#smtpserver = localhost:25
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 1bc162f..bc8266e 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -120,7 +120,7 @@ def check_head_top_equal(crt_series):
 def check_conflicts():
     if git.get_conflicts():
         raise CmdException('Unsolved conflicts. Please fix the conflicts'
-                           ' then use "resolve <files>" or revert the'
+                           ' then use "git add --update <files>" or revert the'
                            ' changes with "status --reset".')
 
 def print_crt_patch(crt_series, branch = None):
diff --git a/stgit/commands/push.py b/stgit/commands/push.py
index 84a93bd..d5e02e0 100644
--- a/stgit/commands/push.py
+++ b/stgit/commands/push.py
@@ -30,8 +30,8 @@ the stack. The 'push' operation allows patch reordering by commuting
 them with the three-way merge algorithm. If there are conflicts while
 pushing a patch, those conflicts are written to the work tree, and the
 command halts. Conflicts raised during the push operation have to be
-fixed and the 'resolved' command run (alternatively, you may undo the
-conflicting push with 'stg undo').
+fixed and the 'git add --update' command run (alternatively, you may
+undo the conflicting push with 'stg undo').
 
 The command also notifies when the patch becomes empty (fully merged
 upstream) or is modified (three-way merged) by the 'push' operation."""
diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
index a4bc6e7..b949a5c 100644
--- a/stgit/commands/rebase.py
+++ b/stgit/commands/rebase.py
@@ -31,7 +31,7 @@ Pop all patches from current stack, move the stack base to the given
 If you experience merge conflicts, resolve the problem and continue
 the rebase by executing the following sequence:
 
-        $ stg resolved -a [-i]
+        $ git add --update
         $ stg refresh
         $ stg goto top-patch
 
diff --git a/stgit/commands/resolved.py b/stgit/commands/resolved.py
deleted file mode 100644
index eba778d..0000000
--- a/stgit/commands/resolved.py
+++ /dev/null
@@ -1,82 +0,0 @@
-
-__copyright__ = """
-Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
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
-from stgit.argparse import opt
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit import argparse, stack, git, basedir
-from stgit.config import config, file_extensions
-
-help = 'Mark a file conflict as solved'
-kind = 'wc'
-usage = ['[options] [<files...>]']
-description = """
-Mark a merge conflict as resolved. The conflicts can be seen with the
-'status' command, the corresponding files being prefixed with a
-'C'."""
-
-args = [argparse.conflicting_files]
-options = [
-    opt('-a', '--all', action = 'store_true',
-        short = 'Mark all conflicts as solved'),
-    opt('-r', '--reset', metavar = '(ancestor|current|patched)',
-        args = [argparse.strings('ancestor', 'current', 'patched')],
-        short = 'Reset the file(s) to the given state'),
-    opt('-i', '--interactive', action = 'store_true',
-        short = 'Run the interactive merging tool')]
-
-directory = DirectoryHasRepository(needs_current_series = False, log = False)
-
-def func(parser, options, args):
-    """Mark the conflict as resolved
-    """
-    args = git.ls_files(args)
-    directory.cd_to_topdir()
-
-    if options.reset \
-           and options.reset not in file_extensions():
-        raise CmdException, 'Unknown reset state: %s' % options.reset
-
-    if options.all and not options.interactive:
-        resolved_all(options.reset)
-        return
-
-    conflicts = git.get_conflicts()
-
-    if len(args) != 0:
-        files = args
-    elif options.all:
-        files = conflicts
-    else:
-        parser.error('incorrect number of arguments')
-
-    if not conflicts:
-        raise CmdException, 'No more conflicts'
-
-    # check for arguments validity
-    if not options.all:
-        for filename in files:
-            if not filename in conflicts:
-                raise CmdException, 'No conflicts for "%s"' % filename
-
-    # resolved
-    if options.interactive:
-        git.mergetool(files)
-    else:
-        git.resolved(files, options.reset)
diff --git a/stgit/config.py b/stgit/config.py
index a98c303..a3dbfa5 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -28,7 +28,6 @@ class GitConfigException(StgException):
 
 class GitConfig:
     __defaults={
-        'stgit.autoresolved':	'no',
         'stgit.smtpserver':	'localhost:25',
         'stgit.smtpdelay':	'5',
         'stgit.pullcmd':	'git pull',
diff --git a/t/t0002-status.sh b/t/t0002-status.sh
index ffcad77..2512c53 100755
--- a/t/t0002-status.sh
+++ b/t/t0002-status.sh
@@ -145,7 +145,7 @@ A fie
 M foo/bar
 EOF
 test_expect_success 'Status after resolving the push' '
-    stg resolved -a &&
+    git add --update &&
     stg status > output.txt &&
     test_cmp expected.txt output.txt
 '
diff --git a/t/t2000-sync.sh b/t/t2000-sync.sh
index 00ea7bd..d550538 100755
--- a/t/t2000-sync.sh
+++ b/t/t2000-sync.sh
@@ -117,7 +117,7 @@ test_expect_success \
     '
     [ "$(echo $(stg series --applied --noprefix))" = "p1" ] &&
     [ "$(echo $(stg series --unapplied --noprefix))" = "p2 p3" ] &&
-    stg resolved -a &&
+    git add --update &&
     stg refresh &&
     stg goto p3
     [ "$(echo $(stg series --applied --noprefix))" = "p1 p2 p3" ] &&
@@ -135,7 +135,7 @@ test_expect_success \
     '
     [ "$(echo $(stg series --applied --noprefix))" = "p1 p2 p3" ] &&
     [ "$(echo $(stg series --unapplied --noprefix))" = "" ] &&
-    stg resolved -a &&
+    git add --update &&
     stg refresh &&
     [ "$(echo $(stg series --applied --noprefix))" = "p1 p2 p3" ] &&
     [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
