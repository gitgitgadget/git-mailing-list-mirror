From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 14/14] Make "stg log" show stack log instead of patch log
Date: Thu, 12 Jun 2008 07:35:31 +0200
Message-ID: <20080612053531.23549.77890.stgit@yoghurt>
References: <20080612052913.23549.69687.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 07:37:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6fUl-0005PP-GS
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 07:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829AbYFLFfj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 01:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbYFLFfi
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 01:35:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2191 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbYFLFfh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 01:35:37 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K6fT9-000174-00; Thu, 12 Jun 2008 06:35:32 +0100
In-Reply-To: <20080612052913.23549.69687.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84716>

Make "stg log" show the new stack log instead of the old patch logs,
which is now obsolete. Delete t1400-patch-history, which is specific
to the old "stg log".

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/log.py    |  169 ++++++++++++++------------------------=
--------
 stgit/commands/reset.py  |   15 +---
 stgit/lib/log.py         |    3 +
 t/t1400-patch-history.sh |  103 ----------------------------
 4 files changed, 58 insertions(+), 232 deletions(-)
 delete mode 100755 t/t1400-patch-history.sh


diff --git a/stgit/commands/log.py b/stgit/commands/log.py
index 13e0baa..cf15c7d 100644
--- a/stgit/commands/log.py
+++ b/stgit/commands/log.py
@@ -1,5 +1,8 @@
+# -*- coding: utf-8 -*-
+
 __copyright__ =3D """
 Copyright (C) 2006, Catalin Marinas <catalin.marinas@gmail.com>
+Copyright (C) 2008, Karl Hasselstr=C3=B6m <kha@treskal.com>
=20
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2 as
@@ -15,133 +18,67 @@ along with this program; if not, write to the Free=
 Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-import sys, os, time
-from optparse import OptionParser, make_option
-from pydoc import pager
-from stgit.commands.common import *
-from stgit import stack, git
-from stgit.out import *
-from stgit.run import Run
+import os.path
+from optparse import make_option
+from stgit import run
+from stgit.commands import common
+from stgit.lib import log
+from stgit.out import out
=20
 help =3D 'display the patch changelog'
-usage =3D """%prog [options] [patch]
-
-List all the current and past commit ids of the given patch. The
---graphical option invokes gitk instead of printing. The changelog
-commit messages have the form '<action> <new-patch-id>'. The <action>
-can be one of the following:
+usage =3D """%prog [options] [<patchnames>]
=20
-  new     - new patch created
-  refresh - local changes were added to the patch
-  push    - the patch was cleanly pushed onto the stack
-  push(m) - the patch was pushed onto the stack with a three-way merge
-  push(f) - the patch was fast-forwarded
-  undo    - the patch boundaries were restored to the old values
+List the history of the patch stack: the stack log. If one or more
+patch names are given, limit the list to the log entries that touch
+the named patches.
=20
-Note that only the diffs shown in the 'refresh', 'undo' and 'sync'
-actions are meaningful for the patch changes. The 'push' actions
-represent the changes to the entire base of the current
-patch. Conflicts reset the patch content and a subsequent 'refresh'
-will show the entire patch."""
+"stg undo" and "stg redo" let you step back and forth in the patch
+stack. "stg reset" lets you go directly to any state."""
=20
-directory =3D DirectoryHasRepository(log =3D False)
+directory =3D common.DirectoryHasRepositoryLib()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
'),
-           make_option('-p', '--patch',
-                       help =3D 'show the refresh diffs',
-                       action =3D 'store_true'),
+           make_option('-d', '--diff', action =3D 'store_true',
+                       help =3D 'show diff to previous state'),
            make_option('-n', '--number', type =3D 'int',
-                       help =3D 'limit the output to NUMBER commits'),
-           make_option('-f', '--full',
-                       help =3D 'show the full commit ids',
-                       action =3D 'store_true'),
-           make_option('-g', '--graphical',
-                       help =3D 'run gitk instead of printing',
-                       action =3D 'store_true')]
-
-def show_log(log, options):
-    """List the patch changelog
-    """
-    commit =3D git.get_commit(log)
-    if options.number !=3D None:
-        n =3D options.number
-    else:
-        n =3D -1
-    diff_list =3D []
-    while commit:
-        if n =3D=3D 0:
-            # limit the output
-            break
-
-        log =3D commit.get_log().split('\n')
-
-        cmd_rev =3D log[0].split()
-        if len(cmd_rev) >=3D 2:
-            cmd =3D cmd_rev[0]
-            rev =3D cmd_rev[1]
-        elif len(cmd_rev) =3D=3D 1:
-            cmd =3D cmd_rev[0]
-            rev =3D ''
-        else:
-            cmd =3D rev =3D ''
-
-        if options.patch:
-            if cmd in ['refresh', 'undo', 'sync', 'edit']:
-                diff_list.append(git.pretty_commit(commit.get_id_hash(=
)))
-
-                # limiter decrement
-                n -=3D 1
-        else:
-            if len(log) >=3D 3:
-                notes =3D log[2]
-            else:
-                notes =3D ''
-            author_name, author_email, author_date =3D \
-                         name_email_date(commit.get_author())
-            secs, tz =3D author_date.split()
-            date =3D '%s %s' % (time.ctime(int(secs)), tz)
-
-            if options.full:
-                out.stdout('%-7s %-40s %s' % (cmd[:7], rev[:40], date)=
)
-            else:
-                out.stdout('%-8s [%-7s] %-28s  %s' % \
-                           (rev[:8], cmd[:7], notes[:28], date))
-
-            # limiter decrement
-            n -=3D 1
-
-        parent =3D commit.get_parent()
-        if parent:
-            commit =3D git.get_commit(parent)
-        else:
-            commit =3D None
-
-    if options.patch and diff_list:
-        pager('\n'.join(diff_list).rstrip())
+                       help =3D 'limit the output to NUMBER entries'),
+           make_option('-f', '--full', action =3D 'store_true',
+                       help =3D 'show the log in more detail'),
+           make_option('-g', '--graphical', action =3D 'store_true',
+                       help =3D 'run gitk instead of printing')]
+
+def show_log(stacklog, pathlim, num, full, show_diff):
+    cmd =3D ['git', 'log']
+    if num !=3D None and num > 0:
+        cmd.append('-%d' % num)
+    if show_diff:
+        cmd.append('-p')
+    elif not full:
+        cmd.append('--pretty=3Dformat:%h   %aD   %s')
+    run.Run(*(cmd + [stacklog.sha1, '--'] + pathlim)).run()
=20
 def func(parser, options, args):
-    """Show the patch changelog
-    """
-    if len(args) =3D=3D 0:
-        name =3D crt_series.get_current()
-        if not name:
-            raise CmdException, 'No patches applied'
-    elif len(args) =3D=3D 1:
-        name =3D args[0]
-        if not name in crt_series.get_applied() + crt_series.get_unapp=
lied() + \
-               crt_series.get_hidden():
-            raise CmdException, 'Unknown patch "%s"' % name
+    if options.branch:
+        stack =3D directory.repository.get_stack(options.branch)
     else:
-        parser.error('incorrect number of arguments')
-
-    patch =3D crt_series.get_patch(name)
-
-    log =3D patch.get_log()
-    if not log:
-        raise CmdException, 'No changelog for patch "%s"' % name
+        stack =3D directory.repository.current_stack
+    patches =3D common.parse_patches(args, list(stack.patchorder.all))
+    logref =3D log.log_ref(stack.name)
+    try:
+        logcommit =3D stack.repository.refs.get(logref)
+    except KeyError:
+        out.info('Log is empty')
+        return
+    stacklog =3D log.Log(stack.repository, logref, logcommit)
+    pathlim =3D [os.path.join('patches', pn) for pn in patches]
=20
     if options.graphical:
-        # discard the exit codes generated by SIGINT, SIGKILL, SIGTERM
-        Run('gitk', log).returns([0, -2, -9, -15]).run()
+        for o in ['diff', 'number', 'full']:
+            if getattr(options, o):
+                parser.error('cannot combine --graphical and --%s' % o=
)
+        # Discard the exit codes generated by SIGINT, SIGKILL, and SIG=
TERM.
+        run.Run(*(['gitk', stacklog.pretty.sha1, '--'] + pathlim)
+                 ).returns([0, -2, -9, -15]).run()
     else:
-        show_log(log, options)
+        show_log(stacklog.pretty, pathlim,
+                 options.number, options.full, options.diff)
diff --git a/stgit/commands/reset.py b/stgit/commands/reset.py
index 22d7731..bbe5dda 100644
--- a/stgit/commands/reset.py
+++ b/stgit/commands/reset.py
@@ -26,19 +26,8 @@ help =3D 'reset the patch stack to an earlier state'
 usage =3D """%prog [options] <state> [<patchnames>]
