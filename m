Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA498188CC9
	for <git@vger.kernel.org>; Sat,  2 Aug 2025 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754124918; cv=none; b=MVw5eJXmSRzT9IvDLye0MTNrgDXEAmOi/mNHvunNJW9Iqx9VE8sqIiZn9syE6oMNpmLspBosEnnu3rDricTgG+6Y9Unwc5hQcFNuTfjy+aL3s5aJKett+W1XsfQxCTOSwwgqUxIQZKs2BvjQlgCc2Iy/WI5qW+svaOaqG7BUtRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754124918; c=relaxed/simple;
	bh=3UGtG7WlrJbBSwJIcPqCqJCx7s4jrv+WQH2fC4V8B+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww1KMX7VQOyjDMALP0oRLYR0CBW0RuHhJkLx6EU4FYl5rPa6yXWak9O3UtOyDb0BGvjHO1ezfXVDwyb/ENU90u7Iav1v+gtZIfUYopmKwyYtNgTYQu7oCsIRQomV16qKgUQ2RT93zKDGDaoCj0wR/+lTnO+qRaT/GdvTd4CGgog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=G/RyQP5J; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="G/RyQP5J"
Received: (qmail 8814 invoked by uid 109); 2 Aug 2025 08:55:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3UGtG7WlrJbBSwJIcPqCqJCx7s4jrv+WQH2fC4V8B+4=; b=G/RyQP5JJijbaAbUyH79X0wZiWjgnDEWr/oVV4P2A+jDn7oscvyW3lZkmgpoq0gsic9tgFvJqtc0GaKJ4KkqWlPySl3QLZZQaD9tu99EsemaPsi4skvZmLd2j5Mao+M7M4E/DFmG/umWGTJbJ2ingcgwHe0i3Xa0GGHwdlp78tyB+t8hcdsdWVp5c8BR8LcTxRoi9io0Jwjdv7ef8V+elAT2zPoQqN6WG3hw33ocVffKvghB/p7TbXlEKfwyKDYS2aZlpXXKgj5JeeIuPbusqxH6VI573oENqKi6pBCiPldQODLWIxG5EHVzHrTnx5bbfFm9F+yGDd+F7DK57dN/ig==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 02 Aug 2025 08:55:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11009 invoked by uid 111); 2 Aug 2025 08:55:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 02 Aug 2025 04:55:19 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 2 Aug 2025 04:55:13 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 05/11] merge-tree: do not use strbuf_split*()
Message-ID: <20250802085513.GD3711639@coredump.intra.peff.net>
References: <20250731074154.2835370-1-gitster@pobox.com>
 <20250731225433.4028872-1-gitster@pobox.com>
 <20250731225433.4028872-6-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250731225433.4028872-6-gitster@pobox.com>

On Thu, Jul 31, 2025 at 03:54:27PM -0700, Junio C Hamano wrote:

> -			if (input_merge_base && split[2] && split[3] && !split[4]) {
> [...]
> +			if (input_merge_base && split.nr == 4) {

I always hated strbuf_split() because the array-of-strbufs was awkward
to work with. But I never realized how inconvenient it was not to have
the count of split items until seeing that monstrosity in the pre-image. ;)

-Peff
