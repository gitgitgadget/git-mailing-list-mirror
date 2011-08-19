From: Michal Sojka <sojka@os.inf.tu-dresden.de>
Subject: [PATCH] gitk: Allow commit editing
Date: Fri, 19 Aug 2011 14:25:53 +0200
Message-ID: <1313756753-26498-1-git-send-email-sojka@os.inf.tu-dresden.de>
References: <87obzlwpx0.fsf@steelpick.2x.cz>
Cc: peff@peff.net, paulus@samba.org,
	Michal Sojka <sojka@os.inf.tu-dresden.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 14:26:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuO9Q-0003mt-Pd
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 14:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416Ab1HSM0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 08:26:12 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:60403 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753295Ab1HSM0K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 08:26:10 -0400
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 553FF3CFE71;
	Fri, 19 Aug 2011 14:26:09 +0200 (CEST)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id io0T6wZnmtBE; Fri, 19 Aug 2011 14:26:07 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id EEACD19F32DD;
	Fri, 19 Aug 2011 14:26:06 +0200 (CEST)
Received: from steelpick.2x.cz (unknown [141.76.49.12])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id DEDBEFA003;
	Fri, 19 Aug 2011 14:26:06 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.76)
	(envelope-from <sojkam1@fel.cvut.cz>)
	id 1QuO9G-0006tv-Jv; Fri, 19 Aug 2011 14:26:06 +0200
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <87obzlwpx0.fsf@steelpick.2x.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179696>

I often use gitk to review patches before pushing them and would like
to have an easy way of fixing typos in commit messages. The current
approach if copying the commitid, switching to terminal, invoking git
rebase -i, editing the commit and switching back to gitk is a way too
complicated just for chaning a single letter.

This patch adds "Edit this commit" item to gitk's context menu which
invokes interactive rebase in a non-interactive way :-). git gui is
used to actually edit the commit.

The user is warned if the commit that is going to be edited is
contained in a remote branch.

Signed-off-by: Michal Sojka <sojka@os.inf.tu-dresden.de>
---
 gitk-git/gitk |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4cde0c4..83b3307 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2487,6 +2487,7 @@ proc makewindow {} {
     makemenu $rowctxmenu {
 	{mc "Diff this -> selected" command {diffvssel 0}}
 	{mc "Diff selected -> this" command {diffvssel 1}}
+	{mc "Edit this commit" command edit_commit}
 	{mc "Make patch" command mkpatch}
 	{mc "Create tag" command mktag}
 	{mc "Write commit to file" command writecommit}
@@ -9102,6 +9103,36 @@ proc cherrypick {} {
     notbusy cherrypick
 }
 
+proc edit_commit {} {
+    global rowmenuid selectedline
+
+    if {[exec git branch -r --contains=$rowmenuid] ne {}} {
+	if {![confirm_popup [mc "The commit you are going to edit appears in at least one\
+				 remote branch. It is a bad idea to change a branch that is\
+				 possibly used by other people. See git-rebase(1) for details.\n\n\
+				 Do you want to continue?"]]} return }
+
+    nowbusy edit [mc "Editing commit"]
+    if {[catch {exec sh -c "(GIT_EDITOR='sed -ie 1s/^pick/edit/' git rebase -p -i $rowmenuid^ && git gui citool --amend) 2>&1"} err]} {
+	notbusy edit
+	error_popup $err
+	exec git rebase --abort
+	return
+    }
+    set newcommit [exec git rev-parse HEAD]
+    if {[catch {exec sh -c "git rebase --continue 2>&1"} err]} {
+	notbusy edit
+	error_popup $err
+	exec git rebase --abort
+	return
+    }
+    updatecommits
+    # XXX How to select the edited commit? This doesn't work.
+    selbyid $newcommit
+    notbusy edit
+}
+
+
 proc resethead {} {
     global mainhead rowmenuid confirm_ok resettype NS
 
-- 
1.7.5.4
