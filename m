From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 5/9] Convert 'hide' to the lib infrastructure
Date: Tue, 28 Apr 2009 16:10:03 +0100
Message-ID: <20090428151003.27261.72531.stgit@pc1117.cambridge.arm.com>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:13:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyp04-0002lt-S7
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbZD1PK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbZD1PKy
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:10:54 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:48965 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932099AbZD1PKx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 11:10:53 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n3SF6vZm027053;
	Tue, 28 Apr 2009 16:06:57 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 16:10:49 +0100
In-Reply-To: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.375.g65f9.dirty
X-OriginalArrivalTime: 28 Apr 2009 15:10:49.0658 (UTC) FILETIME=[83B809A0:01C9C813]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117784>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/hide.py |   44 ++++++++++++++++++++++++--------------------
 1 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/stgit/commands/hide.py b/stgit/commands/hide.py
index 014febb..0b93a59 100644
--- a/stgit/commands/hide.py
+++ b/stgit/commands/hide.py
@@ -1,5 +1,5 @@
 __copyright__ = """
-Copyright (C) 2007, Catalin Marinas <catalin.marinas@gmail.com>
+Copyright (C) 2009, Catalin Marinas <catalin.marinas@gmail.com>
 
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2 as
@@ -15,12 +15,10 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os
+from stgit.commands import common
+from stgit.lib import transaction
+from stgit import argparse
 from stgit.argparse import opt
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit.out import *
-from stgit import argparse, stack, git
 
 help = 'Hide a patch in the series'
 kind = 'stack'
@@ -29,25 +27,31 @@ description = """
 Hide a range of unapplied patches so that they are no longer shown in
 the plain 'series' command output."""
 
-args = [argparse.patch_range(argparse.applied_patches,
-                             argparse.unapplied_patches)]
+args = [argparse.patch_range(argparse.unapplied_patches)]
 options = [
     opt('-b', '--branch', args = [argparse.stg_branches],
         short = 'Use BRANCH instead of the default branch')]
 
-directory = DirectoryHasRepository(log = True)
+directory = common.DirectoryHasRepositoryLib()
 
 def func(parser, options, args):
-    """Hide a range of patch in the series
-    """
-    if args:
-        # parsing all the patches for a more meaningful error reporting
-        all_patches = crt_series.get_applied() + crt_series.get_unapplied() \
-                      + crt_series.get_hidden()
-        patches = parse_patches(args, all_patches)
-    else:
+    """Hide a range of patch in the series."""
+    stack = directory.repository.current_stack
+    trans = transaction.StackTransaction(stack, 'hide')
+
+    if not args:
         parser.error('No patches specified')
 
-    for patch in patches:
-        crt_series.hide_patch(patch)
-        out.info('Patch "%s" hidden' % patch)
+    patches = common.parse_patches(args, trans.all_patches)
+    for p in patches:
+        if p in trans.applied:
+            raise common.CmdException('Cannot hide applied patch "%s"' % p)
+        elif p in trans.hidden:
+            raise common.CmdException('Patch "%s" already hidden' % p)
+
+    applied = list(trans.applied)
+    unapplied = [p for p in trans.unapplied if not p in set(patches)]
+    hidden = patches + trans.hidden
+
+    trans.reorder_patches(applied, unapplied, hidden)
+    return trans.run()
