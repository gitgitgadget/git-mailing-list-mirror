From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/17] Clean up how fetch_pack() handles the heads list
Date: Thu, 23 Aug 2012 15:56:48 -0400
Message-ID: <20120823195648.GB15268@sigill.intra.peff.net>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
 <20120823092624.GG6963@sigill.intra.peff.net>
 <49DEA56853C64B9B900D3C7F886D4FA6@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: mhagger@alum.mit.edu, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 21:57:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4dWV-0008TV-6e
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 21:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561Ab2HWT4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 15:56:52 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46485 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab2HWT4v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 15:56:51 -0400
Received: (qmail 23966 invoked by uid 107); 23 Aug 2012 19:57:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Aug 2012 15:57:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2012 15:56:48 -0400
Content-Disposition: inline
In-Reply-To: <49DEA56853C64B9B900D3C7F886D4FA6@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204167>

On Thu, Aug 23, 2012 at 08:13:29PM +0100, Philip Oakley wrote:

> >>I'm still suspicious about the logic related to args.fetch_all and
> >>args.depth, but I don't think I've made anything worse.
> >
> >I think the point of that is that when doing "git fetch-pack --all
> >--depth=1", the meaning of "--all" is changed from "all refs" to
> >"everything but tags".
> >
> 
> There is a comment in \git\Documentation\technical\shallow.txt that
> "- If you deepen a history, you'd want to get the tags of the
>  newly stored (but older!) commits. This does not work right now."
> which may be the source of this restriction. That is, how is the depth
> of the tag fetching to be restricted to the requested depth count?
> [assuming I've undestood the problem correctly]

I don't think this is about deepening, but rather about making sure we
remain shallow for the initial fetch. Remember that this is on the
"fetch-pack --all" code path, which used to be used by "git clone" when
it was a shell script (these days, clone is a C builtin and will
actually feed the list of refs to fetch-pack).

This code blames back to:

 commit 4bcb310c2539b66d535e87508d1b7a90fe29c083
 Author: Alexandre Julliard <julliard@winehq.org>
 Date:   Fri Nov 24 16:00:13 2006 +0100

    fetch-pack: Do not fetch tags for shallow clones.

    A better fix may be to only fetch tags that point to commits that we
    are downloading, but git-clone doesn't have support for following
    tags. This will happen automatically on the next git-fetch though.

So it is about making sure that "git clone --depth=1" does not
accidentally pull a single commit from v1.0, v1.1, v1.2, and so forth,
losing the purpose of using --depth in the first place. These days it is
largely irrelevant, since this code path is not followed by clone, and
clone will automatically restrict its list of fetched refs to a single
branch if --depth is used.

The bug that shallow.txt talks about (and which is mentioned in that
commit message) is that we will not properly auto-follow tags during
such a clone (i.e., when we fetch a tag because it is pointing to a
commit that we already have or are already pulling). I'm not sure if
that is still the case or not. But assuming your workflow is something
like:

  [make an initial, cheap clone]
  git clone --depth=1 $repo

  [the next day, you do a regular fetch, which will just get new stuff
   on top of what you already have]
  git fetch

Then that second fetch will auto-follow the tags, anyway. And that is
what the commit message is pointing: it's a bug, but one you can work
around.

> It may be (?) that it is a good time to think about a 'datedepth'
> capability to bypass the current counted-depth shallow fetch that can
> cause so much trouble. With a date limited depth the relevant tags
> could also be fetched.

I don't have anything against such an idea, but I think it is orthogonal
to the issue being discussed here.

-Peff
