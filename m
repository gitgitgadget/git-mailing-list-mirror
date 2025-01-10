Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051DA19ABDE
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510546; cv=none; b=P5gs1+/xBG/CeMox9B1NeAuCO74qor5GfrnHFksqiTP5W7QdH3SBiSip83p61RMUctkxO/GzHc6HyVbXnzbfuAye/2N9ZQbSc7Ge91O6ZIhFuqGE+T6+IFDGGMqaszjNQnkQkp25wev6wOUtxMUbohEeOorHEgzmQSbyVwS9khQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510546; c=relaxed/simple;
	bh=DZ58T8yARp549GwKwWWwtuJf0hxz/5YIjUozHJwVzL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgO1GEAVMix848aJ6bgPXVQjWlV77sIF5CEUlwB3t8+LaZgk0mXt4F58wbk2Oy66whh4gmK8tLXO7yCD0X+AUCgEcwa2hvBM2a99cX5nBgsmjRtqLUQhE5sZ4A5MVtyx6fU1/uwyXTR/9AokJuLENQjb+YOWQKPnN7dttVqWDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VNHdc46m; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VNHdc46m"
Received: (qmail 4534 invoked by uid 109); 10 Jan 2025 12:02:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DZ58T8yARp549GwKwWWwtuJf0hxz/5YIjUozHJwVzL8=; b=VNHdc46moeRswzms/JVSRsFpr01I8qrp20BfkmE/Y4nYKOkVsX+7/PRmjl+hfsi00IXqORAb2L2uHvirsl8uhgue9O3NaAG77aHMHuQOkqlzrDmL96K5QdcN2wAfTCaIoB75C9n4co2EKAJid4J7F2HTfyIs+tb4J0WDsjtIwAvm/EskH3tWmTA3U/0CjWVyBN7Q2vO2nkHVEfJdLPsMl8EFTXvWFVixILjCWnHNH0GsuOkUiEeJjTlToDwZMaRhiab6I2BvAzQp0Nd9KEfqw3hzhImqbvC8NsB6I77aeI2RrLT3PQFWEJTjLHuBjfnvguWjaJd0dZ1ieYpdXgdVxw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Jan 2025 12:02:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5361 invoked by uid 111); 10 Jan 2025 12:02:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Jan 2025 07:02:23 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Jan 2025 07:02:23 -0500
From: Jeff King <peff@peff.net>
To: Olly Betts <olly@survex.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: git grep: ^$ false match at end of file
Message-ID: <20250110120223.GC1014503@coredump.intra.peff.net>
References: <20250109235255.GA3418@survex.com>
 <20250110114308.GB1014503@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250110114308.GB1014503@coredump.intra.peff.net>

On Fri, Jan 10, 2025 at 06:43:08AM -0500, Jeff King wrote:

> I'll stop digging on it for now (but adding Junio to the cc as the
> author there). Probably it would have been faster just to start with a
> debugger than to look through the history. ;)

OK, my curiosity got the better of me. This fixes it:

diff --git a/grep.c b/grep.c
index 4e155ee9e6..9eac3dd95d 100644
--- a/grep.c
+++ b/grep.c
@@ -1470,10 +1470,12 @@ static int look_ahead(struct grep_opt *opt,
 		hit = patmatch(p, bol, bol + *left_p, &m, 0);
 		if (hit < 0)
 			return -1;
 		if (!hit || m.rm_so < 0 || m.rm_eo < 0)
 			continue;
+		if (m.rm_so == *left_p)
+			continue; /* don't match nothing */
 		if (earliest < 0 || m.rm_so < earliest)
 			earliest = m.rm_so;
 	}
 
 	if (earliest < 0) {

but it is weird to me that patmatch() will match "^$" to the end of the
buffer at all. It is just calling regexec_buf() behind the scenes, so I
guess this is just a weird special case there, and may even depend on
the regex implementation. If I pass "-P" to use pcre instead, the
problem goes away even without my patch.

If we skip look-ahead the problem also goes away. I'd have thought
match_line() would have the same problem, but there we process line by
line, and regexec_buf() never even sees the newline.

So I guess the rationale is: some regexec implementations are weird
about this special regex, and we should not trust their result with it
on a whole buffer with newlines.

-Peff
