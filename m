Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AE6C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 20:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC45C64DBD
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 20:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbhBHUQF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 15:16:05 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52190 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbhBHUPC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 15:15:02 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B1BB3122D8C;
        Mon,  8 Feb 2021 15:13:58 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yB/zlUrQc2jofhXfmT8xzH8C4gw=; b=fqmRZl
        /FP19NF2Md7nQm6C2dPhnyTVWkjCSbMXJDzvO80OZ89C72vnaN8kJbmleEIvMqOV
        fgKwwsBJA1Q6W6pNixw+VvuKggHF+bCVGTo3EM7QberUbHw3f1sUYXCHluCuCWNu
        G0VnAyRnb/AFIaMbNc6tRYu7t+h6O4fafo+Qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jtY7y1nXLWHhCACDNfncOQ3x92DY/W1c
        3ANZYfo3dHLMRdw/ksH2m8+54Y2qpk/EVqIXnz6AEviNhwQl0C0bfaIsK5CEfbyB
        tr6uIOqM0koPOh9GTZ+7WGgUajaKJKCU5GbfX0v9xBt5kj79ujg0lXJm8xtrYGGX
        Qe16dLWCNwY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A9FA2122D8B;
        Mon,  8 Feb 2021 15:13:58 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E3D4C122D8A;
        Mon,  8 Feb 2021 15:13:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2] git-difftool-helper.sh: learn a new way go back to
 last save point
References: <pull.870.git.1612711153591.gitgitgadget@gmail.com>
        <pull.870.v2.git.1612803744188.gitgitgadget@gmail.com>
Date:   Mon, 08 Feb 2021 12:13:54 -0800
In-Reply-To: <pull.870.v2.git.1612803744188.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Mon, 08 Feb 2021 17:02:23 +0000")
Message-ID: <xmqqczxa5nct.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BC6AD3C-6A4A-11EB-A5DF-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index 46af3e60b718..a01aa7c9d551 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -6,6 +6,8 @@
>  # Copyright (c) 2009, 2010 David Aguilar
>  
>  TOOL_MODE=diff
> +GIT_DIFFTOOL_LAST_POSITION="$GIT_DIR/difftool-last-position"
> +DIFFTOOL_FIRST_NUM="1"

Do we need this constant?  I do not think it makes the resulting
code easier to follow.

>  . git-mergetool--lib
>  
>  # difftool.prompt controls the default prompt/no-prompt behavior
> @@ -40,6 +42,30 @@ launch_merge_tool () {
>  	# the user with the real $MERGED name before launching $merge_tool.
>  	if should_prompt
>  	then
> +		if test -f "$GIT_DIFFTOOL_LAST_POSITION"
> +		then
> +			if SAVE_POINT_NUM=$(cat 2>/dev/null "$GIT_DIFFTOOL_LAST_POSITION") &&
> +				test "$SAVE_POINT_NUM" -le "$GIT_DIFF_PATH_TOTAL" &&
> +					test "$SAVE_POINT_NUM" -gt "$GIT_DIFF_PATH_COUNTER"
> +			then

No need to push the subsequent lines that far to the right,
especially when your variable names are already overly long.  It
just makes things harder to read.

			if test -r "$GIT_DIFFTOOL_LAST_POSITION" &&
			   SAVE_POINT_NUM=$(cat "$GIT_DIFFTOOL_LAST_POSITION") &&
			   test "$SAVE_POINT_NUM" -le "$GIT_DIFF_PATH_TOTAL" &&
			   test "$SAVE_POINT_NUM" -gt "$GIT_DIFF_PATH_COUNTER"
			then

> +				if test "$GIT_DIFF_PATH_COUNTER" -eq "$DIFFTOOL_FIRST_NUM"
> +				then
> +					printf "Do you want to start from the possible last file you were viewing? [Y/n]?"

Where does that "possible" come from?  If the reason is "We might
have miscomputed or misrecorded an incorrect last position", we
probably should work harder to make sure we don't ;-)

At this point in the code, do we have the _name_ of the file we are
going to skip to readily available, or do we actually need to seek
to that position before we can find it out?

	You were looking at 'hello-world.txt' the last time.
	Do you want to restart from there [Y/n]?

would be far easier to answer for an end-user than an unspecified
"possible last file".

> +		fi
> +		if test -z "$SAVE_POINT_NUM" ||
> +			test "$SAVE_POINT_NUM" -ne "$GIT_DIFF_PATH_COUNTER"

Ditto about indentation.

Is this behaviour something we can write a test for in
t/t7800-difftool.sh, by the way?

Other than these, i.e. (cosmetic) indentation and overly long lines
(ui) giving filename is easier to work with for the users and (dev)
lack of tests, looking quite good.

Thanks.
