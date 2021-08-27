Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E7C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 00:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E19560F5C
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 00:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhH0AX3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 20:23:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51868 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhH0AX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 20:23:28 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D3CFD6BB3;
        Thu, 26 Aug 2021 20:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TSV1vPtThRMgTmxcZjGU09IIeGaFMUFh5XU9nk
        0BTOc=; b=LUhkMpurbVt07gflxOJDYCXlJte8VfqIRghDF+GrZo7521NrJ3lmxC
        Xgfkb2251q2zXQla6ooB6wLIYFOEFHQYWQkDqH3pCNuz7ef9C1zZ5o5Low9wvPvt
        d0W54M15GZL/r5SOgakuaCCoCUPAq3mfQip7P2hvssmhFiavsy9iI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54E33D6BB2;
        Thu, 26 Aug 2021 20:22:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D418CD6BB1;
        Thu, 26 Aug 2021 20:22:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 4/6] hook: allow running non-native hooks
References: <20210819033450.3382652-1-emilyshaffer@google.com>
        <20210819033450.3382652-5-emilyshaffer@google.com>
        <87o89mej3y.fsf@evledraar.gmail.com> <YSgatN5kYwLJtDMQ@google.com>
Date:   Thu, 26 Aug 2021 17:22:39 -0700
In-Reply-To: <YSgatN5kYwLJtDMQ@google.com> (Emily Shaffer's message of "Thu,
        26 Aug 2021 15:50:28 -0700")
Message-ID: <xmqq7dg7d9dc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E356E218-06CC-11EC-B074-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> I think it's A) pretty important to make it easy for users to run
> whatever not-necessarily-git-native hook they want, and B) useful for
> script Git commands to take advantage of the typo check. So, I'll add a
> `--enforce-known-hookname` (or maybe a better named one, this isn't my
> strong suit) and switch git-send-email and friends to use it.

I somehow feel this is backwards.  

Once you write the invocation of "git hook run <hookname>" into your
script and tested it, there is no further need for typo checking.

What's the use case you are trying to help with typo checking?  When
a script takes a hookname from the user and runs "git hook run $1",
then passing --this-must-be-a-known-hook option that errors out when
the named hook does not exist and unrecognised (there is no need to
error out if a hook with unusual name the user gave us does
exist---the user asked us to run it, so we just can run it) might
make sense.  But I am somehow not getting the sense that it is the
expected use case you are worried about.

If the reason why you are making the typo-checking an opt-in feature
is because you want to allow users to run "git hook run" with
minimum typing, I suspect that you may be optimizing for a wrong
case.  Interactive users are the ones that benefit from
typo-checking the most, and if they are interactive (as opposed to
being a script), they are flexible enough not to say "git hook run
foobar" when they know foobar does not exist and they know foobar is
not a generally accepted hook, no?  So, I think it makes more sense
to by default allow a hook with a recognizable name to be missing,
but complain when a randomly named hook is missing, and to have an
option that permits a hook to be unrecognised and missing.



