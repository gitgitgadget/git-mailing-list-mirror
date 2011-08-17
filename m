From: Michal Sojka <sojka@os.inf.tu-dresden.de>
Subject: [PATCH RFC] gitk: Allow commit editing
Date: Wed, 17 Aug 2011 21:56:11 +0200
Message-ID: <1313610971-1741-1-git-send-email-sojka@os.inf.tu-dresden.de>
Cc: paulus@samba.org, Michal Sojka <sojka@os.inf.tu-dresden.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 22:03:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtmL9-0000qv-Mt
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 22:03:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753556Ab1HQUDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 16:03:46 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:40989 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752446Ab1HQUDq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 16:03:46 -0400
X-Greylist: delayed 437 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Aug 2011 16:03:46 EDT
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id B7E3B19F3336;
	Wed, 17 Aug 2011 21:56:26 +0200 (CEST)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id 9MUij9tI6fSf; Wed, 17 Aug 2011 21:56:25 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 6848819F32DB;
	Wed, 17 Aug 2011 21:56:25 +0200 (CEST)
Received: from steelpick.2x.cz (unknown [141.76.49.12])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 21B5CFA003;
	Wed, 17 Aug 2011 21:56:24 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.76)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1QtmDw-0000Sc-Gm; Wed, 17 Aug 2011 21:56:24 +0200
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179533>

Hi, this is a proof of concept patch that allows editing of commits
from gitk. I often review patches before pushing in gitk and if I
would like to have an easy way of fixing typos in commit messages etc.

So the patch adds "Edit this commit" item to gitk's context menu and
the actual editing is done by non-interactively invoking interactive
rebase :-) and git gui.

There is almost no error checking etc., but before learning TCL and
coding this properly, I'd like to get some feedback.

-Michal

Signed-off-by: Michal Sojka <sojka@os.inf.tu-dresden.de>
---
 gitk-git/gitk |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4cde0c4..121b926 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2497,6 +2497,7 @@ proc makewindow {} {
 	{mc "Return to mark" command gotomark}
 	{mc "Find descendant of this and mark" command find_common_desc}
 	{mc "Compare with marked commit" command compare_commits}
+	{mc "Edit this commit" command edit_commit}
     }
     $rowctxmenu configure -tearoff 0
 
@@ -9102,6 +9103,21 @@ proc cherrypick {} {
     notbusy cherrypick
 }
 
+proc edit_commit {} {
+    global rowmenuid
+
+    nowbusy edit [mc "Editing commit"]
+    if {[catch {exec sh -c "(GIT_EDITOR='sed -ie 1s/^pick/edit/' git rebase -i $rowmenuid^ && git gui citool --amend && git rebase --continue) 2>&1"} err]} {
+	notbusy edit
+	error_popup $err
+	exec git rebase --abort
+	return
+    }
+    notbusy edit
+    run updatecommits
+}
+
+
 proc resethead {} {
     global mainhead rowmenuid confirm_ok resettype NS
 
-- 
1.7.5.4
