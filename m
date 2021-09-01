Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D61C4320A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 05:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F5E6101A
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 05:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbhIAFaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 01:30:09 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58967 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbhIAFaI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 01:30:08 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDBE6C9B23;
        Wed,  1 Sep 2021 01:29:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZElHn/uiHWiyKYV4rmfn15GAM+5YebOH8TgfOf
        ugcn8=; b=YIagl5b0JQTYgvKfiFUdpKryADyLKYzb3kPMYjwDQBJbR7G2onUBeb
        MmnzsYtk8UjZxbf/ozmTKIWX5skpVsgRW2PCbotaadvnDU6Pl6U+j3qoFnQ1n2/h
        aSs6abVt10dvg7cEmLp49Yj7aFCNHzrjuD4/1mq+mYXSQSzoOmCxg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4C31C9B22;
        Wed,  1 Sep 2021 01:29:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 71E34C9B21;
        Wed,  1 Sep 2021 01:29:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase, cherry-pick, revert: only run from toplevel
References: <pull.1083.git.git.1630379030665.gitgitgadget@gmail.com>
        <YS3Tv7UfNkF+adry@coredump.intra.peff.net>
        <CABPp-BFmU+RaAjq4_0-PSfRgH1Jc63nN0fMuDWk2+iDbdz7CCA@mail.gmail.com>
Date:   Tue, 31 Aug 2021 22:29:10 -0700
In-Reply-To: <CABPp-BFmU+RaAjq4_0-PSfRgH1Jc63nN0fMuDWk2+iDbdz7CCA@mail.gmail.com>
        (Elijah Newren's message of "Tue, 31 Aug 2021 13:14:55 -0700")
Message-ID: <xmqqk0k0sw2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89A6FD08-0AE5-11EC-8BA5-ECFD1DBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Ooh, this sounds intriguing to me...but what if we changed that rule
> slightly and just decided to never make the cwd go away?  Currently,
> the checkout code removes directories if they have no tracked or
> untracked or ignored files left, i.e. if they're empty.  What if we
> decide to only have remove_scheduled_dirs() remove directories that
> are empty AND they are not the current working directory?

Is that generally doable?  What would we do when the directory the
subcommand was started from (or one of its parent directories) is
not just missing but has to be a file in the revision the subcommand
is trying to checkout?
