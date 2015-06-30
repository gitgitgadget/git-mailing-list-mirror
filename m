From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 06:20:56 -0400
Message-ID: <20150630102055.GA11928@peff.net>
References: <20150625165341.GA21949@peff.net>
 <20150625165545.GC23503@peff.net>
 <20150629222247.GA31607@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 12:21:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9sf5-0006t6-LY
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 12:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbbF3KVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 06:21:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:53577 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750940AbbF3KVA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 06:21:00 -0400
Received: (qmail 14567 invoked by uid 102); 30 Jun 2015 10:21:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 05:21:00 -0500
Received: (qmail 11564 invoked by uid 107); 30 Jun 2015 10:21:02 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 06:21:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jun 2015 06:20:56 -0400
Content-Disposition: inline
In-Reply-To: <20150629222247.GA31607@flurp.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273040>

On Mon, Jun 29, 2015 at 06:22:47PM -0400, Eric Sunshine wrote:

> Clients of strbuf rightly expect the buffer to grow as needed in
> order to complete the requested operation. It is, therefore, both
> weird and expectation-breaking for strbuf_addftime() to lack this
> behavior. Worse, it doesn't even signal when the format has failed
> due to insufficient buffer space.

Agreed on all points.

> --- 8< ---
> void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm)
> {
> 	size_t len;
> 	struct strbuf f = STRBUF_INIT;
> 
> 	/*
> 	 * This is a bit tricky since strftime returns 0 if the result did not
> 	 * fit in the supplied buffer, as well as when the formatted time has
> 	 * zero length. In the former case, we need to grow the buffer and try
> 	 * again. To distinguish between the two cases, we supply strftime with
> 	 * a format string one character longer than what the client supplied,
> 	 * which ensures that a successful format will have non-zero length,
> 	 * and then drop the extra character from the formatted time before
> 	 * returning.
> 	 */
> 	strbuf_addf(&f, "%s ", fmt);

Basically I was trying to avoid making any assumptions about exactly how
strftime works. But presumably "stick a space in the format" is a
universally reasonable thing to do. It's a hack, but it's contained to
the function.

> 	do {
> 		strbuf_grow(sb, 128);
> 		len = strftime(sb->buf + sb->len, sb->alloc - sb->len,
> 			       f.buf, tm);
> 	} while (!len);

I think we need to keep growing this 128 ourselves, or else each loop
iteration will just say "yup, we have 128 bytes available; no need to
grow".


> [...]
> 
> If this is performance critical code, then the augmented format
> string can be constructed with less expensive functions than
> strbuf_addf().

This does get called a lot (e.g., once per commit). One extra allocation
would probably not kill us there, but I think we could fairly trivially
put this on the unlikely path:

  size_t hint = 128;
  size_t len;

  /* optimize out obvious 0-length case */
  if (!*fmt)
	return;

  strbuf_grow(sb, hint);
  len = strftime(sb->buf + sb->len, sb->alloc - sb->len, fmt, tm);

  /* maybe not enough room, or maybe 0-length output */
  if (!len) {
	struct strbuf f = STRBUF_INIT;
	strbuf_addf(&f, "%s ", fmt);
	while (!len) {
		hint *= 2;
		strbuf_grow(sb, hint);
		len = strftime(sb->buf + sb->len, sb->alloc - sb->len, f.buf, tm);
	}
  }

I'd guess most cases will fit in 128 bytes and never even hit this code
path. You could also get fancier and start the buffer smaller, but only
do the fmt hack when we cross a threshold.

-Peff
