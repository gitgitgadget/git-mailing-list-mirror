Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73E2020705
	for <e@80x24.org>; Thu,  7 Jul 2016 20:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933AbcGGUwj (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 16:52:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751243AbcGGUwg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 16:52:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 42A102B74C;
	Thu,  7 Jul 2016 16:52:25 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xt1p2SIrw7UAGpu2MP58YRIrQRM=; b=wAd5eO
	NWgOJjFTRWuuwTj53T1HHxXlIp7/jgQmU61tPMu/Zj16cQFVcljYo86xaHnyAFpK
	UJxcqy3J2WA0tSHO7LN1xunJNkXfndUlR7oVIEo1g87yDkPZlQUGtJ87vb7dugbx
	9jc7hrepUC2T7FimB86M1mw2Yduh3NmU8lPFE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qOiJvh1mmcoDjKMNlGslWgTknzpOsYfa
	foTbFsA9+eMWbb08e8U0IMOUKdQTwqFEbVDgtKVU3hTJDXGFp3zEjTCfqhB1FKQL
	xICKjg8nM12yzF1Nva6Ux7z1xw9+JKgjZ9uFRBtnAWmvJkp9CNAZpfbGvMdP2Uoh
	9GQ5vhUIpmk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 392992B74B;
	Thu,  7 Jul 2016 16:52:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0C4B2B74A;
	Thu,  7 Jul 2016 16:52:24 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, e@80x24.org, peff@peff.net, dwwang@google.com,
	dennis@kaarsemaker.net
Subject: Re: [PATCH 3/4] push: accept push options
References: <20160707011218.3690-1-sbeller@google.com>
	<20160707011218.3690-4-sbeller@google.com>
Date:	Thu, 07 Jul 2016 13:52:22 -0700
In-Reply-To: <20160707011218.3690-4-sbeller@google.com> (Stefan Beller's
	message of "Wed, 6 Jul 2016 18:12:17 -0700")
Message-ID: <xmqq60shp3w9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5364B9A-4484-11E6-A36A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +-L::
> +--push-option::
> +	Transmit the given string to the server, which passes them to
> +	the pre-receive as well as the post-receive hook. Only C strings
> +	containing no new lines are allowed.

This is to affect what happens at the remote end, so I would have
understood "-R".  I also would have understood "-P" as a short-hand
for "--push-option".  What is the justification of "-L"?

What does "C strings" mean?  Did you mean to say "A sequence of
bytes excluding NUL is passed verbatim"?

I do not think I saw anything in the code I reviewed so far that
requires "no LF" limitation.

... Ahh, OK, you want to make sure that push-options are
one-per-line in the push certificate.  While I do not think it is
absolutely necessary, starting with a possibly tighter than
necessary limitation is much better than starting loose and having
to tighten it later.

>  	} else {
>  		struct transport *transport =
>  			transport_get(remote, NULL);
> -
> +		if (flags & TRANSPORT_PUSH_OPTIONS)
> +			transport->push_options = push_options;

The result would be easier to read without the removal of a blank
that separates decl/defn and stmt here.

> @@ -533,6 +542,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
>  		  0, "signed", &push_cert, "yes|no|if-asked", N_("GPG sign the push"),
>  		  PARSE_OPT_OPTARG, option_parse_push_signed },
>  		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"), TRANSPORT_PUSH_ATOMIC),
> +		OPT_STRING_LIST('o', "push-option", &push_options, N_("server-specific"), N_("option to transmit")),

Here it seems to expect "-o".  If we really want a short option,
"-o" would probably be OK, as I do not think "git push" wants to
have "send the output to this file" option.

> diff --git a/send-pack.c b/send-pack.c
> index 299d303..c943560 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -260,6 +260,7 @@ static int generate_push_cert(struct strbuf *req_buf,
>  			      const char *push_cert_nonce)
>  {
>  	const struct ref *ref;
> +	struct string_list_item *item;
>  	char *signing_key = xstrdup(get_signing_key());
>  	const char *cp, *np;
>  	struct strbuf cert = STRBUF_INIT;
> @@ -278,6 +279,12 @@ static int generate_push_cert(struct strbuf *req_buf,
>  		strbuf_addf(&cert, "nonce %s\n", push_cert_nonce);
>  	strbuf_addstr(&cert, "\n");
>  
> +	if (args->push_options) {
> +		for_each_string_list_item(item, args->push_options)
> +			strbuf_addf(&cert, "push-option %s\n", item->string);
> +		strbuf_addstr(&cert, "\n");

Why the extra blank?

I would actually have expected to see

	certificate version ...
        pusher ...
        <datestamp>
	pushee ...	# optional
        nonce ...	# optional
        push-option ... # optional
        push-option ... # optional

        <old> <new> <name>
        ...

by adding this between the two lines in the pre-context of this
hunk, i.e.

	if (push_cert_nonce[0])
		strbuf_addf(&cert, "nonce %s\n", push_cert_nonce);
	if (args->push_options)
		for_each_string_list_item(item, args->push_options)
			strbuf_addf(&cert, "push-option %s\n", item->string);
	strbuf_addstr(&cert, "\n");

