Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68563C432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 17:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C212082E
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 17:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E37WdinP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfK3RIk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 12:08:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61345 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfK3RIj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 12:08:39 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FB4E3C62C;
        Sat, 30 Nov 2019 12:08:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=p1+R7Yze6BFgRqHSnRBS0KjUiKw=; b=E37Wdi
        nPv1SeN7Los7VrNikEaRnAggYjY0iA5nT4vBccsJMww5IFguxfkbWYzkDtUZI9SC
        4JWr8xOLjMyEujzmvtyb5YwuhZOZsUSDEK8FnMyvPqG2RJl60OS5ezJVY/KjS+8C
        BS01ZWs7EGBxgUD6Bq9IhBiWtaCgWZoXeKDtI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RP+b+g6Vf15cqbHPCv7wKDvBwN7mV62x
        QUxJqLF+TXnD7b2mRKxBibJvv40CUw+ru/NCdYbBz4j0UKbSDF/1qgL3V9V+TqhN
        hIvzVk759n97sLwHMKbm62iICzP7iV3q07Qgild99X4E0M1CWTt1zxyrw6A8nenW
        T6FEwM2AJUw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 779D83C62B;
        Sat, 30 Nov 2019 12:08:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D642B3C629;
        Sat, 30 Nov 2019 12:08:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "Patrick Marlier \(pamarlie\)" <pamarlie@cisco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative objects
References: <CH2PR11MB429411CA1288526D21C7AF26CF4C0@CH2PR11MB4294.namprd11.prod.outlook.com>
        <20191127123211.GG22221@sigill.intra.peff.net>
Date:   Sat, 30 Nov 2019 09:08:32 -0800
In-Reply-To: <20191127123211.GG22221@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 27 Nov 2019 07:32:11 -0500")
Message-ID: <xmqqr21p2sxb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A68C926-1394-11EA-A575-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think the patch below would help you.
>
> -- >8 --
> Subject: [PATCH] send-pack: use OBJECT_INFO_QUICK to check negative objects
>
> When pushing, we feed pack-objects a list of both positive and negative
> objects. The positive objects are what we want to send, and the negative
> objects are what the other side told us they have, which we can use to
> limit the size of the push.
>
> Before passing along a negative object, send_pack() will make sure we
> actually have it (since we only know about it because the remote
> mentioned it, not because it's one of our refs). So it's expected that
> some of these objects will be missing on the local side. But looking for
> a missing object is more expensive than one that we have: it triggers
> reprepare_packed_git() to handle a racy repack, plus it has to explore
> every alternate's loose object tree (which can be slow if you have a lot
> of them, or have a high-latency filesystem).
>
> This isn't usually a big problem, since repositories you're pushing to
> don't generally have a large number of refs that are unrelated to what
> the client has. But there's no reason such a setup is wrong, and it
> currently performs poorly.
>
> We can fix this by using OBJECT_INFO_QUICK, which tells the lookup
> code that we expect objects to be missing. Notably, it will not re-scan
> the packs, and it will use the loose cache from 61c7711cfe (sha1-file:
> use loose object cache for quick existence check, 2018-11-12).
>
> The downside is that in the rare case that we race with a local repack,
> we might fail to feed some objects to pack-objects, making the resulting
> push larger. But we'd never produce an invalid or incorrect push, just a
> less optimal one. That seems like a reasonable tradeoff, and we already
> do similar things on the fetch side (e.g., when marking COMPLETE
> commits).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Interestingly, upload-pack does not use OBJECT_INFO_QUICK when it's
> getting oids from the other side. But I think it could possibly benefit
> in the same way. Nobody seems to have noticed. Perhaps it simply comes
> up less, as servers would tend to have more objects than their clients?

Makes me wonder how many times we wre bitten by the fact that
INFO_SKIP_FETCH_OBJECT does not imply INFO_QUICK.  Perhaps most of
the users of INFO_SKIP_FETCH_OBJECT wants to use INFO_FOR_PREFETCH?

cf. 31f5256c ("sha1-file: split OBJECT_INFO_FOR_PREFETCH", 2019-05-28)

>  send-pack.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/send-pack.c b/send-pack.c
> index 34c77cbb1a..16d6584439 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -41,7 +41,9 @@ int option_parse_push_signed(const struct option *opt,
>  static void feed_object(const struct object_id *oid, FILE *fh, int negative)
>  {
>  	if (negative &&
> -	    !has_object_file_with_flags(oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
> +	    !has_object_file_with_flags(oid,
> +					OBJECT_INFO_SKIP_FETCH_OBJECT |
> +					OBJECT_INFO_QUICK))
>  		return;
>  
>  	if (negative)
