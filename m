Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4671C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 23:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbiCIXiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 18:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiCIXiU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 18:38:20 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAE3106C8D
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 15:37:20 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B755710E43F;
        Wed,  9 Mar 2022 18:37:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ASdFVLgVYxiwZf4tfAmyUp/JqULgqDN10FKoZ9
        7Cc+Y=; b=DeJFXJWZHFbhrVL9Fxt/wdFCtdV64XLX8EzVuDR4xY8iTjWE0kHiBM
        tJc13O1wdPISPuEBY/fIK4Lu8eAxiVqBQFUpPeBDty9lVerS1DdjHuWk2j2SnYuw
        m3ZAjhhHetwDMlQKo0qnD5pRmIJtwiEdy8AO1OKiGEfPwQ3dh+KqU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE4D510E43E;
        Wed,  9 Mar 2022 18:37:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.247.14.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1512B10E43C;
        Wed,  9 Mar 2022 18:37:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 0/4] builtin add -p: hopefully final readkey fixes
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
        <20220309110325.36917-1-phillip.wood123@gmail.com>
        <xmqqilsmlo31.fsf@gitster.g>
Date:   Wed, 09 Mar 2022 15:37:17 -0800
In-Reply-To: <xmqqilsmlo31.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        09 Mar 2022 15:10:10 -0800")
Message-ID: <xmqqzglyk89e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DC2DCA3C-A001-11EC-96B2-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> These patches are based on 'pw/single-key-interactive'
>
> Is it still true, or does the base only apply to v1?
>
> $ git checkout --detach pw/single-key-interactive
> HEAD is now at ac618c418e add -p: disable stdin buffering when interactive.singlekey is set
> $ git am -s ./+pw4-v2-add-p-single
> Applying: terminal: use flags for save_term()
> Applying: terminal: don't assume stdin is /dev/tty
> Applying: terminal: work around macos poll() bug
> error: patch failed: compat/terminal.c:397
> error: compat/terminal.c: patch does not apply
> Patch failed at 0003 terminal: work around macos poll() bug
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> $ exit

I think I figured it out.  A merge of pw/single-key-interactive into
a recent tip of 'master' wants the "return 0" in the preimage below
to be "break" in compat/terminal.c


> @@ -397,12 +433,7 @@ int read_key_without_echo(struct strbuf *buf)
>  		 * half a second when we know that the sequence is complete.
>  		 */
>  		while (!is_known_escape_sequence(buf->buf)) {
> -			struct pollfd pfd = { .fd = 0, .events = POLLIN };
> -
> -			if (poll(&pfd, 1, 500) < 1)
> -				break;
> -
> -			ch = getchar();
> +			ch = getchar_with_timeout(500);
>  			if (ch == EOF)
>  				return 0;
>  			strbuf_addch(buf, ch);

I'll wiggle it in to see how well it fares with other topics in
flight.

Thanks.
