Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9DEC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 14:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16729610EA
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 14:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240986AbhHMO7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 10:59:51 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62686 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240973AbhHMO7v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 10:59:51 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3D5F614428A;
        Fri, 13 Aug 2021 10:59:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oHRdKayWwwuK9SjllSSMKt+qKuBveI777NNSWM
        IkG7w=; b=x6G3QR9KQSpCVQC5VbumvCL652kvDOJlLSO06g4WtJ216rhUwVBhSQ
        MNk6sDZDueLnWphZuLbC32zdaYzlSq3JvNNpaBiB/vqr2LMAWsC+oNtGxbw13BQ9
        09CdPPyZ9dMZ939uD6tx1ejbLOvLioJQOfIpZADQmKWa6+xiE1CpM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 35D85144289;
        Fri, 13 Aug 2021 10:59:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 816D9144286;
        Fri, 13 Aug 2021 10:59:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Mahi Kolla <mahikolla@google.com>
Subject: Re: [PATCH v5] clone: set submodule.recurse=true if user enables
 feature.experimental flag
References: <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
        <pull.1006.v5.git.1628736366133.gitgitgadget@gmail.com>
        <xmqqeeaz70ph.fsf@gitster.g> <YRW0pGXXWnY7C470@google.com>
        <c74a9d75-cd89-d020-dcb3-76509bc95284@gmail.com>
Date:   Fri, 13 Aug 2021 07:59:19 -0700
In-Reply-To: <c74a9d75-cd89-d020-dcb3-76509bc95284@gmail.com> (Philippe
        Blain's message of "Thu, 12 Aug 2021 23:35:39 -0400")
Message-ID: <xmqqr1exxuew.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A96D760-FC47-11EB-AD3D-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Here I think you are confusing submodule.active (which takes a pathspec)
> and submodule.recurse (which takes a boolean).

Sigh, but I have to agree with you.

I really hoped that in a recursive clone of a repository with two
submodules A and B, when made with --recurse-submodules=A, "git grep
." would look for things in the superproject and submodule A as
Emily seemed to have meant by her "the right thing", but you are
correct.  We only set .active but we do not set .recurse, so "git
grep ." in the superproject does not descend into neither
submodules without being told.

If it did "the right thing" as Emily said, it would have been much
easier to justify the change being proposed as a simple fix for the
bug that --recurse-submodules without pathspec does one thing
(i.e. setting things up not to recurse for later "grep" etc.") and
the same option with "everything matches" pathspec "." does a
different thing (i.e. always to recurse).

The discrepancy would have given us an excuse, an argument for
changing the behaviour for the former to match the latter.  Some
users may have deliberately built their workflow relying on the
distinction and the result still may give them a regression, but at
least it would have gave us a viable justification:

    A command run without pathspec means the entire tree and it is
    the same as running it with pathspec '.' in the rest of Git, but
    the way "git clone --recurse-submodules" handles its optional
    pathspec is inconsistent.  Treat "clone --recurse-submodules"
    without pathspec as if it came with pathspec '.' and give the
    same configuration.

But unfortunately it does not seem to be the case.
