Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8B91FF40
	for <e@80x24.org>; Wed, 14 Dec 2016 17:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbcLNR6u (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 12:58:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60765 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753793AbcLNR6t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 12:58:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16E85556CE;
        Wed, 14 Dec 2016 12:57:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OGjbJmgHqbm0bKiwSMrMyrjdGwk=; b=vMG6+Z
        SpCU4pxTDbI8vqnRDBvBKea3GSko+15mrV4PrHNzgLw8zvWBHNUMYytrMm1CwYlJ
        vjsSj+BUpRwJeX7RmliMkbldYmGG+FM1WpCRjTuFIgiDVI3YC20f3hdIUNipcsNB
        HG7Qdd8r8iQaZjEEJd4Uqugx3qQQrQKEix3LU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NwpmS3E9D8Hl2LkE5nG1+L5lxzWLeSqC
        bpUqP8LTewX6+eDevtFaAZY91rcrVfRF3/mc5pNoaYfZVQPGliDcJwl8Cj4NPej3
        /PJkqltza4eoX5uRvOcdEJ9fl5tIPiLu/WFRBh9apEXNeAHGM1GvKpjFFoWuIbBm
        +NRuRqEzNgY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 056D3556CD;
        Wed, 14 Dec 2016 12:57:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 75D6E556CB;
        Wed, 14 Dec 2016 12:57:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] parse-options: print "fatal:" before usage_msg_opt()
References: <20161214151009.4wdzjb44f6aki5ug@sigill.intra.peff.net>
Date:   Wed, 14 Dec 2016 09:57:55 -0800
In-Reply-To: <20161214151009.4wdzjb44f6aki5ug@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 14 Dec 2016 10:10:10 -0500")
Message-ID: <xmqqr35axujg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7B61450-C226-11E6-8B76-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Programs may use usage_msg_opt() to print a brief message
> followed by the program usage, and then exit. The message
> isn't prefixed at all, though, so it doesn't match our usual
> error output and is easy to overlook:
>
>     $ git clone 1 2 3
>     Too many arguments.
>
>     usage: git clone [<options>] [--] <repo> [<dir>]
>
>     -v, --verbose         be more verbose
>     -q, --quiet           be more quiet
>     --progress            force progress reporting
>     -n, --no-checkout     don't create a checkout
>     --bare                create a bare repository
>     [...and so on for another 31 lines...]
>
> It looks especially bad when the message starts with an
> option, like:
>
>     $ git replace -e
>     -e needs exactly one argument
>
>     usage: git replace [-f] <object> <replacement>
>        or: git replace [-f] --edit <object>
>     [...etc...]
>
> Let's put our usual "fatal:" prefix in front of it.

I briefly wondered if any caller uses this in a non-fatal situation,
but usage_with_options() always dies, so this looks like the right
thing to do.  Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Some of the message in git-clone could stand to be rewritten to match
> our usual style, too (no capitals, no trailing period), but that's
> obviously out of scope for this patch. I don't think this change makes
> them look any worse.
>
>  parse-options.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/parse-options.c b/parse-options.c
> index 312a85dbd..4fbe924a5 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -661,7 +661,7 @@ void NORETURN usage_msg_opt(const char *msg,
>  		   const char * const *usagestr,
>  		   const struct option *options)
>  {
> -	fprintf(stderr, "%s\n\n", msg);
> +	fprintf(stderr, "fatal: %s\n\n", msg);
>  	usage_with_options(usagestr, options);
>  }
