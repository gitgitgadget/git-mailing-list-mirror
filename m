From: Michal Sojka <sojka@os.inf.tu-dresden.de>
Subject: Re: [PATCH RFC] gitk: Allow commit editing
Date: Fri, 19 Aug 2011 15:34:06 +0200
Message-ID: <87sjoxv835.fsf@steelpick.2x.cz>
References: <1313610971-1741-1-git-send-email-sojka@os.inf.tu-dresden.de> <20110818223346.GA8481@sigill.intra.peff.net> <4E4E4C84.4030804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, paulus@samba.org
To: Chris Packham <judge.packham@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 19 15:34:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuPDJ-0000kS-Eb
	for gcvg-git-2@lo.gmane.org; Fri, 19 Aug 2011 15:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755490Ab1HSNeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 09:34:11 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:47290 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755461Ab1HSNeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 09:34:09 -0400
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id A4C273CFE77;
	Fri, 19 Aug 2011 15:34:07 +0200 (CEST)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id nWnYriIEPTkl; Fri, 19 Aug 2011 15:34:06 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 854903CFE71;
	Fri, 19 Aug 2011 15:34:06 +0200 (CEST)
Received: from steelpick.2x.cz (unknown [141.76.49.12])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 4FEAEFA003;
	Fri, 19 Aug 2011 15:34:06 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.76)
	(envelope-from <sojka@os.inf.tu-dresden.de>)
	id 1QuPD4-0000Hu-3T; Fri, 19 Aug 2011 15:34:06 +0200
In-Reply-To: <4E4E4C84.4030804@gmail.com>
User-Agent: Notmuch/0.6.1-91-g55c2c34 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179700>

On Fri, 19 Aug 2011, Chris Packham wrote:
> One thing I've thought about (but don't know enough TCL to begin to
> implement) is a graphical rebase front end. I often use git gui to make
> tweaks to the last commit (message and content) so why not extend that
> to a rebase operation. I think that might address some of Peffs concerns
> because the user would be invoking something specifically intended for
> rebasing and accepts all the caveats that go along with that.

Hi Chris,

the version of the patch below supports not only editing of commit
message but also of the commit itself. There is an easy way to split
commits and to remove lines/hunks form the commits. Additionally, with
the help of editor and "Rescan" button in git gui, you can add things to
the commits.

I think that in the similar way as in this patch, it would be easy to
allow gitk doing fixup and squash operations offered by rebase.

-Michal

--8<---------------cut here---------------start------------->8---
From 1d0f0a778afbaeb928cdecb3f18065757b3aa2fa Mon Sep 17 00:00:00 2001
From: Michal Sojka <sojka@os.inf.tu-dresden.de>
Date: Fri, 19 Aug 2011 15:21:47 +0200
Subject: [PATCH] gitk: Allow commit editing

I often use gitk to review patches before pushing them and would like
to have an easy way of fixing typos in commit messages. The current
approach with copying the commitid, switching to terminal, invoking
git rebase -i, editing the commit and switching back to gitk is a way
too complicated just for changing a single letter in commit message or
remove a debug printf().

This patch adds "Edit this commit" item to gitk's context menu which
invokes interactive rebase in a non-interactive way :-). git gui is
used to actually edit the commit.

Splitting of commits (as described in git-rebase(1)) is also supported.

The user is warned if the commit that is going to be edited is
contained in a remote branch.

Signed-off-by: Michal Sojka <sojka@os.inf.tu-dresden.de>
---
 gitk-git/gitk |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4cde0c4..432ca9b 100755
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
@@ -9102,6 +9103,45 @@ proc cherrypick {} {
     notbusy cherrypick
 }
 
+proc edit_commit {} {
+    global rowmenuid selectedline
+
+    if {[exec git branch -r --contains=$rowmenuid] ne {}} {
+	if {![confirm_popup [mc "The commit you are going to edit is contained in at least\
+				 one remote branch. It is a bad idea to change a branch that is\
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
+    while {[catch {exec sh -c "git diff-index --quiet --cached HEAD && git diff-files --quiet"} err]} {
+	if {[confirm_popup [mc "There are uncommited changes in the working tree or in the index.\
+				Do you want to create a new commit (OK) or throw them away (Cancel)?"]]} {
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
