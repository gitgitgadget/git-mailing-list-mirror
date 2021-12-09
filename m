Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37643C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 22:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhLIWUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:20:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65001 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhLIWUS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:20:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 81305F565E;
        Thu,  9 Dec 2021 17:16:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IrOjiOJoIAn3FxFhUL2nlVvcHSkx/afMWLYuhe
        mWQh4=; b=VbTqbyMTmt40szcbULf8FDN/+HVFo6Jb9GCW2p8OQZCDmZKkMSXuXN
        idmyovsQcT3X4tuwqudYqsgMrjSatf5Y7frkqW8qaGFCcEhjXL1tolKIxCAs9flN
        fAKdKjDg1JK+SJE4DD0ljzXzFr0/Xfjf3FgH0ePjgv/x8SBTSvA0g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 79363F565D;
        Thu,  9 Dec 2021 17:16:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7729F565C;
        Thu,  9 Dec 2021 17:16:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [RFC] fetch: update refs in a single transaction
References: <259de62b26302c10f429d52bec42a8a954bc5ba3.1638886972.git.ps@pks.im>
        <CAP8UFD0Y-2aD6ywRFi49_emxzcLqrfyNpZ29fgsJ0FKc0njYqg@mail.gmail.com>
        <YbEgDBJPuGXQ+2t6@coredump.intra.peff.net>
Date:   Thu, 09 Dec 2021 14:16:41 -0800
In-Reply-To: <YbEgDBJPuGXQ+2t6@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 8 Dec 2021 16:13:48 -0500")
Message-ID: <xmqqtufho246.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0663BC4-593D-11EC-B0C0-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I suspect the surgery needed for the ref-transaction code to allow
> non-atomic updates would be pretty big, though. It involves checking
> every error case to make sure it is safe to continue rather than
> aborting (and munging data structures to mark particular refs as
> "failed, don't do anything further for this one").
>
> So I dunno. All of my analysis assumes the breakdown of user
> expectations I gave above is a reasonable one. There may be others. But
> it seems like the behavior created by just this patch would be very hard
> to explain, and subject to change based on implementation details.

Oh, I should have read your analysis before reacting to the original
message myself ;-)

Yes, current callers of ref-transaction code may have some logic to
decide that it is not even worth telling a proposed change to the
ref API (e.g. non-fast-forward) but that does feel like an
unnecessary implementation detail, and a true "partial transaction"
needs cooperation by the ref-transaction layer.

And when it is done, we do not have to explain anything to the user
beyond what we already do.  The "--atomic" option will make it
all-or-none, and without it, changes to each ref may or may not fail
individually with its own reason, without correlation to the outcome
of the changes to any other refs.  And use of single or multiple
transactions just becomes an implementation detail of non-atomic
updates.
