Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856761F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 01:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfJ3BQP (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 21:16:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59575 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfJ3BQP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 21:16:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FB309D360;
        Tue, 29 Oct 2019 21:16:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QnOPTGT3NVENFiyljn9CK9kx5B8=; b=sGUaRy
        EeYoNx/DIuh9UTzQgteEWq1WVPZdAl4HJCAe0u8EDe/JKF5ErTcRxXwgiRzgKaKA
        7BypEbZZe2QYvsM7/ACRb76E3bdyAHL7DGtmOpmFYiYFdmvtvMU6/1TO4uhbUTv2
        QTqA2o/H+s1XXmw5H7I5DO0lI+NG9VviKdmNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dv3Vdk87B52oaBwDKGk2xStvESkHWgOi
        PSgTWQMu4qN5fCMftNlnnkRlNZCajWASfSFDMYVpnmkR05tR1+AjRmwoxGart/SK
        JgSSf8xn1cjPiTscdggfOyVRLZAfdcJun7IiQx2U65tPp6mOfxYKdo9ulag1/bjs
        CUf3Ghuh29I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56D9A9D35F;
        Tue, 29 Oct 2019 21:16:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 869D69D35E;
        Tue, 29 Oct 2019 21:16:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] stash: handle staged changes in skip-worktree files correctly
References: <pull.355.git.gitgitgadget@gmail.com>
        <pull.355.v2.git.1572261615.gitgitgadget@gmail.com>
        <9835e66399b5feeb3313bcee62f0519c025a4ca2.1572261615.git.gitgitgadget@gmail.com>
Date:   Wed, 30 Oct 2019 10:16:08 +0900
In-Reply-To: <9835e66399b5feeb3313bcee62f0519c025a4ca2.1572261615.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 28 Oct 2019
        11:20:15 +0000")
Message-ID: <xmqq1ruv58yv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB86B9BE-FAB2-11E9-8019-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When calling `git stash` while changes were staged for files that are
> marked with the `skip-worktree` bit (e.g. files that are excluded in a
> sparse checkout), the files are recorded as _deleted_ instead.

Good.  Much easier to see what is going on than the verb "lose" used
in the cover letter of v1 that puzzled me.

> However, when the temporary index is updated via `git update-index --add
> --remove`, skip-worktree entries mark the files as deleted by mistake.
>
> Let's use the newly-introduced `--ignore-skip-worktree-entries` option
> of `git update-index` to prevent exactly this from happening.

Good.

> Note that the regression test case deliberately avoids replicating the
> scenario described above and instead tries to recreate just the symptom.

That's good.  Testing the end-user visible effect is just as
important as the narrowly pointed root-cause test like the one in
the previous patch.

Thanks.
