Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2AFC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27355613CF
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 16:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhHWQGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:06:49 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50995 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHWQGs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 12:06:48 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EF79FEE601;
        Mon, 23 Aug 2021 12:06:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Kls85/OeqLEZq/TAh9uZ4vZxCXwrtX5AhOCp8l
        MxRb0=; b=og4Evh/7bHlrzYnZmLCjllUoZlulIbzWpu7BKi78DlAneXgvlj7o/c
        p3MudoedRYu1Q7MNnAOVoW1Mfk+em5FKjeGev+oIBe9GU0LygLZUL8A9DXgfRxUW
        b9gyxPm6Aj7D+Uqx26AwdYliJdO4PuL5t5vFC6imvZTZL0JwOxxRs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9C5CFEE600;
        Mon, 23 Aug 2021 12:06:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27DE2EE5FF;
        Mon, 23 Aug 2021 12:06:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] multi-pack-index: fix --object-dir from outside repo
References: <20210820193504.37044-1-johannes@sipsolutions.net>
        <04ed58aa-94fa-010e-f4db-f41cd51876a5@gmail.com>
        <4d65ef5b0a9e4104d763facc42d10a20557d054d.camel@sipsolutions.net>
        <xmqqo89osi0b.fsf@gitster.g>
        <caafaf945ec43ba606b054bf4c4faa42e35a8db1.camel@sipsolutions.net>
Date:   Mon, 23 Aug 2021 09:06:02 -0700
In-Reply-To: <caafaf945ec43ba606b054bf4c4faa42e35a8db1.camel@sipsolutions.net>
        (Johannes Berg's message of "Mon, 23 Aug 2021 10:10:10 +0200")
Message-ID: <xmqq1r6krvrp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03E1C384-042C-11EC-AFE4-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> Makes sense. FWIW, the test *did* restore the CWD so things worked, and
> subshells are actually ugly (need to import test-lib-functions.sh again
> if you want to use those), but I'll make it work somehow.

You do not need to dot-include test-lib-functions or anything ugly
or special.  The variables (not only the exported ones but regular
shell variables) and shell functions that is visible immediately
before you enter the opening "(" are all visible in the subshell.

The only notable difference you need to keep in mind when using
subshell is that you cannot affect variables and environment in
general of the calling shell.  In this case, you are taking
advantage of it---no matter where you chdir to, the main test
procedure that spawned the subshell will not be affected even if
your tests fail inside a subshell.  But it also disallows you from
doing certain things that rely on the ability to modify shell
variables, like setting up test_when_finished clean-up routine.

> More importantly, how do you feel about the "cd /"?

Please don't.  If somebody had a repository in /.git and the program
you are testing is buggy, you'd risk destroying it.  In general, it
is not a good idea to step outside the test directory you are given,
especially if you are *not* limiting yourself to read-only operation.

> The tests are always run in a place where there's a parent git folder
> (even if it's git itself), so you cannot reproduce the segfault in a
> test without the "cd /"

There is a "nongit" test helper in the test suite.  Would that work
for your case?

Thanks.
