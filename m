Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF47C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 18:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47F122080C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 18:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FJTWIqDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHLSGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:06:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60549 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHLSGV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 14:06:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6A32ED59D7;
        Wed, 12 Aug 2020 14:06:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pprAJtRhvL/fF0GqSvNSaJEb5CA=; b=FJTWIq
        Dw3loiiB1/JfnfhrUMWrMRDkH4fXzoE72mSuh669NbF/GnU1PltFfI54G2Uj4uyF
        0sgT/lk/mbC21cwaBi02KMJmAJzVCVMtk9W8VLE/Bj33XTWcS7TIvFO4FtM3pyYH
        BTitiCC67brLtbmjRz82Hf+9v06ZLktIYamiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TxE6mMIbM9Sag4UyA0jFf4q52gnAkaxz
        NR7DBrQVNG/PqkWZBQLf85irboMrMIczfYJj0w9Gpd66qVxXpKxwhYuI5RwMW6C3
        UVTxHfJwclY7VeEDTDgSc48u1kb+QHv+f+MxYMjanvNtoK21X0yJqsqpaHnFGcuq
        Up+cKa1nu/Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 63BE0D59D5;
        Wed, 12 Aug 2020 14:06:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A78EDD59D4;
        Wed, 12 Aug 2020 14:06:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 4/7] fetch: only populate existing_refs if needed
References: <20200724223844.2723397-1-jonathantanmy@google.com>
        <cover.1597184948.git.jonathantanmy@google.com>
        <77bc83e7f2c0a9c95e2ff31aa7a11295bbdf054c.1597184949.git.jonathantanmy@google.com>
Date:   Wed, 12 Aug 2020 11:06:14 -0700
In-Reply-To: <77bc83e7f2c0a9c95e2ff31aa7a11295bbdf054c.1597184949.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 11 Aug 2020 15:52:19 -0700")
Message-ID: <xmqqk0y37n8p.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8427720C-DCC6-11EA-82AA-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When fetching tags, Git only writes tags that do not already exist in
> the client repository. This necessitates an iteration over all the refs,
> but fetch performs this iteration even if no tags are fetched.

Hmph, the change itself mechanically makes sense (i.e. if the
ref_map has no entry with peer_ref defined, existing_refs hashmap is
never looked up, so there is no reason to populate it), but the
explanation of log message, especially the part that places strees
on tags, does not.  Wouldn't a plain vanilla "git fetch" with no
argument that uses the remote.origin.fetch populated with standard
refspecs to maintain remote-tracking branches use this hash?

I think the readers need to be somehow made aware of the fact that
the author of this commit message is concentrated primarily on fetch
used as a mechanism to grab specific objects, often used by lazy
fetch, without touching any remote-tracking refs.  Because tag
following is on by default (which is a convenient default for the
plain vanilla fetches that updates remote-tracking branches),
however, such a "these specific objects only" fetch still tries to
trigger the auto following of tags, and necessitates "--no-tags" to
take advantage of the optimization proposed by this patch.

So nothing written in the proposed log message is incorrect per-se,
but it is not very friendly to readers without clarivoyance.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 29db219c68..6460ce3f4e 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -449,6 +449,7 @@ static struct ref *get_ref_map(struct remote *remote,
>  	struct ref *orefs = NULL, **oref_tail = &orefs;
>  
>  	struct hashmap existing_refs;
> +	int existing_refs_populated = 0;
>  
>  	if (rs->nr) {
>  		struct refspec *fetch_refspec;
> @@ -542,15 +543,18 @@ static struct ref *get_ref_map(struct remote *remote,
>  
>  	ref_map = ref_remove_duplicates(ref_map);
>  
> -	refname_hash_init(&existing_refs);
> -	for_each_ref(add_one_refname, &existing_refs);
> -
>  	for (rm = ref_map; rm; rm = rm->next) {
>  		if (rm->peer_ref) {
>  			const char *refname = rm->peer_ref->name;
>  			struct refname_hash_entry *peer_item;
>  			unsigned int hash = strhash(refname);
>  
> +			if (!existing_refs_populated) {
> +				refname_hash_init(&existing_refs);
> +				for_each_ref(add_one_refname, &existing_refs);
> +				existing_refs_populated = 1;
> +			}
> +
>  			peer_item = hashmap_get_entry_from_hash(&existing_refs,
>  						hash, refname,
>  						struct refname_hash_entry, ent);
> @@ -560,7 +564,8 @@ static struct ref *get_ref_map(struct remote *remote,
>  			}
>  		}
>  	}
> -	hashmap_free_entries(&existing_refs, struct refname_hash_entry, ent);
> +	if (existing_refs_populated)
> +		hashmap_free_entries(&existing_refs, struct refname_hash_entry, ent);
>  
>  	return ref_map;
>  }
