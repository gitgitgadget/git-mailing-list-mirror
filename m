Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0989C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA596103C
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 20:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbhJ0UP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 16:15:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58298 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbhJ0UPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 16:15:25 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11A69F0892;
        Wed, 27 Oct 2021 16:12:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K1sghF1UpsunRNb6CWhryyLwfnN8M+JqmFN/sY
        JbcQ8=; b=ZR18IcTFxyMfzy1hUCOgHXI1bGkcuQiDJEL93GEBDPSbYApFDsGDQ1
        sNHi52twKotqNQjpoVwGNfUbwAlOxiGMi7cRpEyZoYS9LyIvzT9V5gqcLI+Mi8nw
        7WL9CNPbfnzt9QDdU2rUPqg5/C4AX4R6DZyBXBNrslHvJoNMfyfAQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 09AE2F0891;
        Wed, 27 Oct 2021 16:12:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6BE16F0890;
        Wed, 27 Oct 2021 16:12:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Alex Riesen <alexander.riesen@cetitec.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] Fix "commit-msg" hook unexpectedly called for "git pull
 --no-verify"
References: <YXfwanz3MynCLDmn@pflmari>
        <YXhwGQOTfD+ypbo8@coredump.intra.peff.net>
Date:   Wed, 27 Oct 2021 13:12:57 -0700
In-Reply-To: <YXhwGQOTfD+ypbo8@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 26 Oct 2021 17:16:09 -0400")
Message-ID: <xmqq8ryew7jq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47531014-3762-11EC-980D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> OK, so we failed to pass through --no-verify, because it got caught as a
> prefix of --verify-signatures, since the outer parse-options didn't know
> about it. Makes sense, and I suppose this has been broken since
> 11b6d17801 (pull: pass git-merge's options to git-merge, 2015-06-14).
>
> I was going to ask whether this should be passing through "verify", and
> allowing its "no-" variant, but there is no "--verify" in git-merge.
> Arguably there should be (for consistency and to countermand an earlier
> --no-verify), but that is outside the scope of your fix (sadly if
> somebody does change that, they'll have to remember to touch this spot,
> too, but I don't think it can be helped).

We do not even have "--verify" in "git commit", because letting the
hooks to interfere is the default, but if we were designing it
today, we probably would add "--verify" to override a "--no-verify"
earlier on the command line, so it is not implausible that people
would want to add "--verify" to "git commit" and "git merge" in the
future.

We can add two hunks, one for builtin/merge.c and another for
builtin/pull.c, to leave a note for future developers and it would
help quite a lot, I would presume.

Thanks.
