Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40ADB1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 20:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390202AbfHHUBH (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 16:01:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63751 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbfHHUBH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 16:01:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 050F216C69D;
        Thu,  8 Aug 2019 16:01:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6ZRMYvdEY3uXkMZ0opYFYybeUcE=; b=OADDYy
        yJkfD4eWpa2eQE3eufEXgWpqxWyHoQ9Zzow+BqgZFNXs1IWuo9ClUXuSwVgDP+fm
        U1UhW9XgI6ZvtXdwBA98JDP6sZhvdYwRQWxTRtBnYHFwjVCZ/3FZEI+rRuj6NenY
        zxu/0bbUym3vZuJXWin+wHDK0yy57ijgmjjZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dmCAyNB0VzvIwRW2YNxOWIwcO36U+mF/
        b4fgtld6AwyFn6mNGgAKpziPaAXq1BBDxWaTO7zvqpdASrryRXDZNDPRyZDnj2J5
        X3Lh/gE0Wa7KnR9m8kUuFAkUhwE7+lZObcTJ332Vw4DVN2gXL7MzlIhqd7LTvbki
        EyPgl/lBsOo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EEE6516C69B;
        Thu,  8 Aug 2019 16:01:04 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 555D616C699;
        Thu,  8 Aug 2019 16:01:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 5/7] quote: add sq_quote_argv_pretty_ltrim
References: <pull.298.git.gitgitgadget@gmail.com>
        <pull.298.v2.git.gitgitgadget@gmail.com>
        <5059776248b6686faaff37c97aa63d0212579cd8.1565273938.git.gitgitgadget@gmail.com>
        <xmqqh86rfs70.fsf@gitster-ct.c.googlers.com>
        <7dbee619-2495-6426-b02b-49fd59e4f028@jeffhostetler.com>
Date:   Thu, 08 Aug 2019 13:01:03 -0700
In-Reply-To: <7dbee619-2495-6426-b02b-49fd59e4f028@jeffhostetler.com> (Jeff
        Hostetler's message of "Thu, 8 Aug 2019 15:04:24 -0400")
Message-ID: <xmqqzhkje8ao.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40AD84C6-BA17-11E9-B2FF-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>> That is, "if we are appending to an existing string, have SP to
>> separate the first element from that existing string; treat the
>> remaining elements the same way (if the buffer is empty, there is no
>> point adding SP at the beginning)".
>
> I don't think that would do what we want.

I know that there are current callers of quote_argv_pretty that
either (1) expects that it will always get the leading SP for free,
or (2) has to work the unwanted SP around (basically, the places you
changed from quote_argv_pretty to quote_argv_pretty_ltrim in your
series).  But I wanted to see if we can come up with a single helper
whose behaviour is easy to explain and understand that both existing
and new callers can adopt---and if the resulting codebase becomes
easy to understand and maintain overall.  And if that would give us
the ideal longer term direction.

>> I may have found a long-standing bug in sq_quote_buf_pretty(), by
>> the way.  What does it produce when *src is an empty string of
>> length 0?  It does not add anything to dst, but shouldn't we be
>> adding two single-quotes (i.e. an empty string inside sq pair)?
>
> I would think so.  I did a quick grep and most of the calls looked
> guarded, so I don't think this is urgent.  I'll address this in a
> separate commit shortly.

Thanks.
