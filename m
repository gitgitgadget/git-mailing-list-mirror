Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15880C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 22:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiC1Wqu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiC1Wqt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 18:46:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D4F12F146
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 15:45:08 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7910F193460;
        Mon, 28 Mar 2022 18:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=z6PnxgRYkpTC
        6ByZCSjVxlk4jbdJOjW1MCHlrwWxuKo=; b=KkjvRiWUeRlRAAhV3ammYEtvpbHo
        XyX05ehXXVlR3j4l75xevgw3+ajIWQMerABjM4nOTnvoDaF1SeQAC1uWkmRaIm2I
        sWTf09M4PCZo6kYkTL+cdW+6Uq34Mf9Nqwi9aEbkVoI+2flRgqpYHYD/R9JofMNT
        kdcnXqrvt527Ajs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 70CA419345F;
        Mon, 28 Mar 2022 18:45:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8892219345E;
        Mon, 28 Mar 2022 18:45:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] reflog: fix 'show' subcommand's argv
References: <patch-8.8-618e975f8b2-20220317T180439Z-avarab@gmail.com>
        <20220328212152.589491-1-szeder.dev@gmail.com>
Date:   Mon, 28 Mar 2022 15:45:02 -0700
In-Reply-To: <20220328212152.589491-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Mon, 28 Mar 2022 23:21:52 +0200")
Message-ID: <xmqqa6d9zogh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B51B3E34-AEE8-11EC-9077-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> cmd_reflog() invokes parse_options() with PARSE_OPT_KEEP_ARGV0, but it
> doesn't account for the retained argv[0] before invoking
> cmd_reflog_show() to handle the 'git reflog show' subcommand.
> Consequently, cmd_reflog_show() always gets an 'argv' array starting
> with elements argv[0]=3D"reflog" and argv[1]=3D"show".
>
> Strip the name of the git command from the 'argv' array before passing
> it to the function handling the 'show' subcommand.
>
> There is no user-visible bug here, because cmd_reflog_show() doesn't
> have any options or parameters of its own.

These two changes cancel out as far as cmd_log_reflog() is concerned
but makes a difference inside cmd_reflog_show(), if that function
cared.

There is parse_options() call that uses argc and argv supplied by
the caller, and it is not adjusted, so it is curious why there is no
externally observable behaviour change.  But argv[0] and argv[1] are
not dashed options and because we do not say STOP_AT_NON_OPTION,
parse_options() will skip such an extra non-option argument, so is
that the reason why there is no behaviour change?

As this is an "oops, that is not quite right" fix for
ab/reflog-parse-options topic, let's queue it diretly on top of the
topic.

Thanks.

> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/reflog.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 6c4fe1af40..c943c2aabe 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -225,7 +225,7 @@ static int cmd_reflog_show(int argc, const char **a=
rgv, const char *prefix)
>  		      PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
>  		      PARSE_OPT_KEEP_UNKNOWN);
> =20
> -	return cmd_log_reflog(argc - 1, argv + 1, prefix);
> +	return cmd_log_reflog(argc, argv, prefix);
>  }
> =20
>  static int cmd_reflog_expire(int argc, const char **argv, const char *=
prefix)
> @@ -425,7 +425,7 @@ int cmd_reflog(int argc, const char **argv, const c=
har *prefix)
>  		goto log_reflog;
> =20
>  	if (!strcmp(argv[1], "show"))
> -		return cmd_reflog_show(argc, argv, prefix);
> +		return cmd_reflog_show(argc - 1, argv + 1, prefix);
>  	else if (!strcmp(argv[1], "expire"))
>  		return cmd_reflog_expire(argc - 1, argv + 1, prefix);
>  	else if (!strcmp(argv[1], "delete"))
