Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8347A1F855
	for <e@80x24.org>; Wed, 27 Jul 2016 22:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162965AbcG0WJV (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 18:09:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56379 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162948AbcG0WJM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 18:09:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BA721312E4;
	Wed, 27 Jul 2016 18:09:09 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k7xjVJvyqEf7jxVcpeacUuNe+lM=; b=BELFRi
	3Fgtf1i5s6b/9uYi65LB5tI1r7hWzNUAQBLMPtUkuiHmBy5mruNMlS1zPlXXqvRc
	zc5ZtGnbT5YvDolz7uL5oSO072qB7HZHxzgj2X/dGGKomY7qXVYLa7GzghQxsRqZ
	CfaA2GMWltumDG0MclwBW68VtElRTyMSxDef8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=be9jnNVKVgNTjQteZDrSMmTWkIGc4dpE
	kFSrjGyJ4NNWWx/OBa32hakzycdIQaKNC+m/5bO+NccrhXcuhRNnjbCIggGLkiQ7
	a+brIT/yn6Kf6zBLOtnxj85h90z6j70+sm68LcU33MxykndVhkSmDgvjq1fvbdC8
	+bSA5B1BqMw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AECBA312DC;
	Wed, 27 Jul 2016 18:09:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B107312DB;
	Wed, 27 Jul 2016 18:09:09 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 14/16] merge-recursive: offer an option to retain the output in 'obuf'
References: <cover.1469187652.git.johannes.schindelin@gmx.de>
	<cover.1469547160.git.johannes.schindelin@gmx.de>
	<0ba371955b9a4aeb752ce08fc22bbd8171f413c4.1469547160.git.johannes.schindelin@gmx.de>
Date:	Wed, 27 Jul 2016 15:09:07 -0700
In-Reply-To: <0ba371955b9a4aeb752ce08fc22bbd8171f413c4.1469547160.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 26 Jul 2016 18:06:42 +0200
	(CEST)")
Message-ID: <xmqqd1lyvim4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDF1A618-5446-11E6-B840-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Since 66a155b (Enable output buffering in merge-recursive., 2007-01-14),
> we already accumulate the output in a buffer. The idea was to avoid
> interfering with the progress output that goes to stderr, which is
> unbuffered, when we write to stdout, which is buffered.
>
> We extend that buffering to allow the caller to handle the output
> (possibly suppressing it). This will help us when extending the
> sequencer to do rebase -i's brunt work: it does not want the picks to
> print anything by default but instead determine itself whether to print
> the output or not.
>
> Note that we also redirect the error messages into the output buffer
> when the caller asked not to flush the output buffer, for two reasons:
> 1) to retain the correct output order, and 2) to allow the caller to
> suppress *all* output.

I am not yet sure if it makes sense to mix both the regular output
and an error into the same buffer for the callers to process (your
"reason 1)" above), and this looks like a wrong way to allow a
caller that wants no output (your "reason 2)" above).  A caller that
wants to massage the output would want to know which ones are errors
and which ones are not, I would imagine, and setting a knob to make
both output() and err() a no-op would be a more suitable way to give
a caller a total silence.

At least I cannot yet judge if this is a good change, only from the
material presented here.  That does not mean I have a concrete
reason to say this is a bad change, either.  Only from the material
presented here, I cannot judge that, either.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  merge-recursive.c | 17 +++++++++++++----
>  merge-recursive.h |  2 +-
>  2 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 723b8d0..311cfa4 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -25,7 +25,7 @@
>  
>  static void flush_output(struct merge_options *o)
>  {
> -	if (o->obuf.len) {
> +	if (o->buffer_output < 2 && o->obuf.len) {
>  		fputs(o->obuf.buf, stdout);
>  		strbuf_reset(&o->obuf);
>  	}
> @@ -36,10 +36,19 @@ static int err(struct merge_options *o, const char *err, ...)
>  	va_list params;
>  
>  	va_start(params, err);
> -	flush_output(o);
> +	if (o->buffer_output < 2)
> +		flush_output(o);
> +	else {
> +		strbuf_complete(&o->obuf, '\n');
> +		strbuf_addstr(&o->obuf, "error: ");
> +	}
>  	strbuf_vaddf(&o->obuf, err, params);
> -	error("%s", o->obuf.buf);
> -	strbuf_reset(&o->obuf);
> +	if (o->buffer_output > 1)
> +		strbuf_addch(&o->obuf, '\n');
> +	else {
> +		error("%s", o->obuf.buf);
> +		strbuf_reset(&o->obuf);
> +	}
>  	va_end(params);
>  
>  	return -1;
> diff --git a/merge-recursive.h b/merge-recursive.h
> index d415724..340704c 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -13,7 +13,7 @@ struct merge_options {
>  		MERGE_RECURSIVE_THEIRS
>  	} recursive_variant;
>  	const char *subtree_shift;
> -	unsigned buffer_output : 1;
> +	unsigned buffer_output : 2; /* 1: output at end, 2: keep buffered */
>  	unsigned renormalize : 1;

Once a field ceases to be a boolean, it is OK not to squish it into
a bitfield like this for a struct that we will have only a very
small number of instances of.  Treating it just like "verbosity",
which occupies a whole int even though it can only get up to 5 or
so, would be more appropriate.

>  	long xdl_opts;
>  	int verbosity;
