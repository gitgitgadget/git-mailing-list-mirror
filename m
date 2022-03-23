Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C5A1C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 14:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236854AbiCWOyl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 10:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiCWOyk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 10:54:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BEEBE13
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 07:53:09 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3E73A18F63F;
        Wed, 23 Mar 2022 10:53:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=DeFQ8Q/81WG4H+xyJx/Md0zNuATmAbCbVCQ85+6pRdI=; b=o0s4
        9IGOtFc16A4hOpPNUPxfO5FvDDF7QwNg0ATHhRLCkKcwiB0aZXgqllwLTtv1XPcM
        jUJCyuXnXLnD/K/HRBW5Q7azT+1oaFx4jZEhCPrFdlBaLBlKjPVP4YckdD3a60tv
        vQsvsmpzPb4u7Ht2ATAEVSrvLUsmHLET38m5ZEI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3742C18F63E;
        Wed, 23 Mar 2022 10:53:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9E59518F63D;
        Wed, 23 Mar 2022 10:53:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, chakrabortyabhradeep79@gmail.com
Subject: Re: [PATCH] test-lib-functions: fix test_subcommand_inexact
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
        <540936ba-7287-77fa-9cee-e257ed3c119d@github.com>
Date:   Wed, 23 Mar 2022 07:53:05 -0700
Message-ID: <xmqqmthgu3e6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F2D8D206-AAB8-11EC-B996-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> So, this patch is incorrect about keeping things working. The
> options are:
>
> 1. Keep the repeated ".*" and be clear about the expectations.
>    (This could drop the "remove trailing comma" line.)
>
> 2. Find another way to test this --write-midx behavior while
>    keeping the stricter test_subcommand_inexact helper.
>
> 3. Something else???

The result of doing #1 is still "inexact" but at that point it is
unclear if we are being way too inexact to be useful.  If the
looseness bothers us too much, we may decide that #1 is not worth
doing.  But obviously the looseness did not bother us that much
until last week, so probably an obvious #3, do nothing, letting the
sleeping dog lie, might be what we want to do?

If we were to pursue #2, then, would we tightening the test for the
write-midx using the "stricter" helper, or would the stricter one be
too strict to be useful for that case?  If we are rewriting the
write-midx test by not using the "stricter" helper, then we would be
creating a stricter one nobody uses, which sounds quite wasteful.

It seems that the only case that could result in a result that is
better than "do nothing" is if we can use a different pattern with
the "stricter" helper to express what "write-midx" test wanted to
do, but because what we need to fuzzily match on the command line in
that test includes a generated temporary filename, I do not think
it is likely to be easily doable.

So, perhaps #3 ;-)?
