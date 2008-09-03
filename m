From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 3 Sep 2008 12:49:43 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0809031234560.19665@iabervon.org>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> <200809022339.20123.johan@herland.net> <20080902214428.GA20355@sigill.intra.peff.net> <200809030945.08619.johan@herland.net> <20080903131507.GC12936@coredump.intra.peff.net>
 <20080903133446.GA6967@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 03 18:51:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KavZE-0005P7-GJ
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 18:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048AbYICQtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 12:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbYICQtq
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 12:49:46 -0400
Received: from iabervon.org ([66.92.72.58]:53824 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbYICQtq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 12:49:46 -0400
Received: (qmail 26796 invoked by uid 1000); 3 Sep 2008 16:49:43 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Sep 2008 16:49:43 -0000
In-Reply-To: <20080903133446.GA6967@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94812>

On Wed, 3 Sep 2008, Jeff King wrote:

> On Wed, Sep 03, 2008 at 09:15:07AM -0400, Jeff King wrote:
> 
> > Hrm. I thought we decided on a message like:
> > 
> >   Previous HEAD position was 1234abcd
> > 
> > when leaving the detached HEAD state, but it seems to have disappeared.
> > Maybe with the move to builtin-checkout (sorry, I don't have time to
> > bisect right at this second). Was that intentional?
> 
> OK, I lied. I did have time to bisect it.
> 
> It never worked in builtin-checkout, and I am a bit suspicious of the
> code (and comment) below. Why would we not want to show such a message
> if moving to a branch (as long as it is not a _new_ branch)? The patch
> below makes more sense to me.

Good point. I think I confused myself with the new branch case. On the 
other hand, I think the "not starting a new branch" case should go as 
well. If you've got a detached HEAD, and you do:

$ git checkout -b foo origin/master

we probably ought to describe the old state. The reason that starting a 
new branch usually shouldn't give the message is that new->commit == 
old.commit (assuming that the defaults have gotten filled in by this 
point, which they should have).

(I think I included the new branch case to match the existing branch case; 
I'm not sure where I got the idea that switching to a branch shouldn't 
give the message. Hey, at least the comment makes it clear that I was 
actually trying to write the wrong code...)

Actually, the test for HEAD should be able to go, also, since checking out 
HEAD wouldn't change the current commit, although this doesn't matter to 
anything other than the complexity of the condition.

> 
> ---
> diff --git a/builtin-checkout.c b/builtin-checkout.c
> index b380ad6..b2c7d3c 100644
> --- a/builtin-checkout.c
> +++ b/builtin-checkout.c
> @@ -386,12 +386,12 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
>  	}
>  
>  	/*
> -	 * If the new thing isn't a branch and isn't HEAD and we're
> +	 * If the new thing isn't isn't HEAD and we're
>  	 * not starting a new branch, and we want messages, and we
>  	 * weren't on a branch, and we're moving to a new commit,
>  	 * describe the old commit.
>  	 */
> -	if (!new->path && strcmp(new->name, "HEAD") && !opts->new_branch &&
> +	if (strcmp(new->name, "HEAD") && !opts->new_branch &&
>  	    !opts->quiet && !old.path && new->commit != old.commit)
>  		describe_detached_head("Previous HEAD position was", old.commit);
>  
> 
