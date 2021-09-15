Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A140EC433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D9A60E8B
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhIOQnI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:43:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55656 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhIOQmt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:42:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B0E2F5B2F;
        Wed, 15 Sep 2021 12:41:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OYPwbi993BVnbiA8tA6SwK1hj/DpyVhVfFx+/a
        uzzkY=; b=mtVK7I3sIWFp2pYoeh0ZmwFWt01ui8l2sOC9oO36bJfRefXwebNeuH
        WmrswPraZ9t7BudamQrJkBljOQynkrpfqJG56zf0BOvJEuDVLPkjdOEYEX2NIwiz
        itWffPpne/0r2p0knpC4TzsO+nLxouhmOezYEK55AVgVQoQFBQ8+Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4121DF5B2E;
        Wed, 15 Sep 2021 12:41:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B406BF5B2D;
        Wed, 15 Sep 2021 12:41:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 03/11] serve: add "receive" method for v2
 capabilities table
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
        <YUE1fGZc1FuuyUNH@coredump.intra.peff.net>
Date:   Wed, 15 Sep 2021 09:41:28 -0700
In-Reply-To: <YUE1fGZc1FuuyUNH@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Sep 2021 19:51:24 -0400")
Message-ID: <xmqqpmt9yeo7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C652D1AA-1643-11EC-81F1-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +	/*
> +	 * Function called when a client requests the capability as a
> +	 * non-command. This may be NULL if the capability does nothing.
> +	 *
> +	 * For a capability of the form "foo=bar", the value string points to
> +	 * the content after the "=" (i.e., "bar"). For simple capabilities
> +	 * (just "foo"), it is NULL.
> +	 */
> +	void (*receive)(struct repository *r, const char *value);

What does "as a non-command" mean?  To put it another way, when a
client requests the capability as a command, what does the receive
method do differently?

> @@ -164,12 +174,17 @@ static struct protocol_capability *get_capability(const char *key, const char **
>  	return NULL;
>  }
>  
> -static int is_valid_capability(const char *key)
> +static int receive_client_capability(const char *key)
>  {
>  	const char *value;
>  	const struct protocol_capability *c = get_capability(key, &value);
>  
> -	return c && c->advertise(the_repository, NULL);
> +	if (!c || !c->advertise(the_repository, NULL))
> +		return 0;
> +
> +	if (c->receive)
> +		c->receive(the_repository, value);
> +	return 1;
>  }
>  
>  static int parse_command(const char *key, struct protocol_capability **command)
> @@ -262,7 +277,7 @@ static int process_request(void)
>  		case PACKET_READ_NORMAL:
>  			/* collect request; a sequence of keys and values */

The comment tentatively gets slightly stale here, but that will be
corrected at the end, so it would be fine ;-)

>  			if (parse_command(reader.line, &command) ||
> -			    is_valid_capability(reader.line))
> +			    receive_client_capability(reader.line))
>  				strvec_push(&keys, reader.line);
>  			else
>  				die("unknown capability '%s'", reader.line);
