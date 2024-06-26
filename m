Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCEE14D6EB
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719436231; cv=none; b=dRWxwdi83+JcbrVnOq/3sg7ZRbRasSPUUO7USqd1tPIUJxvWoCz8FcB/36qGHuC3NrHZmEOiv1US3RYJMQl7BGNrZu0aN3epV45VWHEIhvL6pus6DlMBhxVnXTgqS8inkziEdBp8l7neJZxsFOKzZomJeZpcnW1kPRRQEXPddTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719436231; c=relaxed/simple;
	bh=oUidVu3GiHTtr+A4wQgYqYFcqDdV0iDroLPLE5BY7uY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ox0IDlnhIYjzeadSPOIvhtu6h6OW6WUf01NDhOqnfJ2UlbgFGR4eBDqKlmBuNtvmoYHuvQCvhXyNwSmiui6zz09e6YjxPjOCtERp/0Ue5+YTb4/6pzDT+N56gUsu+G4LsblBDwyDqxKvNTrquC/AlVkhG6jjDoexsOMDPB4FDEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v1xPsM20; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v1xPsM20"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6211622135;
	Wed, 26 Jun 2024 17:10:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=oUidVu3GiHTtr+A4wQgYqYFcqDdV0iDroLPLE5
	BY7uY=; b=v1xPsM20kqLIlBZzlfD5Zhb/t7g+okdGYwxZ/EUKW2IrpFYMKwAxrX
	Stp4NCZu4bbPiO/Un6lWPf9TmsSYZrKaPIyoyMGALYS0XHH+G+qxrTuUZ/G2HXzD
	v2LU003as0jxOTK2p/y0VeSAOWoaoiYUoEx2aXL5/9OOwfDuJDc3g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A34422134;
	Wed, 26 Jun 2024 17:10:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D89F6220E8;
	Wed, 26 Jun 2024 17:10:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,  Patrick
 Steinhardt <ps@pks.im>,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 13/17] mktree: use iterator struct to add tree
 entries to index
In-Reply-To: <56f28efff5404a3fa22bd544d6de8ce2d919b78a.1718834285.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Wed, 19 Jun 2024 21:58:01
	+0000")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<pull.1746.v2.git.1718834285.gitgitgadget@gmail.com>
	<56f28efff5404a3fa22bd544d6de8ce2d919b78a.1718834285.git.gitgitgadget@gmail.com>
Date: Wed, 26 Jun 2024 14:10:23 -0700
Message-ID: <xmqq8qyrxveo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 817F9274-3400-11EF-B96A-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -157,14 +186,18 @@ static int add_tree_entry_to_index(struct index_state *istate,
>  
>  static void write_tree(struct tree_entry_array *arr, struct object_id *oid)
>  {
> +	struct tree_entry_iterator iter = { NULL };
>  	struct index_state istate = INDEX_STATE_INIT(the_repository);
>  	istate.sparse_index = 1;
>  
>  	sort_and_dedup_tree_entry_array(arr);
>  
> -	/* Construct an in-memory index from the provided entries */
> -	for (size_t i = 0; i < arr->nr; i++) {
> -		struct tree_entry *ent = arr->entries[i];
> +	tree_entry_iterator_init(&iter, arr);
> +
> +	/* Construct an in-memory index from the provided entries & base tree */
> +	while (iter.current) {
> +		struct tree_entry *ent = iter.current;
> +		tree_entry_iterator_advance(&iter);
>  
>  		if (add_tree_entry_to_index(&istate, ent))
>  			die(_("failed to add tree entry '%s'"), ent->name);

OK, looking good.

If we make _iterator_init() and _iterator_advance to both return the
current, then the loop can still be like so:

	for (ent = tree_entry_iterator_init(&iter, arr);
             ent;
	     ent = tree_entry_iterator_advance(&iter)) {
		... use ent ...
	}

and .current does not need to be a non-private member, if we wanted
to (I am not convinced it is necessarily a better interface to make
.current as private---especially if we end up needing _peek() method
to learn its value, i.e. the value the most recent call to _init()
or _advance() returned.  If we need a write access to .current from
outside the interator interface, then what I outlined above would
not be a good match).


Thanks.
