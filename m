From: Jeff King <peff@github.com>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Wed, 15 Jun 2011 20:48:03 -0400
Message-ID: <20110616004803.GD20355@sigill.intra.peff.net>
References: <20110608093648.GA19038@elte.hu>
 <201106141156.56320.johan@herland.net>
 <20110614171204.GC26764@sigill.intra.peff.net>
 <201106150145.12912.johan@herland.net>
 <20110615230033.GB19803@sigill.intra.peff.net>
 <7vips6ircc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 02:48:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QX0km-0004pG-Ut
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 02:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753991Ab1FPAsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 20:48:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43657
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329Ab1FPAsG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 20:48:06 -0400
Received: (qmail 8918 invoked by uid 107); 16 Jun 2011 00:48:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 15 Jun 2011 20:48:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Jun 2011 20:48:03 -0400
Content-Disposition: inline
In-Reply-To: <7vips6ircc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175878>

On Wed, Jun 15, 2011 at 04:53:55PM -0700, Junio C Hamano wrote:

> Jeff King <peff@github.com> writes:
> 
> > Given 1/2/3, you would look for tags in:
> >
> >   refs/remotes/1/tags/2/3
> >   refs/remotes/1/2/tags/3
> >
> > and then similarly heads in:
> >
> >   refs/remotes/1/heads/2/3
> >   refs/remotes/1/2/heads/3
> 
> > And then complain of ambiguity if they both match (which will almost
> > _never_ happen, unless you have a totally insane repo setup. So this is
> > really just about having well-defined rules just in case, and probably
> > won't affect most people in practice. In most cases, it will just DWYM).
> >
> > The "HEAD" thing remains simple. You check for:
> >
> >   refs/remotes/1/2/3/HEAD
> >
> > since HEAD is going to be at the top-level anyway.
> 
> Gaah, why is this even a good thing?

I do think it's slightly insane, but if we are going to have "foo/bar"
map into "refs/remotes/foo/heads/bar", then we have to start giving some
significance to the slash; a straight append won't work anymore. It may
be enough to say "the first slash always ends the part between "remotes"
and "heads" (i.e., remotes cannot have slashes).

> Yes, you demonstrated that it is _possible_ to define disambiguation
> rules, but do we currently allow (or horrors encourage) hierarchical
> remote nicknames, and do people rely on being able to do so?  What
> workflows benefit from such a confusing layout?
> 
> I am not fundamentally opposed to it, but just trying to tell between "we
> do so because we can" and "because we need to for such and such reasons".

My reasoning is that we don't disallow remote names with slashes, nor do
we disallow people putting arbitrarily nested refs into refs/remotes. So
in the name of compatibility, we should assume people are doing it and
not break them.

If we want to declare this illegal, I'm not too opposed. The only use
case I could think of is somebody who works with two different sets of
remotes, like "upstream" people and internal people. E.g., if I'm at
company "foo" working on linux internally, I might have a few remotes:

  origin: linus
  foo/alice: coworker alice's tree
  foo/bob: coworker bob's tree

And then I could ask questions that involve globbing on the refs like
"which commits are in my company but not published upstream?"
Something like:

  git log \
    `git for-each-ref --format='%(objectname)' refs/remotes/foo/*` \
    --not linus/master

I've never actually seen anything like this, though. That was just the
only useful example I could come up with.

-Peff
