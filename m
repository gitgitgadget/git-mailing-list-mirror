Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAED3C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiGUQeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGUQeX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:34:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA7789AAB
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:34:22 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5296135635;
        Thu, 21 Jul 2022 12:34:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0CAtOqDAyFxicIBxWBnDs3fc11W+B4zBqS8+hD
        RS9SE=; b=Pk+dHOPdopvZco6hZSQfmSfQdu+eC/4/S3iuokuwO7hY1FKv1WZZN/
        tUtEsve09Qs4ccTLothpOyY6kdehKYno1YS626XEtWMbIfcaVMdgFH6iRytxTQcn
        IFgwKsKFSHbVqo/VgMav579n/sNsewkhqN02wO5gDCMAQ65R1fDNs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BB96C135634;
        Thu, 21 Jul 2022 12:34:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 25475135632;
        Thu, 21 Jul 2022 12:34:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 7/7] merge: do not exit restore_state() prematurely
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <81c40492a62e81100c66a8ccc1ec200fb2e6fca5.1658391391.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Jul 2022 09:34:20 -0700
In-Reply-To: <81c40492a62e81100c66a8ccc1ec200fb2e6fca5.1658391391.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 21 Jul 2022
        08:16:31 +0000")
Message-ID: <xmqqy1wmjugj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F91B0144-0912-11ED-9049-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -386,11 +386,11 @@ static void restore_state(const struct object_id *head,
>  	const char *args[] = { "stash", "apply", "--index", "--quiet",
>  			       NULL, NULL };
>  
> -	if (is_null_oid(stash))
> -		return;
> -
>  	reset_hard(head, 1);
>  
> +	if (is_null_oid(stash))
> +		goto refresh_cache;
> +

OK, so the idea is that we can call restore_state() without having
anything worth "restoring" in the stash, and what it means is that
we are restoring to HEAD.  As the current state does not necessarily
match HEAD, we should do the "reset --hard" part even if there was
nothing to stash.

Makes sense.

