Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FFCC433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E160064E06
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239194AbhBDSjj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 13:39:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59093 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbhBDShS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 13:37:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 19BABA838F;
        Thu,  4 Feb 2021 13:36:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HvfjWfGnxGAhH/etvu35RfFr9DU=; b=LldsXd
        +va8zYQP+n+YoAeUhx7MQcvTwZkC1sf/j1yjofz0OnO11ruMOLO5lLiDhLY9knQ5
        uL29UUmpTde5Mnu2G61hP0IoFFT94dxTrCo3mhDHyd4g1wXNoCXfIExJYRbv6EEZ
        7NnGURxV80HcDg13Zc+OdRbMewpgs3VwF4fKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RAseOznq7kjNKVRN9nXhPj/uJ+o5ESfD
        ypHcsqg+treiBCg8VdP8rLroD4eo131tvFNhhT4MYeq55CVEqQMsxnK+F0ZQDCHQ
        2bYbNyxqHG/OhYLeEbw0Z+tPIrgn3PriCMtFUv0gfxmh2sH4//p5vzP3Jm1T6U2B
        2qiqZ4usk3g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F1DBA838E;
        Thu,  4 Feb 2021 13:36:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80588A838D;
        Thu,  4 Feb 2021 13:36:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     lilinchao@oschina.cn
Cc:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, "Derrick Stolee" <stolee@gmail.com>,
        dscho <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] builtin/clone.c: add --no-shallow option
References: <pull.865.git.1612409491842.gitgitgadget@gmail.com>
        <xmqq35yc9yan.fsf@gitster.c.googlers.com>
        <57d5526c66d411eb81800024e87935e7@oschina.cn>
Date:   Thu, 04 Feb 2021 10:36:34 -0800
In-Reply-To: <57d5526c66d411eb81800024e87935e7@oschina.cn>
        (lilinchao@oschina.cn's message of "Thu, 4 Feb 2021 18:32:52 +0800")
Message-ID: <xmqqft2b7k99.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8F86782-6717-11EB-B901-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"lilinchao@oschina.cn" <lilinchao@oschina.cn> writes:

> I found an issue described like this:
>
>     The blame information can be completely wrong when fetching it from
>     a shallow clone, without errors or warnings. When the outcome is invalid
>     data, it's extremely difficult to diagnose that it comes from a shallow clone.
>     If a line in a file was not changed in the commits that were downloaded as
>     part of the shallow fetch, git will report the first known commit as the author.
>     This has a big impact on the auto-assignment of new issues.
>
> It looks like this is another scenario that can prove this feature is necessary.

In other words:

    Users may want more history than the repository offered for
    cloning, which happens to be shallow, can give them.

And the way chosen by "--reject-shallow" is to require that the
source repository has the entire history.

I wonder if the design of this UI is flexible enough so that we can
extend it to allow "I need the history that goes back at least to X"
in the future.  "I need the history goes back to all the roots" then
becomes a narrow special case of that.

> After I applied your review suggestions above, then we can reject a 
> non-local clone from shallow repo. For now, it will clone a empty 
> repo with --no-local option.

It is my understanding that your patch with or without my suggestion
only deals with local clone and does not change anything for
non-local case.  A "local-only" solution is a good place to start
and is a good test bed to experiment with the user experience, but I
view without support for non-local clone, it would not be ready for
general use.

Thanks.
