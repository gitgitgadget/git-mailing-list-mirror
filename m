Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 533D01FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 22:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753892AbcHWWSr (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 18:18:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61610 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752974AbcHWWSq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 18:18:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3721D37596;
        Tue, 23 Aug 2016 18:18:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ASOhJc7HB1YRJZUazEO/aMLnSQk=; b=kiSwqd
        LnLPO5wcCrXBaZ32naEjhd35D9NV18pi4Sz5+wFePTK8HJI4Un3P4oKF24msb82t
        /+8ROq/s12lh1F4plWez+6q4V90QNa4eED6I0jccs+mNl94kQwk+3JccURCUfhal
        zkX83hjyjqwch0rwSad3Fn7qH8pmEk0W20HVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sS69uUd4L2aTLD9wRsmY6kazo2YgNUQh
        qJAxUO7SLCtLVshvpKKW3SJ5RrbWo4LmfuIR0+Ummf08t3ys4XV9fOvpkPtPq/DX
        azjht9EBLPN9uSuosumZFjomdzr2DHR3EcD1rYr9ZbCOTfOTJwfqPfRXEj2i2+dr
        OlCd1+MXyo0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F6A537590;
        Tue, 23 Aug 2016 18:18:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A05E23758E;
        Tue, 23 Aug 2016 18:18:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/7] delta_base_cache: drop special treatment of blobs
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
        <20160822215956.kuqnucvfodxjrawn@sigill.intra.peff.net>
Date:   Tue, 23 Aug 2016 15:18:42 -0700
In-Reply-To: <20160822215956.kuqnucvfodxjrawn@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 22 Aug 2016 17:59:56 -0400")
Message-ID: <xmqqshtvt9h9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E128E00-697F-11E6-9E50-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Let's run the same numbers without caring about object type
> at all (i.e., one LRU list, and always evicting whatever is
> at the head, regardless of type).
> ...
> So it seems like a clear winner, and that's what this patch
> implements.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Nice work.  You make your readers expect some clever data structures
that may perform better than the obvious two-separate-list approach
and end up using the simplest way.  Quite nice.



>  sha1_file.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index c02e785..33564d6 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2175,14 +2175,6 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
>  			list_entry(lru, struct delta_base_cache_entry, lru);
>  		if (delta_base_cached <= delta_base_cache_limit)
>  			break;
> -		if (f->type == OBJ_BLOB)
> -			release_delta_base_cache(f);
> -	}
> -	list_for_each(lru, &delta_base_cache_lru) {
> -		struct delta_base_cache_entry *f =
> -			list_entry(lru, struct delta_base_cache_entry, lru);
> -		if (delta_base_cached <= delta_base_cache_limit)
> -			break;
>  		release_delta_base_cache(f);
>  	}
