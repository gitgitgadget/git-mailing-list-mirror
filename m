From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 22:47:48 -0400
Message-ID: <20071019024748.GB14735@spearce.org>
References: <20071019004527.GA12930@spearce.org> <20071019021255.GD3290@coredump.intra.peff.net> <20071019022154.GY14735@spearce.org> <20071019023425.GB8298@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 04:48:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IihuD-0003hj-RD
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 04:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760060AbXJSCr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 22:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758210AbXJSCr5
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 22:47:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43842 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758170AbXJSCr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 22:47:56 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iihte-0000bq-D6; Thu, 18 Oct 2007 22:47:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5088520FBAE; Thu, 18 Oct 2007 22:47:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071019023425.GB8298@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61615>

Jeff King <peff@peff.net> wrote:
> On Thu, Oct 18, 2007 at 10:21:54PM -0400, Shawn O. Pearce wrote:
> 
> > My eyes have gotten used to "Deltifying" but I have to admit that
> > in my early Git days I thought it looked damn odd.  Today I'm far
> > too familiar with Git to really notice this as a problem now.
> 
> OK, I will confess I found it a little odd at first, but I think it's a
> straightforward and playful extension of the language, which is
> something I like. But you know, we have the corporate git customers to
> think about these days. ;)

Heh.  Yeah, Git is gaining users on a daily basis.  Its good.  :)
 
> On a similar note, some complaints with progress meters, even after
> recent patches:
> 
>   - When fetching, one progress meter says "Indexing" which, while
>     technically true, is almost certainly blocking on "Downloading". In
>     fact, it is not clear from the existing messages exactly _when_ we
>     are downloading, and when we are just computing, which is something
>     I think a user might want to know. Objections to changing this
>     (though perhaps index-pack will need to be told when it is
>     downloading and when it is just indexing)? Objections to a
>     throughput indicator?

Yes!  I agree entirely.  This is actually not very difficult.

I think the only time we run `git-index-pack --stdin` is from within
git-fetch-pack and git-receive-pack.  These are the only two points
where index-pack's stdin is attached to a network socket and not
to a file.  Its also where you'd want this to say "Transferring",
"Uploading" or "Downloading".

Really the important one to change here is probably the call in
fetch-pack.c as that is the most visible and most time consuming
operation for the average user (think git-clone on a large project).

The same change probably should also be made for unpack-objects as
fetch-pack/receive-pack may have chosen to use that if the object
count is low and it wasn't instructed to keep the packfile.

>   - Running git-gc, we now get something like:
>       Counting objects: 62317, done.
>       Deltifying objects: 100% (18042/18042), done.
>       Writing objects: 100% (62317/62317), done.
>       Total 62317 (delta 43861), reused 61404 (delta 43036)
>       Pack pack-32f8ac40c1a5ec146e45c657cb16f53fdd354095 created.
>       Removing unused objects 100%...
>       Done.
>     Can we get rid of total statistics (I think this is useful for some
>     power users, but perhaps there should be a verbosity level), the
>     name of the pack file (same deal), and the totally useless "Done."?

Yea.  I keep forgetting to write a patch to do this.  I've had much
the same thought as you.

The verbosity should probably be controlled like merge-recursive's
is, but should default to not showing the "Total" line or the "Pack
.. created" line.  For the average user there isn't any valuable
information in either line.

I also think that the progress meter of git-prune-packed should be
fixed to use the standard progress meter system.  And maybe also
be delayed so it doesn't trip if its going to be very quick.

-- 
Shawn.
