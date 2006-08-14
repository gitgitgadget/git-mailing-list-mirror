From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/2] Add a --parent flag to "stgit pick".
Date: Mon, 14 Aug 2006 18:55:42 +0200
Message-ID: <20060814165542.20350.34612.stgit@gandelf.nowhere.earth>
References: <20060814165307.20350.63286.stgit@gandelf.nowhere.earth>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 18:56:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCfiy-0005LB-UH
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 18:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWHNQzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 12:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWHNQzc
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 12:55:32 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:25003 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S932187AbWHNQzc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Aug 2006 12:55:32 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id D1E1822598;
	Mon, 14 Aug 2006 18:55:30 +0200 (CEST)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1GCfjD-00060Y-6f; Mon, 14 Aug 2006 18:55:51 +0200
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <20060814165307.20350.63286.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25365>


This is useful to pick changes from a non-stgit branch, that were
recorded as a merge commit, while giving control on the parent to
use as "bottom" for the patch (for some reason stgit selects the
first parent by default).

Incidentally, it can be used to pick changes between arbitrary
trees in the revision graph.  Since that can be useful as well,
I did not implement the is_parent check I originally meant to add.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/pick.py |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/pick.py b/stgit/commands/pick.py
index 1aa83d0..2916b6e 100644
--- a/stgit/commands/pick.py
+++ b/stgit/commands/pick.py
@@ -37,6 +37,8 @@ options = [make_option('-n', '--name',
            make_option('-r', '--reverse',
                        help = 'reverse the commit object before importing',
                        action = 'store_true'),
+           make_option('-p', '--parent',
+                       help = 'use COMMITID as parent'),
            make_option('--fold',
                        help = 'fold the commit object into the current patch',
                        action = 'store_true'),
@@ -73,12 +75,17 @@ def func(parser, options, args):
             if not patch:
                 raise CmdException, 'Unknown patch name'
 
+    if options.parent:
+        parent = options.parent
+    else:
+        parent = commit.get_parent()
+
     if not options.reverse:
-        bottom = commit.get_parent()
+        bottom = parent
         top = commit_id
     else:
         bottom = commit_id
-        top = commit.get_parent()
+        top = parent
 
     if options.fold:
         print 'Folding commit %s...' % commit_id,
