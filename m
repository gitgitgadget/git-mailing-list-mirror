Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155F2517AC
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251299; cv=none; b=SBgp7irg0lVuUCQF8PYn8Ox1L9HUI1eC020PrCLfF6BGy84vs3Hi7Nik1d3UlmKEPgYsR09nvSjNQSRyD8pN+wZPpyaIHVXJjAlgtjv9SPaZtvd89Z1/5TEx6c8GkuAIAMr0c3eDMY6iK6LHcTgkJakYhiZwX1ODFg9SWAa9sJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251299; c=relaxed/simple;
	bh=3m1C3mjBhldYGBjOJBERwHlE6+Sca5cGOXxQtLsN1hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csvFSTUKcjm+F49NaUUEQwkIGtY5/SyfAIbuFfXKvFNMOv9yOXcixZSeQ+5UEb/P1pyphglnkyygxECm4IJVgXNwz06iCocA6IpnskNnSVt2RPO+duvQPxIWY21+b69waK9g/I91hDQ1Dq9UlHuk/O6ACCeFWHZMObtM6Pl2GX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eEyR/QCE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eEyR/QCE"
Received: (qmail 78157 invoked by uid 106); 11 Mar 2026 17:48:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=3m1C3mjBhldYGBjOJBERwHlE6+Sca5cGOXxQtLsN1hs=; b=eEyR/QCEuS4pLfiHSS6K0tt3lG049IqZ9ZIBsNRZVfDlH+x292AEDN6wPOtKHnxzAGCjwKOAKmNHC9i1fyLmS/AZoL7yWlGRAHP26nk3enY5+NS4wl/BYiN6PYqyBni6mXyo3nzS65EfErycsb2td4wVQ8WHPVwqkaEk6rRFFKm8kpQRTydM23YMHLix/F/Dwpx0tOA/1QMALKDUH0ud4Bt04RliYuAANQB7NEYNbHRuiOmQdUWshRVKm1VDPWuI/SI3ghzVFMoaSphsHwkrkl0138iTaCKHwI5LVbU3/SDRIsW/DoDea6CtdKLJQ484kjKvKkV8AUWhZUpKKlXo4w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Mar 2026 17:48:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 492772 invoked by uid 111); 11 Mar 2026 17:48:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Mar 2026 13:48:17 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Mar 2026 13:48:16 -0400
From: Jeff King <peff@peff.net>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v3 2/2] list-objects-filter-options: avoid
 strbuf_split_str()
Message-ID: <20260311174816.GB1900488@coredump.intra.peff.net>
References: <20260311132041.12044-1-deveshigurgaon@gmail.com>
 <20260311173336.8395-1-deveshigurgaon@gmail.com>
 <20260311173336.8395-3-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311173336.8395-3-deveshigurgaon@gmail.com>

On Wed, Mar 11, 2026 at 05:33:36PM +0000, Deveshi Dwivedi wrote:

> +	while (*p && !result) {
> +		const char *end = strchrnul(p, '+');
> +
> +		strbuf_reset(&sub);
> +		strbuf_add(&sub, p, end - p);
> +
> +		if (sub.len)
> +			result = parse_combine_subfilter(filter_options, sub.buf, errbuf);
> +
> +		if (!*end)
> +			break;
> +		p = end + 1;
>  	}
> +	strbuf_release(&sub);

This version of the loop looks good to me.

-Peff
