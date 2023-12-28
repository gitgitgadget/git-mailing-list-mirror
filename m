Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA64310941
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xWUepPUQ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 91A5528CB0;
	Thu, 28 Dec 2023 12:03:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ug16ddABCa669iXYoZoL0Bs1bUjZMTdG3BLLcU
	T41UA=; b=xWUepPUQdO9DIYQl04srxj6JzvLkub18l959tGaa3M7O028WThKyhA
	BxiwZ3+34bIWycmicC/7qsFEI3vJMo6M1sw5uz7jAoJUmp/pGINDMoljrXTwMQ7S
	q0VSXG6jXegfsuXVJMcoinjPrjLxkOpGPIlB//o0ebVLBzrexSu1s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A4A928CAF;
	Thu, 28 Dec 2023 12:03:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C97E28CAC;
	Thu, 28 Dec 2023 12:03:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 7/8] reftable/merged: really reuse buffers to compute
 record keys
In-Reply-To: <6313f8affdc136b183c1bd411d481efe5c676aee.1703743174.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 28 Dec 2023 07:28:04 +0100")
References: <cover.1703063544.git.ps@pks.im> <cover.1703743174.git.ps@pks.im>
	<6313f8affdc136b183c1bd411d481efe5c676aee.1703743174.git.ps@pks.im>
Date: Thu, 28 Dec 2023 09:03:00 -0800
Message-ID: <xmqq8r5ei7jv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F5C97452-A5A2-11EE-983D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In 829231dc20 (reftable/merged: reuse buffer to compute record keys,
> 2023-12-11), we have refactored the merged iterator to reuse a set of
> buffers that it would otherwise have to reallocate on every single
> iteration. Unfortunately, there was a brown-paper-bag-style bug here as
> we continue to release these buffers after the iteration, and thus we
> have essentially gained nothing.

s/-style// perhaps.  It took me more than just reading of the above
but I needed to see the code before noticed that you are talking
about strbuf_release().  Only after that I think I understood what
you meant as a bug.

    With the change, instead of using a new "entry_key" strbuf for
    each iteration, the code now passes mi->entry_key to
    reftable_record_key(), which will reuse the existing .buf member
    of the strbuf to avoid reallcation.  But releasing the strbuf in
    each iteration defeats such optimization.

I suspect that a Git developer who will be reading "git log" output
in 6 months and finds the above paragraph understands the problem
and its fix better if the description hinted strbuf_reset() near
where it mentions "release", something like:

    ... to reuse a pair of long-living strbufs by relying on the
    fact that reftable_record_key() tries to reuse its already
    allocated .buf member by calling strbuf_reset(), which should
    give us significantly fewer reallocation compared to the old
    code that used on-stack strbufs that are allocated for each and
    every iteration.  Unfortunately, we called strbuf_release() on
    these long-living strbufs that we meant to reuse, defeating the
    optimization.

or along that line, perhaps?

Other than that, a very reasonable fix.  Thanks for a pleasant read.

> Fix this performance issue by not releasing those buffers on iteration
> anymore, where we instead rely on `merged_iter_close()` to release the
> buffers for us.
>
> Using `git show-ref --quiet` in a repository with ~350k refs this leads
> to a significant drop in allocations. Before:
>
>     HEAP SUMMARY:
>         in use at exit: 21,163 bytes in 193 blocks
>       total heap usage: 1,410,148 allocs, 1,409,955 frees, 61,976,068 bytes allocated
>
> After:
>
>     HEAP SUMMARY:
>         in use at exit: 21,163 bytes in 193 blocks
>       total heap usage: 708,058 allocs, 707,865 frees, 36,783,255 bytes allocated
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/merged.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/reftable/merged.c b/reftable/merged.c
> index 556bb5c556..a28bb99aaf 100644
> --- a/reftable/merged.c
> +++ b/reftable/merged.c
> @@ -128,8 +128,6 @@ static int merged_iter_next_entry(struct merged_iter *mi,
>  
>  done:
>  	reftable_record_release(&entry.rec);
> -	strbuf_release(&mi->entry_key);
> -	strbuf_release(&mi->key);
>  	return err;
>  }
