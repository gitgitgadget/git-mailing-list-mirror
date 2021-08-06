Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D8BC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 17:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACE260E97
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 17:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhHFRV0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 13:21:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57023 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhHFRVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 13:21:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9F43EE1BC;
        Fri,  6 Aug 2021 13:21:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=heZ5k0nBv56QbC+AdIcq7d7akoHfwcE6gz7LVX
        r5qBE=; b=JA3wK/TVBriSmTSVwvWZF4yvjVmJSz6ef52EYmv8VoOXc4no6tJLSG
        O402LRgk4y6Ctaud1Lt0NNLi+0t2uZ4aPgJgbcsPMXvddFZAeXhVvw9n7qGLLuR0
        VfPoAJh9wOKRxcWBfijLLJKiGocjNigZIcCOysh89bArXsk74sioQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7EB6EE1BB;
        Fri,  6 Aug 2021 13:21:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A852DEE1BA;
        Fri,  6 Aug 2021 13:21:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Alex Henrie <alexhenrie24@gmail.com>,
        huang guanlong <gl041188@gmail.com>, git@vger.kernel.org,
        Hudson Ayers <hudsonayers@google.com>,
        Taylor Yu <tlyu@mit.edu>, Joshua Nelson <jyn514@gmail.com>
Subject: Re: [PATCH] Revert 'diff-merges: let "-m" imply "-p"'
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <20210520214703.27323-1-sorganov@gmail.com>
        <20210520214703.27323-11-sorganov@gmail.com>
        <YQtYEftByY8cNMml@google.com> <YQyUM2uZdFBX8G0r@google.com>
Date:   Fri, 06 Aug 2021 10:21:05 -0700
In-Reply-To: <YQyUM2uZdFBX8G0r@google.com> (Jonathan Nieder's message of "Thu,
        5 Aug 2021 18:45:23 -0700")
Message-ID: <xmqqh7g2ij5q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFE15ED8-F6DA-11EB-8252-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> The problem is that although diff generation options are only relevant
> for the displayed diff, a script author can imagine them affecting
> path limiting.  For example, I might run

I am somewhat puzzled.  What does "can imagine" exactly mean and
justify this change?  A script author may imagine "git cat-file" can
be expected to meow, but the command actually does not meow and end
up disappointing the author, but that wouldn't justify a rename of
"cat-file" to something else.

> 	git log -w --format=%H -- README
>
> hoping to list commits that edited README, excluding whitespace-only
> changes.  In fact, a whitespace-only change is not TREESAME so the use
> of -w here has no effect (since we don't apply these diff generation
> flags to the diff_options struct rev_info::pruning used for this
> purpose), but the documentation suggests that it should work
>
> 	Suppose you specified foo as the <paths>. We shall call
> 	commits that modify foo !TREESAME, and the rest TREESAME. (In
> 	a diff filtered for foo, they look different and equal,
> 	respectively.)
>
> and a script author who has not tested whitespace-only changes
> wouldn't notice.

It would need to be corrected by a bugfix of either TREESAME
computation, or a documentation fix, I would think.  I fail to see
the similarity you perceive to the "-m" issue at hand, though.

> Similarly, a script author could include
>
> 	git log -m --first-parent --format=%H -- README
>
> to filter the first-parent history for commits that modified README.
> The -m is a no-op but it reflects the script author's intent.

So the expectation is with "-m" we'd give single parent commits on
the fp chain, and merges from side branches that change README, in
addition to merges from side branches that was forked way before the
README was updated on the trunk (hence had ancient README but the
merge kept the version from the trunk)?

> For
> example, until 1e20a407fe2 (stash list: stop passing "-m" to "git
> log", 2021-05-21), "git stash list" did this.

This is not a example that supports your conclusion, though.  The
reason why 288c67ca (stash: default listing to working-tree diff,
2014-08-06) added "-m" on the command line to make it:

  git log --format="%gd: %gs" -g --first-parent -m "$@" $ref_stash --

is to prepare for the users who may pass "-p" as part of the "$@";
they wil get no patches out of these merge commits that represent
stash entries otherwise, and they'd have to pass "-m -p" instead,
without the change.

> As a result, we can't safely change "-m" to imply "-p" without fear of
> breaking such scripts.  Restore the previous behavior.

So the above is *not* an example of a script that would have been
broken with this change.
