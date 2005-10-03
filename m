From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [ANNOUNCE] Stacked GIT 0.7
Date: Mon, 03 Oct 2005 15:44:12 +0100
Message-ID: <tnxpsqmwthf.fsf@arm.com>
References: <1128244627.9740.6.camel@localhost.localdomain>
	<20051002121059.GA32367@elte.hu>
	<b0943d9e0510021233n39daa5bao@mail.gmail.com>
	<b0943d9e0510030656l4535bec7u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 03 16:46:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMRYY-00064H-ET
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 16:44:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbVJCOoh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 10:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVJCOoh
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 10:44:37 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:42389 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1750912AbVJCOog (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2005 10:44:36 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j93EiASV029020;
	Mon, 3 Oct 2005 15:44:10 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id PAA24937;
	Mon, 3 Oct 2005 15:44:14 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.3]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 3 Oct 2005 15:44:13 +0100
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <b0943d9e0510030656l4535bec7u@mail.gmail.com> (Catalin
 Marinas's message of "Mon, 3 Oct 2005 14:56:39 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 03 Oct 2005 14:44:13.0961 (UTC) FILETIME=[EC5BBF90:01C5C828]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9635>

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> After some tests, it looks like 'git-diff-tree -p ... | git-apply
> --index' is about 3 times faster than 'git-read-tree -m' (in the best
> case for git-read-tree with minor modifications of the base). It now
> takes ~0.5s to push a single patch (compared to ~1.5s).

And that's the patch for whoever wants to try. I will also add it to
the repository tonight:


Optimise 'push' to use git-apply instead of git-read-tree

With this patch, 'push' will use 'git-diff-tree | git-apply' first. If this
operation fails, it will fall back to the three-way merge with
git-read-tree.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/git.py   |    9 +++++++++
 stgit/stack.py |   19 +++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -355,6 +355,15 @@ def commit(message, files = [], parents 
 
     return commit_id
 
+def apply_diff(rev1, rev2):
+    """Apply the diff between rev1 and rev2 onto the current
+    index. This function doesn't need to raise an exception since it
+    is only used for fast-pushing a patch. If this operation fails,
+    the pushing would fall back to the three-way merge.
+    """
+    return os.system('git-diff-tree -p %s %s | git-apply --index 2> /dev/null'
+                     % (rev1, rev2)) == 0
+
 def merge(base, head1, head2):
     """Perform a 3-way merge between base, head1 and head2 into the
     local tree
diff --git a/stgit/stack.py b/stgit/stack.py
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -598,14 +598,17 @@ class Series:
             # The current patch is empty after merge.
             patch.set_bottom(head, backup = True)
             patch.set_top(head, backup = True)
-            # merge/refresh can fail but the patch needs to be pushed
-            try:
-                git.merge(bottom, head, top)
-            except git.GitException, ex:
-                print >> sys.stderr, \
-                      'The merge failed during "push". ' \
-                      'Use "refresh" after fixing the conflicts'
-                pass
+
+            # Try the fast applying first. If this fails, fall back to the
+            # three-way merge
+            if not git.apply_diff(bottom, top):
+                # merge can fail but the patch needs to be pushed
+                try:
+                    git.merge(bottom, head, top)
+                except git.GitException, ex:
+                    print >> sys.stderr, \
+                          'The merge failed during "push". ' \
+                          'Use "refresh" after fixing the conflicts'
 
         append_string(self.__applied_file, name)
 


-- 
Catalin
