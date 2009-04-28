From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 6/9] Convert 'unhide' to the lib infrastructure
Date: Tue, 28 Apr 2009 16:10:09 +0100
Message-ID: <20090428151008.27261.10237.stgit@pc1117.cambridge.arm.com>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:13:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyp05-0002lt-JU
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761592AbZD1PLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762131AbZD1PLF
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:11:05 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:48977 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932419AbZD1PK6 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 11:10:58 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n3SF73Zm027064;
	Tue, 28 Apr 2009 16:07:03 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 16:10:55 +0100
In-Reply-To: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.375.g65f9.dirty
X-OriginalArrivalTime: 28 Apr 2009 15:10:55.0267 (UTC) FILETIME=[870FE730:01C9C813]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117788>

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/unhide.py |   39 +++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/stgit/commands/unhide.py b/stgit/commands/unhide.py
index 0c0832a..656ddea 100644
--- a/stgit/commands/unhide.py
+++ b/stgit/commands/unhide.py
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
 
 help = 'Unhide a hidden patch'
 kind = 'stack'
@@ -34,19 +32,24 @@ options = [
     opt('-b', '--branch', args = [argparse.stg_branches],
         short = 'Use BRANCH instead of the default branch')]
 
-directory = DirectoryHasRepository(log = True)
+directory = common.DirectoryHasRepositoryLib()
 
 def func(parser, options, args):
-    """Unhide a range of patches in the series
-    """
-    if args:
-        # parsing all the patches for a more meaningful error reporting
-        all_patches = crt_series.get_applied() + crt_series.get_unapplied() \
-                      + crt_series.get_hidden()
-        patches = parse_patches(args, all_patches)
-    else:
+    """Unhide a range of patch in the series."""
+    stack = directory.repository.current_stack
+    trans = transaction.StackTransaction(stack, 'hide')
+
+    if not args:
         parser.error('No patches specified')
 
-    for patch in patches:
-        crt_series.unhide_patch(patch)
-        out.info('Patch "%s" unhidden' % patch)
+    patches = common.parse_patches(args, trans.all_patches)
+    for p in patches:
+        if not p in trans.hidden:
+            raise common.CmdException('Patch "%s" not hidden' % p)
+
+    applied = list(trans.applied)
+    unapplied = trans.unapplied + patches
+    hidden = [p for p in trans.hidden if not p in set(patches)]
+
+    trans.reorder_patches(applied, unapplied, hidden)
+    return trans.run()
