Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5EAC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 19:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbhLGTpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 14:45:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51392 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbhLGTpF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 14:45:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08F3C10A78B;
        Tue,  7 Dec 2021 14:41:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i3X0JZv52W2M3mPU9O5BLPCtiiulN2yqxMM0In
        n3ew8=; b=Wg+APBC8ZvWPw+jVZXTIja8+ARDIBfyLCxCRkDTo4wbhMhaSXZCtvO
        ouXznuhEV4yYnmloD+sK8iiPwxRwuP0mLbZX4Wayqepy4+7XW2tkY1+ZxHO7xkRc
        XFUKssmrLkUAq07fx1lpx6/o2yjs62zLhjndEJKgQEutXHTJWLcyw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F36AF10A78A;
        Tue,  7 Dec 2021 14:41:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5D2FB10A789;
        Tue,  7 Dec 2021 14:41:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, emilyshaffer@google.com,
        avarab@gmail.com
Subject: Re: [PATCH v5 2/2] branch: add flags and config to inherit tracking
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
        <cover.1638859949.git.steadmon@google.com>
        <c7e4af9a365cc61e682c3c73045fb1ee4b79cfbf.1638859949.git.steadmon@google.com>
Date:   Tue, 07 Dec 2021 11:41:32 -0800
In-Reply-To: <c7e4af9a365cc61e682c3c73045fb1ee4b79cfbf.1638859949.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 6 Dec 2021 23:12:08 -0800")
Message-ID: <xmqq7dcg6w43.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEAE01BC-5795-11EC-B0B3-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

>  --no-track::
>  	Do not set up "upstream" configuration, even if the
> -	branch.autoSetupMerge configuration variable is true.
> +	branch.autoSetupMerge configuration variable is set.

I guess "inherit" is different from "true".
Nice to see an attention to the details.  

> diff --git a/branch.h b/branch.h
> index df0be61506..6484bda8a2 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -10,7 +10,8 @@ enum branch_track {
>  	BRANCH_TRACK_REMOTE,
>  	BRANCH_TRACK_ALWAYS,
>  	BRANCH_TRACK_EXPLICIT,
> -	BRANCH_TRACK_OVERRIDE
> +	BRANCH_TRACK_OVERRIDE,
> +	BRANCH_TRACK_INHERIT
>  };

Unless INHERIT must stay to be at the end of the enumeration even
when we add more of these, let's leave a common at the end to help
future developers.

> -		if (value && !strcasecmp(value, "always")) {
> +		if (value && !strcmp(value, "always")) {

This is belatedly correcting the mistake we made 5 years ago, which
can break existing users who used "[branch]autosetupmerge=Always" in
their configuration files.

I'm OK to fix it to accept only lowercase as written here, see if
anybody screams, and tell them that the all-lowercase is the only
documented way to spell this word.

>  			git_branch_track = BRANCH_TRACK_ALWAYS;
>  			return 0;
> +		} else if (value && !strcmp(value, "inherit")) {
> +			git_branch_track = BRANCH_TRACK_INHERIT;
> +			return 0;
>  		}
>  		git_branch_track = git_config_bool(var, value);
>  		return 0;

Thanks.
