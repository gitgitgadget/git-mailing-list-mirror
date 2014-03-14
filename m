From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] diff: simplify cpp funcname regex
Date: Thu, 13 Mar 2014 23:54:57 -0400
Message-ID: <20140314035457.GA31906@sigill.intra.peff.net>
References: <20140305003639.GA9474@sigill.intra.peff.net>
 <5316D922.9010501@viscovery.net>
 <20140306212835.GA11743@sigill.intra.peff.net>
 <531973D9.9070803@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 04:55:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOJD8-0006YN-WE
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 04:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbaCNDzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 23:55:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:39210 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754801AbaCNDy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 23:54:59 -0400
Received: (qmail 31462 invoked by uid 102); 14 Mar 2014 03:54:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Mar 2014 22:54:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Mar 2014 23:54:57 -0400
Content-Disposition: inline
In-Reply-To: <531973D9.9070803@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244071>

On Fri, Mar 07, 2014 at 08:23:05AM +0100, Johannes Sixt wrote:

> No, I meant lines like
> 
>     static double var;
>    -static int old;
>    +static int new;
> 
> The motivation is to show hints where in a file the change is located:
> Anything that could be of significance for the author should be picked up.

I see. Coupled with what you said below:

> As I said, my motivation is not so much to find a "container", but rather
> a clue to help locate a change while reading the patch text. I can speak
> for myself, but I have no idea what is more important for the majority.

your proposal makes a lot more sense to me, and I think that is really
at the center of our discussion. I do not have a gut feeling for which
is "more right" (i.e., "container" versus "context").

But given that most of the cases we are discussing are ones where the
"diff -p" default regex gets it right (or at least better than) compared
to the C regex, I am tempted to say that we should be erring in the
direction of simplicity, and just finding interesting lines without
worrying about containers (i.e., it argues for your patch).

> > Makes sense. I noticed your fix is to look for end-of-line or comments
> > afterwards.  Would it be simpler to just check for a non-colon, like:
> > 
> >   !^[ \t]*[A-Za-z_][A-Za-z_0-9]*:($|[^:])
> 
> I want to match [[:space:]] after the label's colon, because I have lot's
> of C++ files with CRLF, and I need to match the CR. Your more liberal
> pattern would fit as well, although it would pick up a bit field as in
> 
>    struct foo {
>       unsigned
>         flag: 1;
>    -old
>    +new

Thanks, I was having trouble thinking of another good use of a colon,
but bitfields are what I was missing. Your pattern is probably better
here.

So I am leaning towards your patch, but I'm not sure if I understand all
of the implications for "git grep". Can you give some concrete examples?

-Peff
