Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9462247A64
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 23:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722641089; cv=none; b=pagzXGWCjG5BeFalnZH406x5G6x0T74/FYYjyQz7+ucgHq4pxCYddMS0WB/bGTAeO+E+4Xb5z5GtNWg7ViTjAn2KQNkcY/Wcn+MdvYTngMaLTygzVpqllO+ktwtFbts4M1ddZnqpYLAYtcVG6KOZ4Kh+YXrc50mN5cYV9tLiEzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722641089; c=relaxed/simple;
	bh=XKsyyt6PpUgCcekMsLi6mxW3yrE2QVlZnlLi9KuAlx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NewGwemqc3GVabwiJjYBiooNhhQAwl9OuNO/DToiCDRsIpyyWxdR3Zgpp7BcCL+yfapupSwXNapbyc7drz6IHAlRRxzpYqrDqP7ILvUWMvJLZYePCae8MyH5z73o8/Dg7DTj1XCMqtZtGo9rubya91jlV3K3ku2WLDQyi4uxagM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cygfc1Pu; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cygfc1Pu"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 793E118D80;
	Fri,  2 Aug 2024 19:24:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XKsyyt6PpUgCcekMsLi6mxW3yrE2QVlZnlLi9K
	uAlx4=; b=Cygfc1Pu6GQY+Puqt4Tj+tkVCyhu+N2wXU1XN2urLCCX5O7VHtAn7j
	rSUA7aNLhY9ZyDw36tFyLodt9U1MrWFl6IAhNQlHsM49bezyNttH4ArlZ46zf6gZ
	Mfr3Nt4cg2ev7Pqr/JUd0NSk7mGHAvSY4q2qKhaLlgGTzMOQzyYPA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 70DE218D7F;
	Fri,  2 Aug 2024 19:24:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD09918D7E;
	Fri,  2 Aug 2024 19:24:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] reftable/stack: handle locked tables during
 auto-compaction
In-Reply-To: <dc2217830700acaac50d96361352ff433aa57a4d.1722435214.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 31 Jul 2024 16:15:25 +0200")
References: <cover.1722435214.git.ps@pks.im>
	<dc2217830700acaac50d96361352ff433aa57a4d.1722435214.git.ps@pks.im>
Date: Fri, 02 Aug 2024 16:24:42 -0700
Message-ID: <xmqqo76a8q4l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6767A0E6-5126-11EF-9C40-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> -	for (i = first; i <= last; i++) {
> -		stack_filename(&table_name, st, reader_name(st->readers[i]));
> +	for (i = last + 1; i > first; i--) {
> +		stack_filename(&table_name, st, reader_name(st->readers[i - 1]));
>  
>  		err = hold_lock_file_for_update(&table_locks[nlocks],
>  						table_name.buf, LOCK_NO_DEREF);
>  		if (err < 0) {
> -			if (errno == EEXIST)
> +			/*
> +			 * When the table is locked already we may do a
> +			 * best-effort compaction and compact only the tables
> +			 * that we have managed to lock so far. This of course
> +			 * requires that we have been able to lock at least two
> +			 * tables, otherwise there would be nothing to compact.
> +			 * In that case, we return a lock error to our caller.
> +			 */
> +			if (errno == EEXIST && last - (i - 1) >= 2 &&
> +			    flags & STACK_COMPACT_RANGE_BEST_EFFORT) {
> +				err = 0;
> +				/*
> +				 * The subtraction is to offset the index, the
> +				 * addition is to only compact up to the table
> +				 * of the preceding iteration. They obviously
> +				 * cancel each other out, but that may be
> +				 * non-obvious when it was omitted.
> +				 */
> +				first = (i - 1) + 1;
> +				break;

OK, so this case no longer jumps to "done" label.  Starting from the
high end of the st->readers[] array down to what we manged to take
locks on will be processed with the existing logic that compacted
first..last, which makes sense.

> +			} else if (errno == EEXIST) {
>  				err = REFTABLE_LOCK_ERROR;
> -			else
> +				goto done;
> +			} else {
>  				err = REFTABLE_IO_ERROR;
> -			goto done;
> +				goto done;
> +			}
>  		}
>  
>  		/*
> @@ -1270,7 +1308,7 @@ static int stack_compact_range(struct reftable_stack *st,
>  	 * delete the files after we closed them on Windows, so this needs to
>  	 * happen first.
>  	 */
> -	err = reftable_stack_reload_maybe_reuse(st, first < last);
> +	err = reftable_stack_reload_maybe_reuse(st, first_to_replace < last_to_replace);

What is this change about?

No code changed that computes first_to_replace and last_to_replace?
Perhaps before this step, using first/last and using
first_to_replace/last_to_replace did not make any difference,
because we never dealt with a case where we failed to lock any of
the tables?

I am wondering if this would be helped by a no-op clarification
before the actual behaviour change, similar to how step 4/8 added
the nlocks variable.

Thanks.
