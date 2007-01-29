From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 6/7] Have 'stg branch --create' record parent information.
Date: Tue, 30 Jan 2007 00:05:50 +0100
Message-ID: <20070129230550.7102.68705.stgit@gandelf.nowhere.earth>
References: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 00:34:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBg0z-00041G-U1
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 00:34:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbXA2XeS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 18:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbXA2XeS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 18:34:18 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:54329 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964976AbXA2XeR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 18:34:17 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 27B845304;
	Tue, 30 Jan 2007 00:34:16 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id DC9761F07F;
	Tue, 30 Jan 2007 00:05:50 +0100 (CET)
In-Reply-To: <20070129230117.7102.64322.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38113>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/branch.py |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index d348409..f074d47 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -123,10 +123,41 @@ def func(parser, options, args):
         check_head_top_equal()
 
         tree_id = None
-        if len(args) == 2:
+        if len(args) >= 2:
+            try:
+                if git.rev_parse(args[1]) == git.rev_parse('refs/heads/' + args[1]):
+                    # we are for sure refering to a branch
+                    parentbranch = 'refs/heads/' + args[1]
+                    print 'Recording "%s" as parent branch.' % parentbranch
+                elif git.rev_parse(args[1]) and re.search('/', args[1]):
+                    # FIXME: should the test be more strict ?
+                    parentbranch = args[1]
+                else:
+                    # Note: this includes refs to StGIT patches
+                    print 'Don\'t know how to determine parent branch from "%s".' % args[1]
+                    parentbranch = None
+            except git.GitException:
+                # should use a more specific exception to catch only non-git refs ?
+                print 'Don\'t know how to determine parent branch from "%s".' % args[1]
+                parentbranch = None
+
             tree_id = git_id(args[1])
-        
-        stack.Series(args[0]).init(create_at = tree_id)
+        else:
+            # branch stack off current branch
+            parentbranch = git.get_head_file()
+
+        if parentbranch:
+            parentremote = git.identify_remote(parentbranch)
+            if parentremote:
+                print 'Using "%s" remote to pull parent from.' % parentremote
+            else:
+                print 'Not identified a remote to pull parent from.'
+        else:
+            parentremote = None
+
+        stack.Series(args[0]).init(create_at = tree_id,
+                                   parent_remote = parentremote,
+                                   parent_branch = parentbranch)
 
         print 'Branch "%s" created.' % args[0]
         return
