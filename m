From: Jeff King <peff@peff.net>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 7 Feb 2011 00:18:34 -0500
Message-ID: <20110207051834.GB4748@sigill.intra.peff.net>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <20110201181428.GA6579@sigill.intra.peff.net>
 <AANLkTimtU56BAnWU-2pY1npdkPdKEBq_CMCGwXUK+E=H@mail.gmail.com>
 <201102020322.00171.johan@herland.net>
 <7vpqr7xw4z.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102051330270.12104@xanadu.home>
 <20110205193708.GA2192@sigill.intra.peff.net>
 <alpine.LFD.2.00.1102051449420.12104@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 06:18:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmJUp-0000W4-6P
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 06:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471Ab1BGFSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 00:18:38 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:34213 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751264Ab1BGFSh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 00:18:37 -0500
Received: (qmail 25284 invoked by uid 111); 7 Feb 2011 05:18:36 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 07 Feb 2011 05:18:36 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Feb 2011 00:18:34 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1102051449420.12104@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166230>

On Sat, Feb 05, 2011 at 02:55:06PM -0500, Nicolas Pitre wrote:

> > The latter seems like a regression for the common case of fetching from
> > two upstreams. E.g., I usually pull from Junio, getting
> > remotes/origin/v1.7.0.  One day Shawn is the interim maintainer, and I
> > pull from him, getting remotes/spearce/v1.7.0, which he previously
> > fetched from Junio. Under the current code, I can still do "git show
> > v1.7.0"; under the scheme described above I now have to say
> > "origin/v1.7.0" to disambiguate.
> 
> Let's suppose that both tags are identical, as in your scenario above 
> they would be, then there is no need to call for any ambiguity in that 
> case.

Agreed, but...

> > The real issue, I think, is that we are claiming ambiguity even though
> > those tags almost certainly point to the same sha1. When handling
> > ambiguous tags, should we perhaps check to see if all of the ambiguities
> > point to the same sha1, and in that case, just pick one at random?
> 
> If they're identical then there is no randomness.  If they refer to 
> different tag objects, even if those tag objects do refer to the same 
> commit object, then I'd say there is an ambiguity only if the tag object 
> content matters i.e. when displaying the tag content.

My gut feeling is that they should point to the same tag object, for the
sake of simplicity (if you are re-tagging a commit under the same name,
wouldn't I want to know?) and efficiency (we can detect non-ambiguity
just by looking at the sha1 values without opening objects).

But more importantly, don't we sometimes care where the ref came from?
If I say "git push remote v1.7.4" we do some automagic on the
destination side of the refspec based on the fact that the source ref
was found in the refs/tags hierarchy. In the case we're talking about,
all of the ambiguous refs would presumably also be coming from
refs/remotes/*/tags/, so they would be functionally equivalent. But I
wanted to point it out because:

  1. It is an additional equivalent requirement for two refs to not be
     ambiguous. They must have the same sha1, _and_ they must have the
     same "type".

  2. I couldn't think of any other cases where the actual refname might
     matter and this would break. But I wanted to bring it up explicitly
     in case somebody else can think of one.

-Peff
