From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-rerere observations and feature suggestions
Date: Thu, 19 Jun 2008 11:19:03 +0200
Message-ID: <20080619091903.GA14415@diana.vm.bytemark.co.uk>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu> <20080618105731.GA9242@elte.hu> <m33anao11u.fsf@localhost.localdomain> <20080618223821.GJ29404@genesis.frugalware.org> <20080619072308.GA12727@diana.vm.bytemark.co.uk> <7v7iclx4nw.fsf@gitster.siamese.dyndns.org> <20080619082156.GB12727@diana.vm.bytemark.co.uk> <20080619083356.GN29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 11:21:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9GKL-00073y-Eo
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 11:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbYFSJUQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 05:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757589AbYFSJUQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 05:20:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1906 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757583AbYFSJUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 05:20:15 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K9GIJ-0003mS-00; Thu, 19 Jun 2008 10:19:03 +0100
Content-Disposition: inline
In-Reply-To: <20080619083356.GN29404@genesis.frugalware.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85463>

On 2008-06-19 10:33:56 +0200, Miklos Vajna wrote:

> On Thu, Jun 19, 2008 at 10:21:56AM +0200, Karl Hasselstr=F6m
> <kha@treskal.com> wrote:
>
> > Catalin and I are tossing ideas around for how to represent the
> > history of an StGit patch stack (using a git commit for each log
> > entry). One complication is that we have to keep references to all
> > unapplied patches so that gc will leave them alone (and so that
> > they will get carried along during a pull, in the future). And the
> > number of unapplied patches is potentially large, so I thought
> > we'd be going to have to make a tree of "merge" commits to connect
> > them all up.
> >
> > (What we'd really like, of course, is a way to refer to a set of
> > commits such that they are guaranteed to be reachable (in the gc
> > and pull sense), but not considered "parents".)
>
> I had a similar problem in git/vmiklos.git on repo.or.cz, while
> working on builtin-rebase: I squash several patches using rebase -i
> before sending a series, but it's nice to have the old long list of
> small patches in case I would need them later.
>
> What I did is to have a rebase-history branch: each commit in it is
> an octopus merge:
>
> - The first parent is the previous rebase-history ref
>
> - The second is the old HEAD
>
> - The third is the new HEAD
>
> This way I can use git rebase -i without worrying about loosing
> history, even if reflogs are not shared among machines.
>
> (It may or may not be a good idea to do something like this in
> StGit, I just though I share this idea here.)

What you're describing is pretty much what we're thinking about doing
-- have a log branch where each commit contains enough metadata to
recreate the complete patch stack state at that point in time, and has
all the parents it needs to be safe from gc.

The particular problem I'm asking about here is that due to StGit's
concept of "unapplied" patches that are per definition not reachable
from the current branch head, a given log entry might have to keep an
unbounded number of commits from being gc'ed. Thus my question about
what would blow up if we were to make a commit with 50 parents. Or
100. Or 1000, if our users are crazy enough. (The alternative being,
of course, to make a tree of octopuses with a fixed maximum fan-out.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
