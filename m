Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAD9C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 05:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhKVFwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 00:52:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54675 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhKVFwm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 00:52:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8723B16C276;
        Mon, 22 Nov 2021 00:49:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mMlzPjsNidOPyqbkDUmcK2UyxAdyfYSDgDHq+h
        52Rfk=; b=MguAfZVZ8RVhmhX00cUX9nZsx4CGnKwiQHEyi+UWMc5IgJEw3DZ5GI
        HpS7X/xjLpF9AJ5ATsZ3ZGD2xPRUPjWQxXyH7wTUtkkQK2xmC7PF9EPtG+JV/GY8
        p9Qgz2MHCVyVQTZEkbXmCPUKd29bbptQr0PwZvZRG2B+nYU7w8+R4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7BE1416C274;
        Mon, 22 Nov 2021 00:49:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE82216C271;
        Mon, 22 Nov 2021 00:49:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t7006: clean up SIGPIPE handling in trace2 tests
References: <xmqq1r4b8ezp.fsf@gitster.g> <20211024170349.GA2101@szeder.dev>
        <YZqSgu4XjPWnURju@coredump.intra.peff.net>
        <YZrCmPb5AIW8YYQ0@coredump.intra.peff.net>
        <YZrOLy03s5ZWMQ+t@coredump.intra.peff.net>
        <xmqqa6hxlysf.fsf@gitster.g>
        <YZsh6mnjuKbbIrw8@coredump.intra.peff.net>
        <YZsih3ar+g1ZTZOc@coredump.intra.peff.net>
Date:   Sun, 21 Nov 2021 21:49:32 -0800
In-Reply-To: <YZsih3ar+g1ZTZOc@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 21 Nov 2021 23:54:31 -0500")
Message-ID: <xmqq5yskn3ir.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F8282FEC-4B57-11EC-BF01-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm tempted to say that this would be clearer if the in_signal code path
> just followed the main logic, like this:
>
> diff --git a/run-command.c b/run-command.c
> index f40df01c77..1f58c17b6c 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -552,20 +552,17 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
>  
>  	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
>  		;	/* nothing */
> -	if (in_signal) {
> -		if (WIFEXITED(status))
> -			code = WEXITSTATUS(status);
> -		return code;
> -	}
>  
>  	if (waiting < 0) {
>  		failed_errno = errno;
> -		error_errno("waitpid for %s failed", argv0);
> +		if (!in_signal)
> +			error_errno("waitpid for %s failed", argv0);
>  	} else if (waiting != pid) {
> -		error("waitpid is confused (%s)", argv0);
> +		if (!in_signal)
> +			error("waitpid is confused (%s)", argv0);
>  	} else if (WIFSIGNALED(status)) {
>  		code = WTERMSIG(status);
> -		if (code != SIGINT && code != SIGQUIT && code != SIGPIPE)
> +		if (!in_signal && code != SIGINT && code != SIGQUIT && code != SIGPIPE)
>  			error("%s died of signal %d", argv0, code);
>  		/*
>  		 * This return value is chosen so that code & 0xff
> @@ -576,10 +573,12 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
>  	} else if (WIFEXITED(status)) {
>  		code = WEXITSTATUS(status);
>  	} else {
> -		error("waitpid is confused (%s)", argv0);
> +		if (!in_signal)
> +			error("waitpid is confused (%s)", argv0);
>  	}
>  
> -	clear_child_for_cleanup(pid);
> +	if (!in_signal)
> +		clear_child_for_cleanup(pid);
>  
>  	errno = failed_errno;
>  	return code;
>
> That's a lot more tedious "if (!in_signal)" checks, but:
>
>   - we don't have to duplicate any of the actual application logic
>
>   - we'd now cover the extra cases for waitpid failing or returning the
>     wrong pid (previously if waitpid() failed we'd still look at status,
>     which could contain complete garbage!)

Yeah, the repeated "if (!in_signal)" look a bit ugly, but fixing
that "we only deal with ifexited in in_signal case" to do the right
thing would make the code even more annoying and harder to maintain.
