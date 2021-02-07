Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BC7C433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478AB64E3B
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 19:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhBGTwC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 14:52:02 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50965 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhBGTvw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 14:51:52 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D066911A51B;
        Sun,  7 Feb 2021 14:51:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DVi9kT4x2yU4SAT+4Ye0tkABuHQ=; b=gGsPg3
        qO2kZFrCdQ5YU9BROopjGnO3EKu6hP7sA+Aq9/DZVc6SFqrxlalXwFZNdvhaXmJR
        0/a4VIIeS3JJ6zXTOa2iavBjFzNkBI5K84D5yBtBum4aMkLycIbmhRig0xBay6vl
        ETbjoesjMCRSjxtl9lXl3Mbh1g7JRm11rLaM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pvjB8atbxRUVbGOlo6gSXqa+lMt1JtrQ
        Ph7IOho3qEf4dnVVA9TzYDPkSgjX5PhD/xoZxK1maHTyS7+W4fFE1+abWWrN3dNK
        DfKJSV7vr+AC0EBTzh7NCFsDyF4RkHB6S/NN/0lEt45wFFCFA1SImiQKOj9yz4Fg
        NIpg2CZdd/c=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C97F211A51A;
        Sun,  7 Feb 2021 14:51:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C3D4011A517;
        Sun,  7 Feb 2021 14:51:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/3] diffcore-rename: guide inexact rename detection
 based on basenames
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
        <1d941c35076e8d515c8ff7ef01d6b9d8c092aaa9.1612651937.git.gitgitgadget@gmail.com>
        <9fbed0f9-032e-3f99-8467-f8a9cfa2d8f1@gmail.com>
Date:   Sun, 07 Feb 2021 11:51:05 -0800
In-Reply-To: <9fbed0f9-032e-3f99-8467-f8a9cfa2d8f1@gmail.com> (Derrick
        Stolee's message of "Sun, 7 Feb 2021 09:38:37 -0500")
Message-ID: <xmqqsg677j2u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D14C1C2E-697D-11EB-8725-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Before I get too deep into reviewing these patches, I do want
> to make it clear that the speed-up is coming at the cost of
> a behavior change. We are restricting the "best match" search
> to be first among files with common base name (although maybe
> I would use 'suffix'?). If we search for a rename among all
> additions and deletions ending the ".txt" we might find a
> similarity match that is 60% and declare that a rename, even
> if there is a ".txt" -> ".md" pair that has a 70% match.

Yes, my initial reaction to the idea was that "yuck, our rename
detection lost its purity".  diffcore-rename strived to base its
decision purely on content similarity, primarily because it is one
of the oldest part of Git where the guiding principle has always
been that the content is the king.  I think my aversion to the "all
of my neighbors are relocating, so should I move to the same place"
(aka "directory rename") comes from a similar place, but in a sense
this was worse.

At least, until I got over the initial bump.  I do not think the
suffix match is necessarily a bad idea, but it adds more "magically
doing a wrong thing" failure modes (e.g. the ".txt" to ".md" example
would probably have more variants that impact the real life
projects; ".C" vs ".cc" vs ".cxx" vs ".cpp" immediately comes to
mind), and a tool that silently does a wrong thing because it uses
more magic would be a tool that is hard to explain why it did the
wrong thing when it does.

> This could be documented in a test case, to demonstrate that
> we are making this choice explicitly.

Yes.  I wonder if we can solve it by requiring a lot better than
minimum match when trying the "suffix match" first, or something?

Provided if we agree that it is a good idea to insert this between
"exact contents match" and "full matrix", I have one question to
Elijah on what the code does.

To me, it seems that the "full matrix" part still uses the remaining
src and dst candidates fully.  But if "A.txt" and "B.txt" are still
surviving in the src/dst at that stage, shouldn't we be saying that
"no way these can be similar enough---we've checked in the middle
stage where only the ones with the same suffix are considered and
this pair didn't turn into a rename"?

Thanks.
