From: Jeff King <peff@peff.net>
Subject: Re: bug? in checkout with ambiguous refnames
Date: Sat, 8 Jan 2011 16:40:11 -0500
Message-ID: <20110108214011.GA4753@sigill.intra.peff.net>
References: <20110107104650.GA5399@pengutronix.de>
 <20110107194909.GB6175@sigill.intra.peff.net>
 <alpine.DEB.1.10.1101081449220.12031@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 22:40:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbgWN-0000Cg-Vk
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 22:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872Ab1AHVkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 16:40:17 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37783 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab1AHVkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 16:40:16 -0500
Received: (qmail 30743 invoked by uid 111); 8 Jan 2011 21:40:13 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 08 Jan 2011 21:40:13 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Jan 2011 16:40:11 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.1101081449220.12031@debian>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164841>

On Sat, Jan 08, 2011 at 03:40:33PM -0500, Martin von Zweigbergk wrote:

> > Yeah, we generally resolve ambiguities in favor of the tag (and that
> > warning comes from deep within get_sha1_basic). So the real bug here is
> > that it still said "Switched to branch", which is totally wrong.
> > 
> > That being said, it probably would make more sense for "git checkout" to
> > prefer branches to tags.
> 
> What was the rationale for generally favoring tags?

I don't recall hearing any specific argument, but it has always been
that way from early on. I think it is from a vague sense of "tags are
more important than branch tips because they are about marking specific
points, not lines of development". But maybe other old-timers can say
more.

I don't necessarily buy that argument; my only reasoning is that we
should probably keep historic behavior.

> Why does that reasoning not apply to 'git checkout' too?

Because checkout has always been fundamentally about branches. It did
end up growing sane behavior for "git checkout tag" (i.e., a detached
HEAD), but branches are still the fundamental unit for most of its
arguments.

> Btw, what exactly does "generally" mean, i.e. which other commands
> don't favor tags? I know rebase is one example of a command that does
> not favor tags.

It means "we favor tags in resolve_ref, which is the underlying
machinery for most commands, so unless a command special-cases it, that
will be the behavior, and I am too lazy to exhaustively search for such
special cases".

> Slightly off topic, but why does 'git rev-parse --symbolic-full-name'
> not output anything when the input is ambiguous? 'git rev-parse'
> without any flags favors tags, so I would have expected to get
> something like refs/tags/$name back.

I dunno. I never tried it, but I would have expected to get the tag-name
back.

> The reason I'm asking is because I just happened to see in the rebase
> code the other day that it will rebase a detached head if the <branch>
> parameter is not "completely unqualified". For example 'git rebase
> master heads/topic' or 'git rebase master refs/heads/topic' will not
> update refs/heads/topic. I was trying to fix that by using 'git
> rev-parse --symbolic-full-name' to parse <branch>. That seemed to work
> fine until I saw this thread :-).

Heh. I think that would be an argument in favor of changing rev-parse's
behavior.

-Peff
