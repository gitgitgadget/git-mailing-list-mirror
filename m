Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE873C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 03:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344017AbiBPDFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 22:05:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344000AbiBPDFp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 22:05:45 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D005AFDFAF
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 19:05:34 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E23218E03D;
        Tue, 15 Feb 2022 22:05:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MaxNd0l9e92VgjuI655Fs7xMtUvm187/EwuBth
        ewtIU=; b=WcJG9X2FAe4DmtnbUBHjOlmSYsuy28non/kRe0EZYQaHYEmZzMm8r/
        4B3BtlQct+TLkqKqnVdtjezmynM2E5LpoTTEfRsUy4ApeY0hIn6jMELj7dQVPGXL
        YYBOcnLWjKvysGv4qdyhLI1zc6j+H6agPQiJCGicGBWg1u7kx3Zss=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 762EA18E03C;
        Tue, 15 Feb 2022 22:05:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D414818E03B;
        Tue, 15 Feb 2022 22:05:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH 5/7] sparse-checkout: reject non-cone-mode patterns
 starting with a '#'
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
        <265cbe36b2df5a9a076877fe3ddc3880a64a9217.1644712798.git.gitgitgadget@gmail.com>
        <xmqqsfsl2utb.fsf@gitster.g>
        <CABPp-BEhsp4=dzCkSpyu4Bd7Q=hP1Ec6W09-zX2+N+5_-ytk8A@mail.gmail.com>
        <xmqqr183y5yh.fsf@gitster.g>
        <CABPp-BFymV-bQVfT7u1phO1N8MHu03SfbVa6Q+CDKeJL21Fbwg@mail.gmail.com>
Date:   Tue, 15 Feb 2022 19:05:30 -0800
In-Reply-To: <CABPp-BFymV-bQVfT7u1phO1N8MHu03SfbVa6Q+CDKeJL21Fbwg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 15 Feb 2022 18:23:45 -0800")
Message-ID: <xmqqzgmrv7d1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D5E235C-8ED5-11EC-8348-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> I do not quite get where you are seeing an inconsistency.  Do you
>> mean that it is inconsistent that "# comment" is only allowed in
>> files but not on the command line?
>
> I don't understand what distinction you are trying to make between the
> file or the command line; for non-cone mode, all positional arguments
> to sparse-checkout {add,set} are taken as-is and inserted into the
> $GIT_DIR/info/sparse-checkout file directly.

If so, then '# comment" from the command line would be a valid way
to spell a comment, no?  It sounds like the right thing to do here
is just passing it through to $GIT_DIR/info/sparse-checkout and let
it become comment, instead of warning, \-quoting, or rejecting.

> I don't like just assuming that users are specifying paths rather than
> patterns, when non-cone mode is all about specifying patterns rather
> than paths; it just feels broken to me.

Oh, I don't like such an assumption, either.  If the user gives a
pathspec, we do assume that is a collection of patterns.  If we are
taking patterns from the command line, treating them as patterns is
the right thing to do.  I do not see how that interacts with what a
path or pattern that begins with a pound should be handled, though.
