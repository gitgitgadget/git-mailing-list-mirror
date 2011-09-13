From: Michal Sojka <sojka@os.inf.tu-dresden.de>
Subject: Re: [PATCH v4] gitk: Allow commit editing
Date: Wed, 14 Sep 2011 01:11:24 +0200
Message-ID: <87litsf36r.fsf@steelpick.2x.cz>
References: <87obzlwpx0.fsf@steelpick.2x.cz> <1313756753-26498-1-git-send-email-sojka@os.inf.tu-dresden.de> <20110825031420.GB3465@sigill.intra.peff.net> <87bovdvdhd.fsf@steelpick.2x.cz> <20110825173018.GA519@sigill.intra.peff.net> <87fwknaveh.fsf@steelpick.2x.cz> <20110908205945.GB8091@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 01:11:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3c8b-0002CK-KX
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 01:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933042Ab1IMXL3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 19:11:29 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:54900 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932988Ab1IMXL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 19:11:28 -0400
Received: from localhost (unknown [192.168.200.4])
	by max.feld.cvut.cz (Postfix) with ESMTP id 402E43CFE77;
	Wed, 14 Sep 2011 01:11:27 +0200 (CEST)
X-Virus-Scanned: IMAP AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.4]) (amavisd-new, port 10044)
	with ESMTP id St2Rtba-dTcA; Wed, 14 Sep 2011 01:11:26 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id C23543CFE76;
	Wed, 14 Sep 2011 01:11:25 +0200 (CEST)
Received: from steelpick.2x.cz (cable-86-56-4-108.cust.telecolumbus.net [86.56.4.108])
	(Authenticated sender: sojkam1)
	by imap.feld.cvut.cz (Postfix) with ESMTPSA id 29DFEFA003;
	Wed, 14 Sep 2011 01:11:25 +0200 (CEST)
Received: from wsh by steelpick.2x.cz with local (Exim 4.76)
	(envelope-from <sojka@os.inf.tu-dresden.de>)
	id 1R3c8S-0000JD-Bg; Wed, 14 Sep 2011 01:11:24 +0200
In-Reply-To: <20110908205945.GB8091@bloggs.ozlabs.ibm.com>
User-Agent: Notmuch/0.8-38-g2f99445 (http://notmuchmail.org) Emacs/23.3.1 (x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181321>

On Thu, 08 Sep 2011, Paul Mackerras wrote:
> On Sat, Aug 27, 2011 at 02:31:02PM +0200, Michal Sojka wrote:
> > Here is a new version with the micro-optimization.
> > 
> > Another minor change is that this patch now applies to gitk repo
> > (http://git.kernel.org/pub/scm/gitk/gitk.git) instead of the main git
> > repo.
> > 
> > -Michal
> > 
> > --8<---------------cut here---------------start------------->8---
> > I often use gitk to review patches before pushing them out and I would
> > like to have an easy way to edit commits. The current approach with
> > copying the commitid, switching to terminal, invoking git rebase -i,
> > editing the commit and switching back to gitk is a way too complicated
> > just for changing a single letter in the commit message or removing a
> > debug printf().
> > 
> > This patch adds "Edit this commit" item to gitk's context menu which
> > invokes interactive rebase in a non-interactive way :-). git gui is
> > used to actually edit the commit.
> > 
> > Besides editing the commit message, splitting of commits, as described
> > in git-rebase(1), is also supported.
> > 
> > The user is warned if the commit to be edited is contained in another
> > ref besides the current branch and the stash (e.g. in a remote
> > branch). Additionally, error box is displayed if the user attempts to
> > edit a commit not contained in the current branch.
> 
> I have to say that this patch makes me pretty nervous.  I can see the
> attractiveness of the feature, but I don't like making gitk
> unresponsive for a potentially long time, i.e. until git gui exits.
> It may not be clear to users that the reason gitk isn't responding is
> because some other git gui window is still running.

I understand this. See below for a possible solution.
 
> Also, if some subsequent commit no longer applies because of the
> changes you make to a commit, it's going to abort the rebase
> completely and thus lose the changes you made.  That could be
> annoying.

Agreed. A solution could be to create a ref called for example
refs/gitk/failed-rebase and then abort the rebase together with
displaying the error message explaining what happened. The edited commit
would remain visible and a user can manually cherry pick remaining
commits and then reset the original branch to this failed-rebase ref.

> I usually do this by starting a new branch just before the commit I
> want to change and then use a combination of the cherry-pick menu item
> and git commit --amend.  Maybe something to make that simpler for
> users would be good, i.e. automate it a bit but still have it be a
> step-by-step process if necessary.  Part of the problem of course is
> that neither gitk nor git gui are really designed to be an editing
> environment.

So what about the following:

1) When user selects "Edit commit", git rebase -i is called, git citool
   is started on background and things will be set up (I do not know yet
   how exactly) so that same callback is called when git citool exits.

2) gitk updates the list of commits and marks the current (detached)
   head by a tag (colored box) saying that there is rebase in progress.
   The same tag would appear if gitk is executed manually during
   interactive rebase.

3) When git citool exits (or when you explicitly select something from
   rebase tag's context menu), rebase would continue.

> In fact you really want an edit/compile/test environment so you don't
> introduce new bugs.

Another possibility would be to allow only editing of the commit
message. Then you don't need compile/test steps and the rebase should
not fail due to conflicts.

I do not think I would like this limitation, but it would certainly be
better then nothing.

-Michal
