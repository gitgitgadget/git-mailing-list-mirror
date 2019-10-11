Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 659D61F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 04:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfJKEWl (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 00:22:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50510 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfJKEWl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 00:22:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD89625383;
        Fri, 11 Oct 2019 00:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pw9pmmOjk/9d1UzgBYWogyJUU/c=; b=OJu2ls
        npu/lwF6PbQJceRBzcDvr5R9ALYQhk6e/mwoknCOMB7hiXwJAj7RD9mEHapbZ53w
        KdUd6NbAcOUCTrtE1J2PnctM9uAMi2tIO0VFklKR2UzYewnkg18IdJlw++Eai1K2
        yoMapBzek8cPf2fGk4SVhq3UVbF06BRiOeZtM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TJI0/jxm5jwQoBWOt6i/+uGWmO3BmEEn
        qthPYupUbfrQrt/9qsnEhilzrP9l0IXAAfDnuFbfy/JIvfpMGEWLCqT4hqns4K+R
        CH46yt/0CfYJgVlYY5bVCC7PaQfyCb47LzVePXVv41r5V3a5xGkJBt7/skNlcYk9
        58fURn/yUTs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3E0A25382;
        Fri, 11 Oct 2019 00:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 114E225381;
        Fri, 11 Oct 2019 00:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Magne Land <magne.land@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/1] Pass through the exit code of post-checkout
References: <pull.385.git.gitgitgadget@gmail.com>
Date:   Fri, 11 Oct 2019 13:22:38 +0900
In-Reply-To: <pull.385.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Thu, 10 Oct 2019 05:01:38 -0700 (PDT)")
Message-ID: <xmqqo8ynj4hd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3268364-EBDE-11E9-81A5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> To answer Jonathan's question, at long last, yes, it is useful. A hook is
> not only an opportunity to run code at given points in Git's life cycle, but
> also an opportunity to stop Git in its tracks.

In general that is correct, and especially so for pre_$git_action
hooks, which are about interfering and vetoing an action that is
being carried out.

On the other hand, post_$git_action hooks are specifically defined
as a way to trigger an extra action and documented that they cannot
affect the outcome of the operation (in other words, they trigger at
a point in the operation flow that is too late to affect the
outcome).

Now, it is somewhat debatable how the "outcome" should be defined.
A post-rebase hook that drops the last commit in the sequence, for
example, should not be allowed (the rebase has rebuilt a sequence
and that final sequence of commits should be left), but should it be
allowed to signal back to "git rebase" and affect its exit status?

I am not 100% sure if it is a good idea to allow post-checkout to
affect the exit status of "git checkout" or its friends.  If one
codepath in "git checkout" or its friends lets post-checkout to
influence the exit status while another codepath ignores, it makes
sense to discuss if the inconsistency needs to be removed, but in
such a case, I think it would make sense to unify in the direction
of ignoring (i.e. not allowing post-* hook to affect the outcome).


