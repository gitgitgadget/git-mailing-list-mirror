Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04093280CFF
	for <git@vger.kernel.org>; Mon, 19 May 2025 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674220; cv=none; b=i5EntFApQJKd+qFlvEryb94EXkhiMGhUl9oB+iMUm9Z2ypCQYK2RwHIwIeZrAwUS+WBID6unBvd48Tt4Avu0hjJal8tq4AGr52M4+7mN1laPQ8RKqJr+5P/z4df4rrhh41EddOuh5r2Wp0JsVtsWk27Q3yUoYZKm58A7+dFTeZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674220; c=relaxed/simple;
	bh=9BYk4EhRkxnMLvXaJrUlIx5ce/GHx8j+0/LTjnk1zzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCpcLI6VT2yxd8hNgRn0pFY61hjlj8GHJi05a8T/S92twCPajWABjiZjB7M21UpJ+uk+Ry20syjyBupYsljydPoSD0fz9Pc3sNuzzRYCIkrvU5s0r1kL0ntE59KK7+fq05nakAIM8m6iKikVyaqL98xBjuWkW0lAgv3xbhJi3Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hU/mMhpw; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hU/mMhpw"
Received: (qmail 17553 invoked by uid 109); 19 May 2025 17:03:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9BYk4EhRkxnMLvXaJrUlIx5ce/GHx8j+0/LTjnk1zzk=; b=hU/mMhpwRt3mpUGdABaBnbq/9t3A/X1tHGuwKOXv7XavM9vWEyb1AWVy+UBcv1/fi1bWN8UtM6RlxfklWhC5yUGgKKGAE+OQJ6JhQ7GHKw15Sbnpc9vjKFaLY6oA1RfsCLQKEPQ+itUcXAqbO7OsfivoT6KdnvGHcIELI7y2g3RCAkgiZy1V3/c23NE2hFZ7RTj3wqmKf1ui5VTPv1qZDjuuiN8sxn/5r9FWxACkugLoo/tNbqJLcznhDZ8koifTd/WMhpqjBJ1wS6i1/uG6dqR5i3HbBAZTk4vl6y6R3wYa0xVT0JSrOB1jSGwSQ/hp9nRftnkj2FYSzse+V6dkCg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 May 2025 17:03:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32066 invoked by uid 111); 19 May 2025 17:03:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 May 2025 13:03:37 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 May 2025 13:03:35 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/13] t/helper: add zlib test-tool
Message-ID: <20250519170335.GB772062@coredump.intra.peff.net>
References: <20250516044916.GA21985@coredump.intra.peff.net>
 <20250516044959.GH22242@coredump.intra.peff.net>
 <xmqqo6voprrk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6voprrk.fsf@gitster.g>

On Mon, May 19, 2025 at 08:03:11AM -0700, Junio C Hamano wrote:

> > +static void do_zlib(struct git_zstream *stream,
> > +		    int (*zlib_func)(git_zstream *, int),
> > +		    int fd_in, int fd_out)
> > +{
> > +	struct strbuf buf_in = STRBUF_INIT;
> > +	int status = Z_OK;
> > +
> > +	if (strbuf_read(&buf_in, fd_in, 0) < 0)
> > +		die_errno("read error");
> > +
> > +	stream->next_in = (unsigned char *)buf_in.buf;
> > +	stream->avail_in = buf_in.len;
> > +
> > +	while (status == Z_OK ||
> > +	       (status == Z_BUF_ERROR && !stream->avail_out)) {
> > +		unsigned char buf_out[4096];
> > +
> > +		stream->next_out = buf_out;
> > +		stream->avail_out = sizeof(buf_out);
> > +
> > +		status = zlib_func(stream, Z_FINISH);
> > +		if (write_in_full(fd_out, buf_out,
> > +				  sizeof(buf_out) - stream->avail_out) < 0)
> > +			die_errno("write error");
> > +	}
> 
> Even though I may have written this as do {} while() loop, I do not
> mind a while () loop that depends on status being initialized to
> Z_OK.

Hmm, yeah. I agree that is slightly nicer, but probably not worth caring
about too much.

I thought at first there might be an opportunity to also simplify some
of the assignments, similar to 03e7c454e9 (unpack_loose_header():
simplify next_out assignment, 2025-02-25), but I don't think so (in that
commit the complication was that we inflated a little before hitting the
loop).

-Peff
