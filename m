Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E2AC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6635D2225F
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 20:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jDPfyJr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409350AbgJTUGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 16:06:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52109 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409326AbgJTUGV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 16:06:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B33478664C;
        Tue, 20 Oct 2020 16:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ok6ZG8xO9NKuFHtK0pkYtYe+pHc=; b=jDPfyJ
        r4nnfdL0Saw87BaqNi94FuMuRMu9XgmerzVyo/P0hGuq3m4z8PlxVxd663bdfeH1
        wv0pLtzsnY2o2F5rQ6GomioAsqmNY04Kl7oDLmEorLpEPLjKjycHXsyBNNH9EwDp
        HiDa/wydcK85ahOjs4rPUZiPEeapUu6ixcq7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=nJWxb0YzQvKdB62GOyYlc7Qc0n7AiTPH
        dgaeHBM16MNHXRFLDETpx39MGtm7CA9Ah35bYSnF7tEr0D5y2C6vejrODK2II9er
        /WBedXcQMrMAORAE8IFO66pvlfQecpmLd1f40ht+nRArioSf50Vvc8V3r8RCm/ah
        uB4hbLYTUGw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAD3C8664B;
        Tue, 20 Oct 2020 16:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 256A786649;
        Tue, 20 Oct 2020 16:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] apply: when -R, also reverse list of sections
References: <xmqqy2ktk11t.fsf@gitster.c.googlers.com>
        <20201020191206.104924-1-jonathantanmy@google.com>
Date:   Tue, 20 Oct 2020 13:06:19 -0700
In-Reply-To: <20201020191206.104924-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 20 Oct 2020 12:12:06 -0700")
Message-ID: <xmqqeelsbr2c.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8421810-130F-11EB-81EF-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> But I have to wonder if it breaks the support for (arguably outside
>> the Git usecase) input that has more than one patch that touches the
>> same path to blindly reverse the order of all patches
>
> Sorry for getting back to this so late.
>
> The only other case I can think of (besides symlink<->file) is
> directory<->file, and even in that case, I think blindly reversing the
> order still works.
>
> If a more sophisticated rearrangement was needed, I would think that
> even applying the patches in the forward direction (that is, without
> "-R") wouldn't work, since Git is sensitive to the order of the patches.
> So I don't think we need to support such input (since they wouldn't work
> in the forward direction anyway).

I wish you told that to those who added fn_table kludge to apply.c
back when they did so.  They apparently wanted to have a patch that
has more than one "diff --git a/hello.c b/hello.c" that talks about
the same file applied with a single invocation of "git apply".
Perhaps what they did is already broken with "apply -R", and blind
reversal of everything magically makes it work?  Or what they did
already works with "apply -R" and your blind reversal would break,
unless you undo what they did?

>> (instead of
>> the obvious implementation of the fix for the above stated problem
>> --- i.e. make sure the first patch is a deletion of a symlink and
>> what immediately follows is a creation of a regular file, and swap
>> them only in such a case).
>
> This would make patch application more robust, but I still appreciate
> the relative simplicity of the existing approach

I'd rather want to see that we keep the normal cases simple,
i.e. majority parts of a patch with "apply -R" that did *not* have
to futz with the application order will keep what we do, and if
there are tricky cases like typechange diff, only special case them.

Thanks.
