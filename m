From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] push to mirrior interferes with parallel operations
Date: Thu, 18 Nov 2010 14:04:15 -0500
Message-ID: <20101118190414.GA30438@sigill.intra.peff.net>
References: <e355bb33c6192a6a29de56c7be93278e.squirrel@artax.karlin.mff.cuni.cz>
 <20101118175007.GA26505@sigill.intra.peff.net>
 <20101118184241.GN3693@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Nov 18 20:04:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ9mT-0002iK-KW
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 20:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757504Ab0KRTEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 14:04:21 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:54803 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753602Ab0KRTEU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 14:04:20 -0500
Received: (qmail 18219 invoked by uid 111); 18 Nov 2010 19:04:19 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 18 Nov 2010 19:04:19 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Nov 2010 14:04:15 -0500
Content-Disposition: inline
In-Reply-To: <20101118184241.GN3693@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161706>

On Thu, Nov 18, 2010 at 07:42:41PM +0100, Jan Hudec wrote:

> The above config is what is created by default by 'git remote add --mirror'.
> So I expect the problem to be somewhat common with mirror and a lot rarer
> without.

Agreed, and I think just turning off the behavior with "mirror" might be
OK in practice. But I do want to consider whether we can make other
corner cases more sensible at the same time.

> Which brings the yet another question, namely whether it actually makes sense
> to set the fetch for a mirror remote. Note that any call to fetch will almost
> inevitably abort with "reusing to pull to checked out ref in non-bare
> repository" error.

Hmm. Yeah, of the "fetch vs push mirror" distinction I made earlier, it
really only makes sense to push from a non-bare repo, and to fetch into
a bare repo.

> [skip some thoughtful analysis which I agree with, but I think ends up
>  not being relevant]
>
> In fact the problem is not in the race, but in the fact, that push updates
> refs, that may have other purpose than tracking the particular remote. The
> problem is in some cases we don't know whether a ref is purely tracking
> *that* remote or not.

Yeah, you're right. I think the real problem is that we generally assume
that by putting something on the RHS of a fetch refspec, it is used just
for tracking the particular remote (especially when there is a "+" on
the front!).

So the real solution is not having that fetch line.

> and the third option (similar to the first, but done at different point):
> 
>  3. Don't set 'fetch' for mirror remotes in non-bare repositories, since
>     non-bare repositories can't be treated as mirrors of something.

Of all the options, this is my favorite. It does what we want in the
common cases, it's simple, and it still allows people to hand-config
crazy stuff if they want to.

It doesn't un-break people's existing repos, but I think we can accept
that (actually, the docs say that --mirror only makes sense in bare
repositories. Which I think is not true, as you demonstrate, but perhaps
it dissuaded people from creating broken push mirrors in the past :) ).

That does still leave one slight corner case, which is a bare repo that
is used for both fetch and push mirrors. E.g., a repo that straddles the
border between two networks might do:

  git init --bare
  git remote add --mirror network1 host.network1:foo.git
  git remote add --mirror network2 host.network2:foo.git

  git fetch network1
  git push network2

to relay commits. Both remotes will have the fetch refspec, as they are
in a bare repo. But only the first one wants it. In the second one, we
will update the heads as tracking refs. A simultaneous fetch/push would
be in conflict.

That is such an unlikely case that we can probably just leave it to be
hand-configured by anybody who really wants it. Or we can have:

  # adds fetch = refs/*:refs/*
  git remote add --mirror=fetch network1 host.network1:foo.git
  # adds push = refs/*:refs/*
  git remote add --mirror=push network2 host.network2:foo.git

and the default for --mirror (with no type) can be "fetch" in a bare repo
and "push" in a non-bare one.

-Peff
