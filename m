Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41DB82018E
	for <e@80x24.org>; Wed, 24 Aug 2016 19:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755607AbcHXTav (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 15:30:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60353 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754856AbcHXTav (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 15:30:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7961E3637F;
        Wed, 24 Aug 2016 15:30:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+KveJW2S0OEl6WqiLCwNHilQduI=; b=rR3yxI
        mj8Ahj3CjBN38GOcGEiPOynVLEj4qJfJoECudQXDZsmE/sMrJVc/CHualZg9B/hE
        guqGSD6blTm0R/XUEm2a+6PR6uBQSbQnFEgbV9GmndAxUhzbKHIkIBEZCHKqspwh
        2o+3KDHTGMi5NkXGC++RTJHUsNOV9u+mfCAnc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NLa1gfETfAsdk3buvDJV6l1g2QKRkLDo
        zdgDck8myRY5Xr5NCWSmHPRq9MhoKHQG0+6wXARhnxR/fqeFE8JlhDfcgMIKyvdj
        3+nPF1x10T4smEQ2h6VdYNmt2zwAioEbz/65kasE2jO7RnqnUfb8u1oojuRbbqpw
        iqKK3ApLiDQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 71C923637E;
        Wed, 24 Aug 2016 15:30:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F288C3637D;
        Wed, 24 Aug 2016 15:30:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/3] limit the size of the packs we receive
References: <20160824184157.19264-1-chriscool@tuxfamily.org>
Date:   Wed, 24 Aug 2016 12:30:46 -0700
In-Reply-To: <20160824184157.19264-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Wed, 24 Aug 2016 20:41:54 +0200")
Message-ID: <xmqqoa4iotg9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42EC096C-6A31-11E6-B33D-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Diff with previous v2 version
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f5b6061..8a115b3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2517,10 +2517,11 @@ receive.unpackLimit::
>  	especially on slow filesystems.  If not set, the value of
>  	`transfer.unpackLimit` is used instead.
>  
> -receive.maxsize::
> -	If the size of a pack file is larger than this limit, then
> -	git-receive-pack will error out, instead of accepting the pack
> -	file. If not set or set to 0, then the size is unlimited.
> +receive.maxInputSize::
> +	If the size of the incoming pack stream is larger than this
> +	limit, then git-receive-pack will error out, instead of
> +	accepting the pack file. If not set or set to 0, then the size
> +	is unlimited.
>  
>  receive.denyDeletes::
>  	If set to true, git-receive-pack will deny a ref update that deletes
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> ...
> diff --git a/t/t5546-receive-limits.sh b/t/t5546-receive-limits.sh
> new file mode 100755
> index 0000000..10cb0be
> --- /dev/null
> +++ b/t/t5546-receive-limits.sh
> @@ -0,0 +1,55 @@
> +#!/bin/sh
> + ...
> +test_done
> ---
>
> Christian Couder (1):
>   unpack-objects: add --max-input-size=<size> option
>
> Jeff King (2):
>   index-pack: add --max-input-size=<size> option
>   receive-pack: allow a maximum input size to be specified

This was a pleasant read.  All looked sensible.

Thanks.
