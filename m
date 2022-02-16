Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F61C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 21:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbiBPVlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 16:41:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiBPVlG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 16:41:06 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040DF2A0D4B
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 13:40:52 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C26AFF8CE5;
        Wed, 16 Feb 2022 16:40:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=itnbOGqvMSYvZP2wfjX53QblsyfNZ8cCi/1y0F
        SmkbU=; b=K3mY1zhN9ICgFrZQKy+ks/dD8NSU2IS9yqrP6aJsDHF9HloU7/pF0a
        K8xIWG4a447w6jl7yMqwFn2I7G9xT18Rjxuvm5RUB/R6o1Aqrn/XRGpHDPCH227+
        Y7FOmdo/2DhaHFRNhpmg/1XYTYyJ5VMKfGQ8+0WS/s8mYtMHatoW8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B88F2F8CE4;
        Wed, 16 Feb 2022 16:40:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 24810F8CE1;
        Wed, 16 Feb 2022 16:40:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] terminal: set VMIN and VTIME in non-canonical mode
References: <pull.1146.git.1645008873.gitgitgadget@gmail.com>
        <02009172e081ab5c4de8e2476c1142f97b41698e.1645008873.git.gitgitgadget@gmail.com>
Date:   Wed, 16 Feb 2022 13:40:49 -0800
In-Reply-To: <02009172e081ab5c4de8e2476c1142f97b41698e.1645008873.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 16 Feb 2022 10:54:31
        +0000")
Message-ID: <xmqqpmnmcwwu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C5F0CDE-8F71-11EC-A2D5-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If VMIN and VTIME are both set to zero then the terminal performs
> non-blocking reads which means that read_key_without_echo() returns
> EOF if there is no key press pending. This results in the user being
> unable to select anything when running "git add -p".  Fix this by
> explicitly setting VMIN and VTIME when enabling non-canonical mode.

Makes sense.

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  compat/terminal.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/compat/terminal.c b/compat/terminal.c
> index 20803badd03..d882dfa06e3 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -57,6 +57,10 @@ static int disable_bits(tcflag_t bits)
>  	t = old_term;
>  
>  	t.c_lflag &= ~bits;
> +	if (bits & ICANON) {
> +		t.c_cc[VMIN] = 1;
> +		t.c_cc[VTIME] = 0;
> +	}

Quite sensible.  I wonder if we can simplify the "are we looking at
an ESC that is the first byte of a multi-byte control sequence?"
logic in the caller by using inter-character delay, but it is
probably better to go one step at a time like this patch does.

>  	if (!tcsetattr(term_fd, TCSAFLUSH, &t))
>  		return 0;
>  
> @@ -159,7 +163,11 @@ static int disable_bits(DWORD bits)
>  
>  		if (bits & ENABLE_LINE_INPUT) {
>  			string_list_append(&stty_restore, "icanon");
> -			strvec_push(&cp.args, "-icanon");
> +			/*
> +			 * POSIX allows VMIN and VTIME to overlap with VEOF and
> +			 * VEOL - let's hope that is not the case on windows.
> +			 */
> +			strvec_pushl(&cp.args, "-icanon", "min", "1", "time", "0", NULL);

Interesting.  So each call to read_key_without_echo() ends up being
a run_command("stty -icanon min 1 time 0") followed by a read
followed by another "stty".

At least while in -icanon mode, VEOF and VEOL do not take effect,
and the potential overlap would not matter.  It really depends on
what happens upon restore.

Do we have similar "let's hope" on the tcsetattr() side, too?

>  		}
>  
>  		if (bits & ENABLE_ECHO_INPUT) {

Thanks.
