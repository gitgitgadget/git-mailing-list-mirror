Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFDCC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 16:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiFUQvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiFUQvG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 12:51:06 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08FE2AE02
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 09:51:03 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 442C9131872;
        Tue, 21 Jun 2022 12:51:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9q5DiA5H6rWwp8WhvICAUNsM6RiwoA8izcW2Zl
        6VKTw=; b=SB58hqYHUWMtI7jEPvlO5ScrLufDLwr/teowxi1GHGLKSAP4ze9VCx
        ViMe1m2J+eLf0Bm69IKl+3KFck9qx1TelEpOgEBtD7dDaN/sVf0ksrDX/EEG1zHv
        krjAz6gWBiSXlNgK9TqX6KNvLmcC8QVfiOgQ013bpoksvemRoNgDc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A8CD131870;
        Tue, 21 Jun 2022 12:51:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 765A613186F;
        Tue, 21 Jun 2022 12:51:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Richard Oliver <roliver@roku.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH] mktree: do not check type of remote objects
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
        <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
        <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
        <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
        <YqkpRE8nykqVv8cn@nand.local>
        <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
        <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com>
        <xmqqa6adzln6.fsf@gitster.g>
        <1566aed1-a38f-a9ca-241c-21b56d732328@roku.com>
        <xmqqy1xwtsds.fsf@gitster.g>
        <748f39a9-65aa-2110-cf92-7ddf81b5f507@roku.com>
Date:   Tue, 21 Jun 2022 09:51:00 -0700
In-Reply-To: <748f39a9-65aa-2110-cf92-7ddf81b5f507@roku.com> (Richard Oliver's
        message of "Tue, 21 Jun 2022 14:59:39 +0100")
Message-ID: <xmqqwndagdu3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54F5C3F8-F182-11EC-8788-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Richard Oliver <roliver@roku.com> writes:

> As a side note, do you think we need to re-work some uses of the word
> 'missing' in the documentation? Some uses of the word, such as in
> mktree, predate the concept of promisor remotes. The partial-clone.txt
> documentation differentiates between missing "due to a partial clone
> or fetch" and missing "due to repository corruption".  Would making
> such a distinction elsewhere be useful?

I do agree with that direction.  Back when the world was simpler,
there were just "we have the object" and "we ought to have the
object but we do not see it", the latter of which was a clear
repository corruption.  There was no third choice.

With the lazy/partial clone stuff, it is not a corrupted repository
anymore when certain objects that are reachable during traversal is
missing (this is slightly different from a shallow clone in that a
shallow history makes the traversal stop early, so at least objects
in a shallow clone that are reachable during traversal must exist).

So, yes, I think the distinction between "missing but shouldn't be"
and "missing by design" is a good thing to keep in mind.

Thanks.
