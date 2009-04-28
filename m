From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 1/9] Show "Pushing <patch>...done" when pushing a patch
Date: Tue, 28 Apr 2009 16:09:40 +0100
Message-ID: <20090428150940.27261.65680.stgit@pc1117.cambridge.arm.com>
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
	id 1Lyp01-0002lt-NZ
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 17:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762124AbZD1PKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 11:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762111AbZD1PKc
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 11:10:32 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:48890 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756095AbZD1PKa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 11:10:30 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n3SF6ZZm027012;
	Tue, 28 Apr 2009 16:06:35 +0100 (BST)
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 28 Apr 2009 16:10:27 +0100
In-Reply-To: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.375.g65f9.dirty
X-OriginalArrivalTime: 28 Apr 2009 15:10:27.0174 (UTC) FILETIME=[76514060:01C9C813]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117785>

My main reason is for the automatic invocation of the interactive merge
when I don't know what patch I have to deal with. The other reasons is
for people working over slow filesystems (NFS) where a three-way merging
may take a significant amount of time.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/lib/transaction.py |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 4148ff3..582ee72 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -302,6 +302,7 @@ class StackTransaction(object):
         """Attempt to push the named patch. If this results in conflicts,
         halts the transaction. If index+worktree are given, spill any
         conflicts to them."""
+        out.start('Pushing patch "%s"' % pn)
         orig_cd = self.patches[pn].data
         cd = orig_cd.set_committer(None)
         oldparent = cd.parent
@@ -330,12 +331,12 @@ class StackTransaction(object):
                 iw.merge(base, ours, theirs, interactive = interactive)
                 tree = iw.index.write_tree()
                 self.__current_tree = tree
-                s = ' (modified)'
+                s = 'modified'
             except git.MergeConflictException, e:
                 tree = ours
                 merge_conflict = True
                 self.__conflicts = e.conflicts
-                s = ' (conflict)'
+                s = 'conflict'
             except git.MergeException, e:
                 self.__halt(str(e))
         cd = cd.set_tree(tree)
@@ -345,12 +346,12 @@ class StackTransaction(object):
             self.head = comm
         else:
             comm = None
-            s = ' (unmodified)'
+            s = 'unmodified'
         if already_merged:
-            s = ' (merged)'
+            s = 'merged'
         elif not merge_conflict and cd.is_nochange():
-            s = ' (empty)'
-        out.info('Pushed %s%s' % (pn, s))
+            s = 'empty'
+        out.done(s)
         def update():
             if comm:
                 self.patches[pn] = comm
