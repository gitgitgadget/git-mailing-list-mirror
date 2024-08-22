Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFDF1CF2BC
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724350874; cv=none; b=Gz0MFdD/yz+yxE6W9pb/H/uj+0N2Z8adUJ4iYl+Nkx8dwGiteo+gby5iKrtb8cAemf/Do3EG617NIkTiIykfv2cg8j8sjRSlLrqH8we+0swEVDCkrVgAvkTDWPsDgpGP/1r8OEN5tkGzNArDLQKxbRyRqVqUrAuqHSiiZ8cH8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724350874; c=relaxed/simple;
	bh=ZYtkZm8m651hV7kMblK8rTCt5muFPIEKRQP4teBkvKQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HRSxWmPOiJ3Kv5yHreMHhxpDsROAsANmPXwA++XGj24x+qrtfdxosQaC1PUB9OVLfqngyTJwJAIWx6x1DDjEJTn3x8533S1gr9U8tXbCcg1+3MuUfeo2WrQtz649SeGrxcF2tAPCxPaKyh1NaBWMO4niqASgq0bA+tTAPJah9h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Nfc/bIxC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nfc/bIxC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B24D2204C;
	Thu, 22 Aug 2024 14:21:04 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZYtkZm8m651hV7kMblK8rTCt5muFPIEKRQP4te
	BkvKQ=; b=Nfc/bIxCrDEs8z0COXRxnmGLoRUht4OECV1eqkF77ivKxdzImtaZ4N
	Vodhjr5HxPFvwdRAmBF669z/iGOiJhESQ4frKEXa5uAo0cPbxVk0bowxiWfRBSD/
	HXK6BCTzCqcBukm04goWZOoaD29vwNBfMi8ShYIK+4MJ6WrHU9k7w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC8862204B;
	Thu, 22 Aug 2024 14:21:03 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D90402204A;
	Thu, 22 Aug 2024 14:21:02 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 19/20] transport: fix leaking arguments when fetching
 from bundle
In-Reply-To: <4c5740afe43c3bb619a9cba0c1634097c27ed33f.1724315484.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 22 Aug 2024 11:18:08 +0200")
References: <cover.1724159575.git.ps@pks.im> <cover.1724315484.git.ps@pks.im>
	<4c5740afe43c3bb619a9cba0c1634097c27ed33f.1724315484.git.ps@pks.im>
Date: Thu, 22 Aug 2024 11:21:01 -0700
Message-ID: <xmqqmsl4qv02.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4A073182-60B3-11EF-9D7E-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In `fetch_refs_from_bundle()` we assemble a vector of arguments to pass
> to `unbundle()`, but never free it. And in theory we wouldn't have to
> because `unbundle()` already knows to free the vector for us. But it
> fails to do so when it exits early due to `verify_bundle()` failing.
>
> The calling convention that the arguments are freed by the callee and
> not the caller feels somewhat weird. Refactor the code such that it is
> instead the responsibility of the caller to free the vector, adapting
> the only two callsites where we pass extra arguments. This also fixes
> the memory leak.
>
> This memory leak gets hit in t5510, but fixing it isn't sufficient to
> make the whole test suite pass.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/bundle.c | 2 ++
>  bundle.c         | 4 +---
>  transport.c      | 2 ++
>  3 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/bundle.c b/builtin/bundle.c
> index d5d41a8f672..df97f399019 100644
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -220,7 +220,9 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
>  			 &extra_index_pack_args, 0) ||
>  		list_bundle_refs(&header, argc, argv);
>  	bundle_header_release(&header);
> +
>  cleanup:
> +	strvec_clear(&extra_index_pack_args);
>  	free(bundle_file);
>  	return ret;
>  }
> diff --git a/bundle.c b/bundle.c
> index ce164c37bc8..0f6c7a71ef1 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -639,10 +639,8 @@ int unbundle(struct repository *r, struct bundle_header *header,
>  	if (flags & VERIFY_BUNDLE_FSCK)
>  		strvec_push(&ip.args, "--fsck-objects");
>  
> -	if (extra_index_pack_args) {
> +	if (extra_index_pack_args)
>  		strvec_pushv(&ip.args, extra_index_pack_args->v);
> -		strvec_clear(extra_index_pack_args);
> -	}
>  
>  	ip.in = bundle_fd;
>  	ip.no_stdout = 1;
> diff --git a/transport.c b/transport.c
> index f0672fdc505..da639d3bff0 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -189,6 +189,8 @@ static int fetch_refs_from_bundle(struct transport *transport,
>  		       &extra_index_pack_args,
>  		       fetch_pack_fsck_objects() ? VERIFY_BUNDLE_FSCK : 0);
>  	transport->hash_algo = data->header.hash_algo;
> +
> +	strvec_clear(&extra_index_pack_args);
>  	return ret;
>  }

Looks much better.  Will queue.  Thanks.
