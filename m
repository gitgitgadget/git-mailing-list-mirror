Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717F92047F
	for <e@80x24.org>; Wed, 20 Sep 2017 05:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbdITFr3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 01:47:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53272 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751175AbdITFr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 01:47:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E79689691F;
        Wed, 20 Sep 2017 01:47:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LSA6U0orzZTEKf+AX5dHn221414=; b=pjC/xq
        zxGo696TH6Y24K0vihW98DYdv0zcu96c04vkphSeoS+zZjRiKclQHbRcOcZuck+7
        gmps0WZxT7f6elrLLbjVadlTZBKDjdfu/RZt94oIB0NXy6eSXSXlGgrT0ptGdJtA
        OIzouZYUeSWpdn/t3hC/fPCwwFEHFeSdVfyj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ko+ngh+eTUR6hf0YGgh8kyVZvXslBxkN
        hZSQ9+ESSR2PLnxo7X2QBahQOiZbgo71AP72JFS6+U4IAQwKmK+rVwAc3J67VdGG
        /xHxVXvjyTyoCXaQg5dq/hTray2fyjyPhqG8nqu1YK9SKVpetzh0GxkYimSrryvO
        yEHDnoiRQhs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC6289691E;
        Wed, 20 Sep 2017 01:47:27 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 306AF9691D;
        Wed, 20 Sep 2017 01:47:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     David.Turner@twosigma.com, avarab@gmail.com,
        christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v7 03/12] update-index: add a new --force-write-index option
References: <20170915192043.4516-1-benpeart@microsoft.com>
        <20170919192744.19224-1-benpeart@microsoft.com>
        <20170919192744.19224-4-benpeart@microsoft.com>
Date:   Wed, 20 Sep 2017 14:47:25 +0900
In-Reply-To: <20170919192744.19224-4-benpeart@microsoft.com> (Ben Peart's
        message of "Tue, 19 Sep 2017 15:27:35 -0400")
Message-ID: <xmqq7ewtor9u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2F20076A-9DC7-11E7-81D3-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> +		OPT_SET_INT(0, "force-write-index", &force_write,
> +			N_("write out the index even if is not flagged as changed"), 1),

Hmph.  The only time this makes difference is when the code forgets
to mark active_cache_changed even when it actually made a change to
the index, no?  I do understand the wish to be able to observe what
_would_ be written if such a bug did not exist in order to debug the
other aspects of the change in this series, but at the same time I
fear that we may end up sweeping the problem under the rug by
running the tests with this option.

>  		OPT_END()
>  	};
>  
> @@ -1147,7 +1150,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		die("BUG: bad untracked_cache value: %d", untracked_cache);
>  	}
>  
> -	if (active_cache_changed) {
> +	if (active_cache_changed || force_write) {
>  		if (newfd < 0) {
>  			if (refresh_args.flags & REFRESH_QUIET)
>  				exit(128);
