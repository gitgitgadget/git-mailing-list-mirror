Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053D4D9E0
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 21:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711576469; cv=none; b=egO+kVLyoPiWNd7vFwQXiPdXQScXwd6qhLxGdYPHwi3lO+kSqoxHas9xK1XHL80Y3COO7+T01nw+mr20gLUCq12mlZnz4j9wbsozQFE5yXkU08UUaiJhXt6kw1q3rkRJDsZT81u5JzCbSWSeXHUFvGQSFPVN7f0IpMx3tTOKrTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711576469; c=relaxed/simple;
	bh=0oO3PAq4PPec87hW5a9DjdB8BiIs/nSr52mo/A5pu+U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RdILd4/1WtnMl18y/fEZwgHgJFFPo+RojkgeEgMDNTg7UPD1W+s6mos+EHnOK8X28fAEfqacTDTbG2r42Mm2wZNduwjkNVPwfBvxxuo2rwoJIYb/l6gDvhBSGSdyF1P7V4DtO9X8YU5PGG25Oi/2wgjIlHcGs++ENNPIh0yWlL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SNGAwjZE; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SNGAwjZE"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B2BCC1E45DF;
	Wed, 27 Mar 2024 17:54:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0oO3PAq4PPec87hW5a9DjdB8BiIs/nSr52mo/A
	5pu+U=; b=SNGAwjZEBQQ2KF5CW0ficIG0lUAhoewzf+x98ShwtrL9x170cA4MlH
	gAt3r9tLUhORs7fhO9MultHjWo7XaCHaWBx3XywP3bO+qK5/+zu4qm8KihG/CSXy
	LF5Pnu+1/N6JWU0l/qTzsoY9ePg/aIo/8WWQWZ6B0RXocMz6btI+k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AA45C1E45DC;
	Wed, 27 Mar 2024 17:54:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 188A61E45D4;
	Wed, 27 Mar 2024 17:54:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Eric Wong <e@80x24.org>,  git@vger.kernel.org
Subject: Re: [PATCH 2/3] treewide: switch to khashl for memory savings
In-Reply-To: <20240327093710.GA847433@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 27 Mar 2024 05:37:10 -0400")
References: <20240325230704.262272-1-e@80x24.org>
	<20240325230704.262272-3-e@80x24.org> <xmqqttksanpj.fsf@gitster.g>
	<20240327093710.GA847433@coredump.intra.peff.net>
Date: Wed, 27 Mar 2024 14:54:18 -0700
Message-ID: <xmqq7chn1gtx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 909DAAC0-EC84-11EE-8B69-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> On Tue, Mar 26, 2024 at 10:48:40AM -0700, Junio C Hamano wrote:
>
>> $ make builtin/fast-import.sp ;# part of make sparse
>>     SP builtin/fast-import.c
>> builtin/fast-import.c: note: in included file (through oidset.h, packfile.h):
>> khashl.h:516:1: error: Using plain integer as NULL pointer
>> khashl.h:516:1: error: Using plain integer as NULL pointer
>> make: *** [Makefile:3237: builtin/fast-import.sp] Error 1
>> 
>> I found IMPL_GET and IMPL_DEL's use of (h->keys == 0) were giving
>> one of these two, and managed to reduce the error to just one with
>> the attached patch, but I don't know what the other error is coming
>> from.
>
> Probably:
>
> diff --git a/khashl.h b/khashl.h
> index 8fcebed237..1e724bbf88 100644
> --- a/khashl.h
> +++ b/khashl.h
> @@ -116,7 +116,7 @@ static kh_inline khint_t __kh_h2b(khint_t hash, khint_t bits) { return hash * 26
>  
>  #define __KHASHL_IMPL_RESIZE(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
>  	SCOPE void prefix##_resize(HType *h, khint_t new_n_buckets) { \
> -		khint32_t *new_used = 0; \
> +		khint32_t *new_used = NULL; \
>  		khint_t j = 0, x = new_n_buckets, n_buckets, new_bits, new_mask; \
>  		while ((x >>= 1) != 0) ++j; \
>  		if (new_n_buckets & (new_n_buckets - 1)) ++j; \
>
> -Peff

Spot on.  With this (and the other two 0 -> NULL fixes), and with
the SWAP() thing in brian's credential series fixed, the tip of
'seen' passes the static-analysis and sparse CI jobs again.

Thanks.
