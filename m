Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3498937F0FA
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029893; cv=none; b=bulFBs+727Sie7PxcPAZCdAjQAblUCd7qLLCAYZIgI1pT73m/HticPUqPVQGdmXTSKhGFxDARXE/gqUq/9Fp+QOSlyOY8fZr2vlReDsR5lXjEGuTzj15gO8ehDHNPQnhtGbdLlndnAKR2GFgQVPVGbFkicyFq8CFlwmF7ZPR0y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029893; c=relaxed/simple;
	bh=JEEi1H3K1L8c3esiRa0K7Z5z4OEoO2WvEV3tsP32Bew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrQyCfF2W9VnUh9FK5pg5PcyH1q8otvqqqNPm1GBoPklzY3X1uhiTloh2btYk4CePHVE/XR5qk8rDs4SC1UGBOXFrtobRWjffEifKUmhgCXSWDx1f5S/p8eXpr1HIHIwUWud0rDjInJbIOQSs7J3tmpyLcAh6i+7DE5oMXWAwns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZPxmX422; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZPxmX422"
Received: (qmail 123788 invoked by uid 109); 21 Jan 2026 21:11:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=JEEi1H3K1L8c3esiRa0K7Z5z4OEoO2WvEV3tsP32Bew=; b=ZPxmX422b/CgN1E3NwzVzXMer+byHUPRDdphXNN0NOZ+Q4OxdLa/yVGeNh22RofxOAvkuiEydjHp8UHJc0/lBymKYuvBqbyYz/AeKgJidKPKkZQJf4xML9ekcVSNh6RLiBmEi8cIGqCHQ1S94oNYz9tQVLaNqoeHSt0tUvpAkRTlCXgmbk2J5Rs+BIekNLDpoeBoxI3iumG1AVlzZbyoCYSCKZnujPxl4YmUzRf73pEMPNJdfn+0tZ7q/CWY/oyczjdaEu+RgxdnJcyNo/G4UKcIjTezr1f7sdX4pKs4wgxKskj8ueC0xXsmFEoKodneezh7H/Kifio1ZexdkPYMYw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jan 2026 21:11:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 210612 invoked by uid 111); 21 Jan 2026 21:11:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jan 2026 16:11:30 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Jan 2026 16:11:28 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/14] odb: fix flags parameter to be unsigned
Message-ID: <20260121211128.GB723458@coredump.intra.peff.net>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-2-12c4dfd24227@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-pks-odb-for-each-object-v3-2-12c4dfd24227@pks.im>

On Wed, Jan 21, 2026 at 01:50:18PM +0100, Patrick Steinhardt wrote:

> The `flags` parameter accepted by various `for_each_object()` functions
> is a bitfield of multiple flags. Such parameters are typically unsigned
> in the Git codebase, but we use `enum odb_for_each_object_flags` in
> some places.

I agree that using "unsigned" instead of "int" for flags is a good
practice in general. But isn't using "unsigned" instead of an enum
strictly worse?

The enum is more descriptive to human readers (since the type defines
which flags we expect to see). And it lets the compiler use the correct
type in the few cases where it might matter. E.g., if you imagine an
enum that defines 40 bits, then the compiler will know that it needs to
use a type larger than 32 bits to store it. Whereas passing a raw
"unsigned" will truncate some values.

I don't expect this latter reason to be common, but if we are going to
have a general principle for how to pass flags, it feels like passing
the enum (assuming the flags are defined in one) is always better. And
IMHO just the first reason (human readers) makes it worth doing that way
anyway.

You can find this pattern in lots of places (try grepping for "enum
[a-z_]* flag"). The ones that aren't are typically using flags that are
not using enums at all (just #defines).

> diff --git a/object-file.c b/object-file.c
> index 64e9e239dc..8fa461dd59 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -414,7 +414,8 @@ static int parse_loose_header(const char *hdr, struct object_info *oi)
>  
>  int odb_source_loose_read_object_info(struct odb_source *source,
>  				      const struct object_id *oid,
> -				      struct object_info *oi, int flags)
> +				      struct object_info *oi,
> +				      unsigned flags)

So I'd argue this should be switching to the enum...

> diff --git a/packfile.h b/packfile.h
> index 15551258bd..447c44c4a7 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -339,9 +339,9 @@ typedef int each_packed_object_fn(const struct object_id *oid,
>  				  void *data);
>  int for_each_object_in_pack(struct packed_git *p,
>  			    each_packed_object_fn, void *data,
> -			    enum odb_for_each_object_flags flags);
> +			    unsigned flags);
>  int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
> -			   void *data, enum odb_for_each_object_flags flags);
> +			   void *data, unsigned flags);

..and these should be left untouched.

-Peff
