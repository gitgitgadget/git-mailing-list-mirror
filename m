From: Michal Sojka <sojka@os.inf.tu-dresden.de>
Subject: Re: [PATCH RFC] gitk: Allow commit editing
Date: Fri, 19 Aug 2011 16:40:31 +0200
Message-ID: <87pqk1v50g.fsf@steelpick.2x.cz>
References: <1313610971-1741-1-git-send-email-sojka@os.inf.tu-dresden.de> <20110818223346.GA8481@sigill.intra.peff.net> <4E4E4C84.4030804@gmail.com> <87sjoxv835.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, paulus@samba.org
To: Chris Packham <judge.packham@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 16:40:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuQFT-0000kA-Vo
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 16:40:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876Ab1HSOkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 10:40:35 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:46788 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161Ab1HSOke (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 10:40:34 -0400
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 183A13CFE75;
	Fri, 19 Aug 2011 16:40:33 +0200 (CEST)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id 6bn8VvS2xTPu; Fri, 19 Aug 2011 16:40:32 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 0802019F2F36;
	Fri, 19 Aug 2011 16:40:32 +0200 (CEST)
Received: from steelpick.2x.cz (unknown [141.76.49.12])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 03F4EFA003;
	Fri, 19 Aug 2011 16:40:31 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.76)
	(envelope-from <sojka@os.inf.tu-dresden.de>)
	id 1QuQFL-0002RI-P6; Fri, 19 Aug 2011 16:40:31 +0200
In-Reply-To: <87sjoxv835.fsf@steelpick.2x.cz>
User-Agent: Notmuch/0.6.1-91-g55c2c34 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179703>

On Fri, 19 Aug 2011, Michal Sojka wrote:
> On Fri, 19 Aug 2011, Chris Packham wrote:
> > One thing I've thought about (but don't know enough TCL to begin to
> > implement) is a graphical rebase front end. I often use git gui to make
> > tweaks to the last commit (message and content) so why not extend that
> > to a rebase operation. I think that might address some of Peffs concerns
> > because the user would be invoking something specifically intended for
> > rebasing and accepts all the caveats that go along with that.
> 
> Hi Chris,
> 
> the version of the patch below supports not only editing of commit
> message but also of the commit itself. There is an easy way to split
> commits and to remove lines/hunks form the commits. Additionally, with
> the help of editor and "Rescan" button in git gui, you can add things to
> the commits.
> 
> I think that in the similar way as in this patch, it would be easy to
> allow gitk doing fixup and squash operations offered by rebase.

Here is another proof of concept, that gitk can also fold commits
together. It applies on top of the previously sent patch.

This operation is probably even more dangerous then simple edit because
it reorders commits. Does anybody have an idea which checks should be
employed in order to warn users about unexpected results?

-Michal

--8<---------------cut here---------------start------------->8---
From 5943dfcd9738f8da9d159f912302cfbb2b4d35b5 Mon Sep 17 00:00:00 2001
From: Michal Sojka <sojka@os.inf.tu-dresden.de>
Date: Fri, 19 Aug 2011 16:33:55 +0200
Subject: [PATCH 2/2] gitk: Learn how to fixup commits


Signed-off-by: Michal Sojka <sojka@os.inf.tu-dresden.de>
---
 gitk-git/gitk |   41 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 432ca9b..53fa51d 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2488,6 +2488,7 @@ proc makewindow {} {
 	{mc "Diff this -> selected" command {diffvssel 0}}
 	{mc "Diff selected -> this" command {diffvssel 1}}
 	{mc "Edit this commit" command edit_commit}
+	{mc "Fold this into selected (fixup)" command fixup_commit}
 	{mc "Make patch" command mkpatch}
 	{mc "Create tag" command mktag}
 	{mc "Write commit to file" command writecommit}
@@ -8448,6 +8449,7 @@ proc rowmenu {x y id} {
     $menu entryconfigure [mca "Diff this -> selected"] -state $state
     $menu entryconfigure [mca "Diff selected -> this"] -state $state
     $menu entryconfigure [mca "Make patch"] -state $state
+    $menu entryconfigure [mca "Fold this into selected (fixup)"] -state $state
     tk_popup $menu $x $y
 }
 
@@ -9103,14 +9105,24 @@ proc cherrypick {} {
     notbusy cherrypick
 }
 
+proc rebase_ok {id} {
+    if {[exec git branch -r --contains=$id] ne {}} {
+	if { [confirm_popup [mc "The commit you are going to edit is contained in at least\
+				 one remote branch. It is a bad idea to change a branch that is\
+				 possibly used by other people. See git-rebase(1) for details.\n\n\
+				 Do you want to continue?"]]} {
+	    return 1
+	} else {
+	    return 0
+	}
+    }
+    return 1
+}
+
 proc edit_commit {} {
     global rowmenuid selectedline
 
-    if {[exec git branch -r --contains=$rowmenuid] ne {}} {
-	if {![confirm_popup [mc "The commit you are going to edit is contained in at least\
-				 one remote branch. It is a bad idea to change a branch that is\
-				 possibly used by other people. See git-rebase(1) for details.\n\n\
-				 Do you want to continue?"]]} return }
+    if {![rebase_ok $rowmenuid]} return
 
     nowbusy edit [mc "Editing commit"]
     if {[catch {exec sh -c "(GIT_EDITOR='sed -ie 1s/^pick/edit/' git rebase -p -i $rowmenuid^ && git gui citool --amend) 2>&1"} err]} {
@@ -9141,6 +9153,25 @@ proc edit_commit {} {
     notbusy edit
 }
 
+proc fixup_commit {} {
+    global rowmenuid selectedline
+    set selectedid [commitonrow $selectedline]
+    set baseid [exec git merge-base $selectedid $rowmenuid]
+
+    if {![rebase_ok $baseid]} return
+
+    set this [string range $rowmenuid 0 6]
+    set selected [string range $selectedid  0 6]
+    nowbusy fixup
+    if {[catch {exec sh -c "GIT_EDITOR=\"sed -i -e '/^pick $selected/a fixup $this' -e '/^pick $this/d'\" git rebase -p -i $baseid^ 2>&1"} err]} {
+	notbusy fixup
+	error_popup $err
+	exec git rebase --abort
+	return
+    }
+    updatecommits
+    notbusy fixup
+}
 
 proc resethead {} {
     global mainhead rowmenuid confirm_ok resettype NS
-- 
1.7.5.4

--8<---------------cut here---------------end--------------->8---
