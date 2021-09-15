Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE34C433FE
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160356103E
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 16:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhIOQ6F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 12:58:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55520 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229465AbhIOQ6F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 12:58:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95503F5D33;
        Wed, 15 Sep 2021 12:56:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k/CHATwM2/90isR9H6KZYX3aBL8wuod8TZKh1Z
        IbBlA=; b=ASAOlGQpO3wLE9CJein8nFdo/q+DEBJXOWCeQqzEAAUDpOQ7VuaWaX
        v/793jdFu79sQrdDkBMHUpobjWTmtUx7ztLNLshB5uX8uzM0OgCZxTPNdK/FmYcr
        /3aPJaL6+C5OuvO4Qu0wcXPnC2gaWsdEqF8FdUfdh9nfEOSa9pYZQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C174F5D32;
        Wed, 15 Sep 2021 12:56:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 14A44F5D30;
        Wed, 15 Sep 2021 12:56:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 05/11] serve: provide "receive" function for
 session-id capability
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
        <YUE1gvovwj/X1wWV@coredump.intra.peff.net>
Date:   Wed, 15 Sep 2021 09:56:44 -0700
In-Reply-To: <YUE1gvovwj/X1wWV@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 14 Sep 2021 19:51:30 -0400")
Message-ID: <xmqqh7elydyr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E881FD08-1645-11EC-B354-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Rather than pulling the session-id string from the list of collected
> capabilities, we can handle it as soon as we receive it. This gets us
> closer to dropping the collected list entirely.
>
> The behavior should be the same, with one exception. Previously if the
> client sent us multiple session-id lines, we'd report only the first.
> Now we'll pass each one along to trace2. This shouldn't matter in
> practice, since clients shouldn't do that (and if they do, it's probably
> sensible to log them all).
>
> As this removes the last caller of the static has_capability(), we can
> remove it, as well (and in fact we must to avoid -Wunused-function
> complaining).

Nice.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  serve.c | 33 +++++++++------------------------
>  1 file changed, 9 insertions(+), 24 deletions(-)
>
> diff --git a/serve.c b/serve.c
> index f6ea2953eb..6bbf54cbbe 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -57,6 +57,14 @@ static int session_id_advertise(struct repository *r, struct strbuf *value)
>  	return 1;
>  }
>  
> +static void session_id_receive(struct repository *r,
> +			       const char *client_sid)
> +{
> +	if (!client_sid)
> +		client_sid = "";
> +	trace2_data_string("transfer", NULL, "client-sid", client_sid);
> +}
> +
>  struct protocol_capability {
>  	/*
>  	 * The name of the capability.  The server uses this name when
> @@ -121,6 +129,7 @@ static struct protocol_capability capabilities[] = {
>  	{
>  		.name = "session-id",
>  		.advertise = session_id_advertise,
> +		.receive = session_id_receive,
>  	},
>  	{
>  		.name = "object-info",
> @@ -221,26 +230,6 @@ static int parse_command(const char *key, struct protocol_capability **command)
>  	return 0;
>  }
>  
> -static int has_capability(const struct strvec *keys, const char *capability,
> -			  const char **value)
> -{
> -	int i;
> -	for (i = 0; i < keys->nr; i++) {
> -		const char *out;
> -		if (skip_prefix(keys->v[i], capability, &out) &&
> -		    (!*out || *out == '=')) {
> -			if (value) {
> -				if (*out == '=')
> -					out++;
> -				*value = out;
> -			}
> -			return 1;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  enum request_state {
>  	PROCESS_REQUEST_KEYS,
>  	PROCESS_REQUEST_DONE,
> @@ -252,7 +241,6 @@ static int process_request(void)
>  	struct packet_reader reader;
>  	struct strvec keys = STRVEC_INIT;
>  	struct protocol_capability *command = NULL;
> -	const char *client_sid;
>  
>  	packet_reader_init(&reader, 0, NULL, 0,
>  			   PACKET_READ_CHOMP_NEWLINE |
> @@ -319,9 +307,6 @@ static int process_request(void)
>  		    the_repository->hash_algo->name,
>  		    hash_algos[client_hash_algo].name);
>  
> -	if (has_capability(&keys, "session-id", &client_sid))
> -		trace2_data_string("transfer", NULL, "client-sid", client_sid);
> -
>  	command->command(the_repository, &reader);
>  
>  	strvec_clear(&keys);
