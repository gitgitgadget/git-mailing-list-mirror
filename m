Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622054688
	for <git@vger.kernel.org>; Thu, 16 May 2024 18:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885061; cv=none; b=V7giOiUUq7++tKORWa+Y6MpH/NnfKLUvxujW9z0zrzAXcO30T+MOE84hr/3Ga3qv3A1HDgywcGvOxx9oLcce1LYII99aB2YHURBHRSeQRuAM2DCADqGfQ0u2ppQn3UE79A08O8ZlZC/JrompBILAVxZH/VHHH4YnGCh87vaCXNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885061; c=relaxed/simple;
	bh=TBwEi5wE6Uu1lNTIPi6g/VR+MHHtnNmSckAucXZ5D7M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bn0N61rQfnm9ZLcI+h6NzM/QsWj+DynZGLebvR5IRLEwrPnp8U3t3OOPcXmhO+n44gBRWwjc+W/vC2BUDtpHdCcLXPIva9vloXIXwtMuxzzwGJEf3yBZbrx/s4IbFNFaYoBdTdbDGvEZuPBJJnjll7AX8RdawSOec9GvIfprlNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GgDYSMqx; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GgDYSMqx"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 58E902155F;
	Thu, 16 May 2024 14:44:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TBwEi5wE6Uu1lNTIPi6g/VR+MHHtnNmSckAucX
	Z5D7M=; b=GgDYSMqxHpjyIAY37n6wqwkG7p9EYPvZNF2juVtGBzgkPPYm/xTEaB
	9y4dJd5bjp6L32bPZkShp6IV5tGiAnrD1s7YmQcgCzuYtlVrXouJ6p6v5CheEof5
	LhBattHoaGjK9+Az2WoIE75LhijPWyFdLTngKehYDk5Y4CKvJt+jY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F7522155E;
	Thu, 16 May 2024 14:44:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B69022155D;
	Thu, 16 May 2024 14:44:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/16] refs: pass repo when retrieving submodule ref store
In-Reply-To: <1d48289809d5bff3d168b42b2b7f150e3ee953e2.1715836916.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 16 May 2024 10:04:33 +0200")
References: <cover.1715836916.git.ps@pks.im>
	<1d48289809d5bff3d168b42b2b7f150e3ee953e2.1715836916.git.ps@pks.im>
Date: Thu, 16 May 2024 11:44:17 -0700
Message-ID: <xmqqy189ppfi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4D88CF60-13B4-11EF-8F15-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Modify the function to accept the parent repository as parameter and
> move the global map into `struct repository`. Like this it becomes
> possible to look up submodule ref stores for arbitrary repositories.

Hmph.

> diff --git a/refs.c b/refs.c
> index 542acb25ff..86008ce7b4 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1949,8 +1949,7 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
>  	struct ref_store *refs;
>  	int flags;
>  
> -	refs = get_submodule_ref_store(submodule);
> -
> +	refs = repo_get_submodule_ref_store(the_repository, submodule);
>  	if (!refs)
>  		return -1;

This still wants to work on the_repository, which means at this 5th
step of 16-patch series, we cannot do a submodule of a submodule
that hangs below the top-level superproject yet?

> @@ -2069,20 +2066,15 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
>  		goto done;
>  
>  	subrepo = xmalloc(sizeof(*subrepo));
> -	/*
> -	 * NEEDSWORK: Make get_submodule_ref_store() work with arbitrary
> -	 * superprojects other than the_repository. This probably should be
> -	 * done by making it take a struct repository * parameter instead of a
> -	 * submodule path.
> -	 */
> -	if (repo_submodule_init(subrepo, the_repository, submodule,
> +
> +	if (repo_submodule_init(subrepo, repo, submodule,
>  				null_oid())) {
>  		free(subrepo);
>  		goto done;
>  	}
>  	refs = ref_store_init(subrepo, submodule_sb.buf,
>  			      REF_STORE_READ | REF_STORE_ODB);
> -	register_ref_store_map(&submodule_ref_stores, "submodule",
> +	register_ref_store_map(&repo->submodule_ref_stores, "submodule",
>  			       refs, submodule);
>  
>  done:

Nice.
