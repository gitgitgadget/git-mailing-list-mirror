Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429DEC433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 16:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243EB615E1
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 16:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345572AbhI2QQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 12:16:33 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61885 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345569AbhI2QQc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 12:16:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C4C3E166884;
        Wed, 29 Sep 2021 12:14:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/8voON+lbm7o69ji4tNm+fdO7C/FZdnr4Rf2u/
        m/Vic=; b=KT6XmciPwp+xXSbMhfdCgt5lgqrm7SbZig2c1ONgAZEqNgFGAoJtl5
        ruqIbHw5yMBYLcOSsoq7smoUYe92aaebl3BkZk5DfMuPRjrwv6ufvcB7qjWJkx9/
        vRy8mDcwdPeCYwbnEklOwNaDQvWNfscWSdOGYv3Iad3XX7vNkMLOA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BE6F1166883;
        Wed, 29 Sep 2021 12:14:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1F1C7166882;
        Wed, 29 Sep 2021 12:14:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 2/7] merge-ort: add ability to record conflict messages
 in a file
References: <pull.1080.git.git.1630376800.gitgitgadget@gmail.com>
        <ed71913886e19ccc276b382de707b4bab7834d12.1630376800.git.gitgitgadget@gmail.com>
        <YVOXPTjsp9lrxmS6@coredump.intra.peff.net>
        <CABPp-BEioOUJRd6FSsmsDtYHhUy7xhr4YabdEmVKzkduo4g9TQ@mail.gmail.com>
Date:   Wed, 29 Sep 2021 09:14:47 -0700
In-Reply-To: <CABPp-BEioOUJRd6FSsmsDtYHhUy7xhr4YabdEmVKzkduo4g9TQ@mail.gmail.com>
        (Elijah Newren's message of "Tue, 28 Sep 2021 23:25:20 -0700")
Message-ID: <xmqqr1d7e4ug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EA9736C-2140-11EC-96E3-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> I also don't like how diff.orderFile provides a global ordering of the
> files listed, rather than providing some scheme for relative
> orderings.  That'd either force me to precompute the diff to determine
> all the files that were different so I can list _all_ of them,...

Don't we determine all the files that would be listed in the diff
anyway?  The diffcore pipeline collects all the different filepairs,
matches them up for rename/copy detection, and finally do the output
formatting for each individual filepair.

> So, I'm not so sure about this solution; it feels like it introduces
> bigger holes than the ugly space character it is fixing.
>
>>  - there can be other non-diff data between the individual segments. For
>>    example, "patch" will skip over non-diff lines. And certainly in Git
>>    we have our own custom headers. I'm wondering if we could attach
>>    these annotations to the diff-pair somehow, and then show something
>>    like:
>>
>>      diff --git a/foo.c b/foo.c
>>      index 1234abcd..5678cdef 100644
>>      conflict modify/delete foo.c
>
> A couple things here...
>
> First, I'm not so sure I like the abbreviation here.  Just knowing
> "modify/delete" might be enough in some cases, but I'd rather have the
> full messages that would have been printed to the console...
>
> Second, what about when there are multiple ...
>
> Third, what about the cases where there is no diff, ...

None of the above seems like a problem to me at least from the
presentation and consumption sides.  There is no rule that extended
diff headers has to fit on a 72-char line, cannot use line folding
by inserting LF-SP in the middle of a logical line, and there
already is at least one case we give an extended diff header without
a single line of content change (namely, "chmod +x README").

Thanks.
