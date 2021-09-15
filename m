Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E5EC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A1B61242
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 17:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhIORDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 13:03:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61716 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIORDA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 13:03:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 17A021500B5;
        Wed, 15 Sep 2021 13:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mg+3IjG3QQrdxOGGBanBc8Hjj1xBrJt3/8AbNj
        SafuQ=; b=HIQozCXNG0Hq2rqp+Yo9DgZd38uoZzfHrgv/tX+iurIbYjnYrcSW4B
        1MyfFeRZFfxKZjGPXBx1bsY235lc6tMTu2sjIFty71prwbdjhc4+3EJol33ZEEkh
        zVo7KHaH8yIAytIVOcQymU5nCVvucwnjpGGo1PbWVO2uiqyClT0NY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 111641500B4;
        Wed, 15 Sep 2021 13:01:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 57B471500B3;
        Wed, 15 Sep 2021 13:01:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 06/11] serve: drop "keys" strvec
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
        <YUE1hExkU9V12iZv@coredump.intra.peff.net>
Date:   Wed, 15 Sep 2021 10:01:36 -0700
In-Reply-To: <YUE1hExkU9V12iZv@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Sep 2021 19:51:32 -0400")
Message-ID: <xmqqczp9ydqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 974FFAE2-1646-11EC-AA27-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We collect the set of capabilities the client sends us in a strvec.
> While this is usually small, there's no limit to the number of
> capabilities the client can send us (e.g., they could just send us
> "agent" pkt-lines over and over, and we'd keep adding them to the list).
>
> Since all code has been converted away from using this list, let's get
> rid of it. This avoids a potential attack where clients waste our
> memory.
>
> Note that we do have to replace it with a flag, because some of the
> flush-packet logic checks whether we've seen any valid commands or keys.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  serve.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/serve.c b/serve.c
> index 6bbf54cbbe..5ea6c915cb 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -239,7 +239,7 @@ static int process_request(void)
>  {
>  	enum request_state state = PROCESS_REQUEST_KEYS;
>  	struct packet_reader reader;
> -	struct strvec keys = STRVEC_INIT;
> +	int seen_capability_or_command = 0;
>  	struct protocol_capability *command = NULL;
>  
>  	packet_reader_init(&reader, 0, NULL, 0,
> @@ -263,7 +263,7 @@ static int process_request(void)
>  			/* collect request; a sequence of keys and values */
>  			if (parse_command(reader.line, &command) ||
>  			    receive_client_capability(reader.line))
> -				strvec_push(&keys, reader.line);
> +				seen_capability_or_command = 1;

OK, we no longer "collect" request in the keys strvec, but I guess
what receive_client_capability() does still counts as "collecting",
so the "tentatively stale" comment is not wrong after all at the end
(we have tentatively been collecting in two different places and one
of them is dropped here).

> @@ -275,7 +275,7 @@ static int process_request(void)
>  			 * If no command and no keys were given then the client
>  			 * wanted to terminate the connection.
>  			 */
> -			if (!keys.nr)
> +			if (!seen_capability_or_command)
>  				return 1;
>  
>  			/*
> @@ -309,7 +309,6 @@ static int process_request(void)
>  
>  	command->command(the_repository, &reader);
>  
> -	strvec_clear(&keys);
>  	return 0;
>  }

Nice.
