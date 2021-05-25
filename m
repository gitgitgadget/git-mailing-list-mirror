Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18B3C2B9F7
	for <git@archiver.kernel.org>; Tue, 25 May 2021 02:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B215861420
	for <git@archiver.kernel.org>; Tue, 25 May 2021 02:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhEYCvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 May 2021 22:51:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60376 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhEYCvB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 May 2021 22:51:01 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1716CBFF7;
        Mon, 24 May 2021 22:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=paxHgXeWMevEJXsA94tYa1kW84ZkcnkXy7ZO0M
        iiBTg=; b=NDlfP1Nueo0WKlDNgtnqVcU0pYVPWRp3pFf1jXJCcoXIt3oxpMltp2
        gjq2CGUPbCwZiAw8ynR/MQmca4NOkOcrXhaipUh7zGPbDJ3A544MNX7KuqUyvLWR
        fsVOCh0qoa2vMA0tk6VKLIFIygR+1rR5zOwAy8+cYLWxxsYHq45oc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3AA1CBFF6;
        Mon, 24 May 2021 22:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6E8C6CBFF5;
        Mon, 24 May 2021 22:49:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
        <YKwMU13DOtTIgaeP@google.com>
        <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
        <YKwd2e5VxVmU6zqj@nand.local>
Date:   Tue, 25 May 2021 11:49:30 +0900
In-Reply-To: <YKwd2e5VxVmU6zqj@nand.local> (Taylor Blau's message of "Mon, 24
        May 2021 17:42:49 -0400")
Message-ID: <xmqq5yz7il39.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D49F39FE-BD03-11EB-935E-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> What would perhaps make more sense is to silence the progress meters
> from the commands themselves. AFAICT the only command called by
> run_on_sparse() which generates a progress meter is 'git checkout',
> 'git merge', and 'git submodule', all of which support '--no-progress'.
>
> Might it be worth passing that option instead of setting
> GIT_PROGRESS_DELAY to a large value?

Yup.  The progress meters are obvious source of variation, but there
is no guarantee that is the only source of variation.  The test
strategy to run the same command twice and judge only by observing
their stdout and stderr is, eh, suboptimal.  If we devise a sequence
of commands that are tested immediately followed by a sequence of
commands to check the outcome of these commands, and the output from
the latter for two runs are the same, then that is a more sensible
approach, as the latter "visualize the outcome of the commands that
are just tested" can be controlled more tightly to ignore meaningless
variations (like progress meters or base-delta paring in a resulting
packfile of a parallel packing) and focus on the aspects of the
outcome that matter.






