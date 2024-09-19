Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1A41DA23
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709740; cv=none; b=pDCi5r2pV4nND56mBUkPGfy9ogNtNnpMv2yNwne01MuNuy6pIpwlT8CuhDyJCK0pINTBNxa37l6E0/LJqpOiH1qmLvmuByzG0wwyo5sfmvnpqs7loi7wBFDiJ/DvsDFFZ+WIuzZEqdJ0uDPc58/HF3DLcJG9U7bYA+MkKari8kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709740; c=relaxed/simple;
	bh=jw2T0wATqy3Pz79GLjpOCOoZc5tCgHc9W0vPtIDqEtE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RmibIZwyXMH1N/R+y+fnNpvmDXoEqto4PYLR1VJQcLZG/UMncEOa1rxk/TEFEXvc9XTXNRMLejny92G8k7UBVRSb+AEGbcICmxIFRGJC0fg0L/vwL3Aedn2ZLIg+ybfXNJTgfmixBxaEbh9Qs/hZ33xJMVgSM+gaAyn90Huui+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o/j2wAgu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o/j2wAgu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 46FFA1CFD1;
	Wed, 18 Sep 2024 21:35:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jw2T0wATqy3Pz79GLjpOCOoZc5tCgHc9W0vPtI
	DqEtE=; b=o/j2wAguTBXUmEDhm9EJOeHy6Y+PnRDDqlRtBUAXxeuDmJgw9dbSlq
	/k47X9kmvsSP4UjV1LjIJm2Z8/LN4fUNu0gYwiRQUwnnu20NWCITL1qFGT/bybuY
	Qcz5NmtYAB3VhJm+EHbu3Ro0LMc89zcW6Dc++UCOYOu8bU+mwMn/A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3F8621CFD0;
	Wed, 18 Sep 2024 21:35:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D5B61CFCD;
	Wed, 18 Sep 2024 21:35:36 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] cache-tree: detect mismatching number of index entries
In-Reply-To: <595693a6420b2571aabd51ed989bedfa0cfa62e2.1726556195.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 17 Sep 2024 09:13:11 +0200")
References: <cover.1726556195.git.ps@pks.im>
	<595693a6420b2571aabd51ed989bedfa0cfa62e2.1726556195.git.ps@pks.im>
Date: Wed, 18 Sep 2024 18:35:35 -0700
Message-ID: <xmqqttec8ly0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7857CB9E-7627-11EF-9EDB-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +	if (it->entry_count + pos > istate->cache_nr) {
> +		ret = error(_("corrupted cache-tree has entries not present in index"));
> +		goto out;
> +	}

Is it a safe assumption that the if() condition always indicates an
error?  When sparse-index is in effect, istate->cache_nr may be a
number that is smaller than the true number of paths in the index
(because all paths under a subdirectory we are not interested in are
folded into a single tree-ish entry), and I am not sure how it
should interact with it->entry_count (i.e. the number of paths under
the current directory we are looking at, which obviously cannot be a
sparsified entry) and pos (i.e. the index into active_cache[] that
represend the first path under the current directory)?

I guess as long as "it" is not folded, it does not matter how other
paths from different directories in active_cache[] are sparsified or
expanded, as long as "pos" keeps track of the current position
correctly.

> diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
> index 2501c89c1c9..3f602adb055 100755
> --- a/t/t4058-diff-duplicates.sh
> +++ b/t/t4058-diff-duplicates.sh
> @@ -132,15 +132,15 @@ test_expect_success 'create a few commits' '
>  	rm commit_id up final
>  '
>  
> -test_expect_failure 'git read-tree does not segfault' '
> -	test_when_finished rm .git/index.lock &&
> -	test_might_fail git read-tree --reset base
> +test_expect_success 'git read-tree does not segfault' '
> +	test_must_fail git read-tree --reset base 2>err &&
> +	test_grep "error: corrupted cache-tree has entries not present in index" err
>  '

Very good.  test_might_fail is a sign of trouble, and this gives us
a lot more predictability.
