From: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
Subject: [PATCH] Mod. gitk to support REBASE (with stash support).
Date: Wed,  8 Aug 2007 14:33:48 -0400
Message-ID: <1186598028457-git-send-email-alexandre.bourget@savoirfairelinux.com>
Cc: paulus@samba.org,
	Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 20:58:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIqjk-0006TL-Rk
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 20:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934313AbXHHS6W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 14:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933182AbXHHS6V
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 14:58:21 -0400
Received: from mail.savoirfairelinux.net ([69.28.212.163]:41166 "EHLO
	open-xchange.savoirfairelinux.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761334AbXHHS6U (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 14:58:20 -0400
X-Greylist: delayed 1466 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Aug 2007 14:58:20 EDT
Received: by open-xchange.savoirfairelinux.net (Postfix, from userid 99)
	id E1B8D4612A0; Wed,  8 Aug 2007 14:33:51 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on
	open-xchange.savoirfairelinux.net
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.1.8
Received: from localhost.localdomain (savoirfairelinux.net [199.243.85.90])
	by open-xchange.savoirfairelinux.net (Postfix) with ESMTP id 36482460E14;
	Wed,  8 Aug 2007 14:33:50 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.rc4.24.g5b56a
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55336>

---
Adds a context menu for commits, so that a 'rebase' can be done.

Optionally, it will ask if you want to 'stash' current work before doing so.

TODO: better error handling.

 gitk |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index f74ce51..558b7bb 100755
--- a/gitk
+++ b/gitk
@@ -898,6 +898,8 @@ proc makewindow {} {
 	-command cherrypick
     $rowctxmenu add command -label "Reset HEAD branch to here" \
 	-command resethead
+    $rowctxmenu add command -label "Rebase HEAD branch on this commit" \
+	-command rebasehead
 
     set fakerowmenu .fakerowmenu
     menu $fakerowmenu -tearoff 0
@@ -5593,6 +5595,7 @@ proc rowmenu {x y id} {
     if {$id ne $nullid && $id ne $nullid2} {
 	set menu $rowctxmenu
 	$menu entryconfigure 7 -label "Reset $mainhead branch to here"
+	$menu entryconfigure 8 -label "Rebase $mainhead branch on this commit"
     } else {
 	set menu $fakerowmenu
     }
@@ -5972,6 +5975,41 @@ proc cherrypick {} {
     notbusy cherrypick
 }
 
+proc rebasehead {} {
+    global mainheadid mainhead rowmenuid confirm_ok
+    global localfrow localirow
+
+
+    set head $mainhead
+    set id $rowmenuid
+
+    set confirm_ok 0
+
+    if {$localfrow != -1 || $localirow != -1} {
+	# There's something to stash.
+	set confirm_ok [confirm_popup "There are some local modifications.\n\nDo you want to git-stash any changes before doing a rebase?\n\n(They will be reapplied right after, and stash will be *cleared*)"]
+    }
+
+    nowbusy rebasehead
+    update
+
+    if {$confirm_ok} {
+	exec git stash save
+    }
+
+    # TODO: error handling.
+    exec git rebase $id
+
+    if {$confirm_ok} {
+	exec git stash apply stash@{0}
+	exec git stash clear
+    }
+
+    notbusy rebasehead
+    updatecommits
+}
+
+
 proc resethead {} {
     global mainheadid mainhead rowmenuid confirm_ok resettype
     global showlocalchanges
-- 
1.5.3.rc4.24.g5b56a
