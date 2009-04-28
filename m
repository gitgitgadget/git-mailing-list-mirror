From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 7/9] Reinstate the --annotate option for refresh
Date: Tue, 28 Apr 2009 16:10:14 +0100
Message-ID: <20090428151014.27261.18502.stgit@pc1117.cambridge.arm.com>
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
	id 1Lyp06-0002lt-AK
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762134AbZD1PLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762127AbZD1PLH
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:11:07 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:48985 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762128AbZD1PLF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 11:11:05 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n3SF79Zm027072;
	Tue, 28 Apr 2009 16:07:09 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 16:11:00 +0100
In-Reply-To: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.375.g65f9.dirty
X-OriginalArrivalTime: 28 Apr 2009 15:11:00.0970 (UTC) FILETIME=[8A761CA0:01C9C813]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117781>

It is sometimes useful to add some notes to the log entry when a patch
was refreshed. This option was dropped when the command was updated to
the new infrastructure as there was no logging support at that time.

The note will be visible with 'stg log {-g,-f}'

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/refresh.py |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 5a5f979..c5a0aeb 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -61,6 +61,8 @@ options = [
         short = 'Refresh (applied) PATCH instead of the top patch'),
     opt('-e', '--edit', action = 'store_true',
         short = 'Invoke an editor for the patch description'),
+    opt('-a', '--annotate', metavar = 'NOTE',
+        short = 'Annotate the patch log entry')
     ] + (argparse.message_options(save_template = False) +
          argparse.sign_options() + argparse.author_options())
 
@@ -200,9 +202,13 @@ def absorb_unapplied(trans, iw, patch_name, temp_name, edit_fun):
         # leave the temp patch for the user.
         return False
 
-def absorb(stack, patch_name, temp_name, edit_fun):
+def absorb(stack, patch_name, temp_name, edit_fun, annotate = None):
     """Absorb the temp patch into the target patch."""
-    trans = transaction.StackTransaction(stack, 'refresh')
+    if annotate:
+        log_msg = 'refresh\n\n' + annotate
+    else:
+        log_msg = 'refresh'
+    trans = transaction.StackTransaction(stack, log_msg)
     iw = stack.repository.default_iw
     f = { True: absorb_applied, False: absorb_unapplied
           }[patch_name in trans.applied]
@@ -252,4 +258,5 @@ def func(parser, options, args):
                 diff_flags = [], replacement_diff = None)
             assert not failed_diff
         return cd
-    return absorb(stack, patch_name, temp_name, edit_fun)
+    return absorb(stack, patch_name, temp_name, edit_fun,
+                  annotate = options.annotate)
