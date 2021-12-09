Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6240C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbhLITV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:21:27 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58783 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhLITVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:21:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4689E1673B7;
        Thu,  9 Dec 2021 14:17:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kyhv7ZKh4E7A0Lq4v7wltUChQW21O8gL4W+KVl
        WyhxY=; b=dCJroy+ZTKB3EKRIt9D9Ro4bFRaAA9f6r4Tp9UayFJpo65MTkW8hc0
        PNKePiF8rRxfs36joD711YCQ1Zb58xdZxHZH+LzGyWq3qFqVNgn1qc3J/ztkqY3t
        HecnLT2tCnTPqAav+/NJlpcwelC/KnKkQ5dAZD5+t/P9+Tn86d1+M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E9E61673B5;
        Thu,  9 Dec 2021 14:17:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 86B2C1673B3;
        Thu,  9 Dec 2021 14:17:47 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 07/14] create_autostash(): remove unneeded parameter
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <341fe183c18ee28b459ba26f2c8c369d9367c328.1638975482.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 11:17:46 -0800
In-Reply-To: <341fe183c18ee28b459ba26f2c8c369d9367c328.1638975482.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 08 Dec 2021 14:57:54
        +0000")
Message-ID: <xmqqpmq5r3j9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1A42C3A-5924-11EC-B4B6-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The default_reflog parameter of create_autostash() is passed to
> reset_head(). However as creating a stash does not involve updating
> any refs the parameter is not used by reset_head(). Removing the
> parameter from create_autostash() simplifies the callers.

It does make the callers of create_autostash() easier to reason
about, but ...

> @@ -4132,7 +4131,7 @@ void create_autostash(struct repository *r, const char *path,
>  		write_file(path, "%s", oid_to_hex(&oid));
>  		printf(_("Created autostash: %s\n"), buf.buf);
>  		if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
> -			       default_reflog_action) < 0)
> +			       "") < 0)

... makes the reader wonder what the empty string is doing here.
The fact that reset_head() does not care about the last parameter
when not given oid or switch_to_branch parameters feels like too
much implementation detail to expect the callers to know about.

Unless it is documented in reset.[ch] before the beginning of the
"int reset_head(...)" definition/declaration, that is.

>  			die(_("could not reset --hard"));
>  
>  		if (discard_index(r->index) < 0 ||
> diff --git a/sequencer.h b/sequencer.h
> index 05a7d2ba6b3..da64473636b 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -197,8 +197,7 @@ void commit_post_rewrite(struct repository *r,
>  			 const struct commit *current_head,
>  			 const struct object_id *new_head);
>  
> -void create_autostash(struct repository *r, const char *path,
> -		      const char *default_reflog_action);
> +void create_autostash(struct repository *r, const char *path);
>  int save_autostash(const char *path);
>  int apply_autostash(const char *path);
>  int apply_autostash_oid(const char *stash_oid);
