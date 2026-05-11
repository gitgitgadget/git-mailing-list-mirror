Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F8837B027
	for <git@vger.kernel.org>; Mon, 11 May 2026 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505063; cv=none; b=DAmogYUF9K0MuG21pzvgy0ZgjNU1PSXiQ354VnuQCRmQQkyQ4P1QHP4Df9FFhoIYDNwWYzxIFWFj2mV5ldJATk2gZS2p2QgF9VkBq0TU0HyMTOP2hwBP4xMNQEbSlP2kY15k0x69x41iUCYC/FjLhlV5/XBvYKhisq9KSiQSQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505063; c=relaxed/simple;
	bh=i5kp3o4dnDs6bvKU0Rt8Sv3BNEEF977TeRMkptk18YM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sSDdTTsnX1pBHFAXPOIXkO4pHpvF3ROTUv5jJACvf/UczftZEJA/uyiN+ApOYrXbw7bF7SVfwkLk1H22VnqfQQYU9qAAP3ZVPYXnpn31z1WjNhf2oq7ak15S9XUKipm/mdtsiMcpFILlpS0dgGwqDoO0flnw1n6GbBXwx/uXvkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=oSUJKL31; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="oSUJKL31"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1778505059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZcVYBDyvHxg+HU4wfOSAR+JJvp57XdMBs5behlUsiM=;
	b=oSUJKL31tcLKbQ2X5N7B0pz1dMSOunwoFMVaXclLDUW1nGSOpCQzHT9qb3uu8kDDn4DN99
	YT4KB6pNTP7OFC38CZaGAGGt+vF9Uzn/0/NIe2CVYfttflEsA5yHbjWSCGPgVC5t0+LrW6
	BKFlx8VaHqEV8x1pZuG8AfWOXIsXAoE=
From: Toon Claes <toon@iotcl.com>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>,
 Elijah Newren <newren@gmail.com>, Christian Couder
 <christian.couder@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 6/8] promisor-remote: trust known remotes matching
 acceptFromServerUrl
In-Reply-To: <20260427124108.3524129-7-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260427124108.3524129-1-christian.couder@gmail.com>
 <20260427124108.3524129-7-christian.couder@gmail.com>
Date: Mon, 11 May 2026 15:10:55 +0200
Message-ID: <87qzninlb4.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Christian Couder <christian.couder@gmail.com> writes:

> +static bool match_one_url(const struct url_info *pi, const struct url_info *ui)
> +{
> +	const char *pat = pi->url;
> +	const char *url = ui->url;
> +	char *p_str, *u_str;
> +	bool res;
> +
> +	/*
> +	 * Schemes must match exactly. They are case-folded by
> +	 * url_normalize(), so strncmp() suffices.
> +	 */
> +	if (pi->scheme_len != ui->scheme_len || strncmp(pat, url, pi->scheme_len))
> +		return false;
> +
> +	/*
> +	 * Ports must match exactly. url_normalize() strips default
> +	 * ports (like 443 for https), so length and content
> +	 * comparisons are sufficient.
> +	 */
> +	if (pi->port_len != ui->port_len ||
> +	    strncmp(pat + pi->port_off, url + ui->port_off, pi->port_len))
> +		return false;
> +
> +	/*
> +	 * Match host and path separately to prevent a '*' in the host
> +	 * portion of the pattern from matching across the '/'
> +	 * boundary into the path. Use WM_PATHNAME for the host so '*'
> +	 * cannot cross '/' there, and 0 for the path so '*' can still
> +	 * match multi-level paths.
> +	 */
> +
> +	p_str = xstrndup(pat + pi->host_off, pi->host_len);
> +	u_str = xstrndup(url + ui->host_off, ui->host_len);
> +	res = !wildmatch(p_str, u_str, WM_PATHNAME);
> +	free(p_str);
> +	free(u_str);
> +
> +	if (!res)

I feel it's a bit confusing your negating the result from wildmatch()
to negate it here again? Maybe keep using the int return value, or
rename the variable to 'matches' ?

> +		return false;
> +
> +	p_str = xstrndup(pat + pi->path_off, pi->path_len);
> +	u_str = xstrndup(url + ui->path_off, ui->path_len);
> +	res = !wildmatch(p_str, u_str, 0);
> +	free(p_str);
> +	free(u_str);
> +
> +	return res;
> +}

-- 
Cheers,
Toon
