From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Add new 'rebase' command.
Date: Sat, 20 Jan 2007 19:04:21 +0100
Message-ID: <20070120180329.22621.30534.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 20 19:05:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8KaH-0006AV-9C
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 19:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965353AbXATSEp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 13:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965351AbXATSEp
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 13:04:45 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:38690 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965344AbXATSEo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 13:04:44 -0500
X-Greylist: delayed 8252 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jan 2007 13:04:44 EST
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 27E1B4A1E7;
	Sat, 20 Jan 2007 19:04:43 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1H8Ka2-0000Si-FP; Sat, 20 Jan 2007 19:04:42 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37278>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

Take two: I had forgotten to add "rebase" to the list of stack
commands for the purpose of help.

 stgit/commands/rebase.py |   69 ++++++++++++++++++++++++++++++++++++++++++++++
 stgit/main.py            |    2 +
 t/t2200-rebase.sh        |   33 ++++++++++++++++++++++
 3 files changed, 104 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/rebase.py b/stgit/commands/rebase.py
new file mode 100644
index 0000000..79d67a7
--- /dev/null
+++ b/stgit/commands/rebase.py
@@ -0,0 +1,69 @@
+__copyright__ = """
+Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
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
+help = 'move the stack base to another point in history'
+usage = """%prog [options] --to <target-commit>
+
+Pop all patches from current stack, move the stack base to the
+given <target-commit>, and push the patches back."""
+
+options = [make_option('-n', '--nopush',
+                       help = 'do not push the patches back after pulling',
+                       action = 'store_true'),
+           make_option('--to', metavar = 'COMMITID',
+                       help = 'move the stack base to COMMITID')]
+
+def func(parser, options, args):
+    """Rebase the current stack
+    """
+    if len(args) > 0:
+        parser.error('incorrect number of arguments')
+
+    if not options.to:
+        parser.error('rebase requires option --to')
+
+    if crt_series.get_protected():
+        raise CmdException, 'This branch is protected. Rebase is not permitted'
+
+    check_local_changes()
+    check_conflicts()
+    check_head_top_equal()
+
+    # pop all patches
+    applied = crt_series.get_applied()
+    if len(applied) > 0:
+        print 'Popping all applied patches...',
+        sys.stdout.flush()
+        crt_series.pop_patch(applied[0])
+        print 'done'
+
+    print 'Rebasing to "%s"...' % options.to
+    git.reset(tree_id = git_id(options.to))
+
+    # push the patches back
+    if not options.nopush:
+        push_patches(applied)
+
+    print_crt_patch()
diff --git a/stgit/main.py b/stgit/main.py
index 0f92f75..ca2bbde 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -80,6 +80,7 @@ commands = Commands({
     'pop':              'pop',
     'pull':             'pull',
     'push':             'push',
+    'rebase':           'rebase',
     'refresh':          'refresh',
     'rename':           'rename',
     'resolved':         'resolved',
@@ -110,6 +111,7 @@ stackcommands = (
     'init',
     'pop',
     'push',
+    'rebase',
     'series',
     'top',
     'unapplied',
diff --git a/t/t2200-rebase.sh b/t/t2200-rebase.sh
new file mode 100755
index 0000000..6211cbd
--- /dev/null
+++ b/t/t2200-rebase.sh
@@ -0,0 +1,33 @@
+#!/bin/sh
+#
+# Copyright (c) 2007 Yann Dirson
+#
+
+test_description='Test the "rebase" command.'
+
+. ./test-lib.sh
+
+test_expect_success \
+	'Setup a multi-commit branch and fork an stgit stack' \
+	'
+	echo foo > file1 &&
+	git add file1 &&
+	git commit -m a &&
+	echo foo > file2 &&
+	git add file2 &&
+	git commit -m b &&
+
+	stg branch --create stack &&
+	stg new p -m . &&
+	echo bar >> file1 &&
+	stg refresh
+	'
+
+test_expect_success \
+	'Rebase to previous commit' \
+	'
+	stg rebase --to master~1 &&
+	test `git rev-parse bases/stack` = `git rev-parse master~1`
+	'
+
+test_done
