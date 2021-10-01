Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0334C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42E6619E7
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhJAVKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 17:10:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50366 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhJAVKR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 17:10:17 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5219F1644C5;
        Fri,  1 Oct 2021 17:08:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=e1biJn6gdb275jIrwmlgDPchZCADbYSXXod8zA
        57pyc=; b=lIZ+Y/3jqgOb8/WTygsGziBEk7bRS7Zi2Ds0XDOq3IKRwkFMwSFGc+
        nCisZKcLTqOse9IaquwC+MFa4gIaUvspgmDCMYZUjhw9JKDxUeyZho7yg2wNFyae
        EqDoKeOxA7SDfW6PN3C5XSKIW1u5eXYJ8qThd4Uk1g/aCCL+ZKNWg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A4CA1644C4;
        Fri,  1 Oct 2021 17:08:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D87921644C3;
        Fri,  1 Oct 2021 17:08:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 06/11] reset_head(): make default_reflog_action optional
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <4503defe5912aecc4e6a50ac82a31aa7b230456b.1633082702.git.gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 14:08:29 -0700
In-Reply-To: <4503defe5912aecc4e6a50ac82a31aa7b230456b.1633082702.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 01 Oct 2021 10:04:57
        +0000")
Message-ID: <xmqqczoo5u7m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAE02E70-22FB-11EC-A266-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This parameter is only needed when a ref is going to be updated and
> the caller does not pass an explicit reflog message. Callers that are
> just discarding changes in the working tree like create_autostash() do
> not update any refs so should not have to worry about passing this
> parameter.

This only talks about internal implementation details of passing a
parameter that may not be used, but ...

> -	ret = update_refs(oid, switch_to_branch, reflog_head, reflog_orig_head,
> -			  default_reflog_action, flags);
> +	if (oid != &head_oid || update_orig_head || switch_to_branch)
> +		ret = update_refs(oid, switch_to_branch, reflog_head,
> +				  reflog_orig_head, default_reflog_action,
> +				  flags);

... doesn't this have a more significant behaviour change?

I am not sure if comparison between oid and head_oid can safely
cheat like the patch does, or if it is necessary to do a proper oid
comparison, but either way, this would stop calling update_refs(),
which in turn means it would have an externally visible effect, like
a hook no longer getting called, doesn't it?

It would be a change for the good---calling post-checkout hook when
you did "git checkout (no other arguments)" feels wasteful, but it
deserves to be told to end users, I would think.

Again, a new test to protect the change would go well in the same
patch.

Thanks.


