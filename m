Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE95C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BBB061ABF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhJAVEy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 17:04:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59365 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhJAVEy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 17:04:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A94C1D3459;
        Fri,  1 Oct 2021 17:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0bnRVQNqXcm4MjYMxci4jc32LmLkEahZLf3Z1v
        yi1+8=; b=JXBmGhzyh7Wp2xlrIy5WnCIJDfYu+DuaHBA3y/zI9RMxjhkSkzEcGR
        MwosthXzkMoEOQNprkVE0qecOgaAnTnLXPy5YsNJEUMFo7vxCSj3Wum+cP/FK7Oy
        zo/m1vhN56Q/kNj9bCJAyt6OgB9ZzZtigaCFZMd8fYR/8Iz7r1fYk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DAA0D3458;
        Fri,  1 Oct 2021 17:03:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D545BD3454;
        Fri,  1 Oct 2021 17:03:07 -0400 (EDT)
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
Date:   Fri, 01 Oct 2021 14:03:06 -0700
In-Reply-To: <4503defe5912aecc4e6a50ac82a31aa7b230456b.1633082702.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 01 Oct 2021 10:04:57
        +0000")
Message-ID: <xmqqh7e05ugl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA58E958-22FA-11EC-8A3C-62A2C8D8090B-77302942!pb-smtp1.pobox.com
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
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/merge.c  |  6 ++----
>  builtin/rebase.c | 14 ++++++--------
>  reset.c          | 16 ++++++++++++----
>  sequencer.c      |  6 +++---
>  sequencer.h      |  3 +--
>  5 files changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index d2c52b6e971..35833a963fc 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1561,8 +1561,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>  
>  		if (autostash)
>  			create_autostash(the_repository,
> -					 git_path_merge_autostash(the_repository),
> -					 "merge");
> +					 git_path_merge_autostash(the_repository));
>  		if (checkout_fast_forward(the_repository,
>  					  &head_commit->object.oid,
>  					  &commit->object.oid,

The title talks about an optional change to reset_head(); perhaps a
change to create_autostash() should be a separate preliminary step.
