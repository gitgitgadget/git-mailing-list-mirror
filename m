Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD9FC19F2A
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 16:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiHKQvn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 12:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiHKQvS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 12:51:18 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4405CD11B
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 09:24:54 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F06313F42B;
        Thu, 11 Aug 2022 12:24:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NMymMtUbye7fEiTnFabICHd9z2fY2KDzCwRhW4
        zmqPU=; b=sboz43RinfB/0LpEE61HVqJj1TGuxVNmAWgkSMD/VhEIfHCrGLrI2I
        QOKX/Wvp7QyuaIED6wKEKAhzrEzTObraa1di8v2bw6w4dTTg/Q+wW8dqFI9RFrqx
        HMw9dVDnmxaqMkRYxpmdHYzOghMIt6UfySjxI5jZvp6pPhJYj/fdE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3739F13F42A;
        Thu, 11 Aug 2022 12:24:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A30DF13F429;
        Thu, 11 Aug 2022 12:24:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Xavier Morel <xavier.morel@masklinn.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] fsck: downgrade tree badFilemode to "info"
References: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
        <YvQdR3sDqDMCIjIE@coredump.intra.peff.net>
        <xmqqo7wriwfl.fsf@gitster.g>
        <YvS+x35sxXmO5H1h@coredump.intra.peff.net>
Date:   Thu, 11 Aug 2022 09:24:51 -0700
In-Reply-To: <YvS+x35sxXmO5H1h@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 11 Aug 2022 04:33:11 -0400")
Message-ID: <xmqqh72ihhnw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20EF677A-1992-11ED-ABAE-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I agree with the "it was so long ago it does not matter", but for the
> sake of posterity, here's what my digging found:
> ...

That's indeed an ancient history.  Thanks for a funny find.  I
forgot all about the linked list of tree entries.

> Again, probably not important, but it was interesting for me at least to
> see the evolution of the tree code. Most of those changes predate my
> involvement with the code.

Yeah, your name didn't appear in the history leading to the version
with linked list of tree entries, but by the time it was converted
to more modern "update_tree_entry()" interface, you had a handful of
commits already.

The main codepath never cared about zero-padded octal (we used to
use sscanf "%o", and these days get_mode() does it manually), but
there used to be Git implementations that zero-padded the mode
(e.g. "040000") that we need to warn about.  Both in code before and
after 15b5536ee4, we peek into the bytes directly and check '0',
independent from parsing the octal string into 'mode'.  I found that
interesting (no, there is nothing to fix, just a fun read).

Thanks.


