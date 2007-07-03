From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH v2] Recognize refs under remotes/ as parent branch on
	stack creation.
Date: Wed, 04 Jul 2007 00:12:20 +0200
Message-ID: <20070703220920.30696.3240.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 00:13:21 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5qcZ-00038U-GP
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 00:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbXGCWMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 18:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754247AbXGCWMo
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 18:12:44 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:33339 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739AbXGCWMn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 18:12:43 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C477A5A27D;
	Wed,  4 Jul 2007 00:12:41 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 9E9481F019;
	Wed,  4 Jul 2007 00:12:20 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51542>

Also remove the "relaxed" parentbranch detecting logic (accepting
anything with an embedded slash as a parent branch name), which was
never invoked because of a bug, and looks like a bad idea anyway.
Better add sensible namespaces when we feel a need for them, rather
than accepting anything by default, with potentially unwanted results.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

For some reason I had omitted to run the testsuite on the final
version of this patch.  Here is a version that also works when the
branchpoint is a stgit-only ref ("base" in the testsuite).

 stgit/commands/branch.py |   39 +++++++++++++++++++++++++--------------
 1 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index c22e143..2fb5f59 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -122,27 +122,38 @@ def func(parser, options, args):
 
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
+                # exception in branch = rev_parse() leaves branchpoint unbound
+                branchpoint = None
 
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
