Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D292C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D8560FE8
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 17:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhJHRcI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 13:32:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65061 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhJHRcH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 13:32:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4D20E1E39;
        Fri,  8 Oct 2021 13:30:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fMx6hC8YQKi5M5laPvcOko4Kk+jSMmV7k8H8IF
        rNPRk=; b=H32l1E0Ih7pF0uQqA8iqEssO0LEQjyvWBNJ2FtnOyMA9e65Lxh1J4r
        9DHYud8lXC0oxcHnXxZquOxOlM6JJMXXPPBZjHwRdTmL1En1oPnzwAYnAWAQGgCa
        6wQ2+xCE3gFh5/j6cDxigGD0oOoCU//vvbTbDpsjIDRLxt15gqFO0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 98230E1E37;
        Fri,  8 Oct 2021 13:30:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C635EE1E34;
        Fri,  8 Oct 2021 13:30:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] t/perf/perf-lib.sh: remove test_times.* at the end
 test_perf_()
References: <pull.1051.git.1633386543759.gitgitgadget@gmail.com>
        <YVyPH59LpxFLHep0@nand.local>
        <YV3314Dnhj7srFZ4@coredump.intra.peff.net>
        <3f03ed89-d3db-32ba-3c1f-b8fac7cfb097@jeffhostetler.com>
        <YV+zFqi4VmBVJYex@coredump.intra.peff.net>
Date:   Fri, 08 Oct 2021 10:30:09 -0700
In-Reply-To: <YV+zFqi4VmBVJYex@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 7 Oct 2021 22:55:18 -0400")
Message-ID: <xmqqee8vl90e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63844DFC-285D-11EC-B803-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> What I'd propose instead is that we ought to have:
>
>   test_perf 'checkout'
>             --prepare '
> 	        git reset --hard the_original_state
> 	    ' '
> 	        git checkout
> 	    '
>
> Having two multi-line snippets is a bit ugly (check out that awful
> middle line), but I think this could be added without breaking existing
> tests (they just wouldn't have a --prepare option).
>
> If that syntax is too horrendous, we could have:
>
>   # this saves the snippet in a variable internally, and runs
>   # it before each trial of the next test_perf(), after which
>   # it is discarded
>   test_perf_prepare '
>           git reset --hard the_original_state
>   '
>
>   test_perf 'checkout' '
>           git checkout
>   '
>
> I think that would be pretty easy to implement, and would solve the most
> common form of this problem. And there's plenty of prior art; just about
> every decent benchmarking system has a "do this before each trial"
> mechanism. Our t/perf suite (as you probably noticed) is rather more
> ad-hoc and less mature.

Nice.

> There are cases it doesn't help, though. For instance, in one of the
> scripts we measure the time to run "git repack -adb" to generate
> bitmaps. But the first run has to do more work, because we can reuse
> results for subsequent ones! It would help to "rm -f
> objects/pack/*.bitmap", but even that's not entirely fair, as it will be
> repacking from a single pack, versus whatever state we started with.

You need a "do this too for each iteration but do not time it", i.e.

    test_perf 'repack performance' --prepare '
	make a messy original repository
    ' --per-iteration-prepare '
	prepare a test repository from the messy original
    ' --time-this-part-only '
        git repack -adb
    '

Syntactically, eh, Yuck.

