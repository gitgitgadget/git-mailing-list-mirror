Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF2315B0E8
	for <git@vger.kernel.org>; Wed, 29 May 2024 09:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716974199; cv=none; b=G9psZ/uA+Oa7oMK2hHhNZAKJn/okIJepzhczlRbwNDu5HveXlleMwS0YlCx5G9Lbh46fpNFcAmReKOEF4tyiLD1Yc5Fv98+cX6Bh0plXNGooHBLAvLd1mc5+0WbLT1uyRQX9FfngiB9Cj55PjkQG1719QmzZdkNB3sg7TO9hO9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716974199; c=relaxed/simple;
	bh=VgWTvozZ6TAqcrFdY4fwJsYkG2hrXO2afEVVQxpfNY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1Wj34TyC5g8uPuZhOsr22qV9Pafditi6UjgEqJpr45ifmR76Wh8URXhbhsB0KLzfrDDbJwye3yzP2QwRcuM7RBpHQYKOzBvfp0LzEK11b8kbR6tvMH8NYiYq7xQ1Wwzd7znF+1x4UzpcORZt63CoiDxMUKqzA/xUubMs/t+WpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11444 invoked by uid 109); 29 May 2024 09:16:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 May 2024 09:16:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18283 invoked by uid 111); 29 May 2024 09:16:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 May 2024 05:16:31 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 29 May 2024 05:16:33 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 04/21] strbuf: fix leak when `appendwholeline()` fails
 with EOF
Message-ID: <20240529091633.GB1098944@coredump.intra.peff.net>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
 <9dd8709d1b3b350008218133986befdb2ae74bae.1716541556.git.ps@pks.im>
 <20240525044635.GB1895047@coredump.intra.peff.net>
 <ZlQr3tsDTSOGvFUQ@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlQr3tsDTSOGvFUQ@tanuki>

On Mon, May 27, 2024 at 08:44:46AM +0200, Patrick Steinhardt wrote:

> > diff --git a/strbuf.c b/strbuf.c
> > diff --git a/strbuf.c b/strbuf.c
> > index e1076c9891..aed699c6bf 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -656,10 +656,8 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
> >  	 * we can just re-init, but otherwise we should make sure that our
> >  	 * length is empty, and that the result is NUL-terminated.
> >  	 */
> > -	if (!sb->buf)
> > -		strbuf_init(sb, 0);
> > -	else
> > -		strbuf_reset(sb);
> > +	FREE_AND_NULL(sb->buf);
> > +	strbuf_init(sb, 0);
> >  	return EOF;
> >  }
> >  #else
> > 
> > But I think either of those would solve your leak, _and_ would help with
> > similar leaks of strbuf_getwholeline() and friends.
> 
> I'm not quite convinced that `strbuf_getwholeline()` should deallocate
> the buffer for the caller, I think that makes for quite a confusing
> calling convention. The caller may want to reuse the buffer for other
> operations, and it feels hostile to release the buffer under their feet.
> 
> The only edge case where I think it would make sense to free allocated
> data is when being passed a not-yet-allocated strbuf. But I wonder
> whether the added complexity would be worth it.

I'm not sure what they'd reuse it for. We necessarily have to reset it
before reading, so the contents are now garbage. The allocated buffer
could be reused, but since everybody has to call strbuf_grow() before
assuming they can write, it's not a correctness issue, but only an
optimization. But that optimization is pretty unlikely to matter. Since
we hit this code only on EOF or error, it's generally going to happen
once in a program, and not in a tight loop.

If we really cared, though, I think you could check sb->alloc before the
call to getdelim(), and then we'd know whether the original held an
allocation or not (and we could restore its state). That's what other
syscall-ish strbuf functions like strbuf_readlink() and strbuf_getcwd()
do.

That said, I agree that leaks here are not going to be common. Most
callers are going to call it in a loop and unconditionally release at
the end, whether they get multiple lines or not. The "append" function
is the odd man out by reading a single line into a new buffer[1].

Looking through the results of:

  git grep -P '(?<!while) \(!?strbuf_get(whole)?line'

I saw only one questionable case. builtin/difftool.c does:

  if (strbuf_getline_nul(&lpath, fp))
	break;

without freeing lpath. But then...it does not free it in the case that
we got a value, either! So I think it is leaking either way, and the
solution, to strbuf_release(&lpath) outside of the loop, would fix both
cases.

> I've been going through all callsites and couldn't spot any that doesn't
> free the buffer on EOF. So I'd propose to leave this as-is and revisit
> if we eventually see that this is causing more memory leaks.

OK. I don't feel too strongly about it, but mostly thought it seemed
inconsistent with the philosophy of those other strbuf functions.

-Peff

[1] I was surprised at first that strbuf_appendwholeline() uses that
    extra copy, as the obvious implementation is just to skip the
    strbuf_reset() call in getwholeline(), and then implement "get" as a
    wrapper around "append" to add back in the reset call.

    But that only works for the slower getc() implementation. For the
    getdelim()-based one, there is no notion of append (the interface
    would have to take an offset into the buffer).  We could probably
    optimize this at the cost of repeating ourselves, but given that
    there's only one probably-not-very-hot call to appendwholeline, it's
    likely not worth it.
