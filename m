Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6959BC43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 20:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiGJUmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 16:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJUms (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 16:42:48 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA71CE1D
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 13:42:47 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B63119EA78;
        Sun, 10 Jul 2022 16:42:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8lWW2M3KQGFSIktM3tekn64b53/kAysy/zPIv6
        jbD7w=; b=ZkBjNdRfhBV6ofXMvaXXOH6sQ9n82q+o/WlIQTYP601WTb2xpaVs5x
        VF55d+3c/gdHKWL/c6EUv4/uDCqNdSrdX1sGW3jXiYLjJ+JctFATW9CMdjmFKSMQ
        5uWp+pJlJJzANfXrwQQfw1FF0NWnZ/NsYxVQTo8A6sP2p/GeF6Ppk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6334819EA77;
        Sun, 10 Jul 2022 16:42:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0C71C19EA76;
        Sun, 10 Jul 2022 16:42:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] rev-parse: respect push.autosetupremote when evaluating
 @{push}
References: <pull.1279.git.1657480594123.gitgitgadget@gmail.com>
Date:   Sun, 10 Jul 2022 13:42:42 -0700
In-Reply-To: <pull.1279.git.1657480594123.gitgitgadget@gmail.com> (Tao Klerks
        via GitGitGadget's message of "Sun, 10 Jul 2022 19:16:33 +0000")
Message-ID: <xmqq5yk4r96l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D960FC3A-0090-11ED-9D17-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (branch && (!branch->merge || !branch->merge[0])) {
> +		repo_config_get_bool(the_repository,
> +				     "push.autosetupremote",
> +				     &autosetupremote);
> +		if (autosetupremote)
> +			return tracking_for_push_dest(remote, branch->refname, err);

Before the first push of the branch X where we are asking for
X@{push}, i.e. there is not the corresponding branch over there yet
and we do not have the remote-tracking branch for it yet, what does
this function return?  If it continues to error out, then I think
this patch may make sense, but ...

> +		{
> +			const char *up;
> +			up = default_missing_upstream(remote, branch, err);
> +			if (up)
> +				return up;
> +			return branch_get_upstream(branch, err);

... shouldn't the precedence order the other way around here ...

> +		}
>  	case PUSH_DEFAULT_UNSPECIFIED:
>  	case PUSH_DEFAULT_SIMPLE:
>  		{
>  			const char *up, *cur;
>  
> +			up = default_missing_upstream(remote, branch, err);
> +			if (up)
> +				return up;
> +
>  			up = branch_get_upstream(branch, err);
>  			if (!up)
>  				return NULL;

... and here?  That is, if branch_get_upstream() finds an explicitly
configured one, shouldn't we use that and fall back to the new
"missing" code path only when there isn't an explicitly configured
one?

