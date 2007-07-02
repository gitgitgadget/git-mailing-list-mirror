From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH] Recognize refs under remotes/ as parent branch on stack
	creation.
Date: Mon, 02 Jul 2007 23:37:44 +0200
Message-ID: <20070702213744.3014.793.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:38:21 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5TbA-00086l-L3
	for gcvg-git@gmane.org; Mon, 02 Jul 2007 23:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbXGBViI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 17:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755398AbXGBViH
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 17:38:07 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:41130 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755363AbXGBViG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 17:38:06 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 427A65A26A;
	Mon,  2 Jul 2007 23:38:04 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 7A0F31F175;
	Mon,  2 Jul 2007 23:37:44 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51411>

Also remove the "relaxed" parentbranch detecting logic (accepting
anything with an embedded slash as a parent branch name), which was
never invoked because of a bug, and looks like a bad idea anyway.
Better add sensible namespaces when we feel a need for them, rather
than accepting anything by default, with potentially unwanted results.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/branch.py |   37 +++++++++++++++++++++++--------------
 1 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index c22e143..e45bcee 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -122,27 +122,36 @@ def func(parser, options, args):
 
         tree_id = None
         if len(args) >= 2:
+            parentbranch = None
             try:
-                if git.rev_parse(args[1]) == git.rev_parse('refs/heads/' + args[1]):
-                    # we are for sure referring to a branch
-                    parentbranch = 'refs/heads/' + args[1]
-                    out.info('Recording "%s" as parent branch' % parentbranch)
-                elif git.rev_parse(args[1]) and re.search('/', args[1]):
-                    # FIXME: should the test be more strict ?
-                    parentbranch = args[1]
-                else:
-                    # Note: this includes refs to StGIT patches
-                    out.info('Don\'t know how to determine parent branch'
-                             ' from "%s"' % args[1])
-                    parentbranch = None
+                branchpoint = git.rev_parse(args[1])
+
+                # first, look for branchpoint in well-known branch namespaces
+                for namespace in ('refs/heads/', 'remotes/'):
+                    # check if branchpoint exists in namespace
+                    try:
+                        maybehead = git.rev_parse(namespace + args[1])
+                    except git.GitException:
+                        maybehead = None
+
+                    # check if git resolved branchpoint to this namespace
+                    if maybehead and branchpoint == maybehead:
+                        # we are for sure referring to a branch
+                        parentbranch = namespace + args[1]
+
             except git.GitException:
                 # should use a more specific exception to catch only
                 # non-git refs ?
                 out.info('Don\'t know how to determine parent branch'
                          ' from "%s"' % args[1])
-                parentbranch = None
 
-            tree_id = git_id(args[1])
+            tree_id = branchpoint or git_id(args[1])
+
+            if parentbranch:
+                out.info('Recording "%s" as parent branch' % parentbranch)
+            else:
+                out.info('Don\'t know how to determine parent branch'
+                         ' from "%s"' % args[1])                
         else:
             # branch stack off current branch
             parentbranch = git.get_head_file()
