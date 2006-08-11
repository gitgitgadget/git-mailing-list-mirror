From: Jeff King <peff@peff.net>
Subject: Re: git rebase syntax question
Date: Fri, 11 Aug 2006 18:07:17 -0400
Message-ID: <20060811220717.GC4788@sigio.intra.peff.net>
References: <44DCC880.1080108@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 12 00:07:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBfA8-0001ww-CG
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 00:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932445AbWHKWHX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Aug 2006 18:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWHKWHW
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Aug 2006 18:07:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:28322 "HELO
	peff.net") by vger.kernel.org with SMTP id S932445AbWHKWHV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Aug 2006 18:07:21 -0400
Received: (qmail 30398 invoked from network); 11 Aug 2006 18:06:45 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 11 Aug 2006 18:06:45 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Aug 2006 18:07:17 -0400
To: Steve French <smfrench@austin.rr.com>
Content-Disposition: inline
In-Reply-To: <44DCC880.1080108@austin.rr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25241>

On Fri, Aug 11, 2006 at 01:12:16PM -0500, Steve French wrote:

> The git repository is cloned from 
> /pub/scm/linux/kernel/git/torvalds/linux-2.6.git and has one branch and 
> history like
>         ...->A->MyCommits->B->MoreOfMyCommits->C->EmptyMergeMessages
> and I want to make my master look like
>         ...->A->B->C->MyCommits->MoreOfMyCommits

Since A, B, and C are from upstream, they should still be linked
directly together. So your history is probably more like this:
    MyCommits--Merge--MoreOfMyCommits--EmptyMergeMessage
   /          /                       /
  A----------B-----------------------C

> I tried doing the obvious
>    "git rebase master"
> but that appears to be a no op

You are already merged with master, so rebase doesn't think there is
anything to do. You will have to rebase each of your merged segments
onto a new rebase branch:
  # Go back to just before the first merge...
  $ git-branch commits1 Merge^
  # And add all of C..commits1 on top of C
  $ git-rebase C commits1
  # Now we go back for the second merge...
  $ git-branch commits2 EmptyMergeMessage^
  # And add all of that on top of our previous work
  $ git-rebase commits1 commits2
  # At this point commits2 has A->B->C->MyCommits->MoreOfMyCommits.
  # Now we can clean things up, making master the new desired branch.
  $ git-checkout master
  $ git-reset --hard commits2
  $ git-branch -d commits1 commits2
  $ git-prune

I'm not sure if there's a simpler way to do it. Obviously if you do the
rebase as you go along (instead of merging) it's much easier.

-Peff
