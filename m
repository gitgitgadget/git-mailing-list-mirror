From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] builtin/push.c: make push_default a static variable
Date: Wed, 18 Feb 2015 14:25:18 -0500
Message-ID: <20150218192518.GA7891@peff.net>
References: <20150216054550.GA24611@peff.net>
 <20150216054754.GB25088@peff.net>
 <20150217104628.GA25978@peff.net>
 <xmqqsie4300s.fsf@gitster.dls.corp.google.com>
 <20150217182324.GA12816@peff.net>
 <xmqqzj8cyyip.fsf@gitster.dls.corp.google.com>
 <20150218185007.GA7257@peff.net>
 <xmqqh9uj2g25.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Olszewski <cxreg@pobox.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:25:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOAFR-0005sL-SE
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbbBRTZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:25:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:50659 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753472AbbBRTZU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 14:25:20 -0500
Received: (qmail 5064 invoked by uid 102); 18 Feb 2015 19:25:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 13:25:20 -0600
Received: (qmail 20141 invoked by uid 107); 18 Feb 2015 19:25:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 14:25:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2015 14:25:18 -0500
Content-Disposition: inline
In-Reply-To: <xmqqh9uj2g25.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264053>

On Wed, Feb 18, 2015 at 11:08:34AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> +	if (!strcmp(k, "push.followtags")) {
> >> +		if (git_config_bool(k, v))
> >> +			*flags |= TRANSPORT_PUSH_FOLLOW_TAGS;
> >> +		else
> >> +			*flags &= ~TRANSPORT_PUSH_FOLLOW_TAGS;
> >> +		return 0;
> >> +	}
> >
> > Did you have an opinion on sticking this behind a helper function?
> 
> Not very strongly either way.  Seeing the above does not bother me
> too much, but I do not know how I would feel when I start seeing
> 
> 	val = git_config_book(k, v);
> 	flip_bool(val, &flags, TRANSPORT_PUSH_FOLLOW_TAGS);
> 
> often.  Not having to make sure that the bit constant whose name
> tends to get long is not misspelled is certainly a plus.

I think it would be even nicer as:

  git_config_bits(k, v, &flags, TRANSPORT_PUSH_FOLLOW_TAGS);

There is a similar spot in the tar.*.remote config. And that could of
course build on a "flip_bool" or similar, which itself has many other
uses. But after taking a quick peek, I noticed that one call around
diff.c:3600 would look like:

  flip_bool(!negate, &opt->filter, bit);

IOW, it is the same pattern of conditional, but it flips the AND and OR,
because its flag is flipped. Reading that line makes me head hurt,
because we've really introduced an extra double-negative into the flow.

That "negate" flag is local to the loop we are in, and we could flip it
for clarity. But it makes me second-guess the technique.

-Peff
