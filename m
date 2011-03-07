From: Jeff King <peff@peff.net>
Subject: Re: Fwd: [PATCH 2/2] pretty.c: allow date formats in user format
 strings
Date: Mon, 7 Mar 2011 11:17:58 -0500
Message-ID: <20110307161758.GB11934@sigill.intra.peff.net>
References: <20110305195020.GA3089@sigill.intra.peff.net>
 <20110305200010.GB32095@sigill.intra.peff.net>
 <AANLkTinH8zwX2sbd5bpk=x4R3zOAg3Dc92Fbspfdv03T@mail.gmail.com>
 <AANLkTikaN=wsg6RLFaFxh=L3RCYjKkVGFR4VTrQ=KRZk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 07 17:18:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pwd8T-0002H7-SM
	for gcvg-git-2@lo.gmane.org; Mon, 07 Mar 2011 17:18:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754665Ab1CGQSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Mar 2011 11:18:05 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40044 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754495Ab1CGQSD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Mar 2011 11:18:03 -0500
Received: (qmail 5347 invoked by uid 111); 7 Mar 2011 16:18:01 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Mar 2011 16:18:01 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Mar 2011 11:17:58 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikaN=wsg6RLFaFxh=L3RCYjKkVGFR4VTrQ=KRZk@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168594>

On Sun, Mar 06, 2011 at 09:54:01PM +0000, Will Palmer wrote:

> On Sat, Mar 5, 2011 at 8:00 PM, Jeff King <peff@peff.net> wrote:
> > You can now do "%ad(short)" or similar (using any format
> > that works for --date). This makes some formats like %aD
> > redundant (since you can do "%ad(rfc)"), but of course we
> > keep them for compatibility.
> >
> 
> The more I see long formats like this, the more I think it would make
> sense to make formats %(likeThis), the way for-each-ref does.
> Ideally, these formats could even be unified, at some point.

Yeah, I totally agree. One problem is that everytime an extended format
comes up it gets bikeshedded to death as everybody mentions their
favorite format and/or feature, and then nobody codes it.

> I tried this a long while ago, as part of my attempt to make all
> pre-defined formats work in terms of format strings, but that turned
> into too much of a bloated mess to bother submitting. I don't know
> if there's enough interest in such a thing to justify trying again (or to
> justify rebasing the bloated version, cleaning it up and submitting it
> as-is, for that matter)

I think there is interest. I'd be curious to see what you have. A few
days ago, when working on this series, I tried to make a
minimally-invasive change to allow "%(ad)" to work alongside "%ad", with
a generic arguments format like %(ad:flag:key=value). Which would allow
existing shorthand, for-each-ref-style %(refname:short), and leave room
for arbitrary extension of each placeholder (alongside more
human-readable placeholder names).

The problem I ran into was the internal code interface. We parse the
format string each time we expand it. This works OK for simple
printf-like stuff. But ideally we can handle something like:

  %(ad:key=embedded\:colon:key2=embedded\)paren)

It's hard to make a nice interface to that which doesn't involve copying
the quoted string out into a non-quoted version. But we don't want to be
doing a bunch of parsing and allocation per-expansion. It's slow, and
this expansion happens inside a fairly tight loop in many cases (e.g.,
during rev-list).

So I think the whole thing needs to be factored into two phases: a
parsing phase where we build some internal parse tree, and then an
expansion phase where we walk the parse tree for each commit (or ref, or
whatever is being expanded).

> Point is: we're going to keep having more and more format options,
> I think that's a given. At some point, these short mnemonics will just
> stop making sense, and it makes sense to have an escape plan when
> that happens.

Agreed. And I think it is possible to do it in a backwards-compatible
way; support %(longname:options) for everything, and keep short-hands
like %h and %ad for existing elements without options.

-Peff
