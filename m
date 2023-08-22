Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A2CEE49AB
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 23:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjHVXiW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 19:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjHVXiV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 19:38:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B02CD7
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 16:38:20 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6231E1C5031;
        Tue, 22 Aug 2023 19:38:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LaLh2GX07xa+883tqDPwq9bIiid7+VdqA9M0Eg
        yvMoc=; b=KbBG137A1uJV4yWxCgJ7Y0bsV4vnJjBVlml5u3Xh7rwxzt/uyJ7HB5
        lHxgR3076v/30dZc09TYe2dujF2xhnLozO47a8zbm3MH5LH8dy0McT+FBM7iPFAZ
        t+wmYLoFdoBECVNIi8B2nW6v0CZismUP2qWHvpIkqWhZgNLD1BZ3M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59A9B1C5030;
        Tue, 22 Aug 2023 19:38:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C545B1C502F;
        Tue, 22 Aug 2023 19:38:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 7/7] diff: drop useless "status" parameter from
 diff_result_code()
References: <20230821201358.GA2663749@coredump.intra.peff.net>
        <20230821202046.GG1798590@coredump.intra.peff.net>
Date:   Tue, 22 Aug 2023 16:38:17 -0700
In-Reply-To: <20230821202046.GG1798590@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 21 Aug 2023 16:20:46 -0400")
Message-ID: <xmqq350air6e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F91F6DFE-4144-11EE-BAE0-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Many programs use diff_result_code() to get a user-visible program exit
> code from a diff result (e.g., checking opts.found_changes if
> --exit-code was requested).
>
> This function also takes a "status" parameter, which seems at first
> glance that it could be used to propagate an error encountered when
> computing the diff. But it doesn't work that way:
>
>   - negative values are passed through as-is, but are not appropriate as
>     program exit codes
>
>   - when --exit-code or --check is in effect, we _ignore_ the passed-in
>     status completely. So a failed diff which did not have a chance to
>     set opts.found_changes would erroneously report "success, no
>     changes" instead of propagating the error.
>
> After recent cleanups, neither of these bugs is possible to trigger, as

Here "after recent cleanups" refers to the changes to make them
die() upon seeing an error, instead of using it to call this
function with non-zero in the status parameter?  At least, they were
signaling errors correctly when --exit-code is not in use, but now
all the callers are responsible for exiting with non-zero status to
signal an error even when --exit-code is *not* used.

> every caller just passes in "0". So rather than fixing them, we can
> simply drop the useless parameter instead.

OK.

