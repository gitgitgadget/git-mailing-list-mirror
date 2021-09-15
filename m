Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DECC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8116560EE5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhIOQ4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:56:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52747 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhIOQ4U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:56:20 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2E4A150045;
        Wed, 15 Sep 2021 12:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6pj9MT3T2OM+ZuqGsvTGfloNnAxl+9PHxvfTXY
        5tFUQ=; b=KhGTPYJON29gMDBCEQMzlhkASOCMipTK0ldlb63nHkMxzKuwQC59yP
        5yIuAy1HGhtaRVanhTHSO0+x8uf2PHs/k/KXPRKhqBvLlFTkAt6ARdpkwEtEsJMx
        VdsW+Q+DtQBX5dTBvjiizc7p7keLC1ZmKh//pcXdf0qn3CZN1JK6o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AE645150044;
        Wed, 15 Sep 2021 12:55:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F2368150043;
        Wed, 15 Sep 2021 12:54:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 04/11] serve: provide "receive" function for
 object-format capability
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
        <YUE1fy0eA0wQnn3f@coredump.intra.peff.net>
Date:   Wed, 15 Sep 2021 09:54:56 -0700
In-Reply-To: <YUE1fy0eA0wQnn3f@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Sep 2021 19:51:27 -0400")
Message-ID: <xmqqlf3xye1r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8AC55C0-1645-11EC-8B09-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There should be no change of behavior here, except for two
> broken-protocol cases:
>
>   - if the client sends multiple conflicting object-format capabilities
>     (which they should not), we'll now choose the last one rather than
>     the first. We could also detect and complain about the duplicates
>     quite easily now, which we could not before, but I didn't do so
>     here.

I'd imagine that it would have been easy to retain the "use the
first one" behaviour if we wanted to; I do not think this behaviour
change really matters in practice, so it's OK.

>   - if the client sends a bogus "object-format" with no equals sign,
>     we'll now say so, rather than "unknown object format: ''"

OK.

> @@ -228,22 +241,6 @@ static int has_capability(const struct strvec *keys, const char *capability,
>  	return 0;
>  }
>  
> -static void check_algorithm(struct repository *r, struct strvec *keys)
> -{
> -	int client = GIT_HASH_SHA1, server = hash_algo_by_ptr(r->hash_algo);
> -	const char *algo_name;
> -
> -	if (has_capability(keys, "object-format", &algo_name)) {
> -		client = hash_algo_by_name(algo_name);
> -		if (client == GIT_HASH_UNKNOWN)
> -			die("unknown object format '%s'", algo_name);
> -	}
> -
> -	if (client != server)
> -		die("mismatched object format: server %s; client %s\n",
> -		    r->hash_algo->name, hash_algos[client].name);
> -}
> -
>  enum request_state {
>  	PROCESS_REQUEST_KEYS,
>  	PROCESS_REQUEST_DONE,
> @@ -317,7 +314,10 @@ static int process_request(void)
>  	if (!command)
>  		die("no command requested");
>  
> -	check_algorithm(the_repository, &keys);
> +	if (client_hash_algo != hash_algo_by_ptr(the_repository->hash_algo))
> +		die("mismatched object format: server %s; client %s\n",
> +		    the_repository->hash_algo->name,
> +		    hash_algos[client_hash_algo].name);

OK.
