From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] gitk: Fix warning when removing a branch (take 2)
Date: Wed, 15 Aug 2007 21:08:35 -0400
Message-ID: <11872265153600-git-send-email-mdl123@verizon.net>
Cc: Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 03:08:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILTr1-0001Dh-4J
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 03:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937495AbXHPBIq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 21:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937654AbXHPBIp
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 21:08:45 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:34449 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937495AbXHPBIn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 21:08:43 -0400
Received: from fal-l07294-lp.us.ray.com ([71.246.233.117])
 by vms044.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JMU00FIMDUDQ992@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 15 Aug 2007 20:08:38 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.rc4.85.g3ba6
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55974>

Issue a warning about branch deletion unless gitk knows by name at least
two branch heads pointing to the referenced commit.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---

Paul - your commit b1054ac98 did not solve this for me. Playing around, I've
several times received errors like this when trying to delete a branch:

can't read "idheads(f7b9ebd595c954cd0803e6b6f1f0f96a966e04c9 a890c4fca84a2a5c7835fe6432ede3e7c4e5426b)": no such element in array
can't read "idheads(f7b9ebd595c954cd0803e6b6f1f0f96a966e04c9 a890c4fca84a2a5c7835fe6432ede3e7c4e5426b)": no such element in array
    while executing
"if {$idheads($dheads) eq $head} {
	# the stuff on this branch isn't on any other branch
	if {![confirm_popup "The commits on branch $head aren't on an..."
    (procedure "rmbranch" line 13)
    invoked from within
"rmbranch"
    (menu invoke)

However, I took a different approach: if the commit in question has at
least two branch heads as descendents, deleting one will not leave it
dangling. I am not sure your code attempted to do this anyway.


 gitk |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index aa8baf8..d99a974 100755
--- a/gitk
+++ b/gitk
@@ -6208,10 +6208,16 @@ proc rmbranch {} {
 	return
     }
     set dheads [descheads $id]
-    if {$idheads($dheads) eq $head} {
-	# the stuff on this branch isn't on any other branch
-	if {![confirm_popup "The commits on branch $head aren't on any other\
-			branch.\nReally delete branch $head?"]} return
+    set nheads [llength $dheads]
+    if {$nheads < 2} {
+	catch {
+	    set nheads [llength $idheads($dheads)]
+	}
+	if {$nheads < 2} {
+	    # the stuff on this branch isn't on any other branch that we know about
+	    if {![confirm_popup "The commits on branch $head aren't on any other\
+			    branch.\nReally delete branch $head?"]} return
+	}
     }
     nowbusy rmbranch
     update
--
1.5.3.rc4.85.g3ba6
