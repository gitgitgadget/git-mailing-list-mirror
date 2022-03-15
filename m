Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF61C433EF
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 17:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350746AbiCORwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237757AbiCORwj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 13:52:39 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8266B51312
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 10:51:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E633E19279B;
        Tue, 15 Mar 2022 13:51:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F3hshD/JFYxOLQ5MGbdfZcG3kdm+H1xMiDo9gM
        Aq5ms=; b=piGB3k+jyPDKVTlCOpWYjGMWMQaCFgxlLJ4hseCuTqXohswvGnknSh
        vVfp+Su5UUN0DEVb0yYGQPUtIIzbeChqJ8x/uq6JCFiffx+IrCBPgtzM+YOEszRX
        LHzpn6NhfRoJyNC26zhbxqUX0x1I2Fsz6RGfgsUStYcx2l+2fe4Gg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DEF4619279A;
        Tue, 15 Mar 2022 13:51:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 26F63192797;
        Tue, 15 Mar 2022 13:51:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 4/4] terminal: restore settings on SIGTSTP
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
        <20220315105723.19398-1-phillip.wood123@gmail.com>
        <20220315105723.19398-5-phillip.wood123@gmail.com>
Date:   Tue, 15 Mar 2022 10:51:21 -0700
In-Reply-To: <20220315105723.19398-5-phillip.wood123@gmail.com> (Phillip
        Wood's message of "Tue, 15 Mar 2022 10:57:23 +0000")
Message-ID: <xmqqr173drza.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8690C788-A488-11EC-BEF5-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> @@ -23,6 +23,101 @@ static void restore_term_on_signal(int sig)
>  static int term_fd = -1;
>  static struct termios old_term;
>  
> +static const char *background_resume_msg;
> +static const char *restore_error_msg;
> +static volatile sig_atomic_t ttou_received;

It is a good idea to have a comment here to say why we had to
reinvent a subset of error(), instead of forcing curious readers to
"git blame" the log message for this commit (I am assuming that
"this is called from a signal handler and uses only functions that
are safe in that context" is the reason).

> +static void write_err(const char *msg)
> +{
> +	write_in_full(2, "error: ", strlen("error: "));
> +	write_in_full(2, msg, strlen(msg));
> +	write_in_full(2, "\n", 1);
> +}
> +
> +static void print_background_resume_msg(int signo)
> +{
> +	int saved_errno = errno;
> +	sigset_t mask;
> +	struct sigaction old_sa;
> +	struct sigaction sa = { .sa_handler = SIG_DFL };
> +
> +	ttou_received = 1;
> +	write_err(background_resume_msg);
> +	sigaction(signo, &sa, &old_sa);
> +	raise(signo);
> +	sigemptyset(&mask);
> +	sigaddset(&mask, signo);
> +	sigprocmask(SIG_UNBLOCK, &mask, NULL);
> +	/* Stopped here */
> +	sigprocmask(SIG_BLOCK, &mask, NULL);
> +	sigaction(signo, &old_sa, NULL);
> +	errno = saved_errno;
> +}
>  ...
> +	/* avoid calling gettext() from signal handler */
> +	background_resume_msg = _("cannot resume in the background, please use 'fg' to resume");
> +	restore_error_msg = _("cannot restore terminal settings");

Nice to see such an attention to detail here.

Thanks.
