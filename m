Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222CB1F404
	for <e@80x24.org>; Wed, 27 Dec 2017 18:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbdL0SCD (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 13:02:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57168 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751781AbdL0SCC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 13:02:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2585CBC136;
        Wed, 27 Dec 2017 13:02:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UbGaI1NgNdIcgASia61K50bL4bg=; b=Y/PaUe
        vcokLqpler8VWK+bzVDu182D9UR/Zb7IbfFW9emXNzywIX0y6XuOeVdFSFfhCPJu
        fjhfpHWysdnZxAEUAEo6UxeaOnnxHSe39HUnPne0MNReSLbCuI9vfwDaxlHO7oRU
        gnE5w3xuZXynY0276CcS6zSrrWjlUliDOfo5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uwmoQ08kFT3TGqDs6+VSg8og3oRl/flS
        6m8sW16LfwbuJk0IzPD3Afmhy2g2/0OMerMARMseGoZvDfGzxEWhhI+ejWn4oxbh
        v1LX2+6tHBKxa4uPae3l8CklAIGLlUKozYDAz9b4AdYpiywExiDhNOUJEHcVY4fn
        xVfBmV/xiYI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DFAEABC135;
        Wed, 27 Dec 2017 13:02:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3839BC134;
        Wed, 27 Dec 2017 13:02:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] oidmap: ensure map is initialized
References: <xmqqlghur08f.fsf@gitster.mtv.corp.google.com>
        <20171222232729.253936-1-bmwill@google.com>
Date:   Wed, 27 Dec 2017 10:01:59 -0800
In-Reply-To: <20171222232729.253936-1-bmwill@google.com> (Brandon Williams's
        message of "Fri, 22 Dec 2017 15:27:29 -0800")
Message-ID: <xmqqtvwcnj6w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 097C47F6-EB30-11E7-8435-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Ensure that an oidmap is initialized before attempting to add, remove,
> or retrieve an entry by simply performing the initialization step
> before accessing the underlying hashmap.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---

Looks sane.  Thanks for illustrating the idea with actual code.

Essentially, you are using map->map.cmpfn as a boolean to see "have
we initialized this thing?  if not, we need to initialize it on
demand".  

By the way, I am somewhat more sympathetic than usual to Dscho's
"make oidmap_get() very aware of the internal implementation detail
of hashmap_get_from_hash() to micro-optimize by removing the check
from _get()".  Such a layering violation is disgusting, and making
it deliberately shows an even worse design taste, but in this
particular case, because the oidmap API is too thin a layer on top
of hashmap, it is understandably a very tempting approach.

>  oidmap.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/oidmap.c b/oidmap.c
> index 6db4fffcd..d9fb19ba6 100644
> --- a/oidmap.c
> +++ b/oidmap.c
> @@ -33,12 +33,19 @@ void oidmap_free(struct oidmap *map, int free_entries)
>  
>  void *oidmap_get(const struct oidmap *map, const struct object_id *key)
>  {
> +	if (!map->map.cmpfn)
> +		return NULL;
> +
>  	return hashmap_get_from_hash(&map->map, hash(key), key);
>  }
>  
>  void *oidmap_remove(struct oidmap *map, const struct object_id *key)
>  {
>  	struct hashmap_entry entry;
> +
> +	if (!map->map.cmpfn)
> +		oidmap_init(map, 0);
> +
>  	hashmap_entry_init(&entry, hash(key));
>  	return hashmap_remove(&map->map, &entry, key);
>  }
> @@ -46,6 +53,10 @@ void *oidmap_remove(struct oidmap *map, const struct object_id *key)
>  void *oidmap_put(struct oidmap *map, void *entry)
>  {
>  	struct oidmap_entry *to_put = entry;
> +
> +	if (!map->map.cmpfn)
> +		oidmap_init(map, 0);
> +
>  	hashmap_entry_init(&to_put->internal_entry, hash(&to_put->oid));
>  	return hashmap_put(&map->map, to_put);
>  }
