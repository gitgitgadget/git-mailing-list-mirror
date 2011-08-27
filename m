From: Michal Sojka <sojka@os.inf.tu-dresden.de>
Subject: [PATCH v4] gitk: Allow commit editing
Date: Sat, 27 Aug 2011 14:31:02 +0200
Message-ID: <87fwknaveh.fsf@steelpick.2x.cz>
References: <87obzlwpx0.fsf@steelpick.2x.cz> <1313756753-26498-1-git-send-email-sojka@os.inf.tu-dresden.de> <20110825031420.GB3465@sigill.intra.peff.net> <87bovdvdhd.fsf@steelpick.2x.cz> <20110825173018.GA519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, paulus@samba.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 27 14:31:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxI2i-0005tq-Dd
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 14:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378Ab1H0MbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Aug 2011 08:31:09 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:57307 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab1H0MbH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2011 08:31:07 -0400
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id C76793CFE72;
	Sat, 27 Aug 2011 14:31:05 +0200 (CEST)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id 0CdZEd+7CO+7; Sat, 27 Aug 2011 14:31:04 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 35DE819F333B;
	Sat, 27 Aug 2011 14:31:04 +0200 (CEST)
Received: from steelpick.2x.cz (unknown [141.76.49.12])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 71E1CFA003;
	Sat, 27 Aug 2011 14:31:03 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.76)
	(envelope-from <sojka@os.inf.tu-dresden.de>)
	id 1QxI2R-0007Ow-01; Sat, 27 Aug 2011 14:31:02 +0200
In-Reply-To: <20110825173018.GA519@sigill.intra.peff.net>
User-Agent: Notmuch/0.6.1-96-g451f68f (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180228>

On Thu, 25 Aug 2011, Jeff King wrote:
> On Thu, Aug 25, 2011 at 03:15:42PM +0200, Michal Sojka wrote:
> > +    # Check whether some other refs contain the commit to be edited
> > +    if {[exec git rev-list --stdin $id << $otherrefsneg] eq {}} {
> > +	if { [confirm_popup [mc "The commit you are going to edit is contained in another, possibly non-local, ref (e.g. branch or tag).\
> > +				It is a bad idea to change a ref that is possibly used by other people. See git-rebase(1) for details.\n\n\
> > +				Do you want to continue?"]]} {
> > +	    return 1
> 
> Minor micro-optimization: this can be "git rev-list -1". You only care
> if it produces the one commit, so that's sufficient. Without "-1", git
> will keep reporting commits all the way down to the merge base with some
> other ref.

Here is a new version with the micro-optimization.

Another minor change is that this patch now applies to gitk repo
(http://git.kernel.org/pub/scm/gitk/gitk.git) instead of the main git
repo.

-Michal

--8<---------------cut here---------------start------------->8---
I often use gitk to review patches before pushing them out and I would
like to have an easy way to edit commits. The current approach with
copying the commitid, switching to terminal, invoking git rebase -i,
editing the commit and switching back to gitk is a way too complicated
just for changing a single letter in the commit message or removing a
debug printf().

This patch adds "Edit this commit" item to gitk's context menu which
invokes interactive rebase in a non-interactive way :-). git gui is
used to actually edit the commit.

Besides editing the commit message, splitting of commits, as described
in git-rebase(1), is also supported.

The user is warned if the commit to be edited is contained in another
ref besides the current branch and the stash (e.g. in a remote
branch). Additionally, error box is displayed if the user attempts to
edit a commit not contained in the current branch.

Signed-off-by: Michal Sojka <sojka@os.inf.tu-dresden.de>
---
 gitk |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index a701e0d..1ca2d00 100755
--- a/gitk
+++ b/gitk
@@ -2481,6 +2481,7 @@ proc makewindow {} {
     makemenu $rowctxmenu {
 	{mc "Diff this -> selected" command {diffvssel 0}}
 	{mc "Diff selected -> this" command {diffvssel 1}}
+	{mc "Edit this commit" command edit_commit}
 	{mc "Make patch" command mkpatch}
 	{mc "Create tag" command mktag}
 	{mc "Write commit to file" command writecommit}
@@ -8445,18 +8446,18 @@ proc rowmenu {x y id} {
     if {$id ne $nullid && $id ne $nullid2} {
 	set menu $rowctxmenu
 	if {$mainhead ne {}} {
-	    $menu entryconfigure 7 -label [mc "Reset %s branch to here" $mainhead] -state normal
+	    $menu entryconfigure 8 -label [mc "Reset %s branch to here" $mainhead] -state normal
 	} else {
-	    $menu entryconfigure 7 -label [mc "Detached head: can't reset" $mainhead] -state disabled
+	    $menu entryconfigure 8 -label [mc "Detached head: can't reset" $mainhead] -state disabled
 	}
 	if {[info exists markedid] && $markedid ne $id} {
-	    $menu entryconfigure 9 -state normal
 	    $menu entryconfigure 10 -state normal
 	    $menu entryconfigure 11 -state normal
+	    $menu entryconfigure 12 -state normal
 	} else {
-	    $menu entryconfigure 9 -state disabled
 	    $menu entryconfigure 10 -state disabled
 	    $menu entryconfigure 11 -state disabled
+	    $menu entryconfigure 12 -state disabled
 	}
     } else {
 	set menu $fakerowmenu
@@ -9120,6 +9121,68 @@ proc cherrypick {} {
     notbusy cherrypick
 }
 
+proc rebase_ok {id} {
+    if {[exec git merge-base $id HEAD] ne $id} {
+	error_popup [mc "You cannot edit commits outside of the current branch."]
+	return 0
+    }
+    set headref [exec git symbolic-ref HEAD]
+    set allrefs [split [exec git for-each-ref --format=%(refname)] "\n"]
+    set otherrefs {}
+    set otherrefsneg ""
+    foreach ref $allrefs {
+	if {$ref eq "refs/stash" || $ref eq $headref} continue
+	set otherrefsneg "$otherrefsneg^$ref\n"
+    }
+
+    # Check whether some other refs contain the commit to be edited
+    if {[exec git rev-list --stdin $id --max-count=1 << $otherrefsneg] eq {}} {
+	if { [confirm_popup [mc "The commit you are going to edit is contained in another, possibly non-local, ref (e.g. branch or tag).\
+				It is a bad idea to change a ref that is possibly used by other people. See git-rebase(1) for details.\n\n\
+				Do you want to continue?"]]} {
+	    return 1
+	} else {
+	    return 0
+	}
+    }
+    return 1
+}
+
+proc edit_commit {} {
+    global rowmenuid selectedline
+
+    if {![rebase_ok $rowmenuid]} return
+
+    nowbusy edit [mc "Editing commit"]
+    if {[catch {exec sh -c "(GIT_EDITOR='sed -ie 1s/^pick/edit/' git rebase -p -i --no-autosquash $rowmenuid^ && git gui citool --amend) 2>&1"} err]} {
+	notbusy edit
+	error_popup $err
+	exec git rebase --abort
+	return
+    }
+    set newcommit [exec git rev-parse HEAD]
+    while {[catch {exec sh -c "git diff-index --quiet --cached HEAD && git diff-files --quiet"} err]} {
+	if {[confirm_popup [mc "There are uncommited changes in the working tree or in the index.\
+				Do you want to create a new commit (OK) or discard them (Cancel)?"]]} {
+	    catch {exec git gui citool} err;
+	    # In case of error (i.e. the user did not commit anything), we just ask him again
+	} else {
+	    exec git reset --hard
+	}
+    }
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

--8<---------------cut here---------------end--------------->8---
