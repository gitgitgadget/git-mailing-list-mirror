Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3AC15B1
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 00:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708387463; cv=none; b=fxzUlOQ4K9vsINlJF6uH/Xew6/7Wv5HqfAir4KPocLc4lUFCdhEtn5UVnU9lP6WwERy6a7dkCAvnXk8OmlFB8K3Lns7A/U6AV4FPUTghqmT+/q8zUK+yLrvc6IJ4X0nETA+SGvi5QQuuBQvPtRTJLmmYMLJneeqBfZWIntXnDrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708387463; c=relaxed/simple;
	bh=DAUCpqjubvAG/KnplRxmmYFvAqZxQMG2UJBYsLLjcEk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mnCOsYInBDS8BsujbZfTB8ca7WZbR9e1Nu7OkPa97cnfq2IP5XoFTJnnngn8EL1kjAX+xnNq2R1Qbe68MLp6M6p+8lcCtjRJarslUHBWIASriQNbYZ1qDx1Jcq9MoDS2w1gSU1SteQqUMsHy9nTkTDlrq0nLYEA06omJOD9Ugss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xLjemB09; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xLjemB09"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 338481D3E1C;
	Mon, 19 Feb 2024 19:04:18 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DAUCpqjubvAG/KnplRxmmYFvAqZxQMG2UJBYsL
	LjcEk=; b=xLjemB09nx26s4y8uBZ940+TCd6E/D2nAt1UCJmM793ql/wKUyFP7V
	gNTJDKyeG6y6O1oclkcAllHIsw3s/yhEBKl94ebyS6tqA/6xl96PPS51QECDBMxS
	KUYN6TE4s0tCRC6B/nzzO46YFuDQVBamwoFqV+D10WPgNnd1L/CgQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BC0B1D3E1B;
	Mon, 19 Feb 2024 19:04:18 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E3B61D3E1A;
	Mon, 19 Feb 2024 19:04:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] refs/files: sort reflogs returned by the reflog
 iterator
In-Reply-To: <e4e4fac05c7f4bcac8ef96bdebb8a68eef40ead4.1708353264.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 19 Feb 2024 15:35:26 +0100")
References: <cover.1708353264.git.ps@pks.im>
	<e4e4fac05c7f4bcac8ef96bdebb8a68eef40ead4.1708353264.git.ps@pks.im>
Date: Mon, 19 Feb 2024 16:04:16 -0800
Message-ID: <xmqq34to0znj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 96FE5A4A-CF83-11EE-9D35-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> We use a directory iterator to return reflogs via the reflog iterator.
> This iterator returns entries in the same order as readdir(3P) would and
> will thus yield reflogs with no discernible order.
>
> Set the new `DIR_ITERATOR_SORTED` flag that was introduced in the
> preceding commit so that the order is deterministic. While the effect of
> this can only been observed in a test tool, a subsequent commit will
> start to expose this functionality to users via a new `git reflog list`
> subcommand.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c           | 4 ++--
>  t/t0600-reffiles-backend.sh    | 4 ++--
>  t/t1405-main-ref-store.sh      | 2 +-
>  t/t1406-submodule-ref-store.sh | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 75dcc21ecb..2ffc63185f 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2193,7 +2193,7 @@ static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
>  
>  	strbuf_addf(&sb, "%s/logs", gitdir);
>  
> -	diter = dir_iterator_begin(sb.buf, 0);
> +	diter = dir_iterator_begin(sb.buf, DIR_ITERATOR_SORTED);
>  	if (!diter) {
>  		strbuf_release(&sb);
>  		return empty_ref_iterator_begin();
> @@ -2202,7 +2202,7 @@ static struct ref_iterator *reflog_iterator_begin(struct ref_store *ref_store,
>  	CALLOC_ARRAY(iter, 1);
>  	ref_iterator = &iter->base;
>  
> -	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 0);
> +	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 1);

This caught my attention.  Once we apply this patch, the only way
base_ref_iterator_init() can receive 0 for its last parameter
(i.e. 'ordered') is via the merge_ref_iterator_begin() call in
files_reflog_iterator_begin() that passes 0 as 'ordered'.  If we
force files_reflog_iterator_begin() to ask for an ordered
merge_ref_iterator, then we will have no unordered ref iterators.
Am I reading the code right?
