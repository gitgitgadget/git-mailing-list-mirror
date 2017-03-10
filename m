Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725F71FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 20:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755371AbdCJURP (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 15:17:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61344 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755108AbdCJURN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 15:17:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AA9D6974D;
        Fri, 10 Mar 2017 15:17:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z4tdgkF0chxscTIXrJNarJ7g5dY=; b=xXqo6c
        lMM+YoP804DzbgNdU9uixIXusJzvzQ6+wG+KdnjIOHY9qp+k/dxb/InkuZrvJhII
        hDk0M2avlmmokfXjXL1yJWQ3Eq/gU8CKv57yCGMJWsT4BUTqPnRHzNX9kbrN6M7k
        n8kJEBNGoZSjja3s531bsbrp52gTSk3M2JwUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=g2XKm0O3AVCHs8TOI9/oDGmV8jsqD7H8
        n64mWhS+gRUYyyELKUXmMepCOEsFPwqdWFfERRc6T9/FrdOxcgHM3n2HOw6synce
        bD6rAuVMkYhhzgbF8kFpqwu216CFCoGlnKcdCoLw8tA9Lm9szwcSZHXptTUpBQQZ
        oq1gpMRaQBc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92BF26974C;
        Fri, 10 Mar 2017 15:17:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFAB36974A;
        Fri, 10 Mar 2017 15:17:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: detect errors in running spatch
References: <20170310083117.cbflqx7zbe4s7cqv@sigill.intra.peff.net>
Date:   Fri, 10 Mar 2017 12:16:53 -0800
In-Reply-To: <20170310083117.cbflqx7zbe4s7cqv@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 10 Mar 2017 03:31:18 -0500")
Message-ID: <xmqqbmt8yjii.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AE79234-05CE-11E7-9475-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> It also doesn't help that shells are awkward at passing status out of a
> for-loop. I think the most "make-ish" way of doing this would actually
> be to lose the for loop and have a per-cocci-per-source target.

As we assume we can freely use GNUmake facilities, another option,
(i.e. the most "gnumake-ish" way) may be to have it unroll the loop
with $(foreach,...) so that the shell just sees a series of
commands.

> I don't know if that would make the patches harder to apply. The results
> aren't full patches, so I assume you usually do some kind of munging on
> them? I resorted to:
>
>   make coccicheck SPATCH='spatch --in-place'
>
>  Makefile | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 9ec6065cc..d97633892 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2336,9 +2336,17 @@ check: common-cmds.h
>  C_SOURCES = $(patsubst %.o,%.c,$(C_OBJ))
>  %.cocci.patch: %.cocci $(C_SOURCES)
>  	@echo '    ' SPATCH $<; \
> +	ret=0; \
>  	for f in $(C_SOURCES); do \
> -		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS); \
> -	done >$@ 2>$@.log; \
> +		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
> +			{ ret=$$?; break; }; \
> +	done >$@+ 2>$@.log; \
> +	if test $$ret != 0; \
> +	then \
> +		cat $@.log; \
> +		exit 1; \
> +	fi; \
> +	mv $@+ $@; \
>  	if test -s $@; \
>  	then \
>  		echo '    ' SPATCH result: $@; \
