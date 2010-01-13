From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] strbuf: add strbuf_percentquote_buf
Date: Wed, 13 Jan 2010 12:06:36 -0500
Message-ID: <20100113170636.GA21318@coredump.intra.peff.net>
References: <20100112153656.GA24840@coredump.intra.peff.net>
 <20100112154153.GB24957@coredump.intra.peff.net>
 <7viqb6trwu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 18:06:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV6gG-0003dN-BU
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 18:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119Ab0AMRGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 12:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756103Ab0AMRGr
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 12:06:47 -0500
Received: from peff.net ([208.65.91.99]:60099 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932141Ab0AMRGq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 12:06:46 -0500
Received: (qmail 23943 invoked by uid 107); 13 Jan 2010 17:11:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 13 Jan 2010 12:11:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jan 2010 12:06:36 -0500
Content-Disposition: inline
In-Reply-To: <7viqb6trwu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136840>

On Tue, Jan 12, 2010 at 10:55:45PM -0800, Junio C Hamano wrote:

> > +void strbuf_percentquote_buf(struct strbuf *dest, struct strbuf *src)
> > +{
> 
> Just a style thing, but please call that "dst" to be consistent.  You are
> already dropping vowels from the other side to spell it "src".

I personally dislike that spelling, but it certainly is consistent with
the rest of git, so OK.

> I wondered if the function should be just 1-arg that always quotes
> in-place instead, but your [PATCH 3/3] wants to have an appending
> semantics from this function, so changing it to be a 1-arg "in-place
> quoter" will force the caller to run strbuf_addbuf() on the result, which
> is not nice.

Yep. An in-place version would be a bit more complicated to write, and
would make the caller do extra work.

> Since tucking a p-quoted version of the same string to its original
> doesn't make sense at all, perhaps this should:
> 
>  (0) be renamed to have "append" somewhere in its name;

Yeah, I considered this. To follow the existing naming conventions, the
name should indicate:

  1. it's a strbuf function
  2. it's appending (and the pattern is to use "add")
  3. it's appending a strbuf (and the pattern is to call this "buf")
  4. it's percent-quoting

So perhaps following the existing standards, it should be
strbuf_addbuf_percentquote? Long, but I don't think there is any
confusion about what it does (and leaves room for addstr_percentquote).

>  (1) mark the src side as const; and

Oops, good catch.

>  (2) perhaps have assert(dst != src).  The loop won't terminate when
>      called with src == dst, I think.

Oops again. I think it is sensible to protect against this. I thought
about trying to make it magically work in-place, but I don't think there
is a simple way to do so. And since I don't actually need to do that, I
think leaving an assert in-place until somebody does need it and wants
to write it is fine.

> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -105,7 +105,13 @@ static inline void strbuf_addstr(struct strbuf *sb, const char *s) {
>  	strbuf_add(sb, s, strlen(s));
>  }
>  static inline void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2) {
> -	strbuf_add(sb, sb2->buf, sb2->len);
> +	char *buf = sb2->buf;
> +	int len = sb2->len;
> +	if (sb->buf == sb2->buf) {
> +		strbuf_grow(sb, len);
> +		buf = sb->buf;
> +	}
> +	strbuf_add(sb, buf, len);
>  }

Shouldn't this be "if (sb == sb2)"? Two strbufs in the initial state
will point to the same strbuf_slopbuf, but obviously growing sb will not
impact sb2. Though that would simply provoke a false positive, which I
don't think has any negative consequences.

Also, since reallocating sb will reallocate sb2, can't you just write it
safely like this:

  strbuf_grow(sb, sb2->len);
  strbuf_add(sb, sb2->buf, sb2->len);

The grow will not affect the length of sb2, so that doesn't need to be
saved. And there is no point in deciding whether to point the buf you
pass at sb->buf or sb2->buf. If they are the same, then the grow will
have reallocated sb2 as well as sb, and they are identical. And if they
are not, then sb2->buf is the right thing to pass.

-Peff
