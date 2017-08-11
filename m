Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 601CF20899
	for <e@80x24.org>; Fri, 11 Aug 2017 22:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754254AbdHKWG6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 18:06:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51049 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754152AbdHKWG5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 18:06:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67659AC033;
        Fri, 11 Aug 2017 18:06:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=08I7utNa9p8LkvD7W2l5+LFCdzI=; b=H0zYmT
        19lSAc51K4Dn7prO7dNI35nRoe0SWGzi+SRs5Sti/qx0TUrL1jUL81o4aHSRxZTd
        S0mdv0OKX/mMn8h+slntv+Rx4100na9NLWk4OOK++U5OodtQzTXMchuCqEz7q+hv
        dsyE07sWYwA3ZN3kPkUh9X6ou7gmN6YhFH1z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CfiLuvxV5DbeA/AxaMuxb6JrgdvSm6ot
        6Xz+F6BfIyR6wyCC0QGSrej2gncqmmmPX5IbDcPnY87lXuJPDcnzUZfBthfU0lTI
        MvgRa5HnwDHZ6n+rRqTOQ7+ZSEKur291ZhTscCcM9g/Wy03dBdqBBPeN57WRvTLU
        vLVJL9Mqk/0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EB81AC032;
        Fri, 11 Aug 2017 18:06:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3781AC030;
        Fri, 11 Aug 2017 18:06:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] sha1_file: remove read_packed_sha1()
References: <cover.1502483486.git.jonathantanmy@google.com>
        <xmqqfucz11yb.fsf@gitster.mtv.corp.google.com>
        <cover.1502483486.git.jonathantanmy@google.com>
        <557fbeeac6a0f65d48ba0902f20c0650e75ae332.1502483486.git.jonathantanmy@google.com>
Date:   Fri, 11 Aug 2017 15:06:54 -0700
In-Reply-To: <557fbeeac6a0f65d48ba0902f20c0650e75ae332.1502483486.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 11 Aug 2017 13:36:15 -0700")
Message-ID: <xmqqa835zrlt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 635747A0-7EE1-11E7-A301-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Use read_object() in its place instead. This avoids duplication of code.
>
> This makes force_object_loose() slightly slower (because of a redundant
> check of loose object storage), but only in the error case.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  sha1_file.c | 26 +-------------------------
>  1 file changed, 1 insertion(+), 25 deletions(-)

The original code insisted on reading from pack and never from a
loose object, because it knew it would return early when it found a
loose version.  Now we allow a loose one to appear in the middle of
force_object_loose() operation and happily read from it when we do
not see a pack entry for the object---presumably because we are
racing with another simultanous repack process, or something?---and
then write it out as a new (and identical) loose object, which would
not do any harm.

So this is not strictly a no-op conversion; I have a gut feeling
that it would make it more robust, not less, in the presence of
another racing repack process, but I haven't really thought through
race scenarios that may make difference in its behaviour.


> diff --git a/sha1_file.c b/sha1_file.c
> index 910109fd9..0f758eabf 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -3062,30 +3062,6 @@ int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
>  	return type;
>  }
>  
> -static void *read_packed_sha1(const unsigned char *sha1,
> -			      enum object_type *type, unsigned long *size)
> -{
> -	struct pack_entry e;
> -	void *data;
> -
> -	if (!find_pack_entry(sha1, &e))
> -		return NULL;
> -	data = cache_or_unpack_entry(e.p, e.offset, size, type);
> -	if (!data) {
> -		/*
> -		 * We're probably in deep shit, but let's try to fetch
> -		 * the required object anyway from another pack or loose.
> -		 * This should happen only in the presence of a corrupted
> -		 * pack, and is better than failing outright.
> -		 */
> -		error("failed to read object %s at offset %"PRIuMAX" from %s",
> -		      sha1_to_hex(sha1), (uintmax_t)e.offset, e.p->pack_name);
> -		mark_bad_packed_object(e.p, sha1);
> -		data = read_object(sha1, type, size);
> -	}
> -	return data;
> -}
> -
>  int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
>  		      unsigned char *sha1)
>  {
> @@ -3468,7 +3444,7 @@ int force_object_loose(const unsigned char *sha1, time_t mtime)
>  
>  	if (has_loose_object(sha1))
>  		return 0;
> -	buf = read_packed_sha1(sha1, &type, &len);
> +	buf = read_object(sha1, &type, &len);
>  	if (!buf)
>  		return error("cannot read sha1_file for %s", sha1_to_hex(sha1));
>  	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %lu", typename(type), len) + 1;
