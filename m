Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E160C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6833D6192A
	for <git@archiver.kernel.org>; Tue, 11 May 2021 22:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKWoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 18:44:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58065 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhEKWoS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 18:44:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D420413DA33;
        Tue, 11 May 2021 18:43:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t+85uG+a8NI0WmFInQYFeGr0aUaMaNRehxEdwe
        KiYE0=; b=K5aFsMdPiUbMsLEpH8IhKUZO2nJe/X+Wo1CPsBmg0gKfMahPI/sC60
        W6597uIWd/1n+vTkz/GZaoOgK5d2Ffa3j0VejRmybbYLcPUtTKUVmdPwt4Ipd734
        IiueeZyjci9I069U3xwBFT3EKI5G+N4RVGBIFxlW3Ffd4tLkdq574=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB82B13DA32;
        Tue, 11 May 2021 18:43:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E55113DA31;
        Tue, 11 May 2021 18:43:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v3 4/8] t7300: add testcase showing unnecessary
 traversal into ignored directory
References: <pull.1020.v2.git.git.1620432500.gitgitgadget@gmail.com>
        <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
        <dc3d3f2471410aa55da4dbc8e2747192888bce5f.1620503945.git.gitgitgadget@gmail.com>
        <xmqq7dk7rwcc.fsf@gitster.g>
        <CABPp-BFV6R9GNeZVbiKx_Tazq+6LuBNCzLcsEq63MfG5YD0hFQ@mail.gmail.com>
Date:   Wed, 12 May 2021 07:43:06 +0900
In-Reply-To: <CABPp-BFV6R9GNeZVbiKx_Tazq+6LuBNCzLcsEq63MfG5YD0hFQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 11 May 2021 10:45:56 -0700")
Message-ID: <xmqqsg2sj3id.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 41A9B5A6-B2AA-11EB-8924-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> But to answer your question, the paths we visit are '.', '..', '.git',
> and 'untracked', the first three of which we mark as path_none and
> don't recurse into because of special rules for those paths, and the
> last of which we shouldn't recurse into since it is ignored.

Not a hard requirement, but I wish if we entirely ignored "." and
".." in our code (not just not counting, but making whoever calls
readdir() skip and call it again when it gets "." or "..").

  https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir.html

seems to imply that readdir() may not give "." or ".." (if dot or
dot-dot exists, you are to return them only once, which implies that
it is perfectly OK for dot or dot-dot to be missing).

So dropping the test for number of visited paths would be nicer from
portability's point of view ;-)

Thanks.
