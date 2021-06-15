Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5254C2B9F4
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF2E61378
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 03:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbhFODEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 23:04:20 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51446 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhFODET (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 23:04:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CD40D1253A2;
        Mon, 14 Jun 2021 23:02:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dhezM8EdCRDRSVmkvHZps5JOLTo0VuX4FPjpD0
        jP/D4=; b=QizMivMe0Tq8BTqPGQjHQrpWb2OStlSlWItLi2iKlcLANZEwkSqOXp
        LbklHAlIojHdwC0VCmVrBHcuJvJ2MnWBbOyQ/Kp1iMsXYXg+OUzA8TPY4/bADY5s
        uAPQ8xskE0XrO5A+abfKWAhHBuk/Dj+rO1jrAwozF+SI1X7UVKV9A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6FCC1253A0;
        Mon, 14 Jun 2021 23:02:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F38B12539D;
        Mon, 14 Jun 2021 23:02:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pager: do not unnecessarily set COLUMNS on Windows
References: <pull.982.git.1623701952823.gitgitgadget@gmail.com>
Date:   Tue, 15 Jun 2021 12:02:11 +0900
In-Reply-To: <pull.982.git.1623701952823.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 14 Jun 2021 20:19:12
        +0000")
Message-ID: <xmqqh7hzygng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 154A4C54-CD86-11EB-B23F-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Since https://github.com/gwsw/less/commit/bb0ee4e76c2, `less` prefers
> the `COLUMNS` variable over asking ncurses itself.
>
> This is typically not a problem because we ask `TIOCGWINSZ` in Git, to
> determine the correct value for `COLUMNS`.
>
> However, on Windows it _is_ a problem because Git for Windows' Bash (and
> `less.exe`) uses the MSYS2 runtime while `git.exe` does _not_, and
> therefore we never get the correct value in Git, ...

... meaning in git.exe, ioctl issued in term_columns() does not
work, or TIOCGWINSZ is not even defined while building git.exe,
so all it does is to default to 80 or use COLUMNS exported by
somebody else?

These three lines need a bit of clarification.

> but `less.exe` has no
> problem obtaining it.
>
> Let's not override `COLUMNS` in that case.

If term_columns() sees existing COLUMNS, then the current behaviour
is a no-op, so the problem is specifically what happens when there
is no existing COLUMNS and we override it with the hardcoded default
of 80?  I guess this all makes sense, but "in that case" may want to
get clarified.

Provided if my guesses above are all correct, the change makes
sort-of sense to me, but I wonder why !defined(WIN32) is there in
the first place.  Doesn't any platform that lack TIOCGWINSZ have the
same issue (not with "less" specifically, but "we export 80 that has
no relation to reality in COLUMNS---we should leave it unset if we
do not know")?

This is a tangent, but there are other callers of term_columns().
"git column" obviously wants to use it for determining display
columns, "git diff" wants to measure how many columns to allocate
for function name shown on the hunk header lines, and how wide the
diffstat should be, and the progress bar adjusts to the terminal
width, too.

> diff --git a/pager.c b/pager.c
> index 3d37dd7adaa2..b84668eddca2 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -111,11 +111,13 @@ void setup_pager(void)
>  	 * to get the terminal size. Let's grab it now, and then set $COLUMNS
>  	 * to communicate it to any sub-processes.
>  	 */
> +#if !defined(WIN32) || defined(TIOCGWINSZ)
>  	{
>  		char buf[64];
>  		xsnprintf(buf, sizeof(buf), "%d", term_columns());
>  		setenv("COLUMNS", buf, 0);
>  	}
> +#endif
>  
>  	setenv("GIT_PAGER_IN_USE", "true", 1);
>  
>
> base-commit: ebf3c04b262aa27fbb97f8a0156c2347fecafafb
