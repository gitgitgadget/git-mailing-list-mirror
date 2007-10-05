From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH] Better diagnostic for wrong branch configuration.
Date: Fri, 05 Oct 2007 22:44:52 +0200
Message-ID: <20071005204452.30902.60246.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 22:48:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idu5U-0003Fm-8p
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 22:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761008AbXJEUrm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 16:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbXJEUrm
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 16:47:42 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:54959 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752359AbXJEUrl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 16:47:41 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A01E717B573;
	Fri,  5 Oct 2007 22:47:39 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 84EE017B56D;
	Fri,  5 Oct 2007 22:47:39 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 779711F044;
	Fri,  5 Oct 2007 22:44:53 +0200 (CEST)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60133>

If the branch.*.merge parameter does not name a valid remote head,
stgit would not rebase after a fetch, and would write instead
'Rebasing to "None" ... done'.

This patch makes this situation an error and tells the user what
to fix in his repo configuration.
---

 stgit/commands/pull.py |    9 ++++++++-
 stgit/git.py           |    5 ++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/stgit/commands/pull.py b/stgit/commands/pull.py
index 052ea2b..070db99 100644
--- a/stgit/commands/pull.py
+++ b/stgit/commands/pull.py
@@ -90,7 +90,14 @@ def func(parser, options, args):
     elif policy == 'fetch-rebase':
         out.info('Fetching from "%s"' % repository)
         git.fetch(repository)
-        rebase(git.fetch_head())
+        try:
+            target = git.fetch_head()
+        except git.GitException:
+            out.error('Could not find the remote head to rebase onto, pushing any patches back...')
+            post_rebase(applied, False, False)
+            raise CmdException, 'Could not find the remote head to rebase onto - fix branch.%s.merge in .git/config' % crt_series.get_name()
+
+        rebase(target)
     elif policy == 'rebase':
         rebase(crt_series.get_parent_branch())
 
diff --git a/stgit/git.py b/stgit/git.py
index 9e0f771..a0493bc 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -1003,11 +1003,14 @@ def fetch_head():
         m = re.match('^([^\t]*)\t\t', line)
         if m:
             if fetch_head:
-                raise GitException, "StGit does not support multiple FETCH_HEAD"
+                raise GitException, 'StGit does not support multiple FETCH_HEAD'
             else:
                 fetch_head=m.group(1)
     stream.close()
 
+    if not fetch_head:
+        raise GitException, 'No for-merge remote head found in FETCH_HEAD'
+
     # here we are sure to have a single fetch_head
     return fetch_head
 
