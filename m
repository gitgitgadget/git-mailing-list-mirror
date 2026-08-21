Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33394282F06
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787273262; cv=none; b=Sl9Za8/vwFONauqcGk3+4EzpBEgb3tUzaS5z32u6dpRE30+oErnadROorFmz7b4AQJsGdOcVAckY/FpLnHAoXia1BxtrOUdZ2cKrJ7iFfb3MllYr7eHoRF9lx/aNbDNONkh7PjoUZQJLEd1EvSGe3CxY8+mE8UBCvkd/hpbfhZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787273262; c=relaxed/simple;
	bh=owx9SUVvJz5Ry1lYNpH3gyieSkF6a1ySeMvsxw1UZvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUH5AfGXMt7KF2xVYDZAKjPjGxXboMbpwS6cDzKGd8GabybW2Y57DSsSy4YA7lK00kFqTwT1RGdXgyI6ymPFNhGTa8NC4uBucJKuzG4ZXobciO6/UmjYZ4KCxW9V2FXryBTNKnhGHpEzD5LTiNWU8QVqfXQP4mcjdpDeze2AjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MTEso5CX; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MTEso5CX"
Received: (qmail 83125 invoked by uid 106); 21 Aug 2026 00:47:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=owx9SUVvJz5Ry1lYNpH3gyieSkF6a1ySeMvsxw1UZvI=; b=MTEso5CXvdLm4RcjsbrqTRYeS/HTSQpdl4aZ7Axxc9xOwJdEXFqxYDcTOnxvyC9EmnEZ+x5Whylt8F+ggvZQz4N5nDAAEs8KKfDviY/1aaKxBBk6UD5Lxd5a4LT1HF7Ftue07VnQNvIEfislsr8X6sf0ba/Klo/kRD6JA0dR8G0SxmTGPqLZYwsFrDa9ND5nHP2vusFmauNwxloG8qKaatgrDAYSViAg4ISGCc75t2UJUh7Ut6rvlejV5omLfu4qXaEgCv9C9ImtoX5BlLKB1r1wUXdwsOrifNm9eD0O8xU6fh78BBQEvDCHXSctZIq7N3wF3WBJlb0V4fwy8rEy8g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Aug 2026 00:47:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 68506 invoked by uid 111); 21 Aug 2026 00:47:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Aug 2026 20:47:42 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 20 Aug 2026 20:47:39 -0400
From: Jeff King <peff@peff.net>
To: friel@openai.com
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] pack-objects: trace pack bytes written
Message-ID: <20260821004739.GA297273@coredump.intra.peff.net>
References: <20260817233914.8740-2-friel@openai.com>
 <xmqqo6f02q2f.fsf@gitster.g>
 <c6a8cdac36d2202055d637ebcc97e484122cdcd4.1787158152.git.friel@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6a8cdac36d2202055d637ebcc97e484122cdcd4.1787158152.git.friel@openai.com>

On Wed, Aug 19, 2026 at 04:28:10PM -0700, friel@openai.com wrote:

> From: Friel <friel@openai.com>
> 
> We want to measure how compression settings affect push performance on
> the client. Different settings can produce different-sized packs from
> the same objects. Trace2 records the object count, but we also need the
> pack size to compare those settings.
> 
> Add a write_pack_file/wrote_bytes Trace2 datum alongside
> write_pack_file/wrote. Count packs written to stdout or disk, including
> each pack's header and trailing checksum. When pack.packSizeLimit splits
> the output, report the sum of the pack sizes.
> 
> Signed-off-by: Friel <friel@openai.com>
> ---
> Junio, you're right. Updating bytes_written before finalization is
> equivalent. I've dropped pack_bytes; everything else is unchanged.
> Thanks.

The downthread discussion went pretty far off-topic, so for those who do
not want to read it, the summary is: this patch looks good to me. ;)

-Peff
