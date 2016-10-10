Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E61A20989
	for <e@80x24.org>; Mon, 10 Oct 2016 22:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752180AbcJJWSL (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 18:18:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65222 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751321AbcJJWSK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 18:18:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFC0C44321;
        Mon, 10 Oct 2016 18:18:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=b1Wjq3iiE63FSOf2J2A/qwohls0=; b=raQ6Nb8OUHRcls6Z1Wqv
        YIFsCibsCyRNd8+9KI2QN6LC5imHHsxUvi4coscBgz0KuT7OEWqhMT9lD3ss8dxE
        zbd0tFo+czFGk482K6I38c1N7KVpOJjZxLaxXxtVgJVUlhPe4zl3Ixdhe+bZCj5A
        3kQzLXLhLF8VZameDXLimyk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=rEmXdJbsC0vUrUZmmw90OFRdNCdQSEMXVF45d1nLToQHSK
        845PmYRr0nRCGdGyXctYK+A20AkWcqVmLqVQgkGRshIuduzr7AnMix1cUyVnoVA9
        GZh5ivfhorVQRk8g4VMyn2lNZlKAUzadTi7ceIf5VdhYU2VvjhH2Do+CQk03I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6C7044320;
        Mon, 10 Oct 2016 18:18:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 345F34431F;
        Mon, 10 Oct 2016 18:18:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 05/25] sequencer: eventually release memory allocated for the option values
References: <cover.1473590966.git.johannes.schindelin@gmx.de>
        <cover.1476120229.git.johannes.schindelin@gmx.de>
        <a67af02ef363311b526bddba864c7f1ca9087b43.1476120229.git.johannes.schindelin@gmx.de>
Date:   Mon, 10 Oct 2016 15:18:07 -0700
Message-ID: <xmqqzimbc0gw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CC6132E-8F37-11E6-AB83-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/builtin/revert.c b/builtin/revert.c
> index 7365559..fce9c75 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -174,6 +174,12 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>  
>  	if (argc > 1)
>  		usage_with_options(usage_str, options);
> +
> +	/* These option values will be free()d */
> +	if (opts->gpg_sign)
> +		opts->gpg_sign = xstrdup(opts->gpg_sign);
> +	if (opts->strategy)
> +		opts->strategy = xstrdup(opts->strategy);
>  }

This certainly is good, but I wonder if a new variant of OPT_STRING
and OPTION_STRING that does the strdup for you, something along the
lines of ...

diff --git a/parse-options.c b/parse-options.c
index 312a85dbde..6aab6b0b05 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -138,6 +138,21 @@ static int get_value(struct parse_opt_ctx_t *p,
 			return get_arg(p, opt, flags, (const char **)opt->value);
 		return 0;
 
+	case OPTION_STRDUP:
+		err = 0;
+		free(opt->value);
+		if (unset)
+			*(const char **)opt->value = NULL;
+		else if (opt->flags & PARSE_OPT_OPTARG && !p->opt)
+			*(const char **)opt->value = xstrdup(opt->defval);
+		else {
+			const char *v;
+			err = get_arg(p, opt, flags, &v);
+			if (!err)
+				*(const char **)opt->value = xstrdup(v);
+		}
+		return err;
+
 	case OPTION_FILENAME:
 		err = 0;
 		if (unset)

... may make it even more pleasant to use?  Only for two fields in
this patch that may probably be an overkill, but we may eventually 
benefit from such an approach when we audit and plug leaks in
parse-options users.  I dunno.

It is a sign that the caller wants to _own_ the memory to mark a
variable or field with OPTION_STRDUP, which is why I added the
free() at the beginning there.

The remainder of this patch looks sensible.  The code that frees
these fields when we are done with the struct (and when we are
re-assigning) looked all good.
