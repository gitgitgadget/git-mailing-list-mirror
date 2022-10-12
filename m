Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D34C433FE
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 05:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJLFws (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 01:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJLFwr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 01:52:47 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2794BCA2
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 22:52:46 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 11A611B31A6;
        Wed, 12 Oct 2022 01:52:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oo8O7Ypim8T+2fey/63gAir/8CHuwxWMXwhWc5
        Hny2M=; b=jmYsNCriD8qFkYi53D5guzdljh5D1T8Gj5wSskbVlEubyFTk8dwXTN
        iTOnvcsoScBwZd1BRZ0xpVZH49mrDu2lCUNC/cAlE70TMhTzuzh2RYDsH51rOz2U
        xHaErxnnUKcOQb43lJUz6006ll0rl8cBz6WXzZ46/mw92MkBOFS20=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F143F1B31A5;
        Wed, 12 Oct 2022 01:52:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 267A51B31A4;
        Wed, 12 Oct 2022 01:52:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com, avarab@gmail.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v2 0/4] submodule: parallelize diff
References: <https://lore.kernel.org/git/20220922232947.631309-1-calvinwan@google.com/>
        <20221011232604.839941-1-calvinwan@google.com>
Date:   Tue, 11 Oct 2022 22:52:42 -0700
In-Reply-To: <20221011232604.839941-1-calvinwan@google.com> (Calvin Wan's
        message of "Tue, 11 Oct 2022 23:26:00 +0000")
Message-ID: <xmqqczaxmvv9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16CC02B8-49F2-11ED-896B-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> I also wanted to pose another question to list regarding defaults for
> parallel processes. For jobs that clearly scale with the number of
> processes (aka jobs that are mostly processor bound), it is obvious that
> setting the default number of processes to the number of available cores
> is the most optimal option. However, this changes when the job is mostly
> I/O bound or has a combination of I/O and processing. Looking at my use
> case for `status` on a cold cache (see below), we notice that increasing
> the number of parallel processes speeds up status, but after a certain
> number, it actually starts slowing down.

I do not offhand recall how the default parallelism is computed
there, but if I am correct to suspect that "git grep" has a similar
scaling pattern, i.e. the threads all need to compete for I/O to
read from the filesystem to find needles from the haystack, perhaps
it would give us a precedent to model the behaviour of this part of
the code, too, hopefully?

