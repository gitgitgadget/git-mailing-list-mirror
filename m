From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 4/4] Use a default "hidden" argument in
	StackTransaction.reorder_patches
Date: Tue, 17 Mar 2009 11:09:10 +0000
Message-ID: <20090317110910.27748.80312.stgit@pc1117.cambridge.arm.com>
References: <20090317110721.27748.10295.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 12:11:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjXCm-0004sL-LX
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 12:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760277AbZCQLJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 07:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758332AbZCQLJl
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 07:09:41 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:47592 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756981AbZCQLJk (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 07:09:40 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n2HB7qZm019849;
	Tue, 17 Mar 2009 11:07:52 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Mar 2009 11:09:35 +0000
In-Reply-To: <20090317110721.27748.10295.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.353.gf255
X-OriginalArrivalTime: 17 Mar 2009 11:09:35.0693 (UTC) FILETIME=[DB36BFD0:01C9A6F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113462>

This argument is rarely used so adding a default value simplifies the
calling code.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/float.py  |    3 +--
 stgit/commands/sink.py   |    4 +---
 stgit/lib/transaction.py |    4 +++-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/stgit/commands/float.py b/stgit/commands/float.py
index 8410675..e561c39 100644
--- a/stgit/commands/float.py
+++ b/stgit/commands/float.py
@@ -71,7 +71,6 @@ def func(parser, options, args):
     applied = [p for p in stack.patchorder.applied if p not in patches] + \
             patches
     unapplied = [p for p in stack.patchorder.unapplied if not p in patches]
-    hidden = list(stack.patchorder.hidden)
 
     iw = stack.repository.default_iw
     clean_iw = (not options.keep and iw) or None
@@ -79,7 +78,7 @@ def func(parser, options, args):
                                          check_clean_iw = clean_iw)
 
     try:
-        trans.reorder_patches(applied, unapplied, hidden, iw)
+        trans.reorder_patches(applied, unapplied, iw = iw)
     except transaction.TransactionHalted:
         pass
     return trans.run(iw)
diff --git a/stgit/commands/sink.py b/stgit/commands/sink.py
index 641ab7b..63be461 100644
--- a/stgit/commands/sink.py
+++ b/stgit/commands/sink.py
@@ -81,9 +81,7 @@ def func(parser, options, args):
     else:
         insert_idx = 0
     applied = applied[:insert_idx] + patches + applied[insert_idx:]
-
     unapplied = [p for p in stack.patchorder.unapplied if p not in patches]
-    hidden = list(stack.patchorder.hidden)
 
     iw = stack.repository.default_iw
     clean_iw = (not options.keep and iw) or None
@@ -91,7 +89,7 @@ def func(parser, options, args):
                                          check_clean_iw = clean_iw)
 
     try:
-        trans.reorder_patches(applied, unapplied, hidden, iw)
+        trans.reorder_patches(applied, unapplied, iw = iw)
     except transaction.TransactionHalted:
         pass
     return trans.run(iw)
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 4b5398a..b146648 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -365,8 +365,10 @@ class StackTransaction(object):
             # Update immediately.
             update()
 
-    def reorder_patches(self, applied, unapplied, hidden, iw = None):
+    def reorder_patches(self, applied, unapplied, hidden = None, iw = None):
         """Push and pop patches to attain the given ordering."""
+        if hidden is None:
+            hidden = self.hidden
         common = len(list(it.takewhile(lambda (a, b): a == b,
                                        zip(self.applied, applied))))
         to_pop = set(self.applied[common:])
