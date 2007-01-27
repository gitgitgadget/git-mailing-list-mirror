From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 4/5] Have 'stg branch --create' record parent information.
Date: Sat, 27 Jan 2007 12:21:33 +0100
Message-ID: <20070127112133.16475.53497.stgit@gandelf.nowhere.earth>
References: <20070127104024.16475.81445.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 12:23:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAle7-00059K-9F
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 12:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbXA0LWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 06:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752240AbXA0LWs
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 06:22:48 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:40307 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752239AbXA0LWq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 06:22:46 -0500
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id D433088DE;
	Sat, 27 Jan 2007 12:22:44 +0100 (CET)
Received: from gandelf.nowhere.earth ([10.0.0.5] ident=dwitch)
	by bylbo.nowhere.earth with esmtp (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1HAleB-0003ZT-Pg; Sat, 27 Jan 2007 12:23:03 +0100
In-Reply-To: <20070127104024.16475.81445.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37942>




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
