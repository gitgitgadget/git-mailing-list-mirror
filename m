Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2503352C54
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771845083; cv=none; b=S+ugIZtuKp7U+B+xNFflxqXMeVOPsVJgOVXIjsZEwJsLzcrvmzEsEOHgyTsPmLBTXnJthqoA/WRyQz//Rxn4D67NXw/Y8L9BGKWK+eF2oyE2yZZxjSAuoBjPzE3nVPa4vSNxUNCBkVRNkIokilHELHXUUDHO3t/S3Zod9orke58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771845083; c=relaxed/simple;
	bh=cp8k/bYdiD/BvzVUkclHXy8jOA/fglrJISI49on9Z24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3CwsH2HDP9W3FlBtdxDGutN+qgwVNwSkTQo+EBZ4xTTzDaM+Qh93jzKarbQTMqifrgXGpt6w3qp+hsXpTjl0kb5EDLeczgOCKB1IXmdcW5QmoDw1zdMXk4V8gwtZ7s54hi5KHO+nxx0eF4GmZvaJL/2DXVrOOjuoTEaM8ASlIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MOglZIBd; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MOglZIBd"
Received: (qmail 51911 invoked by uid 109); 23 Feb 2026 11:11:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=cp8k/bYdiD/BvzVUkclHXy8jOA/fglrJISI49on9Z24=; b=MOglZIBdNzirQUYuiYG/hTmMtljBC13e5/u9+oTt+GELFQxYLS9yOh/sPQlm9+p/5WszqEgPJlewUgmh4KaI33ttMSmd3zA8KUK7T3Pg3qnMdmSefNsxvdWFUqSxVRH203vDf0lR8TVDgwvBJVC7uhcYje+nCaHtW8EA3z4CNyVX/6Z4CQmBthcnIP/dEksuN0pAQKbtpu202mfxyc9gc3tHKwieVWA3Qc8khunV+c6XYNhsMWvPPLCHQkWCc9JG2WafzIifwDWxiUDilXcMWC7mpLiYCwBllDKxMRSkOcpPrvUg6Ah+tw7CKKMBszidvqgmi7Qf8A/ZIU310ZEYDg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 11:11:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 100075 invoked by uid 111); 23 Feb 2026 11:11:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 06:11:25 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 06:11:20 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] pack-check: fix verification of large objects
Message-ID: <20260223111120.GC215364@coredump.intra.peff.net>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-4-c29036832b6e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260223-pks-fsck-fix-v1-4-c29036832b6e@pks.im>

On Mon, Feb 23, 2026 at 10:50:43AM +0100, Patrick Steinhardt wrote:

> diff --git a/pack-check.c b/pack-check.c
> index 46782a29d5..6149567060 100644
> --- a/pack-check.c
> +++ b/pack-check.c
> @@ -155,7 +155,7 @@ static int verify_packfile(struct repository *r,
>  			err = error("packed %s from %s is corrupt",
>  				    oid_to_hex(&oid), p->pack_name);
>  		else if (!data &&
> -			 (!(stream = odb_read_stream_open(r->objects, &oid, NULL)) ||
> +			 (packfile_read_object_stream(&stream, p, entries[i].offset) < 0 ||

And now this change is delightfully simple.

> +test_expect_success 'fsck handles multiple packfiles with big blobs' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		blob_one=$(test-tool genrandom one 200k | git hash-object -t blob -w --stdin) &&
> +		blob_two=$(test-tool genrandom two 200k | git hash-object -t blob -w --stdin) &&
> +		printf "%s\n" "$blob_one" | git pack-objects .git/objects/pack/pack &&
> +		printf "%s\n" "$blob_two" | git pack-objects .git/objects/pack/pack &&
> +		remove_object "$blob_one" &&
> +		remove_object "$blob_two" &&
> +		git -c core.bigFileThreshold=100k fsck
> +	)
> +'

I like seeing this much-more-specific test case. It does sort of become
a noop if we fix the iteration problem, though.

A more concrete test would probably be something like:

   1. Two packs, $X and $Y, both contain the same object.

   2. The object is corrupt in $X but not in $Y.

   3. Running fsck detects that one copy is corrupt but the other is
      not.

Right now it may or may not fail depending on the ordering of the packs
in the MRU list (which we might be able to tweak via mtimes). But
hopefully in the "after" state it should deterministically complain
about $X.

-Peff
