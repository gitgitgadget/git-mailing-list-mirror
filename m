Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687FBC433EF
	for <git@archiver.kernel.org>; Tue,  7 Jun 2022 16:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344971AbiFGQWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 12:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344956AbiFGQWo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 12:22:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CA7E8C
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 09:22:41 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BD0131A6C2D;
        Tue,  7 Jun 2022 12:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4nn+3otrLY4lFW1OYaDZP8UuKIhQVATzCaWSvJ
        ZWE1U=; b=f3cRf9FIWVsaULPdxK/G7621qnCHu+gHbIfHOa0IYMdGwu5hymh65R
        BTuM+Hzthio6Qtzm/zDZP6+r2fT9oxCDO9Udfo5qK2j35+doY18eqADGu8Zzt3tI
        +YcMJvE2IRNJ/PBInepSIOl2qVDz+af0Rm7d3+0hzM58VlVRnomyo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B679C1A6C2B;
        Tue,  7 Jun 2022 12:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 126031A6C2A;
        Tue,  7 Jun 2022 12:22:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v7] git-prompt: make colourization consistent
References: <20220606175022.8410-1-joak-pet@online.no>
        <20220607115024.64724-1-joak-pet@online.no>
Date:   Tue, 07 Jun 2022 09:22:35 -0700
In-Reply-To: <20220607115024.64724-1-joak-pet@online.no> (Joakim Petersen's
        message of "Tue, 7 Jun 2022 13:50:24 +0200")
Message-ID: <xmqqzgiozbn8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B43F784-E67E-11EC-9891-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joakim Petersen <joak-pet@online.no> writes:

> The short upstream state indicator inherits the colour of the last short
> state indicator before it (if there is one), and the sparsity state
> indicator inherits this colour as well. This behaviour was introduced by
> 0ec7c23cdc6 (git-prompt: make upstream state indicator location
> consistent, 2022-02-27), while before this change the aforementioned
> indicators were white/the default text colour. Some examples to
> illustrate this behaviour (assuming all indicators are enabled and
> colourization is on):
>  * If there is something in the stash, both the '$' and the short
>    upstream state indicator following it will be blue.
>  * If the local tree has new, untracked files and there is nothing in
>    the stash, both the '%' and the short upstream state indicator
>    will be red.
>  * If all local changes are added to the index and the stash is empty,
>    both the '+' and the short upstream state indicator following it will
>    be green.
>  * If the local tree is clean and there is nothing in the stash, the
>    short upstream state indicator will be white/${default text colour}.
>
> This appears to be an unintended side-effect of the change, and makes
> little sense semantically (e.g. why is it bad to be in sync with
> upstream when you have uncommitted local changes?). The cause of the
> change in colourization is that previously, the short upstream state
> indicator appeared immediately after the rebase/revert/bisect/merge
> state indicator (note the position of $p in $gitstring):
>
> 	local f="$h$w$i$s$u"
> 	local gitstring="$c$b${f:+$z$f}${sparse}$r$p"
> 	
> Said indicator is prepended with the clear colour code, and the short
> upstream state indicator is thus also uncoloured. Now, the short
> upstream state indicator follows the sequence of colourized indicators,
> without any clearing of colour (again note the position of $p, now in
> $f):
>
> 	local f="$h$w$i$s$u$p"
> 	local gitstring="$c$b${f:+$z$f}${sparse}$r${upstream}"
>
> If the user is in a sparse checkout, the sparsity state indicator
> follows a similar pattern to the short upstream state indicator.
> However, clearing colour of the colourized indicators changes how the
> sparsity state indicator is colourized, as it currently inherits (and
> before the change referenced also inherited) the colour of the last
> short state indicator before it. Reading the commit message of the
> change that introduced the sparsity state indicator, afda36dbf3b
> (git-prompt: include sparsity state as well, 2020-06-21), it appears
> this colourization also was unintended, so clearing the colour for said
> indicator further increases consistency.
>
> Make the colourization of these state indicators consistent by making
> all colourized indicators clear their own colour. Make colouring of $c
> dependent on it not being empty, as it is no longer being used to colour
> the branch name. Move clearing of $b's prefix to before colourization so
> it gets cleared properly when colour codes are inserted into it. These
> changes make changing the layout of the prompt less prone to unintended
> colour changes in the future.
>
> Change coloured Bash prompt tests to reflect the colourization changes:
>  * Move the colour codes to wrap the expected content of the expanded
>    $__git_ps1_branch_name in all tests.
>  * Insert a clear-colour code after the symbol for the first indicator
>    in "prompt - bash color pc mode - dirty status indicator - dirty
>    index and worktree", to reflect that all indicators should clear
>    their own colour.
>
> Signed-off-by: Joakim Petersen <joak-pet@online.no>
> ---
> Changes since v6:
>  * Remove repeated statements and move all explanation of what the patch
>    does to the latter part of the message.
>  * Add a short statement about other benefits of the behavioural change.

The handling of $w is different from the original (it used to be
that only '*' was painted in red, now any non-empty strings do), but
'*' is the only value that can be assigned to $w, so there is no
material difference.

Looking good.  Will queue.  Thanks.
