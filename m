Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76004688
	for <git@vger.kernel.org>; Thu, 16 May 2024 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885145; cv=none; b=QKRurMxNITjC0NO6m5H+LdRfxkpL800kJCaRwJ0UNsXTfn2Fhn3m73ORwaPdposihZNnw30r5zNUHHYeSbpVKssWxVBEuPK9w9bpzeL1uFkIENk99GcI4RiPZ9KVL1gsEqHdUlDWRrwp8SIoVvo1TecbYDc7CEdhjHx1mcQryHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885145; c=relaxed/simple;
	bh=Ilrs4tlfOE9tFaBTKqfTazysVxu4OqXjKHY0soHCVqg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DajnmV0FJPXmSx/5+iTWfWavrBTTxvcnHd6RpnoVhEK9RWZsRdYPztey1ko4tNSnx5sL1xfBsFvCIh3GjgXVeH8bJimEvJVv8UjfgqaP6xrcm//9ktprRX056D7N7yxQ10/L4YqAcaDzTVKUTbonaLCNrdUre6QlHksHZMwfUOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vD2HpXPh; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vD2HpXPh"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A18127B7D;
	Thu, 16 May 2024 14:45:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ilrs4tlfOE9tFaBTKqfTazysVxu4OqXjKHY0so
	HCVqg=; b=vD2HpXPhsruJ5MkUyLC3KYybArZgRRXrad/gg6VX1ehsdiAk4Qq+1M
	o0gCXRJWlFEnnAao8WStcgerDXO7RX3Uuu4eQRKpuVosOh+fVIMYT+zOs5WnEDAS
	HW+/4ze+25OGQa+pO536YvZ2jYBF4WiA+STHRPhnukis+fEIAAeew=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 41B8027B7C;
	Thu, 16 May 2024 14:45:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CC59F27B7B;
	Thu, 16 May 2024 14:45:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/16] refs: refactor `resolve_gitlink_ref()` to accept
 a repository
In-Reply-To: <7b4ea1ffd255245ff7b4f00a7d77599dad61f80b.1715836916.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 16 May 2024 10:04:38 +0200")
References: <cover.1715836916.git.ps@pks.im>
	<7b4ea1ffd255245ff7b4f00a7d77599dad61f80b.1715836916.git.ps@pks.im>
Date: Thu, 16 May 2024 11:45:38 -0700
Message-ID: <xmqqttixppd9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7DDE30CE-13B4-11EF-B3A6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/refs.c b/refs.c
> index 86008ce7b4..40e241216e 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1943,13 +1943,14 @@ int ref_store_create(struct ref_store *refs, int flags, struct strbuf *err)
>  	return refs->be->create(refs, flags, err);
>  }
>  
> -int resolve_gitlink_ref(const char *submodule, const char *refname,
> -			struct object_id *oid)
> +int repo_resolve_gitlink_ref(struct repository *r,
> +			     const char *submodule, const char *refname,
> +			     struct object_id *oid)
>  {
>  	struct ref_store *refs;
>  	int flags;
>  
> -	refs = repo_get_submodule_ref_store(the_repository, submodule);
> +	refs = repo_get_submodule_ref_store(r, submodule);
>  	if (!refs)
>  		return -1;

OK.  Looking good.
