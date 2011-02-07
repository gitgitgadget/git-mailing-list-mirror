From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 7 Feb 2011 15:19:13 -0500
Message-ID: <20110207201912.GB13461@sigill.intra.peff.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102070451.37370.johan@herland.net>
 <20110207051123.GA4748@sigill.intra.peff.net>
 <201102070958.11551.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 21:19:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmXYQ-0002nG-TF
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 21:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752839Ab1BGUTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 15:19:18 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52743 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563Ab1BGUTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 15:19:17 -0500
Received: (qmail 29849 invoked by uid 111); 7 Feb 2011 20:19:16 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Feb 2011 20:19:16 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Feb 2011 15:19:13 -0500
Content-Disposition: inline
In-Reply-To: <201102070958.11551.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166277>

On Mon, Feb 07, 2011 at 09:58:11AM +0100, Johan Herland wrote:

> > No, that won't give you me/shawn/junio/v1.7.4, but it does mean we have
> > to gracefully handle the case of ambiguous duplicate tags (that happen
> > to point to the same thing).
> 
> Whoa, we use the "ambiguous" term differently here. In this whole thread I 
> have used "ambiguous" exclusively about when the same (shorthand) tag name 
> point to _different_ things. As long as they point to the same thing, there 
> is no ambiguity, IMHO.

Sorry, I should have been more clear. I meant "ambiguous by the current
code's definition", meaning "we would still need to use your new
ambiguity definition to resolve this situation".

IOW, I think we are on the same page.

> This is the same technique we use when talking about branch names: On this 
> mailing list, nobody is confused when I refer to 'maint', 'master', 'next' 
> and 'pu'. Still, in our own work repos (at least in mine), these branches 
> are actually called "refs/remotes/origin/<name>" (commonly referred to by 
> their shorthands "origin/<name>"). Here we are, juggling the same kind of 
> namespaces that I propose for tags, and it seems to work well without 
> causing much confusion.

Just playing devil's advocate for a moment: isn't this namespace
distinction one of the more confusing things in git for new users? That
is, I have seen new-ish git users say "OK, so I cloned from upstream.
How come I can't say "git log maint" now?" Or it used to be "how come I
can't "git checkout maint" now?" The latter is now handled by some very
specific magic in "git checkout", but in general ref lookup does not
automagically look in remotes namespaces, and it has caused some
confusion.

So here we are introducing more distinction between project-wide names
and per-remote names. I absolutely think it's the right thing to do from
a "keep it simple, orthogonal, and distributed" perspective. But we also
need to recognize we are making some common use cases more confusing. In
the case of remote-tracking branches, we ended up adding some porcelain
features to make common actions (like checking out a local branch from a
remote) more seamless. But there is still some confusion among new
users.

I'm sort of rambling as I'm not quite sure yet what this means for the
tags proposal, but a few questions I think are important to consider
are:

  1. Where have we succeeded and where have we failed with making
     separate-remotes / tracking branches seamless to the user (as
     opposed to something like a system where
     fetching from upstream fetches straight into your master branch
     (which has its own problems, but would be conceptually very
     simple)? Do those failures apply in this case, and if so how can we
     do better?

  2. Can we apply new ideas for handling separate-remote tags to the
     branches case? Obviously one big proposal is searching in the
     per-remote tag namespace for refs. Should we be doing the same with
     heads?

-Peff
