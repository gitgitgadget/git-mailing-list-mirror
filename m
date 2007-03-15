From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 07/10] Stop recording branch.*.remote to '.' for local parents.
Date: Thu, 15 Mar 2007 01:27:05 +0100
Message-ID: <20070315002705.9094.21878.stgit@gandelf.nowhere.earth>
References: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 01:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRdoK-0003GS-Sl
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 01:27:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768AbXCOA1I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 20:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422772AbXCOA1I
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 20:27:08 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59036 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422768AbXCOA1H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 20:27:07 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C24A6395B;
	Thu, 15 Mar 2007 01:27:05 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 58BF31F095;
	Thu, 15 Mar 2007 01:27:05 +0100 (CET)
In-Reply-To: <20070315001808.9094.68529.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42263>


We should be using the remote name of the remote branch in
branch.*.merge, instead of the local one as we currently do (I'll
ensure this in a later patch).

As a consequence, setting "remote" to '.' and "merge" to the name of a
*local* parent would become inconsistent with the remote case.  Anyway
the local case should make use of pull-policy=rebase instead, and this
change revealed that we were fetching useless information in the local
case (no need for a remote).

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/pull.py |   24 +++++++++++++++++-------
 stgit/stack.py         |    4 +---
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 7b3c90c..f551b98 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -50,13 +50,25 @@ options = [make_option('-n', '--nopush',
 def func(parser, options, args):
     """Pull the changes from a remote repository
     """
-    if len(args) > 1:
-        parser.error('incorrect number of arguments')
+    policy = config.get('branch.%s.stgit.pull-policy' % crt_series.get_branch()) or \
+             config.get('stgit.pull-policy')
+
+    if policy == 'rebase':
+        # parent is local
+        if len(args) == 1:
+            parser.error('specifying a repository is meaningless for policy="%s"' % policy)
+        if len(args) > 0:
+            parser.error('incorrect number of arguments')
 
-    if len(args) >= 1:
-        repository = args[0]
     else:
-        repository = crt_series.get_parent_remote()
+        # parent is remote
+        if len(args) > 1:
+            parser.error('incorrect number of arguments')
+
+        if len(args) >= 1:
+            repository = args[0]
+        else:
+            repository = crt_series.get_parent_remote()
 
     if crt_series.get_protected():
         raise CmdException, 'This branch is protected. Pulls are not permitted'
@@ -65,8 +77,6 @@ def func(parser, options, args):
     check_conflicts()
     check_head_top_equal()
 
-    policy = config.get('branch.%s.stgit.pull-policy' % crt_series.get_branch()) or \
-             config.get('stgit.pull-policy')
     if policy == 'pull':
         must_rebase = 0
     elif policy == 'fetch-rebase':
diff --git a/stgit/stack.py b/stgit/stack.py
index d1b04ca..c3dab68 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -450,10 +450,8 @@ class Series(StgitObject):
         config.set('branch.%s.stgit.parentbranch' % self.__name, name)
 
     def set_parent(self, remote, localbranch):
-        # policy: record local branches as remote='.'
-        recordremote = remote or '.'
         if localbranch:
-            self.__set_parent_remote(recordremote)
+            self.__set_parent_remote(remote)
             self.__set_parent_branch(localbranch)
         # We'll enforce this later
 #         else:
