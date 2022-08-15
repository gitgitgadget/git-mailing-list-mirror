Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C45C00140
	for <git@archiver.kernel.org>; Mon, 15 Aug 2022 16:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiHOQyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiHOQxl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 12:53:41 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0063248DC
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 09:53:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BD29119CEB8;
        Mon, 15 Aug 2022 12:53:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mB8+OagmrstQ/lME2/Q0xCXn+q0WAGf13Gw5M/
        cex7c=; b=tY77cs/8l1EmSQArqJTwmu1EeAHjCPLJnOYstSsq7ycvRorHBbyIbG
        LnQjVNi92M8nMXgXj3Rj5m4tCfuiEfBoA5Vf8tHIhwSPJiJacqzPcLAB9DTI2aQ2
        U2efGh7ejusDekuh93IjHvjZak7+gkS5w2qLPwlNrcBUf7/7hDQUg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9EFF419CEB7;
        Mon, 15 Aug 2022 12:53:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 05B6919CEB3;
        Mon, 15 Aug 2022 12:53:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/5] t3416: set $EDITOR in subshell
References: <pull.1323.git.1660576283.gitgitgadget@gmail.com>
        <c1d91a2b190c6ea4550e33260a48a51cd0653a21.1660576283.git.gitgitgadget@gmail.com>
Date:   Mon, 15 Aug 2022 09:53:34 -0700
In-Reply-To: <c1d91a2b190c6ea4550e33260a48a51cd0653a21.1660576283.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 15 Aug 2022 15:11:19
        +0000")
Message-ID: <xmqqo7wl30tt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDC98978-1CBA-11ED-A6A2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> As $EDITOR is exported setting it in one test affects all subsequent
> tests. Avoid this by always setting it in a subshell and remove a
> couple of unnecessary call to set_fake_editor.

Unnecessary because it reuses the one that was established in the
previous test [1]?  Or unnecessary because we know "rebase -i" would
fail even before it gets to the point of asking an editor to tweak
the todo sequence [2]?  Or something else?

If [1], it makes us wonder what happens when an earlier test gets
skipped.  If [2], it makes us wonder what happens when "rebase -i"
fails to fail as expected (does the test correctly diagnose it as a
new breakage in "rebase -i"?).

> @@ -102,7 +106,6 @@ test_expect_success 'rebase -i --onto main...side' '
>  	git checkout side &&
>  	git reset --hard K &&
>  
> -	set_fake_editor &&
>  	test_must_fail git rebase -i --onto main...side J
>  '

This is one of the "removing" instances.

> @@ -187,8 +194,12 @@ test_expect_success 'rebase -i --keep-base main from side' '
>  	git checkout side &&
>  	git reset --hard K &&
>  
> -	set_fake_editor &&
>  	test_must_fail git rebase -i --keep-base main
>  '

And this is the other one.

Thanks.
