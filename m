From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] abbrev_sha1_in_line: don't leak memory
Date: Wed, 30 Mar 2016 13:21:58 -0400
Message-ID: <20160330172157.GA19675@sigill.intra.peff.net>
References: <1459298333-21899-1-git-send-email-sbeller@google.com>
 <1459298333-21899-5-git-send-email-sbeller@google.com>
 <20160330011111.GB2237@sigill.intra.peff.net>
 <CAPig+cR=Zc2QAQTPAqTt4M-nJRw4StCoqT2hYtmHOvi6LseN_A@mail.gmail.com>
 <20160330013127.GA6680@sigill.intra.peff.net>
 <xmqqzitfuc7y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:22:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJol-0008Ow-ET
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962AbcC3RWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:22:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:40967 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752606AbcC3RWC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:22:02 -0400
Received: (qmail 10491 invoked by uid 102); 30 Mar 2016 17:22:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 13:22:00 -0400
Received: (qmail 4665 invoked by uid 107); 30 Mar 2016 17:22:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 30 Mar 2016 13:22:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Mar 2016 13:21:58 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzitfuc7y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290323>

On Wed, Mar 30, 2016 at 10:06:41AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Mar 29, 2016 at 09:30:38PM -0400, Eric Sunshine wrote:
> >
> >> The implementation of strbuf_list_free() is this:
> >> 
> >>     struct strbuf **s = sbs;
> >>     while (*s) {
> >>         strbuf_release(*s);
> >>         free(*s++);
> >>     }
> >>     free(sbs);
> >> 
> >> which means that wt-status.c is leaking not only 'split', but also
> >> each element of split[], right?
> >
> > Yeah, I didn't notice that, but I think you're right.
> 
> Correct.
> 
> I suspect that we would be better off in the longer term if
> we made conscious effort to deprecate and eradicate the use
> of strbuf_split* API functions.  They are easy to write
> crappy code with, inefficient, and error prone.  You would
> rarely need to have N resulting pieces as strbufs to be
> easily manipulatable [*1*].

Yeah, I agree that it is a clunky interface, and I would be happy to see
it go away. Many callers would be better off with string_list_split().
When I've looked in the past, though, converting some of the callers was
somewhat non-trivial.

But in this case...

> The function can be written by not using the "split and then
> rebuild" pattern, perhaps like so, and the result is even
> easier to read and understand, I would say.  A sample rewrite
> is attached at the end.

I agree that the function is much simpler without it.

> +	/* find the second token on the line */
> +	cp = strchr(line->buf, ' ');
> +	if (!cp)
> +		return;
> +	cp++;
> +	ep = strchr(cp, ' ');
> +	if (!ep)
> +		return;

Would we ever see "cmd sha1" without a third token? If so, we'd want:

  ep = strchrnul(cp, ' ');

-Peff
