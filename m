Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF62AC17
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762292022; cv=none; b=XZKxb9CNL4uyikKiU0+PkIn72QczSS7ggtC7GyEA8yhH+HkHcYZsU9FwIoD1QDfjdkvYotOeq7SebXMQMRM0F8gXV/SvJdhXlXbEmjhMfZfjYoefnlZBttWUxAgsCJALJoNjFBkvQxsM+QRKFH8HNmzQ4JroBbelY4VEGdHV+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762292022; c=relaxed/simple;
	bh=KKlv/W6kjlqznNcv7HrMxpie2W2LnmM78CEbrSNA80U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMi3j19uu7lSw4wznbLUq1i442x51Sid6EChxRjRhDdNTMUFa0Z7XRwqWrC+JTFm7+20C74oBDZuXGCTMPECiYfPXu9JNDpb5s1/3YHnpMQNha1Hn6WQhxIis9gK4jdi9HAbJRDxYZU3xdsyPMr7YvuLDmhof7iqo+wlPeIJQgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Xym5LOvV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Xym5LOvV"
Received: (qmail 431051 invoked by uid 109); 4 Nov 2025 21:33:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=KKlv/W6kjlqznNcv7HrMxpie2W2LnmM78CEbrSNA80U=; b=Xym5LOvVpvpfvRwDQjwkD6uQWj651x2XLgNky928g6DIzlaPre/61IBnGq+ePYezFDSi0S57BgNLyYulTT6JDdWJY9m86x0M/pEpuqaVHpmXZA5uAVLZsniO7Si/fU/ZiK5DCb882D9yHRcmn/bh4SvLY3SdFZmzipJvIIq8APS25lzFVWfm7V120LFhJkW1K9I5QH6VZRHybyHNeignnH9YIaFnywgB8OE9U24vyRN8/6nx4/qyelcsfvSytZewE36X1uu12+r1uw8JNwHX9Tbl9c2r9JP4Dkwqa1DtHv6ZtUznb56xe7aEFidRQKsq42wx3fXoYvphbfYJXQ5/rA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Nov 2025 21:33:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 677618 invoked by uid 111); 4 Nov 2025 21:33:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Nov 2025 16:33:32 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Nov 2025 16:33:32 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] ref-filter: fix stale parsed objects
Message-ID: <20251104213332.GB2618884@coredump.intra.peff.net>
References: <20251104-b4-pks-ref-filter-fixup-v1-1-2fbca52d76d9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104-b4-pks-ref-filter-fixup-v1-1-2fbca52d76d9@pks.im>

On Tue, Nov 04, 2025 at 03:36:13PM +0100, Patrick Steinhardt wrote:

> Fix the issue by resetting `maybe_object` in `get_object()`.

Thanks, this spot makes sense looking at the context.

> +test_expect_success 'annotated tag version sort' '
> +	git tag -a -m "sample 1.0" vsample-1.0 &&
> +	git tag -a -m "sample 2.0" vsample-2.0 &&
> +	git tag -a -m "sample 10.0" vsample-10.0 &&
> +	cat >expect <<-EOF &&
> +	vsample-1.0
> +	vsample-2.0
> +	vsample-10.0
> +	EOF
> +
> +	git tag --list --sort=version:tag vsample-\* >actual &&
> +	test_cmp expect actual &&
> +
> +	# Ensure that we also handle this case alright in the case we have the
> +	# peeled values cached e.g. via the packed-refs file.
> +	git pack-refs --all &&
> +	git tag --list --sort=version:tag vsample-\* &&
> +	test_cmp expect actual
> +'

This test seems fine, though I think you can see the same thing even
more easily with just:

  git for-each-ref --format='%(refname) %(tag)' refs/tags/vsample-\*

which shows each tag after the first with the same (wrong) tag.

Curiously if I run something similar in git.git like:

  git for-each-ref --format='%(refname) %(tag)'

I get garbage uninitialized data on each of the tag lines. The
difference is that the first parsed object is a non-tag, so our stale
parsed state didn't actually fill in the tag values. Surprisingly ASan
doesn't complain, but it may be because we end up looking at memory with
a bogus type-cast (get_or_parse returns the stale "struct commit", but
we cast it to a "struct tag").

I didn't dig too deeply there since the fix here should make it all go
away (and seems to in my testing). I wondered if there was a way for a
broken repo to fool the code here (we think something is a tag, but in
the odb it's really a commit or something), but I don't think so. We
enter grab_tag_values() based on data->type being OBJ_TAG, and then we
feed that same value to parse_object_buffer(). So it will be the same
everywhere, and our cast can never do the wrong thing. And if we see
corruption (e.g., a tag refers to object X as a blob, and then another
tag refers to it as a commit), then lookup_commit() should return NULL
for us.

So I think this fix should be sufficient.

-Peff
