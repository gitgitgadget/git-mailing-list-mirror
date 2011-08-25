From: Michal Sojka <sojka@os.inf.tu-dresden.de>
Subject: Re: [PATCH v3] gitk: Allow commit editing
Date: Thu, 25 Aug 2011 15:15:42 +0200
Message-ID: <87bovdvdhd.fsf@steelpick.2x.cz>
References: <87obzlwpx0.fsf@steelpick.2x.cz> <1313756753-26498-1-git-send-email-sojka@os.inf.tu-dresden.de> <20110825031420.GB3465@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, paulus@samba.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 25 15:15:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwZmj-00080z-Ma
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 15:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153Ab1HYNPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 09:15:48 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:45812 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab1HYNPr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 09:15:47 -0400
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 2F5D63CFE76;
	Thu, 25 Aug 2011 15:15:46 +0200 (CEST)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id I8tnzHcoteIp; Thu, 25 Aug 2011 15:15:44 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 0E6EE3CFE7B;
	Thu, 25 Aug 2011 15:15:43 +0200 (CEST)
Received: from steelpick.2x.cz (unknown [141.76.49.12])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 8C1A915C028;
	Thu, 25 Aug 2011 15:15:43 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.76)
	(envelope-from <sojka@os.inf.tu-dresden.de>)
	id 1QwZmY-0001D8-V2; Thu, 25 Aug 2011 15:15:42 +0200
In-Reply-To: <20110825031420.GB3465@sigill.intra.peff.net>
User-Agent: Notmuch/0.6.1-96-g451f68f (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180077>

On Thu, 25 Aug 2011, Jeff King wrote:
> On Fri, Aug 19, 2011 at 02:25:53PM +0200, Michal Sojka wrote:
> 
> > +    if {[exec git branch -r --contains=$rowmenuid] ne {}} {
> > +	if {![confirm_popup [mc "The commit you are going to edit appears in at least one\
> > +				 remote branch. It is a bad idea to change a branch that is\
> > +				 possibly used by other people. See git-rebase(1) for details.\n\n\
> > +				 Do you want to continue?"]]} return }
> 
> We frown on using porcelain like "git branch" here, because it was not
> meant to be scriptable (i.e., its behavior may change in future
> releases).
> 
> As I mentioned elsewhere, I think you really want to see whether the
> commit is referenced by any other ref, not just branches; if it is, then
> the rebase is potentially problematic. You can do that with something
> like:
> 
>   us=`git symbolic-ref HEAD`
>   git for-each-ref --format='%(refname)' |
>   while read ref; do
>     test "$ref" = $us" && continue
>     echo "^$ref"
>   done |
>   git rev-list HEAD --stdin
> 
> That will give a list of commits found only on HEAD and nowhere else
> (i.e., those which are safe to rebase). If your commit is among them,
> then it's safe.

I implemented something like you ontlined above (see below). Instead of
rev-listing HEAD, I use the commit id to be edited. This way I don't
have to find the commit in the returned list, but I only check whether
the list is empty or not.

Additionally, besides skiping HEAD ref, I also skip refs/stash. Rebasing
before stash should not (I hope) cause any problems and therefore it is
not necessary to warn the user.

> Speaking of which, notice that I used HEAD here. What happens with your
> patch if I do:
> 
>   $ git checkout foo
>   $ gitk bar
> 
> and select a commit to edit that is not in "foo"?

I added a check for this. If this is detected, error message is
displayed and no edit is possible.

The other changes in this version are:
- added --no-autosquash to rebase invocation
- fixed indexes of menu entries following the new edit entry.

Regards,
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
 gitk-git/gitk |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 67 insertions(+), 4 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4cde0c4..0968efa 100755
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
@@ -8428,18 +8429,18 @@ proc rowmenu {x y id} {
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
@@ -9102,6 +9103,68 @@ proc cherrypick {} {
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
+    if {[exec git rev-list --stdin $id << $otherrefsneg] eq {}} {
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
