Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C43388E79
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 11:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775214807; cv=none; b=P0y5St5AGWha651noaRBTSxDuEsfQ4MhRcqDsskqZV6xqYyGRLB8APIQ3Xxnr9z2tPY2C37Hb/sA9heMi4Uqc0LfX2Nw12y79dgYRRPO90I3s0MQc+9UodlRdY5kNonFNJP2mzmdGpCAGY7IGcbE/qzwY5iw1nKfh3CQfkB43Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775214807; c=relaxed/simple;
	bh=UD+LSj7PRQ8ulRDdDKlIvsU2BBFshRSyCxf/MtVzEvI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D2+/9vo+D6RgGt5L095bhmAFUM5jidIaqYkJVOBf8HSaFm2eKrYdqYT1l+kdZvbyu5qMvvMMNDHiPoZZlFAtR3Vr4/N5cyO0qbXiGx9NhK9XuDVrAMZ5MA+oqui8d3yWbLCfSy8iYJXkbTYEUPTKkmhcQ6l6d4ddD7PuvOi0qSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Mln/7o52; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Mln/7o52"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1775214801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YZDlxV0YLuMR/g58MTtNZksb1/HuFSDRSErsYcujQ1w=;
	b=Mln/7o52qycv3Q99MQKIP8JLczmXygb9V14PPZ8LUXMmcMjItRCvIrBW1vQY5cRoXSVXna
	fOJMLOSDFVJdiy9h2Q7Sa1vuanVzPqfvfYBc/whfXkEexUFWHzOM7tzC6upo00ssnqOjJI
	0Z3IfmaZSPuIUSnnI5cr8VYmGqGKD9I=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH v2 08/12] skip_prefix(): check const match between in
 and out params
In-Reply-To: <20260402041507.GH3501239@coredump.intra.peff.net>
References: <20260402041433.GA3501120@coredump.intra.peff.net>
 <20260402041507.GH3501239@coredump.intra.peff.net>
Date: Fri, 03 Apr 2026 13:13:11 +0200
Message-ID: <87h5ps5mbc.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Jeff King <peff@peff.net> writes:

> There are a lot of ways to implement the "fails" part. You can use
> __builtin_types_compatible_p() to check, and then either our
> BUILD_ASSERT macros or _Static_assert to fail. But that requires some
> conditional compilation based on compiler feature. That's probably OK
> (the fallback would be to just cast without catching case 4). But we can
> do better.
>
> The macro I have here uses a ternary with a dead branch that tries to
> assign "in" to "out", 

I didn't know this pattern before, but is seems it's used in other
places as well. Clever.

> +/*
> + * Check that an out-parameter that is "at least as const as" a matching
> + * in-parameter. For example, skip_prefix() will return "out" that is a subset
> + * of "str". So:
> + *
> + *  const str, const out: ok
> + *  non-const str, const out: ok
> + *  non-const str, non-const out: ok
> + *  const str, non-const out: compile error
> + *
> + *  See the skip_prefix macro below for an example of use.
> + */
> +#define CONST_OUTPARAM(in, out) \
> +    ((const char **)(0 ? ((*(out) = (in)),(out)) : (out)))

I'm not sure it matters, but this is indented with spaces

-- 
Cheers,
Toon
