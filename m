Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CF3C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 16:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbiFFQ3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241788AbiFFQ3a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 12:29:30 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4E6324992
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 09:29:23 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0B4C318EA8C;
        Mon,  6 Jun 2022 12:29:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X7zBDUhLZ4fowl1VLMBkcSpMKv5oGdChPFQhw8
        Hb514=; b=bx+eGj3ocK4YB/0rL0N1EYARtLegvS9mKnGnJkuyHo1LWQoaaRhSBQ
        qYx68wQVV6lDBsDVyeUTChz7FeS0Jar//uengUKGs/xqW8IP2O4f2uRt8H/6yumh
        6FwL2jXpN4LuUsQKCyLQ2nvJMSdYuLyI9pKIzm3EzIOLyEmC23oRk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 042E618EA8B;
        Mon,  6 Jun 2022 12:29:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7BA2C18EA8A;
        Mon,  6 Jun 2022 12:29:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joakim Petersen <joak-pet@online.no>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
Subject: Re: [PATCH v5] git-prompt: make colourization consistent
References: <20220604161333.54627-1-joak-pet@online.no>
        <20220604192606.176023-1-joak-pet@online.no>
Date:   Mon, 06 Jun 2022 09:29:16 -0700
In-Reply-To: <20220604192606.176023-1-joak-pet@online.no> (Joakim Petersen's
        message of "Sat, 4 Jun 2022 21:26:06 +0200")
Message-ID: <xmqqzgipah7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF870C4A-E5B5-11EC-AACD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joakim Petersen <joak-pet@online.no> writes:

> The short upstream state indicator inherits the colour of the last short
> state indicator before it (if there is one), and the sparsity state
> indicator inherits this colour as well. Make the colourization of these
> state indicators consistent by making all colourized indicators clear
> their own colour.

> As of 0ec7c23cdc6 (git-prompt: make upstream state indicator location
> consistent, 2022-02-27), colourization in the output of __git_ps1 has
> changed such that the short upstream state indicator inherits the colour
> of the last short state indicator before it (if there is one), while
> before this change it was white/the default text colour. Some examples
> to illustrate this behaviour (assuming all indicators are enabled and
> colourization is on):
>  * If there is something in the stash, both the '$' and the short
>    upstream state indicator following it will be blue.
>  * If the local tree has new, untracked files and there is nothing in
>    the stash, both the '%' and the    short upstream state indicator

looong space?

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
> change is that previously, the short upstream state indicator appeared
> immediately after the rebase/revert/bisect/merge state indicator (note
> the position of $p in $gitstring):
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
> sparsity state indicator is colourized , as it currently inherits (and
> before the change referenced also inherited) the colour of the last
> short state indicator before it. Reading the commit message of the
> change that introduced the sparsity state indicator, afda36dbf3b
> (git-prompt: include sparsity state as well, 2020-06-21), it appears
> this colourization also was unintended, so clearing the colour for said
> indicator further increases consistency.

Here, after explaining how bad the current situation is, like the
above, is a good place to say what we do, i.e. "teach indicators to
clear after themselves".

> Colouring of $c was made dependent on it not being empty, as it is no
> longer being used to colour the branch name. Removal of $b's prefix was
> moved to before the colourization so it gets cleared properly now that
> colour codes are inserted into it.
>
> Due to colour clearing being moved into the variables for each coloured
> indicator, the tests for the coloured Bash prompt had to be changed:
>  * All colour tests now have the colour codes around the expected
>    content of the expanded $__git_ps1_branch_name variable instead of
>    the unexpanded variable in the string.
>  * The test with two indicators had a clear-colour code inserted after
>    the symbol for the first indicator, since all indicators clear their
>    own colours now.
>
> Signed-off-by: Joakim Petersen <joak-pet@online.no>
> ---

Nicely written.

Will queue.

Thanks.
