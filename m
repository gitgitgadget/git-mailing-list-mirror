Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60C6C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 20:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiGKURc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 16:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGKURc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 16:17:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC8A3341A
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 13:17:31 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B4B813587A;
        Mon, 11 Jul 2022 16:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T19ouEe0WSvFAfRFM9sCxi9PYyUxJIDnLxmNxk
        VmRsY=; b=Ct9ZYJdYQQBCBjl1UrxyqOOB23VTuVHDcrd57794hu+qEmQ1kxvXHq
        nE0lBQdbrh/pAY1LEtlUR64a4WZrc+1TbR4Ykfi+qikLkZv/Hk50XFf5OoYoYRr4
        Y6fXH1ul4yuZi06XlbpX1p/wSyfsNSy81tnRj7xQqMGNyhr8a7ay4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 028C3135879;
        Mon, 11 Jul 2022 16:17:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D8B9135876;
        Mon, 11 Jul 2022 16:17:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@grubix.eu>, hanxin.hx@bytedance.com,
        chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com, ps@pks.im
Subject: Re: [PATCH v4 1/1] commit-graph.c: no lazy fetch in
 lookup_commit_in_graph()
References: <cover.1656381667.git.hanxin.hx@bytedance.com>
        <cover.1656593279.git.hanxin.hx@bytedance.com>
        <96d4bb71505d87ed501c058bbd89bfc13d08b24a.1656593279.git.hanxin.hx@bytedance.com>
        <165736941632.704481.18414237954289110814.git@grubix.eu>
        <Ysw9LmBFGbRy9L7c@coredump.intra.peff.net>
Date:   Mon, 11 Jul 2022 13:17:28 -0700
In-Reply-To: <Ysw9LmBFGbRy9L7c@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 11 Jul 2022 11:09:34 -0400")
Message-ID: <xmqqk08jo147.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D05634C-0156-11ED-BF0F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> 512 is probably OK in CI in an isolated environment but is too low on a
>> typical "What you mean I'm not working? I'm waiting for the test run!"
>> developper workstation.
>> 
>> Conversely, which number would be too high to catch what the test is
>> supposed to catch? Does it incur a big performance penalty to go as high
>> as possible?
>
> This bit me, too. It works if I run it standalone:
>
>   $ ./t5330-no-lazy-fetch-with-commit-graph.sh 
>   ok 1 - setup: prepare a repository with a commit
>   ok 2 - setup: prepare a repository with commit-graph contains the commit
>   ok 3 - setup: change the alternates to what without the commit
>   ok 4 - fetch any commit from promisor with the usage of the commit graph
>   # passed all 4 test(s)
>
> but it fails when I run the whole test suite with "prove -j32". Or even
> easier, just run it under "--stress":

Understandable.  I am usually on a datacentre VM without graphical
UI so the process count there is much lower than on a typical
developer workstation.

I wonder if we can just run the test without any limit?  If in an
unattended CI situation, hopefully they will kick the job out due to
quota, and on a developer workstation, there may be processes killed
left and right, but that is only when the "infinite respawning" bug
reappears.

