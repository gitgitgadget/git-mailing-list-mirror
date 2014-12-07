From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] doc: document error handling functions and
 conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a
 strbuf)
Date: Sun, 7 Dec 2014 05:07:55 -0500
Message-ID: <20141207100755.GB22230@peff.net>
References: <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
 <20141204030133.GA16345@google.com>
 <xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>
 <20141204234147.GF16345@google.com>
 <20141204234432.GA29953@peff.net>
 <CAPc5daW3+8xjG3z3WgOMfqzWJUiPdcN1-FVgVc0fAjH7tgCa4A@mail.gmail.com>
 <20141205000128.GA30048@peff.net>
 <xmqqfvcuq8nu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 07 11:08:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxYkz-0004Bv-OZ
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 11:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbaLGKH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2014 05:07:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:49598 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752903AbaLGKH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2014 05:07:56 -0500
Received: (qmail 13022 invoked by uid 102); 7 Dec 2014 10:07:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Dec 2014 04:07:57 -0600
Received: (qmail 16023 invoked by uid 107); 7 Dec 2014 10:07:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Dec 2014 05:07:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Dec 2014 05:07:55 -0500
Content-Disposition: inline
In-Reply-To: <xmqqfvcuq8nu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260983>

On Fri, Dec 05, 2014 at 10:00:05AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The only downside I can think of is that we may truncate the message in
> > exceptional circumstances. But is it really any less helpful to say:
> >
> >   error: unable to open file: some-incredibly-long-filename-aaaaaa...
> >
> > than printing out an extra 100 lines of "a"? And I mean the "..."
> > literally. I think mkerror() should indicate the truncation with a
> > "...", just so that it is clear to the user. It should almost never
> > happen, but when it does, it can be helpful to show the user that yes,
> > we know we are truncating the message, and it is not that git truncated
> > your filename during the operation.
> >
> > Is this truncation really a concern, and/or is there some other downside
> > I'm not thinking of?
> 
> I am more worried about variable length part pushing the information
> that is given later out to the right, e.g. "error: missing file '%s'
> prevents us from doing X".  Chomping to [1024] is not a good
> strategy for that kind of message; abbreviating %s to /path/name/...
> (again, with literally "...") would be.

True. Unfortunately I do not think there is an easy way to truncate the
expanded strings used by placeholders. The two approaches I could think
of are:

  1. Loop over the va_list and tweak any pointers we find. Except that
     loop means we actually need to loop over the _format string_, since
     that is the only thing which tells us which placeholders are strings.
     But I am not even sure there is a portable way to munge a va_list,
     as opposed to just reading it.

  2. Transparently rewrite '%s' in the format string to '%.128s' or
     similar. This also requires iterating over the format string, but
     it's fairly straightforward. Code is below, but it's not _quite_
     right. We would want to conditionally add "..." based on whether or
     not the particular item was truncated. But we cannot know when
     munging the format string if that will happen or not (we know
     _something_ will be truncated, but not which string).

I don't think you can do it right without reimplementing vsnprintf
yourself. Which is obviously a terrible idea.

I still think truncation is going to be a non-issue in practice, and I'd
rather deal with that potential fallout than have to deal with memory
management in every error handler that uses this technique. But I don't
have much more to say on the matter, so if you disagree, I guess that's
that.

Unless we can do something clever with a set of global error strbufs or
something (i.e., that expand as needed, but the caller does not have to
free themselves, as they will get recycled eventually). That has its own
corner cases, though.

Anyway, the truncating-fmt code is below, for fun.

-Peff

static int abbrev_fmt(char *buf, int len, int abbrev, const char *fmt, va_list ap)
{
	va_list cp;
	int got;

	va_copy(cp, ap);
	got = vsnprintf(buf, len, fmt, ap);
	if (got >= len) {
		struct strbuf munged = STRBUF_INIT;

		while (*fmt) {
			char ch = *fmt++;
			strbuf_addch(&munged, ch);
			if (ch == '%') {
				if (*fmt == 's') {
					strbuf_addf(&munged, ".%ds...", abbrev);
					fmt++;
				} else /* skips past %%-quoting */
					strbuf_addch(&munged, *fmt);
			}
		}

		got = vsnprintf(buf, len, munged.buf, cp);
		strbuf_release(&munged);
	}
	return got;
}
