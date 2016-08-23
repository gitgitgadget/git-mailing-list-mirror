Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4145C1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 21:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbcHWVtU (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:49:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56490 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932268AbcHWVtT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:49:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1381E37057;
        Tue, 23 Aug 2016 17:49:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=I1A0+wHwkNjlN6h5DW8aESp2TVI=; b=URUDMZ
        3OU+grOz/4FZDJ/U2khP1ZfiiP3jHObs0nI+rhy6i7MhEmk2dAxHx1F6/4ZLcMQA
        t/ISMZDGTasJSvVmE3wfCuAqm79o7/78/TLvMduQOm2JfTsqc+ImPK1ADy+AAWYv
        yYKODF3wpOcMaIgK6zSu87GkrcPALDrWA++Po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lYcVS2PTbPAPnEEwBJ3/cT1PHNF15ojZ
        d9MbpdD7hYZi95ge/6yfmTShNKKzNwQIbNHbMn72VPHkAtfg60HFREALFvF3swxQ
        2BN3kfYfM2Nc40ez8B+gMkGx3RtQ8QSj6uqcvKHtO2pvp3QOdiVEkNt43VpDrSoJ
        hy2MJDLKUhU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B89237056;
        Tue, 23 Aug 2016 17:49:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 924FC37055;
        Tue, 23 Aug 2016 17:49:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] release_delta_base_cache: reuse existing detach function
References: <20160822215725.qdikfcaz3smhulau@sigill.intra.peff.net>
        <20160822215758.uamavr7koin3ze6c@sigill.intra.peff.net>
Date:   Tue, 23 Aug 2016 14:49:15 -0700
In-Reply-To: <20160822215758.uamavr7koin3ze6c@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 22 Aug 2016 17:57:58 -0400")
Message-ID: <xmqqwpj7tauc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 70D27EBC-697B-11E6-9A22-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This function drops an entry entirely from the cache,
> meaning that aside from the freeing of the buffer, it is
> exactly equivalent to detach_delta_base_cache_entry(). Let's
> build on top of the detach function, which shortens the code
> and will make it simpler when we change out the underlying
> storage in future patches.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1_file.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 1d0810c..8264b39 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2152,10 +2152,7 @@ static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
>  {
>  	if (ent->data) {
>  		free(ent->data);
> -		ent->data = NULL;
> -		ent->lru.next->prev = ent->lru.prev;
> -		ent->lru.prev->next = ent->lru.next;
> -		delta_base_cached -= ent->size;
> +		detach_delta_base_cache_entry(ent);

If we were designing this from scratch, we might have made detach_*
to return the pointer to minimize direct access to ent->data, but I
do not think it is worth it.  Looks very sensible.
