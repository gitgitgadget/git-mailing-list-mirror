From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGit PATCH] Add --file option to pick
Date: Wed, 14 Jan 2009 22:59:30 +0000
Message-ID: <20090114225930.11098.2144.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 00:09:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNErp-0000x3-3h
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 00:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbZANXIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 18:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755209AbZANXIV
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 18:08:21 -0500
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:17667 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753836AbZANXIV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 18:08:21 -0500
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20090114225932.UDLR2989.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Wed, 14 Jan 2009 22:59:32 +0000
Received: from localhost.localdomain ([86.9.203.187])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20090114225932.UZPJ21638.aamtaout02-winn.ispmail.ntl.com@localhost.localdomain>;
          Wed, 14 Jan 2009 22:59:32 +0000
User-Agent: StGit/0.14.3.293.g03d7
X-Cloudmark-Analysis: v=1.0 c=1 a=HTGQP5q2E9wA:10 a=ZHhOoE7WMpxN2uTE-KkA:9 a=4ggffSH-gbpkcH4XEnGMFOjuzLsA:4 a=XF7b4UCPwd8A:10 a=ZCfqrk5O2kgA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105726>

This allows folding of specific files only.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/pick.py |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index ee08c01..b0e9114 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -52,6 +52,8 @@ options = [
         short = 'Fold the commit object into the current patch'),
     opt('--update', action = 'store_true',
         short = 'Like fold but only update the current patch files'),
+    opt('-f', '--files', action = 'append',
+        short = 'Only fold the given files'),
     opt('--unapplied', action = 'store_true',
         short = 'Keep the patch unapplied')]
 
@@ -83,8 +85,11 @@ def __pick_commit(commit_id, patchname, options):
         out.start('Folding commit %s' % commit_id)
 
         # try a direct git apply first
-        if not git.apply_diff(bottom, top):
-            git.merge_recursive(bottom, git.get_head(), top)
+        if not git.apply_diff(bottom, top, files = options.files):
+            if options.files:
+                raise CmdException, 'Patch folding failed'
+            else:
+                git.merge_recursive(bottom, git.get_head(), top)
 
         out.done()
     elif options.update:
@@ -152,6 +157,9 @@ def func(parser, options, args):
     if not args:
         parser.error('incorrect number of arguments')
 
+    if options.files and not options.fold:
+        parser.error('--file can only be specified with --fold')
+
     if not options.unapplied:
         check_local_changes()
         check_conflicts()