=20
 Reset the patch stack to an earlier state. The state is specified with
-a commit from a stack log; for a branch foo, StGit stores the stack
-log in foo.stgit^. So to undo the last N StGit commands (or rather,
-the last N log entries; there is not an exact one-to-one
-relationship), you would say
-
-  stg reset foo.stgit^~N
-
-or, if you are not sure how many steps to undo, you can view the log
-with "git log" or gitk
-
-  gitk foo.stgit^
-
-and then reset to any sha1 you see in the log.
+a commit id from a stack log; "stg log" lets you view this log, and
+"stg reset" lets you reset to any state you see in the log.
=20
 If one or more patch names are given, reset only those patches, and
 leave the rest alone."""
diff --git a/stgit/lib/log.py b/stgit/lib/log.py
index 8c0516b..61e9cf2 100644
--- a/stgit/lib/log.py
+++ b/stgit/lib/log.py
@@ -270,6 +270,9 @@ class Log(object):
     def parents(self):
         num_refs =3D len(set([self.top, self.head]))
         return self.commit.data.parents[(1 + num_refs):]
+    @property
+    def pretty(self):
+        return self.commit.data.parents[0]
=20
 class FullLog(Log):
     full_log =3D property(lambda self: self.commit)
diff --git a/t/t1400-patch-history.sh b/t/t1400-patch-history.sh
deleted file mode 100755
index a693e75..0000000
--- a/t/t1400-patch-history.sh
+++ /dev/null
@@ -1,103 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2006 Catalin Marinas
-#
-
-test_description=3D'Test the patch history generation.
-
-'
-
-. ./test-lib.sh
-
-test_expect_success \
-	'Initialize the StGIT repository' \
-	'
-	stg init
-	'
-
-test_expect_success \
-	'Create the first patch' \
-	'
-	stg new foo -m "Foo Patch" &&
-	echo foo > test && echo foo2 >> test &&
-	git add test &&
-	stg refresh --annotate=3D"foo notes"
-	'
-
-test_expect_success \
-	'Create the second patch' \
-	'
-	stg new bar -m "Bar Patch" &&
-	echo bar >> test &&
-	stg refresh
-	'
-
-test_expect_success \
-	'Check the "new" and "refresh" logs' \
-	'
-	stg log --full foo | grep -q -e "^refresh" &&
-	stg log --full | grep -q -e "^refresh"
-	'
-
-test_expect_success \
-	'Check the log annotation' \
-	'
-	stg log foo | grep -q -e    "\[refresh\] foo notes  " &&
-	stg log bar | grep -q -e    "\[refresh\]            " &&
-	stg refresh -p foo --annotate=3D"foo notes 2" &&
-	stg log foo | grep -q -v -e "\[refresh\] foo notes  " &&
-	stg log foo | grep -q -e    "\[refresh\] foo notes 2"
-	'
-
-test_expect_success \
-	'Check the "push" log' \
-	'
-	stg pop &&
-	echo foo > test2 && git add test2 && stg refresh &&
-	stg push &&
-	stg log --full | grep -q -e "^push    "
-	'
-
-test_expect_success \
-	'Check the "push(f)" log' \
-	'
-	stg pop &&
-	stg edit -m "Foo2 Patch" &&
-	stg push &&
-	stg log --full | grep -q -e "^push(f) "
-	'
-
-test_expect_success \
-	'Check the "push(m)" log' \
-	'
-	stg pop &&
-	echo foo2 > test && stg refresh &&
-	stg push &&
-	stg log --full | grep -q -e "^push(m) "
-	'
-
-test_expect_success \
-	'Check the "push(c)" log' \
-	'
-	echo bar > test && stg refresh &&
-	stg pop &&
-	echo foo > test && stg refresh &&
-	! stg push &&
-	stg log --full | grep -q -e "^push(c) "
-	'
-
-test_expect_success \
-	'Check the push "undo" log' \
-	'
-	stg push --undo &&
-	stg log --full bar | grep -q -e "^undo    "
-	'
-
-test_expect_success \
-	'Check the refresh "undo" log' \
-	'
-	stg refresh --undo &&
-	stg log --full | grep -q -e "^undo    "
-	'
-
-test_done
