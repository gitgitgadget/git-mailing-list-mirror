Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F9F347BA7
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784007884; cv=none; b=VbmgsDCRrYBkK6yYzPJZxj35wltmFq2zbENcWEM6v+0hXFsPFSzNp79a+9OH9/4deCzVA2ggQLPOFmPNDQfQrbnvkQ1nB7GirZPcVdEU2mMueWUiTsJd0O5dM1vuWlCLN9x7D700s4onohkDsglGQqjGgQElXbKKFNZL9BpqjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784007884; c=relaxed/simple;
	bh=l4IsuqwCWDAndI844aO1HDtMIWi5wsKLRt3TSY4HLFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BD/2ryc3nZ6pZcGSF2a/OGgo/WMTUO2wZl17F3+FgrHjQIy5cOO8gBRhYvNceE754eodKjYikCIydbplgg975oxMQqmMV8ChMadbxBZ9rN7H46I0b0ffQspq7cDa+D+kt+IhTFiMItFLilMGo+o8cnj8/9brOTl5BRtg29xD7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=gZ5AdLCj; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="gZ5AdLCj"
Received: (qmail 21116 invoked by uid 106); 14 Jul 2026 05:44:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=l4IsuqwCWDAndI844aO1HDtMIWi5wsKLRt3TSY4HLFA=; b=gZ5AdLCj4eNqhETCNBg0oKoj9eqP3m1PON1JwWf2qdunF7dBR1r/RsOb+NOu/NJu7Zx/pb+UQtzFB1wtk6BsgVwjjEoeqXq0cbXN41i7SQ9VvJw6cIGJdK0Hw7Kh0/uEaaSOIEqOa8xsoudMfonguWuuapOl9+zKal7Yuz9UA6ZXSPpiMpERN9pV5sH4QcwDlLIp3hyhx3lLIrVNk+klgOzUQyo0irKhJXC5iDQrqEMnxOG5+9K6LgsIWdrY5bXZ4gYEgT3uD3dKbSqbX2wuQOj8qHbMSADBQvb7uMif4WkcQu+xkaA3yae/uc66jXd6d7xWj74rd5OkiNaoO9MpKA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jul 2026 05:44:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 41960 invoked by uid 111); 14 Jul 2026 05:44:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jul 2026 01:44:43 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jul 2026 01:44:39 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Ted Nyman <tnyman@openai.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/2] http: use unique tempfiles for packfile URI downloads
Message-ID: <20260714054439.GB2516582@coredump.intra.peff.net>
References: <cover.1783982021.git.tnyman@openai.com>
 <alVn-QmK3K91_tkH@com-76773>
 <alW1tAnMtOznxrhK@com-79390>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alW1tAnMtOznxrhK@com-79390>

On Mon, Jul 13, 2026 at 09:06:12PM -0700, Taylor Blau wrote:

> >  void release_http_pack_request(struct http_pack_request *preq)
> >  {
> > -	if (preq->packfile) {
> > +	if (preq->tempfile) {
> > +		delete_tempfile(&preq->tempfile);
> > +		preq->packfile = NULL;
> 
> We should be able to drop the assignment to NULL on the second line,
> since `delete_tempfile()` takes a double pointer to the 'struct
> packfile' and NULL's it out for us.
> 
> (The other callers appear to avoid explicitly setting `preq->tempfile`
> to NULL.)

It takes a double-pointer to the "struct tempfile"; the NULL assignment
is to the "packfile" member, which is the FILE handle.

I thought at first this was buggy; we still call fdopen() on the
tempfile and assign the result to preq->packfile, even in the new
non-resumable case. Don't we need to fclose() it? But the answer is no:
fdopen_tempfile() retains ownership of the result, storing it in
tempfile.fp. So it will be correctly closed during delete_tempfile(),
and in fact we must _not_ fclose it again.

But assigning NULL can happen with either style. So doing it
unconditionally like:

  if (preq->tempfile)
	delete_tempfile(&preq->tempfile);
  else if (preq->packfile)
	fclose(preq->packfile);
  preq->packfile = NULL;

makes more sense, as it is done in finish_http_pack_request(). It might
even make sense to add a comment explaining why we don't need to
fclose() in the first part of the conditional.

All that said, I do not think setting it to NULL matters at all here,
since the function ends with free(preq). So just dropping the NULL would
perhaps be more clear.

-Peff
