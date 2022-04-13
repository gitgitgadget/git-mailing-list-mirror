Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1291C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 23:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbiDMXde (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 19:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiDMXdd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 19:33:33 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F3424951
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 16:31:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60599128A16;
        Wed, 13 Apr 2022 19:31:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XVx1t2pOwiq2WAt9++Cnxcox7SXyh2Ct6vtbe7
        CfwEY=; b=J4v3mPQRUJ7XNp3gBXxFvRKZykVdR1C+gGsW3Atdu/MjBgl7Psbplb
        tPHDcw0iQWDYpeu+jHC2DWbBMyzrwm4POekuZKoKySGVUcB1knhp2xjZ8EvaIE2E
        3LlWsnUAkIIjvF6D5xli3KxhvO//gnmdFLIIRPrrIrAI58jd0osME=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4589D128A15;
        Wed, 13 Apr 2022 19:31:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D136128A14;
        Wed, 13 Apr 2022 19:31:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: reference-transaction regression in 2.36.0-rc1
References: <CAGyf7-GYYA2DOnAVYW--=QEc2WjSHzUhp2OQyuyOr3EOtFDm6g@mail.gmail.com>
        <CAGyf7-GaoBarXD2xKG3KUXwGZgbhKgv-4Mz45achbr6G9ihTBQ@mail.gmail.com>
        <220413.86r161f3qp.gmgdl@evledraar.gmail.com>
        <xmqq4k2w92xo.fsf@gitster.g> <xmqqilrc61te.fsf@gitster.g>
        <xmqqbkx4619t.fsf@gitster.g>
Date:   Wed, 13 Apr 2022 16:31:07 -0700
In-Reply-To: <xmqqbkx4619t.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        13 Apr 2022 15:56:14 -0700")
Message-ID: <xmqq7d7s5zno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CBB8A672-BB81-11EC-849B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Reverting the merge 991b4d47f0a as a whole is an option.  It might
>> be the safest thing to do, if we do not to want to extend the cycle
>> and add a few more -rc releases before the final.
>
> It turns out that this involves nontrivial amount of work to get
> right, as the bottom commit of Patrick's "fetch --atomic" series
> wants to count how many transaction we make, instead of ensuring
> that the updates to the references are all-or-none, so at least
> 2a0cafd4 (fetch: increase test coverage of fetches, 2022-02-17)
> needs to be reverted as well.  This in turn is made unnecessarily
> more cumbersome as the history in the t/ directory is littered with
> unrelated "clean-up" patches since these topics were merged.

I have a tentative revert of the merge and also the "fetch --atomic"
test that (unnecessarily) counted the number of transactions directly
on top of planned 'master', which merges the planned v2.35.3 into
v2.36-rc2 and pushed it as if it were the 'seen' branch.

The CI job https://github.com/git/git/actions/runs/2164208587 seems
to be doing well so far, so once the dust from releasing v2.30.4,
v2.31.3, v2.32.2, v2.33.3, v2.34.3, and v2.35.3 with Derrick's
hotfix for yesterday's CVE fix, I may merge it down to 'master'
before the final.

Thanks.


