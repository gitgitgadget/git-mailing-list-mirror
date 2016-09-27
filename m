Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4814920986
	for <e@80x24.org>; Tue, 27 Sep 2016 17:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935212AbcI0RlT (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 13:41:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51155 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935184AbcI0RlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 13:41:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FC0F3FC2E;
        Tue, 27 Sep 2016 13:41:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gqG16OuK6U3vru1FcK4xwg4UOXc=; b=Gbyx4j
        dRzFZgonr5MYCd2ZjcS5PS2bj5zp+9Re1yA7rLJXpgZ6zu24DEd/UawrK7lRCFjl
        ap/ikKlQFz0cwznmW1c7+3bEiQjxTHUhIBOPPp+3VDkFJrDJhVnkf3oe8tiZbOY1
        mYVQzn0Tkv4fB2ZLWfVIpJrQG59uiAxCCCf/w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xsUegLiKTvkTe+mPC8gdIADML9vKZ4aK
        wk3Qz/8b2dusImbkAJiMr88HbL/1VUt9K5OnHQmvONVeBhR+VBqBvRuspxxnwCrM
        cKA1I8nUtlOhTnxQDMWcmTQDvuaXmOJINdDttOtwSh6A9ThSF5CZDauCepjlSejE
        G8Y4soBQ9ig=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 082A53FC2D;
        Tue, 27 Sep 2016 13:41:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 895463FC2C;
        Tue, 27 Sep 2016 13:41:14 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org
Subject: Re: [PATCH v2 4/5] builtin/verify-tag: add --format to verify-tag
References: <20160926224233.32702-1-santiago@nyu.edu>
        <20160926224233.32702-5-santiago@nyu.edu>
Date:   Tue, 27 Sep 2016 10:41:12 -0700
In-Reply-To: <20160926224233.32702-5-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Mon, 26 Sep 2016 18:42:32 -0400")
Message-ID: <xmqq7f9xp7ev.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 964CDEA2-84D9-11E6-BCE2-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> From: Santiago Torres <santiago@nyu.edu>
>
> Callers of verify-tag may want to cross-check the tagname from refs/tags
> with the tagname from the tag object header upon GPG verification. This
> is to avoid tag refs that point to an incorrect object.
>
> Add a --format parameter to git verify-tag to print the formatted tag
> object header in addition to or instead of the --verbose or --raw GPG
> verification output.
>
> Signed-off-by: Santiago Torres <santiago@nyu.edu>
> ---
>  builtin/verify-tag.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
> index de10198..a941053 100644
> --- a/builtin/verify-tag.c
> +++ b/builtin/verify-tag.c
> @@ -12,12 +12,15 @@
>  #include <signal.h>
>  #include "parse-options.h"
>  #include "gpg-interface.h"
> +#include "ref-filter.h"
>  
>  static const char * const verify_tag_usage[] = {
> -		N_("git verify-tag [-v | --verbose] <tag>..."),
> +		N_("git verify-tag [-v | --verbose] [--format=<format>] <tag>..."),
>  		NULL
>  };
>  
> +static char *fmt_pretty;
> +

I'd suggest to remove this, and then ...

>  static int git_verify_tag_config(const char *var, const char *value, void *cb)
>  {
>  	int status = git_gpg_config(var, value, cb);
> @@ -33,6 +36,7 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)

... instead add

	char *fmt_pretty = NULL;

here, imitating the way "&flags" is handled.  You do not need it to
be visible outside the function.

>  	const struct option verify_tag_options[] = {
>  		OPT__VERBOSE(&verbose, N_("print tag contents")),
>  		OPT_BIT(0, "raw", &flags, N_("print raw gpg status output"), GPG_VERIFY_RAW),
> +		OPT_STRING(  0 , "format", &fmt_pretty, N_("format"), N_("format to use for the output")),
>  		OPT_END()
>  	};
>  
> @@ -46,12 +50,17 @@ int cmd_verify_tag(int argc, const char **argv, const char *prefix)
>  	if (verbose)
>  		flags |= GPG_VERIFY_VERBOSE;
>  
> +	if (fmt_pretty) {
> +		verify_ref_format(fmt_pretty);
> +		flags |= GPG_VERIFY_QUIET;
> +	}
> +
>  	while (i < argc) {
>  		unsigned char sha1[20];
>  		const char *name = argv[i++];
>  		if (get_sha1(name, sha1))
>  			had_error = !!error("tag '%s' not found.", name);
> -		else if (verify_and_format_tag(sha1, name, NULL, flags))
> +		else if (verify_and_format_tag(sha1, name, fmt_pretty, flags))
>  			had_error = 1;
>  	}
>  	return had_error;
