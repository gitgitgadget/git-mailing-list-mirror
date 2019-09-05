Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11C471F461
	for <e@80x24.org>; Thu,  5 Sep 2019 18:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbfIESW5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 14:22:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57828 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfIESW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 14:22:57 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAD2529630;
        Thu,  5 Sep 2019 14:22:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7F+YPV44FC0GPVKdvb9MPfZTe+s=; b=WV/gtT
        GK3mBp8zHuvPLOYEitzm+Tt6XOPTjLXWjyFprwWfFK4dytMKtXfJjc9PbyY5P+v4
        kQE6loz+/qOsdMjFggLXk82mRX5IRd9fZ8nQ9bf98QDvEU+oKrFXK5KzMgplEs8F
        O7Aohg+cGtANmqNYc6KxSPextIAXTwhSnfabc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rbip23nA5oXsBXIwign5goBKFkvs2iFM
        cAHY15RduNyMjdF/hm+r0sgDeqpyOdQ8zrxQn5/Z93Zgb2ev7FO7kNjK17V0LBoS
        W+ljxaFnzZtVKBoBPaWRlRG2bIp8sOduHHsNFm8wjtX95d/irNklFwYVGKQbtmWM
        McunTyIH54U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2C572962F;
        Thu,  5 Sep 2019 14:22:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D5702962E;
        Thu,  5 Sep 2019 14:22:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stephan Beyer <s-beyer@gmx.net>, Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Shawn O. Pearce" <spearce@spearce.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
References: <20190905082459.26816-1-s-beyer@gmx.net>
        <xmqqd0ger5j7.fsf@gitster-ct.c.googlers.com>
        <20190905180348.GC23663@sigill.intra.peff.net>
Date:   Thu, 05 Sep 2019 11:22:53 -0700
In-Reply-To: <20190905180348.GC23663@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 5 Sep 2019 14:03:48 -0400")
Message-ID: <xmqq36har4aq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D7915EC-D00A-11E9-A92B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I said earlier that I wouldn't mind seeing "namelen = 0" here. But I
> think there is a much more direct solution: keeping the assignment and
> point of use closer together. That makes it more clear both to the
> compiler and to a human when we expect the variable to be valid. In
> fact, since it's only used once, we can drop the variable altogther. :)

Yeah, that sounds like a nice solution.

> diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
> index 7e79b555de..244977a29b 100644
> --- a/t/helper/test-read-cache.c
> +++ b/t/helper/test-read-cache.c
> @@ -4,11 +4,10 @@
>  
>  int cmd__read_cache(int argc, const char **argv)
>  {
> -	int i, cnt = 1, namelen;
> +	int i, cnt = 1;
>  	const char *name = NULL;
>  
>  	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
> -		namelen = strlen(name);
>  		argc--;
>  		argv++;
>  	}
> @@ -24,7 +23,7 @@ int cmd__read_cache(int argc, const char **argv)
>  
>  			refresh_index(&the_index, REFRESH_QUIET,
>  				      NULL, NULL, NULL);
> -			pos = index_name_pos(&the_index, name, namelen);
> +			pos = index_name_pos(&the_index, name, strlen(name));
>  			if (pos < 0)
>  				die("%s not in index", name);
>  			printf("%s is%s up to date\n", name,
