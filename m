Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877DB201004
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 04:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773980287; cv=none; b=tDuHb5d+WYEh6xygargqFGh3sUgZCukjhYsrmk16Q3Px5NUVlwXLP0TpHtWrkmiLsfAQcbIpvZfNbh13XJnqS7sI8+fmTWgozwj9Bw3P5FK5uKoi/mLyKiVQUDPjBddMiElyW5y2JtWVsMfeQfKAXjeicRLPP/EqyWepkEU+RlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773980287; c=relaxed/simple;
	bh=pj3TliYrA3s53fUhW+QJeRZt8FEXDeJ49KHxrZdcnFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TidabgeDXUVxP+7cUMdaSRAb0+vwvR6U5fqUeUuWZVO+dd2oit3ZVVz3O/wYg3AIyjKoYNWqI2y+kwS6cDlA3xX1wJbQZ0SZs4c/Mm6nQBtNMbRF6Vmky+j7IERSRGXIJAD7YLapEwAKHYaM3XNVGEhdrtKPZsuR7g/D0AMbF4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S3LtIttr; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S3LtIttr"
Received: (qmail 64553 invoked by uid 106); 20 Mar 2026 04:18:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pj3TliYrA3s53fUhW+QJeRZt8FEXDeJ49KHxrZdcnFM=; b=S3LtIttrkkAk/K+9V2nwrMb1Sksr4jXA8AMp9GKJswAX0EgtFmIgAo1A9A/eb5R156mH1Rbj/cPv0YhcPTyuAvxL0Nwk8B0hl5KayN0EEiJncz/3STWf9AbrKpY0zCOT6sdEOSm2aQ96OurZvnpOlYJS8GgU/OAX+iifwEvRAfY6/pwn1QM4sfQ2Ur/YBKnCv6UCxEtjOJstlfGywo3OzNlKqtxJqx0GV0qzURU3WMAvi0fvb0F6CvsIruP1xUgtaP5XfHZdGvrPkpnuWkCE32V9dz3tTKdh6cL/YZjTcDND+6hh/vbIEQnp47X7kWBRh7tBfIUpE+Ci81SZg1xGLQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Mar 2026 04:18:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 94310 invoked by uid 111); 20 Mar 2026 04:18:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Mar 2026 00:18:04 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Mar 2026 00:18:03 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] cocci: .buf in a strbuf object can never be NULL
Message-ID: <20260320041803.GA18125@coredump.intra.peff.net>
References: <xmqq341wnvbk.fsf@gitster.g>
 <xmqqcy0zii0s.fsf@gitster.g>
 <20260319233546.GA3632561@coredump.intra.peff.net>
 <xmqqcy0zgtmu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcy0zgtmu.fsf@gitster.g>

On Thu, Mar 19, 2026 at 06:46:33PM -0700, Junio C Hamano wrote:

> > diff --git a/strbuf.c b/strbuf.c
> > index 3939863cf3..0333aea261 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -631,6 +631,8 @@ int strbuf_getcwd(struct strbuf *sb)
> >  #ifdef HAVE_GETDELIM
> >  int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
> >  {
> > +	char *buf;
> > +	size_t alloc;
> >  	ssize_t r;
> >  
> >  	if (feof(fp))
> > @@ -639,12 +641,14 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
> >  	strbuf_reset(sb);
> >  
> >  	/* Translate slopbuf to NULL, as we cannot call realloc on it */
> > -	if (!sb->alloc)
> > -		sb->buf = NULL;
> > +	alloc = sb->alloc;
> > +	buf = alloc ? sb->buf : NULL;
> >  	errno = 0;
> 
> I actually was hoping that all lines in this hunk before this point
> can be removed, i.e., strbuf_release(sb), buf = NULL, alloc = 0.

I'm not quite sure what you mean. The function right now looks like:

          ssize_t r;
  
          if (feof(fp))
                  return EOF;
  
          strbuf_reset(sb);
  
          /* Translate slopbuf to NULL, as we cannot call realloc on it */
          if (!sb->alloc)
                  sb->buf = NULL;
          errno = 0;

I think the strbuf_reset() could go away even without any other changes.
We always adjust sb->len in the end to match what happened with
getdelim(), so there is no point in doing it up front.

We could strbuf_release() and set buf to NULL, but that would defeat the
purpose of the function, wouldn't it? We want to reuse sb->buf in each
call, not allocate it fresh each time. I.e., in a loop like:

  while (strbuf_getline(&sb) != EOF) {
     ...look at sb.buf...
  }

we want to use the same buffer over and over.

> > @@ -669,10 +673,13 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
> >  	 * we can just re-init, but otherwise we should make sure that our
> >  	 * length is empty, and that the result is NUL-terminated.
> >  	 */
> > -	if (!sb->buf)
> > +	if (!buf)
> >  		strbuf_init(sb, 0);
> > -	else
> > -		strbuf_reset(sb);
> > +	else {
> > +		sb->buf = buf;
> > +		sb->alloc = alloc;
> > +		strbuf_reset(&sb);
> > +	}
> 
> I do not get all these conditionals.  This is an EOF code path; we
> have no data in buf to return.  We resetted the caller's strbuf
> already.  Can't we return buf (if allocated) to the system and
> return without doing any further damage to sb at this point?

The conditional is trying to keep any allocated buffer returned from
getdelim() attached to the strbuf. Since this is EOF (or error), I agree
it would probably be OK to just free it. Even in a loop like the one
above, the loop will generally end at EOF, and we don't care about
reusing the buffer further.

But it's not quite enough to just do:

  free(buf);

Because "buf" is a copy of sb->buf, and we handed "buf" off to
getdelim(), we need to make sure sb->buf is not still pointing there. I
think it would be enough to do:

  free(buf);
  strbuf_init(sb, 0);

If we did a strbuf_release() at the top of the function then that is not
a concern (you know that sb->buf is pointing at the slopbuf). But I
don't think that is a good idea for the reason I gave above.

-Peff
