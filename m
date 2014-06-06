From: Eric Peters <Eric@Peters.org>
Subject: Feature Request: Fix/Make git-rebase work with git-subtree (was: Re:
 subtree merges lose prefix after rebase)
Date: Fri, 6 Jun 2014 08:41:26 -0700
Message-ID: <CADbXawuVx4-9ujYFEgaX8EML05pZdcfDAN9FZdHBWHQ6WS6U+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 06 17:41:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WswGr-0001Md-4Y
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 17:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbaFFPl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2014 11:41:29 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:52113 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaFFPl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2014 11:41:28 -0400
Received: by mail-lb0-f174.google.com with SMTP id n15so1642186lbi.33
        for <git@vger.kernel.org>; Fri, 06 Jun 2014 08:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=yMe/yv+yf2lAZErJlMwzhUgvVhvUHYFXb+2h9J0uTWw=;
        b=zf5br3qO0p3hEpyuzrP21ZuE54RFZbMC+ICfyNk/XonYsatjiaOeKAqrM1rKtg7HWa
         Fr2Xi+rYZB7eeSicFt8x+rxHbzVtPdSMBkRNrSkm5Qs5Q8zv5rJuVdonFoudgNCNCdiy
         wqucVZNqyiVw5XrnIGCk8y2JbG6uHPXlG+ePfa1y4jRSCQnwTCr1pWHBbI2knV9DPG4O
         QkvQuIsl/D10i9kzOLEubO4BdIM1U0Q9/uJNUkPvWmT9M0HBrmCHpUbtlehkMaBx3eAu
         +7gIdxHDfhWKFPSL+SjPp4xz7mFMPnRix77D0ycWTuDkFzISaCuV3Bnm6V9vswMBWu2X
         4L/g==
X-Received: by 10.112.61.102 with SMTP id o6mr2400963lbr.74.1402069287011;
 Fri, 06 Jun 2014 08:41:27 -0700 (PDT)
Received: by 10.112.156.38 with HTTP; Fri, 6 Jun 2014 08:41:26 -0700 (PDT)
X-Google-Sender-Auth: 72jFr68_j1R34Ep-x5QicqMhnnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250942>

Hi All ~

This is sort of re-open of a 2012 thread:
http://git.661346.n2.nabble.com/subtree-merges-lose-prefix-after-rebase-td7332850.html

A related stackoverflow post that describes the problem & a
work-arounds/what was attempted to solve the problem:
http://stackoverflow.com/questions/12858199/how-to-rebase-after-git-subtree-add/23094756

I understand that git-subtree/git-rebase are currently working "as
intended," and sub-modules were, in theory, were intended to be a
replacement of subtrees.

However, I would like to request re-looking at the viability of making
the rebase example work as someone using a git-subtree should expect
it to.

I don't know enough of the under-the-hood detail of what it would take
to implement - but so far it looks like there's over 1k people on the
stackoverflow that have had the same issue I ran into & were looking
for a work-around.

Thanks,

Eric

On Thu, Mar 1, 2012 at 6:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Zakaria ElQotbi <zakaria@elqotbi.com> writes:
>
> > why subtree merges lose prefix after an interactive rebase, is it a known
> > issue ? or I'am missing somethings:
> > ...
> > $ git rebase -i -p a6d4e8e # this the hash of "merge b" commit
> > $ git commit --amend -m "merge b edit"
> > $ git rebase --continue
> > $ tree
> > .
> > |-- C
> > |-- projects
> > |   |-- a
> > |   |   `-- A
> > |   `-- b
> > |       `-- B
> > `-- README
>
> Rebase essentially is a stepwise cherry-pick, and cherry-pick does not see
> anything but the trees recorded in the commit being rebased and in its
> parent.
>
> Your original history is to merge in projects a, b and c in order,
> renaming them using subtree merge to their own subdirectory.  You rebase
> the commits after the one that merges b, i.e. the merge of project c, in
> that history.  As far as that rebased commit is concerned, the change it
> makes relative to its parent commit is to add file C at the root level.
> So you are starting from the state you merged a and b into the whole
> project, and replaing that commit that adds C at the root level.  That
> matches the above picture.
>
> In short, this is expected, because rebase does not know anything about
> evil merges made by 'subtree' (or 'ours' for that matter).  And I do not
> think there is any plan to make rebase aware of subtree merges.  After
> all, subtree merge was invented merely as a short-term hack to serve as a
> stop gap measure until submodule support becomes mature.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
