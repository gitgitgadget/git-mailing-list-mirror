From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH 1/4] subtree: support split --rejoin --squash
Date: Thu, 23 Jan 2014 07:42:37 -0700
Message-ID: <20140123144237.GA2732@comcast.net>
References: <20131207185853.GA3353@comcast.net>
 <CAMzgWy18wH4_Ds00x7UASQjLgN8LiEucFSZFp-5PJio_pEwmnA@mail.gmail.com>
 <20140123035923.GA4176@comcast.net>
 <CAMzgWy3pfmESX1uvU2=nUtr1AdEVhtw-fXPwdtkNk4U6G4DCoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Penninckx <ibizapeanut@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 15:42:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6LUT-0000oI-Ds
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 15:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747AbaAWOml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 09:42:41 -0500
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:46444 "EHLO
	qmta02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751492AbaAWOmk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jan 2014 09:42:40 -0500
Received: from omta14.emeryville.ca.mail.comcast.net ([76.96.30.60])
	by qmta02.emeryville.ca.mail.comcast.net with comcast
	id HSZM1n0051HpZEsA2Sif7P; Thu, 23 Jan 2014 14:42:39 +0000
Received: from mmogilvi.dynu.net ([50.183.100.68])
	by omta14.emeryville.ca.mail.comcast.net with comcast
	id HSie1n0071UYGSS8aSiePF; Thu, 23 Jan 2014 14:42:39 +0000
Received: by mmogilvi.dynu.net (Postfix, from userid 501)
	id CCB591E96261; Thu, 23 Jan 2014 07:42:37 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <CAMzgWy3pfmESX1uvU2=nUtr1AdEVhtw-fXPwdtkNk4U6G4DCoA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
	s=q20121106; t=1390488159;
	bh=6an0D9J8ME/VSGbpV7lMRMd6gmkIwApRsz/HlCRgl/s=;
	h=Received:Received:Received:Date:From:To:Subject:Message-ID:
	 MIME-Version:Content-Type;
	b=RefQWaZC4EdKXRaFr9wXzqvCa84rIYe9ZiVrh2rNmSws5ls8m3d2PMDo8bETDe3iK
	 n6HqlwRgndUQtc+GCYMCkGxyf+mRq6vkMYNJlBcfUL7oylnrqpQAzPp6n+sBQqmViB
	 iBdyxKKmkDStQGaPlAjDms9skE957uzPYu7YYBcgJzTlPnEQfyA9R28xq6rfxFWRsv
	 XYVCCdTb6KPTY131j6BwkcHgybOfsDUXVsrHCC70+2qV/2p7tcEn9T5V9n0BhuNINF
	 nJCZyz8fAtfljwS3+OueYxNsgijUwMhoPSWRRIvGTHDzQN/OmkfABUvAxLRF8XdKiW
	 XBoA3zZ32usmg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240915>

On Thu, Jan 23, 2014 at 09:51:49AM +0100, Pierre Penninckx wrote:
> Hi again,
> 
> After using the patched git-subtree (with patches 1 to 3) for a while,
> I suspect the added functionality does not do exactly what I wanted.
> So yes, now when doing a rejoin, the squash of the split commits is
> used. But how can I push this squash instead of the individual
> commits? The problem is I don't know how to reference that squashed
> commit.
> 
> I tried adding the --branch option but it adds the branch to the top
> of the individual commits so no luck there.
> This is maybe obvious but I'm not at ease with commit references in git.

Note that there are essentially two trees output by subtree --join.

The first output is the main branch (with --join).  With my
patches and --squash, the main branch merges in a squashed
representation of the subtree changes, so that the main
project history doesn't have two copies of potentially
tons of different commits in it's history (the
original and the subtree, shown merged together).

The second output is the new branch tip of the subtree itself.
My patch always outputs the full history of the subtree, not
a squashed representation.  This is what's different from your
patch, and is what I wanted.  If you want this subtree output
to ALSO be squashed, then it would need another option to
support this.

Note that there is at least one technical reason to prefer my
strategy.  "git subtree" tries to make it so you can
re-run it (potentially from scratch) on the main project at
any point in time, and re-generate exactly the same final
subtree history, regardless of previous runs of "git subtree".
But if some of that history was originally squashed, it currently
has no way of knowing which commits should be squashed together
to properly regenerate exactly the same subtree history.
This is especially true if you use "--ignore-joins", which
is currently the only practical workaround to the bug described
in my patch 4 (about merging in history that originally branched
off before the previous subtree split point).  Perhaps this
issue could be addressed by enhancing subtree to recognize
specially-formatted squash messages, and intentionally
regenerate the squashed based on them?

[Side note: I think the convention on this list is to respond
inline or after the previous message, not at the top, so new
people can more easily pick up the discussion.]

                       - Matthew

> 2014/1/23 Matthew Ogilvie <mmogilvi_git@miniinfo.net>:
> > On Wed, Jan 22, 2014 at 03:58:28PM +0100, Pierre Penninckx wrote:
> >> 2013/12/7 Matthew Ogilvie <mmogilvi_git@miniinfo.net>
> >> > Subject: [PATCH 1/4] subtree: support split --rejoin --squash
> >> >
> >> > Allow using --squash with "git subtree split --rejoin".  It
> >> > will still split off (and save to --branch) the complete
> >> > subtree history, but the merge done for the "--rejoin" will
> >> > be merging a squashed representation of the new subtree
> >> > commits, instead of the commits themselves (similar to
> >> > how "git subtree merge --squash" works).
> >> >
> >> > Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
> >> > ---
> >> >
> >> > I can think of a couple of possible objections to this patch.
> >> > Are these (or any others) worth fixing?
> >> >
> >> > 1. Perhaps someone want the saved subtree (--branch) to have
> >> >    a squashed representation as well, as an option?  Maybe we
> >> >    need two different --squash options?  Something
> >> >    like "--rejoin-squash"?
> >> > 2. It could definitely use some automated tests.  In fact,
> >> >    pre-existing --squash functionality is hardly tested at
> >> >    all, either.
> >> >       See patch 4 comments for a script I use to help with
> >> >    mostly-manual testing.
> >>
> >> Sorry to bother you with this again, but I was wondering if those patches
> >> would be integrated into git anytime soon.
> >> And if not, if there is something I can do to help.
> >>
> >> I found them by the way, thanks a lot!
> >>
> >> Pierre
> >
> > I'm not sure when or if the patches will make it in.  Junio's
> > weekly "What's cooking..." email has asked for "Comments?" about
> > them for the past several weeks, but I have yet to see
> > anyone actually comment about them.
> >
> > Searching throught the last couple of years of mailing list
> > archives for "subtree" reveals a general lack of a active
> > maintainer(s) to help review and improve patches for "git
> > subtree".  Given the general lack of help and feedback, it is
> > understandable that Junio has largely limited inclusion of
> > subtree patches to trivially obvious bug fixes.
> >
> >                         - Matthew Ogilvie
