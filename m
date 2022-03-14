Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD551C433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 19:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiCNTjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 15:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiCNTjl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 15:39:41 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2984227B1C
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 12:38:30 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B48121881F3;
        Mon, 14 Mar 2022 15:38:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BqEsQhKixUOSYQNJ/h/cfYHVW+aMwvPSPW8LWn
        gb5AY=; b=g41hWCRyvUlPhM6hAiHl8/ezJxwgn4YuE9yqDy4bXVDae142Ky6rHD
        8i8lS5yu38++ky9T06nMiZgg/vh1+0L5zHLyAVvZNl/F8NUH60yhtrTD6rZU8F3v
        9vh1p02cjqNsuF3T8+WpMYgvsUkhGHkBJ1t9Q0PAt/c2DC17zYuHI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ACA9C1881F2;
        Mon, 14 Mar 2022 15:38:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3BAEC1881F1;
        Mon, 14 Mar 2022 15:38:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 4/5] reset: suppress '--no-refresh' advice if logging
 is silenced
References: <pull.1170.git.1647043729.gitgitgadget@gmail.com>
        <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
        <cffca0ea5c6b09fa1a0725f81440b6358f79d303.1647274230.git.gitgitgadget@gmail.com>
Date:   Mon, 14 Mar 2022 19:38:27 +0000
In-Reply-To: <cffca0ea5c6b09fa1a0725f81440b6358f79d303.1647274230.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Mon, 14 Mar 2022 16:10:29
        +0000")
Message-ID: <xmqqy21cqq8c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52653896-A3CE-11EC-9443-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> If using '--quiet' or 'reset.quiet=true', do not print the 'resetnoRefresh'
> advice string. For applications that rely on '--quiet' disabling all
> non-error logs, the advice message should be suppressed accordingly.

Funny, but it is true that we would want to squelch advice messages
under 'quiet' mode.

But why did we even spend 2 seconds to refresh the index if --quiet
is given in the first place?  Isn't it because an explicit --refresh
or reset.refresh=yes was in effect?  IOW, the user wanted the
command to be quiet but still wanted it to refresh the index.

So it would be yet another reason why we do not want to show the
message: the user knows what they are doing and explicitly asked
us to spend cycles to refresh.


> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/reset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/reset.c b/builtin/reset.c
> index feab85e03de..c8a356ec5b0 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -535,7 +535,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  				refresh_index(&the_index, flags, NULL, NULL,
>  					      _("Unstaged changes after reset:"));
>  				t_delta_in_ms = (getnanotime() - t_begin) / 1000000;
> -				if (advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
> +				if (!quiet && advice_enabled(ADVICE_RESET_NO_REFRESH_WARNING) && t_delta_in_ms > REFRESH_INDEX_DELAY_WARNING_IN_MS) {
>  					advise(_("It took %.2f seconds to refresh the index after reset.  You can use\n"
>  						 "'--no-refresh' to avoid this.  Set the config setting reset.refresh to false\n"
>  						 "to make this the default."), t_delta_in_ms / 1000.0);
