From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH] Display (empty) when appropriate for the goto command
Date: Sun, 23 Nov 2008 21:23:18 +0000
Message-ID: <20081123212318.9835.53505.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Nov 23 22:40:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4MgU-0002sp-4H
	for gcvg-git-2@gmane.org; Sun, 23 Nov 2008 22:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbYKWVfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Nov 2008 16:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750870AbYKWVft
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Nov 2008 16:35:49 -0500
Received: from queueout03-winn.ispmail.ntl.com ([81.103.221.33]:26338 "EHLO
	queueout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750862AbYKWVfs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Nov 2008 16:35:48 -0500
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Nov 2008 16:35:48 EST
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20081123212320.RJUH1691.mtaout03-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Sun, 23 Nov 2008 21:23:20 +0000
Received: from localhost.localdomain ([86.9.203.187])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20081123212320.GRAE2093.aamtaout03-winn.ispmail.ntl.com@localhost.localdomain>;
          Sun, 23 Nov 2008 21:23:20 +0000
User-Agent: StGit/0.14.3.286.gcbcc.dirty
X-Cloudmark-Analysis: v=1.0 c=1 a=vKuLG_dd5hcA:10 a=Zl5EyQ3bwzoA:10 a=uERWhChZpNBAp2UU5GQA:9 a=wwzqhvt0xV_85KRes_4A:7 a=P5U8L9UAwYCvDbHg8p-D7yEOZC0A:4 a=b5Ty8kZ7TbYA:10 a=Gwyp1ORNCI8A:10 a=MSl-tDqOz04A:10 a=XF7b4UCPwd8A:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101580>

This is a fix for bug #11810. The original implementation of goto used
to display (empty patch) when a patch became empty during a push + merge
operation. This patch adds this feature again.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/lib/transaction.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index de62a8c..6623645 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -290,7 +290,6 @@ class StackTransaction(object):
         conflicts to them."""
         orig_cd = self.patches[pn].data
         cd = orig_cd.set_committer(None)
-        s = ['', ' (empty)'][cd.is_nochange()]
         oldparent = cd.parent
         cd = cd.set_parent(self.top)
         base = oldparent.data.tree
@@ -298,6 +297,7 @@ class StackTransaction(object):
         theirs = cd.tree
         tree, self.temp_index_tree = self.temp_index.merge(
             base, ours, theirs, self.temp_index_tree)
+        s = ''
         merge_conflict = False
         if not tree:
             if iw == None:
@@ -324,6 +324,8 @@ class StackTransaction(object):
         else:
             comm = None
             s = ' (unmodified)'
+        if not merge_conflict and cd.is_nochange():
+            s = ' (empty)'
         out.info('Pushed %s%s' % (pn, s))
         def update():
             if comm:
