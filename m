Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 481441F955
	for <e@80x24.org>; Fri, 29 Jul 2016 20:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753876AbcG2Urn (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 16:47:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57624 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753729AbcG2Url (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 16:47:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42D7031D47;
	Fri, 29 Jul 2016 16:47:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CN4qErtfYACwLKxa6b3POp1VaJc=; b=r9v8pf
	IA6r6wRnXhIVWGXIZE6chfAgR6UTqi8cmwoCmOMLxNIuJr3zlEvUT2BrACyeHyAS
	m2HIWN01N5q1/gWr9MNrfg1kITfegCyt639e5DOqrsr7rfZI/5o6VQfK1C5zRMTU
	nKuTiFL1kEc0XW+TmQ1K1SuOjrYZq3V70kNjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xIrSI9T+KnnXgwXGMcCza97K7lsG6dcP
	5ol8B2E/D7YTy+I64knXFnnIa27Y3rbIUim1bsR2qsEO7DcTr+WMMj+3poc+/lPo
	PWsgwGh89gi+j2Y44IU9wmsRptoUdXJ8RiLzXaMgTFq447kWnLebFi5JF2pQoLUC
	nvCZrkd94MA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B06831D45;
	Fri, 29 Jul 2016 16:47:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B14CD31D44;
	Fri, 29 Jul 2016 16:47:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kevin Willford <kcwillford@gmail.com>
Cc:	git@vger.kernel.org, Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 1/4] patch-ids: stop using a hand-rolled hashmap implementation
References: <20160729161920.3792-1-kcwillford@gmail.com>
	<20160729161920.3792-2-kcwillford@gmail.com>
Date:	Fri, 29 Jul 2016 13:47:37 -0700
In-Reply-To: <20160729161920.3792-2-kcwillford@gmail.com> (Kevin Willford's
	message of "Fri, 29 Jul 2016 12:19:17 -0400")
Message-ID: <xmqqoa5gmas6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B063A8D8-55CD-11E6-9214-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kevin Willford <kcwillford@gmail.com> writes:

> From: Kevin Willford <kewillf@microsoft.com>
>
> This change will use the hashmap from the hashmap.h to keep track of the
> patch_ids that have been encountered instead of using an internal
> implementation.  This simplifies the implementation of the patch ids.
>
> Signed-off-by: Kevin Willford <kcwillford@gmail.com>
> ---
>  patch-ids.c | 86 +++++++++++++++++++++----------------------------------------
>  patch-ids.h |  7 +++--
>  2 files changed, 32 insertions(+), 61 deletions(-)

The patch text itself is almost unreadble because of a lot of
verbose code it had to carry before this change, and the removal of
that unreadable code of course is the point of this very welcome
clean-up ;-).  The resulting code is very readable.

>  struct patch_id *has_commit_patch_id(struct commit *commit,
>  				     struct patch_ids *ids)
>  {
> -	return add_commit(commit, ids, 1);
> +	struct patch_id patch;
> +
> +	memset(&patch, 0, sizeof(patch));
> +	if (init_patch_id_entry(&patch, commit, ids))
> +		return NULL;
> +	return hashmap_get(&ids->patches, &patch, NULL);
>  }
>  
>  struct patch_id *add_commit_patch_id(struct commit *commit,
>  				     struct patch_ids *ids)
>  {
> -	return add_commit(commit, ids, 0);
> +	struct patch_id *key = xcalloc(1, sizeof(*key));
> +
> +	if (init_patch_id_entry(key, commit, ids)) {
> +		free(key);
> +		return NULL;
> +	}

This is a tangent, but this made me wonder if it is safe to simply
free(3) the result of calling hashmap_entry_init() which is called
in init_patch_id_entry().  It would obviously become a resource
leak, if a hashmap_entry (which the api documentation says is "an
opaque structure") holds any allocated resource.

The fact that hashmap_entry_init() is there but there is no
corresponding hashmap_entry_clear() hints that there is nothing to
be worried about and I can see from the implementation of
hashmap_entry_init() that no extra resource is held inside, but an
API user should not have to guess.  We may want to do one of the two
things:

 * document that an embedded hashmap_entry does not hold any
   resource that need to be released and it is safe to free the user
   structure that embeds one; or

 * implement hashmap_entry_clear() that currently is a no-op.

If we anticipate that the hashmap implementation may gain more
fields in this "opaque" structure, the latter might be a more
future-proof approach, as all the callers of hashmap_entry_init()
would already be calling hashmap_entry_clear() to clean it up when
such a change to the hashmap implementation happens.  On the other
hand, a caller that does not call hashmap_entry_clear() would not be
noticed by anybody as leaking resources until such a change happens,
so the future-proofing may not have much practical value (iow, the
existing callers of _init() would need to be audited anyway to make
sure they also call _clear()).
