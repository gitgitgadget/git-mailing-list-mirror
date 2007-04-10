From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Add "stg bury" command,
	with the functionnality of contrib/stg-sink.
Date: Tue, 10 Apr 2007 20:27:02 +0200
Message-ID: <20070410182701.9362.68038.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 21:51:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbL47-0008Sb-Mp
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 20:27:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031394AbXDJS1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 14:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031398AbXDJS1e
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 14:27:34 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:39599 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031394AbXDJS1d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 14:27:33 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 72F715E04B;
	Tue, 10 Apr 2007 20:27:31 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 549C61F0A5;
	Tue, 10 Apr 2007 20:27:02 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44140>


This is the rewrite in python of by stg-sink written in perl.

I changed the name to "bury" since it seems more descriptive of what
it does, despite being less of an opposite to "float" than "sink" was.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/stg-bury.txt    |   49 +++++++++++++++++++++++++++++++
 Documentation/stg.txt         |    2 +
 contrib/stg-sink              |   44 ----------------------------
 contrib/stgit-completion.bash |    1 +
 stgit/commands/bury.py        |   65 +++++++++++++++++++++++++++++++++++++++++
 stgit/main.py                 |    2 +
 6 files changed, 119 insertions(+), 44 deletions(-)

diff --git a/Documentation/stg-bury.txt b/Documentation/stg-bury.txt
new file mode 100644
index 0000000..22ab548
--- /dev/null
+++ b/Documentation/stg-bury.txt
@@ -0,0 +1,49 @@
+stg-bury(1)
+===========
+Yann Dirson <ydirson@altern.org>
+v0.13, April 2007
+
+NAME
+----
+stg-bury - stgdesc:bury[]
+
+SYNOPSIS
+--------
+[verse]
+'stg' bury [--to=<target>] [--nopush] [<patches>]
+
+DESCRIPTION
+-----------
+
+This is the opposite operation of stglink:float[]: move the specified
+patches down the stack.  It is for example useful to group stable
+patches near the bottom of the stack, where they are less likely to be
+impacted by the push of another patch, and from where they can be more
+easily committed or pushed.
+
+If no patch is specified on command-line, the current patch is buried.
+By default patches are buried at the bottom of the stack, but the
+'--to' option allows to bury under any applied patch.
+
+Buring internally involves popping all patches (or all patches
+including <target patch>), then pushing the patches to bury, and then
+(unless '--nopush' is also given) pushing back into place the
+formerly-applied patches.
+
+
+OPTIONS
+-------
+
+--to=<TARGET>::
+-t <TARGET>::
+	Specify a target patch to bury the patches below, instead of
+	buring at the bottom of the stack.
+
+--nopush::
+-n::
+	Do not push back on the stack the formerly-applied patches.
+	Only the patches to bury are pushed.
+
+StGIT
+-----
+Part of the StGIT suite - see gitlink:stg[1].
diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index a91b600..cf28b02 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -137,6 +137,8 @@ stglink:goto[]::
 	stgdesc:goto[]
 stglink:float[]::
 	stgdesc:float[]
+stglink:bury[]::
+	stgdesc:bury[]
 stglink:applied[]::
 	stgdesc:applied[]
 stglink:unapplied[]::
diff --git a/contrib/stg-sink b/contrib/stg-sink
deleted file mode 100755
index cb6e25d..0000000
--- a/contrib/stg-sink
+++ /dev/null
@@ -1,44 +0,0 @@
-#!/usr/bin/perl
-use strict;
-use warnings;
-
-sub _run {
-  #print(' >> ', @_, "\n");# and 0;
-  system(@_);
-}
-
-my $dopush=1;
-my $pop='pop -a';
-while (@ARGV and $ARGV[0] =~ m/^-/) {
-  if ($ARGV[0] eq '-n') {
-    $dopush=0;
-    shift @ARGV;
-  }
-  if ($ARGV[0] eq '-t') {
-    shift @ARGV;
-    $pop = 'goto '.shift @ARGV;
-  }
-}
-
-# default: sink current patch
-if (@ARGV == 0) {
-  $ARGV[0] = `stg top`;
-}
-
-my @oldapplied=`stg applied`;
-chomp (@oldapplied);
-
-_run('stg '.$pop) &&
-  die "cannot pop all patches";
-_run('stg push ' . join (' ', @ARGV)) &&
-  die "error pushing patches";
-
-if ($dopush) {
-  my @newapplied=`stg applied`;
-  chomp (@newapplied);
-  my @remaining=grep { my $check=$_;
-		       not grep { $check eq $_ } @newapplied;
-		     } @oldapplied;
-  _run('stg push ' . join (' ', @remaining)) &&
-    die "error pushing remaining patches";
-}
diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.bash
index 09614dc..b6e1306 100644
--- a/contrib/stgit-completion.bash
+++ b/contrib/stgit-completion.bash
@@ -15,6 +15,7 @@ _stg_commands="
     applied
     assimilate
     branch
+    bury
     delete
     diff
     clean
diff --git a/stgit/commands/bury.py b/stgit/commands/bury.py
new file mode 100644
index 0000000..b14f09e
--- /dev/null
+++ b/stgit/commands/bury.py
@@ -0,0 +1,65 @@
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
+help = 'bury patches down the stack'
+usage = """%prog [-t <target patch>] [-n] [<patches>]
+
+Pop all patches (or all patches including <target patch>), then
+push the specified <patches> (the current patch by default), and
+then push back into place the formerly-applied patches (unless -n
+is also given)."""
+
+options = [make_option('-n', '--nopush',
+                       help = 'do not push the patches back after sinking',
+                       action = 'store_true'),
+           make_option('-t', '--to', metavar = 'TARGET',
+                       help = 'bury patches below TARGET patch')]
+
+def func(parser, options, args):
+    """Bury patches
+    """
+
+    check_local_changes()
+    check_conflicts()
+    check_head_top_equal()
+
+    oldapplied = crt_series.get_applied()
+    unapplied = crt_series.get_unapplied()
+    all = unapplied + oldapplied
+
+    if len(args) > 0:
+        patches = parse_patches(args, all)
+    else:
+        patches = [ crt_series.get_current() ]
+
+    crt_series.pop_patch(options.to or oldapplied[0])
+    push_patches(patches)
+
+    if not options.nopush:
+        newapplied = crt_series.get_applied()
+        def not_reapplied_yet(p):
+            return not p in newapplied
+        push_patches(filter(not_reapplied_yet, oldapplied))
diff --git a/stgit/main.py b/stgit/main.py
index 856b868..9c319c6 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -63,6 +63,7 @@ commands = Commands({
     'applied':          'applied',
     'assimilate':       'assimilate',
     'branch':           'branch',
+    'bury':             'bury',
     'delete':           'delete',
     'diff':             'diff',
     'clean':            'clean',
@@ -110,6 +111,7 @@ stackcommands = (
     'applied',
     'assimilate',
     'branch',
+    'bury',
     'clean',
     'commit',
     'float',
