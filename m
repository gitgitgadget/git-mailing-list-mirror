Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E7D520986
	for <e@80x24.org>; Tue, 27 Sep 2016 18:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755287AbcI0Skv (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 14:40:51 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64974 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754825AbcI0Sku (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 14:40:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA4CB405E3;
        Tue, 27 Sep 2016 14:40:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BAXcaIReJHMu8lqOfkxXaWwtZAI=; b=GMrW82
        sXFM8jWB47axtuzPx/kG/8GHQ/TjgjxLcArqWVfgk8t/qiwphUodujpQhamo7pEf
        ooAffcurVk9+kbKIEYCbubZHaACpk2jUIE/USE9dKexaubG/YqnZNXonNnlI0DSv
        hfj8j0btQ2OTgx2VRTwUfQ1v2fHlJNvyGxAOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JIbjS+NaQEc1V6g5VcVnIWmTrFWcPeNL
        jyERG9fLaN3JByHPBuenXxMYF45nhe1gc2sZ+ElugWxV7gg3+x/sjW11qwFgMKIf
        4U3LXiGTv9GJquP4qp+NvXb3/5rAyIZ3FZausReOHN8Zbt4HQDG72Erjc30zJgAM
        ESSp5vAwWJY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9999E405E0;
        Tue, 27 Sep 2016 14:40:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1DE4F405DE;
        Tue, 27 Sep 2016 14:40:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4 v4] ls-files: pass through safe options for --recurse-submodules
References: <1474676014-134568-1-git-send-email-bmwill@google.com>
        <1474930003-83750-1-git-send-email-bmwill@google.com>
        <1474930003-83750-4-git-send-email-bmwill@google.com>
Date:   Tue, 27 Sep 2016 11:40:47 -0700
In-Reply-To: <1474930003-83750-4-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Mon, 26 Sep 2016 15:46:42 -0700")
Message-ID: <xmqqh991nq34.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8E72A52-84E1-11E6-8970-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Pass through some known-safe options when recursing into submodules.
> (--cached, --stage, -v, -t, -z, --debug, --eol)
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/ls-files.c                     | 34 ++++++++++++++++++++++++++++++----
>  t/t3007-ls-files-recurse-submodules.sh | 17 ++++++++++++-----
>  2 files changed, 42 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index d4bfc60..a39367f 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -31,6 +31,7 @@ static int debug_mode;
>  static int show_eol;
>  static int recurse_submodules;
>  static const char *submodule_prefix;
> +static struct argv_array recurse_submodules_opts = ARGV_ARRAY_INIT;

I'd imagine that this is also thread-unsafe, but we do not have to
comment it ;-)

> @@ -170,6 +171,27 @@ static void show_killed_files(struct dir_struct *dir)
>  	}
>  }
>  
> +/*
> + * Compile an argv_array with all of the options supported by --recurse_submodules
> + */
> +static void compile_submodule_options(int show_tag)
> +{
> +	if (show_cached)
> +		argv_array_push(&recurse_submodules_opts, "--cached");
> +	if (show_stage)
> +		argv_array_push(&recurse_submodules_opts, "--stage");
> +	if (show_valid_bit)
> +		argv_array_push(&recurse_submodules_opts, "-v");
> +	if (show_tag)
> +		argv_array_push(&recurse_submodules_opts, "-t");
> +	if (line_terminator == '\0')
> +		argv_array_push(&recurse_submodules_opts, "-z");
> +	if (debug_mode)
> +		argv_array_push(&recurse_submodules_opts, "--debug");
> +	if (show_eol)
> +		argv_array_push(&recurse_submodules_opts, "--eol");
> +}

OK.  These are only the safe ones to pass through?  "compile" or
"assemble" is much less important thing to say than how these are
chosen.  "pass_supported_options()" or something?  I dunno.

>  	if (recurse_submodules &&
> -	    (show_stage || show_deleted || show_others || show_unmerged ||
> +	    (show_deleted || show_others || show_unmerged ||
>  	     show_killed || show_modified || show_resolve_undo ||
> -	     show_valid_bit || show_tag || show_eol || with_tree ||
> -	     (line_terminator == '\0')))
> +	     with_tree))
>  		die("ls-files --recurse-submodules unsupported mode");

Makes sense.

> +test_expect_success 'ls-files correctly outputs files in submodule with -z' '
> +	cat | tr "\n" "\0" >expect <<-\EOF &&
> +	.gitmodules
> +	a
> +	b/b
> +	submodule/c
> +	EOF

Hmm, what do you need "cat" for here?

In nul_to_q and q_to_nul implementations (t/test-lib-functions.sh)
we seem to avoid using "tr", even though q_to_cr and others do use
it.  I wonder if we had some portability issues with passing NUL
through tr or something?

    ... digs and finds e85fe4d8 ("more tr portability test script
    fixes", 2008-03-12)

So use something like

	perl -pe 'y/\012/\000/' <<\-EOF
        ...
        EOF

instead, perhaps?

> +	git ls-files --recurse-submodules -z >actual &&
> +	test_cmp expect actual
> +'
