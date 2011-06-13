From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] strbuf_split: add a max parameter
Date: Mon, 13 Jun 2011 15:20:55 -0400
Message-ID: <20110613192055.GE17845@sigill.intra.peff.net>
References: <20110609155001.GA14969@sigill.intra.peff.net>
 <20110609155121.GA25507@sigill.intra.peff.net>
 <7voc21od0g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Claire Fousse <claire.fousse@ensimag.imag.fr>, git@vger.kernel.org,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 21:21:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWCh6-0007dI-9d
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 21:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab1FMTU6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 15:20:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38552
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782Ab1FMTU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 15:20:58 -0400
Received: (qmail 16479 invoked by uid 107); 13 Jun 2011 19:21:07 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Jun 2011 15:21:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2011 15:20:55 -0400
Content-Disposition: inline
In-Reply-To: <7voc21od0g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175727>

On Mon, Jun 13, 2011 at 10:30:07AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I am tempted to just call this new one strbuf_split and update all
> > callers. There aren't that many.
> 
> Yes, that is indeed tempting, and because we have a new parameter the
> compiler will catch any new callers that pop up in a mismerge so that
> would be perfectly safe.

Should we also change the naming later in the series to remain
consistent with strbuf_add. IOW, to end up at:

  struct strbuf **strbuf_split(const char *buf, int len, int delim, int max);
  struct strbuf **strbuf_split_str(const char *s, int delim, int max);
  struct strbuf **strbuf_split_buf(const struct strbuf *, int delim, int max);

(though I think consistency would also dictate "splitstr" and "splitbuf"
without the extra underscore. Personally I find it a bit unreadable).

> > -struct strbuf **strbuf_split(const struct strbuf *sb, int delim)
> > +struct strbuf **strbuf_split_max(const struct strbuf *sb, int delim, int max)
> >  {
> >  	int alloc = 2, pos = 0;
> >  	char *n, *p;
> > @@ -114,7 +114,10 @@ struct strbuf **strbuf_split(const struct strbuf *sb, int delim)
> >  	p = n = sb->buf;
> >  	while (n < sb->buf + sb->len) {
> >  		int len;
> > -		n = memchr(n, delim, sb->len - (n - sb->buf));
> > +		if (max <= 0 || pos + 1 < max)
> > +			n = memchr(n, delim, sb->len - (n - sb->buf));
> > +		else
> > +			n = NULL;
> >  		if (pos + 1 >= alloc) {
> >  			alloc = alloc * 2;
> >  			ret = xrealloc(ret, sizeof(struct strbuf *) * alloc);
> 
> Hmm, even when we know the value of max, we go exponential, and even do so
> by hand without using ALLOC_GROW(). Somewhat sad.

Thanks for reminding me. I noticed it wasn't using ALLOC_GROW, but
decided not to change it because I wanted to introduce an optimization
later on not to grow beyond max. But then I forgot. :)

The optimization I was going to do was to simply allocate "max" slots at
the beginning (if it's defined). You know you can't grow beyond that,
and in most splits with a max, the caller is expecting all of them to be
filled.

But your two-pass patch below is also reasonable.

> Also do we currently rely on the bug that strbuf_split() returns (NULL,)
> instead of ("", NULL) when given an empty string?  If not, perhaps...

I assumed that behavior was not a bug (and even had to avoid a segfault
with it in a later series, as you saw). But thinking on it more, it
really is one; splitting even a single character without delimiter ends
up with a non-NULL portion, and I think the empty string should do the
same.

>  strbuf.c |   50 +++++++++++++++++++++++++++++++-------------------
>  1 files changed, 31 insertions(+), 19 deletions(-)

I think your patch looks reasonable. In theory doing two passes over a
very large buffer (e.g., splitting lines from a large commit message)
might be slightly less efficient, but I imagine it is drowned out in the
noise of malloc'ing strbufs.

> +	for (pass = 0; pass < 2; pass++) {
> +		/* First pass counts, second pass allocates and fills */

Maybe it is just me, but I tend not to like writing multi-pass stuff
like this as a for-loop, but instead to factor it into a function with
an "actually allocate" parameter. I find it makes the code much more
obvious.

> +	if (!count) {
>  		t = xmalloc(sizeof(struct strbuf));
> -		strbuf_init(t, len);
> -		strbuf_add(t, p, len);
> -		ret[pos] = t;
> -		ret[++pos] = NULL;
> -		p = ++n;
> +		strbuf_init(t, 0);
> +		ret[0] = t;
>  	}

I think my test in 4/10 (which avoids the segfault by checking
explicitly for NULL in the caller) should go with this part, and then
4/10 can go away.

-Peff
