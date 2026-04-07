Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A0D37B417
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775597379; cv=none; b=ivGpweRuykZ0uUytkC9dJLBolcHP1LIbsYDV/2M+GAB3my2Hs6ijoGw1I4sDRclcgptr+SSeK9uh9FnKWvufozX4JkI1wIxVgVZ37y7zcAdNcUYRR4HLTL2EJ1rbwkiMHz+9tpXNDv4lK0+aTxoOQf4HuWqUeHx+lHDDKJApnm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775597379; c=relaxed/simple;
	bh=SDg3Ontw/faEXgcnjlrAdh5eGGbV+3b/yP4l6EMSRuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXiP27jWOumpRpoEuT/38q1Owuu4A+R06uVu+32yzno8z69ikXnY86QJg6R/p/rOqm7YsVfS2bIxsHUY1ccB2rWI6tYrFglwii3yrfzgPSokyHH3vj/t7Z1AomJnRXanOXDQYEhwdPEDZC6QpDb9qwggzuDCu4ByvTQ7zV9l8h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Fo6C7ZzC; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Fo6C7ZzC"
Received: (qmail 275976 invoked by uid 106); 7 Apr 2026 21:29:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SDg3Ontw/faEXgcnjlrAdh5eGGbV+3b/yP4l6EMSRuY=; b=Fo6C7ZzCI+RCxf5htXNScbrABo4fMON+kasMDCutYMlO2z0N+TlKxevqR7DwQrNWXsTgpqeHFIpqJGR72QvJgdbms5O+mbAYXCjqYv7H3moCca4B4sJXaPD30MjTsbguudV5BF92ssk9A9Dc8wFfh7M6YlRy4W+KX11fnCgDq8/yXUQ4R7qibdFaN1BbeKRXe9onO73A8yimy6mYpM6mRLf2lcCztfsgFUpWGVWHbE/MD9yK0kgE0JyURoTVYMRcvmAumFj7CIC25rqgqbXQLccaqt3uGiivUD9O1gCx+csosVPoaTTSywXfC4AdeUAe/I7vZPw69r8Ws/0/rfPBtw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Apr 2026 21:29:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 452097 invoked by uid 111); 7 Apr 2026 21:29:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Apr 2026 17:29:30 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 7 Apr 2026 17:29:30 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, ps@pks.im,
	luca.stefani.ge1@gmail.com
Subject: Re: [PATCH] object-file: avoid ODB transaction when not writing
 objects
Message-ID: <20260407212930.GA1315247@coredump.intra.peff.net>
References: <20260407201730.2526914-1-jltobler@gmail.com>
 <xmqqo6ju31wx.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo6ju31wx.fsf@gitster.g>

On Tue, Apr 07, 2026 at 02:18:06PM -0700, Junio C Hamano wrote:

> From: Justin Tobler <jltobler@gmail.com>
> Date: Tue, 7 Apr 2026 15:17:30 -0500
> Subject: [PATCH] object-file: avoid ODB transaction when not writing objects
> [...]
> +static int hash_blob_stream(const struct git_hash_algo *hash_algo,
> +			    struct object_id *result_oid, int fd, size_t size)
> +{
> +	unsigned char buf[16384];
> +	struct git_hash_ctx ctx;
> +	unsigned header_len;
> +
> +	header_len = format_object_header((char *)buf, sizeof(buf),
> +					  OBJ_BLOB, size);
> +	hash_algo->init_fn(&ctx);
> +	git_hash_update(&ctx, buf, header_len);
> +
> +	while (size) {
> +		size_t rsize = size < sizeof(buf) ? size : sizeof(buf);
> +		ssize_t read_result = read_in_full(fd, buf, rsize);
> +
> +		if ((read_result < 0) || ((size_t)read_result != rsize))
> +			return -1;
> +
> +		git_hash_update(&ctx, buf, rsize);
> +		size -= read_result;
> +	}
> +
> +	git_hash_final_oid(result_oid, &ctx);

This looks correct to me. In the back of my mind I felt like we might
already have a function to check a streaming hash, but I was just
thinking of how parse_object() streams blobs for its hash-check. And
that is always coming from the object database, whereas here we are
taking data from elsewhere. So we do need this new function.

I probably would have used fewer parentheses in the conditional, but
that may be personal preference. ;)

> diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
> index c824c1a25c..c1dbc6359a 100755
> --- a/t/t1517-outside-repo.sh
> +++ b/t/t1517-outside-repo.sh
> @@ -93,6 +93,14 @@ test_expect_success 'diff outside repository' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'diff files exceeding bigFileThreshold outside repository' '
> +	cd non-repo &&
> +	echo foo >foo &&
> +	echo bar >bar &&
> +	test_must_fail git -c core.bigFileThreshold=1 diff -- foo bar >actual &&
> +	test_grep "diff --git a/foo b/bar" actual
> +'

This does a "cd" outside of a sub-shell, which affects all of the
subsequent tests.

We also are already using the "nongit" wrapper in this script, so it
could be used here.

Thought it was found originally with diff, the bug can also be
demonstrated with just hash-object, which does make the test a little
simpler.

The second and third are more style/taste questions, but I think the
first is a blocker.

-Peff
