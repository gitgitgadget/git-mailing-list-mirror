From: Alex Chiang <achiang@hp.com>
Subject: [StGit PATCH] teach --summary to stg show
Date: Thu, 18 Jun 2009 23:06:53 -0600
Message-ID: <20090619050653.GD21764@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com, kha@treskal.com
X-From: git-owner@vger.kernel.org Fri Jun 19 07:07:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHWJc-0008UF-SG
	for gcvg-git-2@gmane.org; Fri, 19 Jun 2009 07:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbZFSFGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2009 01:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbZFSFGv
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 01:06:51 -0400
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:13564 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbZFSFGv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2009 01:06:51 -0400
Received: from g5t0029.atlanta.hp.com (g5t0029.atlanta.hp.com [16.228.8.141])
	by g5t0007.atlanta.hp.com (Postfix) with ESMTP id 30DB81448E;
	Fri, 19 Jun 2009 05:06:54 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by g5t0029.atlanta.hp.com (Postfix) with ESMTP id CC64710233;
	Fri, 19 Jun 2009 05:06:53 +0000 (UTC)
Received: by ldl.fc.hp.com (Postfix, from userid 17609)
	id 7946439C003; Thu, 18 Jun 2009 23:06:53 -0600 (MDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121882>

Add -s/--summary option to stg show, which will generate a nice
diffstat, similar to what you get in a cover mail if you specify
%(diffstat)s.

This new option is handy for getting a sense of the scale of your
patch-series-in-progress.

You'd think this option wouldn't be necessary, but simply piping
the output of stg show -a into diffstat (v1.45) doesn't do the
Right Thing(tm):

achiang@bob:linux-2.6$ stg series
+ export-acpi-pci-root
+ acpiphp-find-bridges-easy
> acpi-pci-detect-ejectable-interface

achiang@bob:linux-2.6$ stg show -a | diffstat
 b/drivers/acpi/pci_root.c            |   16 ------
 b/drivers/pci/hotplug/acpi_pcihp.c   |    7 --
 b/drivers/pci/hotplug/acpiphp_glue.c |   89 +++++++++++------------------------
 b/drivers/pci/hotplug/pciehp_acpi.c  |    5 +
 b/include/acpi/acpi_bus.h            |   14 +++++
 b/include/linux/pci_hotplug.h        |    2 
 drivers/pci/hotplug/acpiphp_glue.c   |   14 -----
 7 files changed, 52 insertions(+), 95 deletions(-)

Here is the correct diffstat using the new -s option.

achiang@bob:linux-2.6$ stg show -a -s
 drivers/acpi/pci_root.c            |   16 +------
 drivers/pci/hotplug/acpi_pcihp.c   |    7 +--
 drivers/pci/hotplug/acpiphp_glue.c |   77 ++++++++----------------------------
 drivers/pci/hotplug/pciehp_acpi.c  |    5 +-
 include/acpi/acpi_bus.h            |   14 +++++++
 include/linux/pci_hotplug.h        |    2 -
 6 files changed, 39 insertions(+), 82 deletions(-)

Signed-off-by: Alex Chiang <achiang@hp.com>
---
diff --git a/stgit/commands/show.py b/stgit/commands/show.py
index b7a8aa9..1f862f7 100644
--- a/stgit/commands/show.py
+++ b/stgit/commands/show.py
@@ -20,6 +20,7 @@ from pydoc import pager
 from stgit.argparse import opt
 from stgit.commands.common import *
 from stgit import argparse, git
+from stgit.lib import git as gitlib
 
 help = 'Show the commit corresponding to a patch'
 kind = 'patch'
@@ -38,6 +39,8 @@ options = [
         short = 'Show the applied patches'),
     opt('-u', '--unapplied', action = 'store_true',
         short = 'Show the unapplied patches'),
+    opt('-s', '--summary', action = 'store_true',
+        short = 'Show a diffstat summary of the specified patches'),
     ] + argparse.diff_opts_option()
 
 directory = DirectoryHasRepository(log = False)
@@ -62,9 +65,14 @@ def func(parser, options, args):
         patches = args
 
     options.diff_flags.extend(color_diff_flags())
-    commit_ids = [git_id(crt_series, patch) for patch in patches]
-    commit_str = '\n'.join([git.pretty_commit(commit_id,
-                                              flags = options.diff_flags)
-                            for commit_id in commit_ids])
+    if options.summary:
+        commit_str = gitlib.diffstat(git.diff(
+                                rev1 = git_id(crt_series, '%s^' % patches[0]),
+                                rev2 = git_id(crt_series, '%s' % patches[-1])))
+    else:
+        commit_ids = [git_id(crt_series, patch) for patch in patches]
+        commit_str = '\n'.join([git.pretty_commit(commit_id,
+                                                  flags = options.diff_flags)
+                                for commit_id in commit_ids])
     if commit_str:
         pager(commit_str)
