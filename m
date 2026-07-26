Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236EC1DE4EF
	for <git@vger.kernel.org>; Sun, 26 Jul 2026 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051685; cv=none; b=WduiawbJtPQ/rJ+08mgAUmy5Rdl91115iiOFrfZzwSDNnV+fiewJMoSatVB+hAnxMa3VbjSXF6mYoFrwN1XOj5SZgF2YjmKzf2ajO5udF/9NMI/Hjr3bJSc9D6yNZZQ4ff/qj5eLBzMB2YeFVxNcM5uSvfTj/A02DQ/RDniQfNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051685; c=relaxed/simple;
	bh=0HDTe5eT75K1wEpoBALL0kE4WTQCZGpuupYD5TJR2vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3nP/hCUB5x0IQfty8VaX1EBHyHQNzZ7h+dTpreAW5MWCm8pDZ9A+gCZ5vtrdB+zmVAoJXlKTYtneDRgWjZkFLJeoIReKBwSIxaz1VQlorWpAzCGPaeEtPW85RsLwi3CBQ+AXd3Yq5WcFAgu868Q8Deyqo/f752NI+2WP7MUer0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OFLXIzrE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OFLXIzrE"
Received: (qmail 56565 invoked by uid 106); 26 Jul 2026 07:41:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0HDTe5eT75K1wEpoBALL0kE4WTQCZGpuupYD5TJR2vc=; b=OFLXIzrEQwbdbA7zczu2XD8JG2UUOTwdp3n+Y3GHcHnPZHAIJ0zYA8KxVaCupbLCfJ81j9UY4toYoM/2U8+tlETzk63hDRQvWDpbrWRtSuXqysBd7RGm+6g+jrnHbRzTeu3/RQPqOwAo+nmym6Gfu+a7w/a2Ccl0Mv/WMYzO5SoXss9PJ1fsAzmx8rE55t6qZYGHLew+jmZpgdKrM1HmkWcdbhv6uWNO8mx84p+nt9byCllNMYCYV4V812l4tLtTxhBg6ABO0rDcNLV7FvTHE/acX7QsbAHXb+d5TYdnkP3sP3itkYgrPBq0xYNyThe0V47mLJRu5v6D44NoPprKUg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Jul 2026 07:41:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 57356 invoked by uid 111); 26 Jul 2026 07:41:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Jul 2026 03:41:27 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Jul 2026 03:41:22 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: tnyman@openai.com, git@vger.kernel.org, haraldnordgren@gmail.com
Subject: Re: [PATCH] branch: avoid slow strvec Coccinelle matching
Message-ID: <20260726074122.GB2366012@coredump.intra.peff.net>
References: <20260724091152.27794-2-tnyman@openai.com>
 <20260724114948.GA825505@coredump.intra.peff.net>
 <xmqqpl0c8jml.fsf@gitster.g>
 <xmqqbjbw8icj.fsf@gitster.g>
 <xmqqse5870oe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqse5870oe.fsf@gitster.g>

On Fri, Jul 24, 2026 at 10:33:05AM -0700, Junio C Hamano wrote:

> Here is what I recommend that we do.  In the short term, i.e.,
> within the context of the topic in question, let's use 'int' to
> match the type used to count the members of an array embedded in
> 'struct ref_array'.
> 
> But let's leave a '#leftoverbits' note here in the mailing list
> archive to remind us to revisit the idea of consistently using
> 'size_t' to count things when things are quiet.  This is not the
> time to needlessly disrupt the 'hn/branch-delete-merged' topic, I
> think.

Yep, agreed on all points.

-Peff
