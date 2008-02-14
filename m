From: Jeff King <peff@peff.net>
Subject: Re: Keeping reflogs on branch deletion
Date: Thu, 14 Feb 2008 12:57:24 -0500
Message-ID: <20080214175724.GA30689@coredump.intra.peff.net>
References: <ee77f5c20802131745p23aa1db3j47207f1e6538b0e@mail.gmail.com> <18355.42595.377377.433309@lisa.zopyra.com> <ee77f5c20802131903i45b1629fpcb4a5c6e4f483052@mail.gmail.com> <7vr6fgkxt2.fsf@gitster.siamese.dyndns.org> <20080214140152.GT27535@lavos.net> <alpine.LFD.1.00.0802140945520.2732@xanadu.home> <20080214151752.GB3889@coredump.intra.peff.net> <alpine.LFD.1.00.0802141103280.2732@xanadu.home> <20080214163101.GA24673@coredump.intra.peff.net> <alpine.LFD.1.00.0802141147200.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Downing <bdowning@lavos.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Symonds <dsymonds@gmail.com>,
	Bill Lear <rael@zopyra.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Feb 14 18:58:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPiLT-0001tg-HN
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 18:58:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbYBNR53 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 12:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752395AbYBNR53
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 12:57:29 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2557 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752360AbYBNR52 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 12:57:28 -0500
Received: (qmail 9642 invoked by uid 111); 14 Feb 2008 17:57:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 14 Feb 2008 12:57:25 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2008 12:57:24 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0802141147200.2732@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73900>

On Thu, Feb 14, 2008 at 12:32:07PM -0500, Nicolas Pitre wrote:

> I typically have lots of branches.  Many of those are fairly dynamic -- 
> they come and go.  Keeping reflogs for them would only clutter the 
> reflog space, especially when the same names are reused.  I prefer to 
> have a clean reflog for the currently alive branch of a given name 
> rather than having a log of anything that occurred under that name.  And 
> if I really want to find out about that old branch then there is always 
> the HEAD reflog.

OK, that is a fair argument. I totally disagree, but this is a question
of "what users would want" and you and I happen to want different
behavior. I suspect it has to do with how you name your branches.

> > For one thing, just because a modification wasn't _yours_ doesn't mean
> > it isn't valuable. It entered your repository, and therefore it may be
> > of interest.
> 
> And if you delete it then you can retrieve it again from its origin.  

In a system which touts totally independent operation of separate
repositories, saying "oh, you can just ask some other repository for it
again" seems silly. Who is to say the other repo still exists? Or that
it contains the information you're looking for (e.g., a git push from an
arbitrary commit at one repo may enter your branch at a specific point.
the information that is useful to you is where and when it landed in
your branch, which was never in the other repo in the first place).

> > Secondly, you _can_ change a ref without it being the HEAD. Try
> > 
> >   git branch -f foo bar
> 
> Sure.  And what information would become unreachable if you delete 'foo' 
> at that point?  The 'bar' commit is not lost, and likely to still exist 
> in some other reflog.

The fact that 'foo' was set to a particular sha1 at a particular point
in time? Isn't that the point of a reflog?

Of course the 'bar' commit is not lost. My point is not that you are
losing commits this way, it is that finding the commit you wanted
becomes more difficult (e.g., asking "what was at the tip of the branch
when it was deleted").

> This is trivial.
> 
> $ git log -g HEAD | grep -C2 "^Reflog.*moving from branch to"
> 
> If the first hit is HEAD@{x} then your branch@{0} is just HEAD@{x+1}.

That isn't too bad. But it really works only for branch@{0}, and it
doesn't handle any of the non-HEAD cases I mentioned above.

> The naming of deleted reflogs when new branches with same name are 
> created, or the concatenation of entries for unrelated branches that 
> might happen to have existed under the same name.

It seems like there are only 3 options: clear the log upon deletion,
clear the log upon making the new branch of the same name, or appending
to the old log. I think the third makes the most sense, but there is
probably room for a config option.

> And because the relevant entries are already in the HEAD reflog anyway, 
> and trivially retrieved as demonstrated above, I don't think it is worth 
> adding any additional complexity for what is only a convenience feature 
> that is not supposed to be used many times a day after all.

Fair enough. I actually also don't think it is personally worth my time
to implement, which I suppose means I agree with you. But I don't think
it's a bad idea, and I would have no objection if somebody else
implemented it (which I guess that you do). I was mainly responding to
Brian's post about whether it is a reasonable idea; I think it is.

-Peff
