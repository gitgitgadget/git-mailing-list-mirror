Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D329196
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 00:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313505; cv=none; b=dhQdC82P4kZLafGsLnYFpabFOYSPTpmcJmOqd9mQN0wD/DECoTm2F3ZH7SlTFHmsCLzhheQfRTgHi829iJ+MQCxit3nkFnJmOe9UKto1cj2hYSwctLXIuVkrvuzAhjI7Guafj+vJsM8tYWEiRgrczLgghqvDAHG8U4LgMDqj9Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313505; c=relaxed/simple;
	bh=+u/o4Ca7aBjhIJ4u7L2/wp/j26vVpWlDgbwPPQr+lGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wn2kkFojiRfj14VLi2RySDzWWiox259txiFjCdPM4cB+xfZ6IMN4PIppX4k4F+FN3PCIohenEpeTJ7YoLnSuYlMIhmZ0q2HjbJp1+IsQZEkBmmLZ5J1tIsE9UyOr4j1qi8bxo8AEpPQBImcgMFsV4prlaPE+t/NyH5BpY7EYt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16255 invoked by uid 109); 17 Apr 2024 00:24:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Apr 2024 00:24:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5477 invoked by uid 111); 17 Apr 2024 00:24:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Apr 2024 20:24:58 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Apr 2024 20:24:54 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] imap-send: increase command size limit
Message-ID: <20240417002454.GA2305596@coredump.intra.peff.net>
References: <7026075c-db4e-4d43-bbd1-d2edb52da9b7@web.de>
 <20240415185530.GB1709228@coredump.intra.peff.net>
 <85047e64-044f-4bf8-8de9-33b082255f3e@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85047e64-044f-4bf8-8de9-33b082255f3e@web.de>

On Tue, Apr 16, 2024 at 06:08:05PM +0200, René Scharfe wrote:

> > Shouldn't socket_write() just use size_t / ssize_t?
> 
> Probably size_t.

Yes, but you need ssize_t to handle the negative return values.

> > In particular, this made me wonder what we would do for larger items.
> > Like, say, the actual message to be uploaded. And indeed, we use a
> > strbuf to read in the messages and pass the whole buffer for each to
> > socket_write(). So we'd possibly quietly truncate such a message.
> 
> Hmm, perhaps we should at least sprinkle in some more overflow checks?

Perhaps, but...

> > Fixing it is a little more complicated than switching to size_t, because
> > the underlying SSL_write() uses an int. So we'd probably need some
> > looping, similar to xwrite().
> 
> Or SSL_write_ex(), which takes and returns size_t.  It was added in
> OpenSSL 1.1.1, which reached its end of life half a year ago.
> 
> https://www.openssl.org/docs/man1.1.1/man3/SSL_write.html
> https://www.openssl.org/blog/blog/2023/03/28/1.1.1-EOL/

You'd think that when I ran "man SSL_write" while writing the other
email I would have noticed that SSL_write_ex() is mentioned right there
in the synopsis. But somehow I didn't.

I don't think we document a required version for ssl. That version is
"only" 5.5 years old, but I think it would be OK here (especially given
that imap-send is an optional component with a build-time knob).

In which case I think fixing socket_write() would fix this problem, and
then building your other patch on top, it doesn't need to worry about
INT_MAX at all.

Looking at the conversion, I think there's a slight gotcha with
retaining the "0" return value from SSL_write_ex() to pass to
socket_perror() in the error path. Which makes me wonder about that
error path at all; it closes descriptors but doesn't handle SSL at all.
Should it be using socket_shutdown()? And should that function set
sock->ssl to NULL and the descriptors to -1? The rabbit hole of
imap-send is infinite.

> > In practice I doubt this is ever an issue. 2GB emails are not likely to
> > be usable in general.
> 
> Tough.  Who likes to get multi-GB patches in their inbox?  Heard of
> people exchanging CD images by email decades ago, though, so I
> wouldn't rule this out totally.  Perhaps that's the last puzzle piece
> to convert game studios to perform email reviews of asset-heavy
> binary diffs? ;-)

OK, I laughed out loud at this. Perhaps a sign of too much Git.

-Peff
