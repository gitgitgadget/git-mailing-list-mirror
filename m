Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2993020985
	for <e@80x24.org>; Mon, 12 Sep 2016 19:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755088AbcILTKV (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 15:10:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52060 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751986AbcILTKS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 15:10:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8195C3D916;
        Mon, 12 Sep 2016 15:10:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2nrqsQ8Dje7r7iApk3UjfusckcM=; b=fWWgIe
        gNp+Am3pC8WjrhYn8bklGxKZCUt59YD12mJC2QaVrj8bpksbkjjjpX1ZYCgksIHX
        lI/mi/ox4K7QBzkKacBjtCpnaC1vT5mAExZPtr+YchH/qN+Yt1mMAhSvuIL44WnG
        CR4rK7VvIzh2DO7jI2LbUMXHzUlTh1sHoPRWg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KhzP/ZBmuRl2g5Pi9ATCFlZmzgqxKBLX
        Su52CksIKPO839HeyS3h8LDbRCKafUDDuvpC7aEFniIt+PM8iYENVW5QbuXRUTkI
        k/DGAD4uLdCGNRi31Iju2fuZm2ZaenxTcI+Mw7jZ7wAdTgV2Flm6O4lhJBtiTiQj
        JWf1z6WP/UM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70F363D914;
        Mon, 12 Sep 2016 15:10:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D75933D911;
        Mon, 12 Sep 2016 15:10:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2016, #03; Fri, 9)
References: <xmqqoa3w8zco.fsf@gitster.mtv.corp.google.com>
        <20160912164616.vg33kldazuthff3d@sigill.intra.peff.net>
Date:   Mon, 12 Sep 2016 12:10:13 -0700
In-Reply-To: <20160912164616.vg33kldazuthff3d@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 12 Sep 2016 12:46:17 -0400")
Message-ID: <xmqqlgyx2aui.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89C766DE-791C-11E6-95ED-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I happened to notice today that this topic needs a minor tweak:
>
> -- >8 --
> Subject: [PATCH] add_delta_base_cache: use list_for_each_safe
>
> We may remove elements from the list while we are iterating,
> which requires using a second temporary pointer. Otherwise
> stepping to the next element of the list might involve
> looking at freed memory (which generally works in practice,
> as we _just_ freed it, but of course is wrong to rely on;
> valgrind notices it).

I failed to notice it, too.  Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1_file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index a57b71d..132c861 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2187,11 +2187,11 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
>  	void *base, unsigned long base_size, enum object_type type)
>  {
>  	struct delta_base_cache_entry *ent = xmalloc(sizeof(*ent));
> -	struct list_head *lru;
> +	struct list_head *lru, *tmp;
>  
>  	delta_base_cached += base_size;
>  
> -	list_for_each(lru, &delta_base_cache_lru) {
> +	list_for_each_safe(lru, tmp, &delta_base_cache_lru) {
>  		struct delta_base_cache_entry *f =
>  			list_entry(lru, struct delta_base_cache_entry, lru);
>  		if (delta_base_cached <= delta_base_cache_limit)
