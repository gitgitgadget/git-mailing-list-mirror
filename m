From: Zane Bitter <zbitter@redhat.com>
Subject: [StGit PATCH] Fix dirty index errors when resolving conflicts
Date: Wed, 17 Jul 2013 15:57:10 +0200
Message-ID: <20130717135454.16504.69116.stgit@zbitter.fedora>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: jacob.e.keller@intel.com, peter.p.waskiewicz.jr@intel.com,
	catalin.marinas@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 15:57:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzSEN-0006ef-Qz
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 15:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181Ab3GQN5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 09:57:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6124 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754176Ab3GQN5T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 09:57:19 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r6HDvC49013041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 17 Jul 2013 09:57:13 -0400
Received: from zbitter.fedora (vpn1-5-30.ams2.redhat.com [10.36.5.30])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r6HDvBMk020458;
	Wed, 17 Jul 2013 09:57:11 -0400
User-Agent: StGit/0.17-dirty
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230626>

The patch 6e8fdc58c786a45d7a63c5edf9c702f1874a7a19 causes StGit to raise
"warnings" (actually: errors) in the event that there are changes staged in
the index and a refresh is performed without specifying either --index or
--force. This is great for preventing an entire class of common mistakes,
but is also a giant pain when resolving conflicts after a pull/rebase.
Depending on the workflow in use, this may occur with a frequency anywhere
between "never" and "mulitple times on every pull".

This patch removes the pain by:
 - Reporting unresolved conflicts *before* complaining about staged
   changes, since it goes without saying that, when present, these are the
   main problem.
 - Not complaining about staged changes if there are no unstaged changes in
   the working directory, since the presence of --index is immaterial in
   this case.

Signed-off-by: Zane Bitter <zbitter@redhat.com>
---
 stgit/commands/refresh.py |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index a2bab42..331c18d 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -247,18 +247,19 @@ def func(parser, options, args):
     patch_name = get_patch(stack, options.patch)
     paths = list_files(stack, patch_name, args, options.index, options.update)
 
-    # Make sure the index is clean before performing a full refresh
-    if not options.index and not options.force:
-        if not stack.repository.default_index.is_clean(stack.head):
-            raise common.CmdException(
-                'The index is dirty. Did you mean --index? To force a full refresh use --force.')
-
     # Make sure there are no conflicts in the files we want to
     # refresh.
     if stack.repository.default_index.conflicts() & paths:
         raise common.CmdException(
             'Cannot refresh -- resolve conflicts first')
 
+    # Make sure the index is clean before performing a full refresh
+    if not options.index and not options.force:
+        if not (stack.repository.default_index.is_clean(stack.head) or
+                stack.repository.default_iw.worktree_clean()):
+            raise common.CmdException(
+                'The index is dirty. Did you mean --index? To force a full refresh use --force.')
+
     # Commit index to temp patch, and absorb it into the target patch.
     retval, temp_name = make_temp_patch(
         stack, patch_name, paths, temp_index = path_limiting)
