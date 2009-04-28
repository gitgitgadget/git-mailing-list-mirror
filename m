From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 4/9] Convert 'clone' to the use stgit.lib
Date: Tue, 28 Apr 2009 16:09:57 +0100
Message-ID: <20090428150957.27261.83658.stgit@pc1117.cambridge.arm.com>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 17:13:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyp04-0002lt-1x
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbZD1PKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbZD1PKu
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:10:50 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:48953 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932368AbZD1PKs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 11:10:48 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n3SF6qZm027040;
	Tue, 28 Apr 2009 16:06:52 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 16:10:44 +0100
In-Reply-To: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.375.g65f9.dirty
X-OriginalArrivalTime: 28 Apr 2009 15:10:44.0033 (UTC) FILETIME=[805DBB10:01C9C813]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117780>

The patch also adds the stgit.lib.git.clone() function.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/clone.py |   30 +++++++++++++-----------------
 stgit/lib/git.py        |    4 ++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/stgit/commands/clone.py b/stgit/commands/clone.py
index 7fe9c35..369c8a9 100644
--- a/stgit/commands/clone.py
+++ b/stgit/commands/clone.py
@@ -1,5 +1,5 @@
 __copyright__ = """
-Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
+Copyright (C) 2009, Catalin Marinas <catalin.marinas@gmail.com>
 
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2 as
@@ -15,10 +15,11 @@ along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 """
 
-import sys, os
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit import argparse, stack, git
+import os
+from stgit.commands import common
+from stgit.lib import git, stack
+from stgit import argparse
+from stgit.out import out
 
 help = 'Make a local clone of a remote repository'
 kind = 'repo'
@@ -38,7 +39,7 @@ not already exist."""
 args = [argparse.repo, argparse.dir]
 options = []
 
-directory = DirectoryAnywhere(needs_current_series = False, log = False)
+directory = common.DirectoryAnywhere(needs_current_series = False, log = False)
 
 def func(parser, options, args):
     """Clone the <repository> into the local <dir> and initialises the
@@ -51,17 +52,12 @@ def func(parser, options, args):
     local_dir = args[1]
 
     if os.path.exists(local_dir):
-        raise CmdException, '"%s" exists. Remove it first' % local_dir
-
-    print 'Cloning "%s" into "%s"...' % (repository, local_dir)
+        raise common.CmdException, '"%s" exists. Remove it first' % local_dir
 
+    out.start('Cloning "%s" into "%s"' % (repository, local_dir))
     git.clone(repository, local_dir)
     os.chdir(local_dir)
-    git.checkout(tree_id = 'HEAD')
-
-    # be sure to forget any cached value for .git, since we're going
-    # to work on a brand new repository
-    basedir.clear_cache()
-    stack.Series().init()
-
-    print 'done'
+    directory = common.DirectoryHasRepositoryLib()
+    directory.setup()
+    stack.Stack.initialise(directory.repository)
+    out.done()
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 9c530c7..6f2c977 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -933,3 +933,7 @@ def diffstat(diff):
     """Return the diffstat of the supplied diff."""
     return run.Run('git', 'apply', '--stat', '--summary'
                    ).raw_input(diff).raw_output()
+
+def clone(remote, local):
+    """Clone a remote repository using 'git clone'."""
+    run.Run('git', 'clone', remote, local).run()
