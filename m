Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5A9020899
	for <e@80x24.org>; Fri, 11 Aug 2017 21:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753707AbdHKVwe (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 17:52:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53428 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753256AbdHKVwc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 17:52:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7CDBAB633;
        Fri, 11 Aug 2017 17:52:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=akg/BCl8iie7HI9wF3+wjs0YFjw=; b=iILGIr
        o1DaBWoyVjgUE4vj6jJ3nuhzqDMohUyeo7WbD86RkPuyv5PMC9vUxDeVaASag+ER
        hQ0Z9n18i1589FF8BglZEks5jC+xFi2u/s+Hm+BcUFXRyBnWGBnU60emmK+luEQA
        8V6D5Qb/y5zoi/rHSdW6a38netnnhHdxpw3Bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JNfUXRVQbWPwX97A+AXD8lp5OFLV/pbc
        P0bwJ7QRy/MhhQiEu4Z6YcQ5lLFb1js5iJuYD0hCh7M1TKI65DdigYXRIq6TryZB
        7vjSku1ia3ai0GjLvn2QmBrHDz8ERmJZIYCYw5ACKm1c80ANJt5moaKq9qF+zdVZ
        QWux1jNNEMg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C01C0AB632;
        Fri, 11 Aug 2017 17:52:31 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2553AAB62E;
        Fri, 11 Aug 2017 17:52:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] sha1_file: set whence in storage-specific info fn
References: <cover.1502483486.git.jonathantanmy@google.com>
        <xmqqfucz11yb.fsf@gitster.mtv.corp.google.com>
        <cover.1502483486.git.jonathantanmy@google.com>
        <6fbc67183251a852f635154121fcf0f1006310d6.1502483486.git.jonathantanmy@google.com>
Date:   Fri, 11 Aug 2017 14:52:29 -0700
In-Reply-To: <6fbc67183251a852f635154121fcf0f1006310d6.1502483486.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 11 Aug 2017 13:36:14 -0700")
Message-ID: <xmqqefshzs9u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6002510A-7EDF-11E7-9722-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Move the setting of oi->whence to sha1_loose_object_info() and
> packed_object_info().
>
> This allows sha1_object_info_extended() to not need to know about the
> delta base cache. This will be useful during a future refactoring in
> which packfile-related functions, including the handling of the delta
> base cache, will be moved to a separate file.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

Output from 

    git grep -E -e '(\.|->)whence'

makes me wonder if the oi->whence thing is a bit over-engineered,
though.  The only real user of this information is the streaming
code, which wants to see if it can grab an undeltified deflated data
directly out of the pack file (and if so from which packfile at what
offset), or if it can open a loose object file and slurp deflated
data out of it.

But that is totally outside the scope of this patch.  This looks
like a safe no-op conversion to me.

Thanks.

>  sha1_file.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index b60ae15f7..910109fd9 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2444,6 +2444,9 @@ int packed_object_info(struct packed_git *p, off_t obj_offset,
>  			hashclr(oi->delta_base_sha1);
>  	}
>  
> +	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
> +							  OI_PACKED;
> +
>  out:
>  	unuse_pack(&w_curs);
>  	return type;
> @@ -2973,6 +2976,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>  	if (oi->sizep == &size_scratch)
>  		oi->sizep = NULL;
>  	strbuf_release(&hdrbuf);
> +	oi->whence = OI_LOOSE;
>  	return (status < 0) ? status : 0;
>  }
>  
> @@ -3010,10 +3014,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>  
>  	if (!find_pack_entry(real, &e)) {
>  		/* Most likely it's a loose object. */
> -		if (!sha1_loose_object_info(real, oi, flags)) {
> -			oi->whence = OI_LOOSE;
> +		if (!sha1_loose_object_info(real, oi, flags))
>  			return 0;
> -		}
>  
>  		/* Not a loose object; someone else may have just packed it. */
>  		if (flags & OBJECT_INFO_QUICK) {
> @@ -3036,10 +3038,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>  	if (rtype < 0) {
>  		mark_bad_packed_object(e.p, real);
>  		return sha1_object_info_extended(real, oi, 0);
> -	} else if (in_delta_base_cache(e.p, e.offset)) {
> -		oi->whence = OI_DBCACHED;
> -	} else {
> -		oi->whence = OI_PACKED;
> +	} else if (oi->whence == OI_PACKED) {
>  		oi->u.packed.offset = e.offset;
>  		oi->u.packed.pack = e.p;
>  		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
