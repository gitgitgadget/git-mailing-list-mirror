Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76053C63777
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 192142086A
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 20:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BPqO/oMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgKXUBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 15:01:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64714 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbgKXUBO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 15:01:14 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08B449BA68;
        Tue, 24 Nov 2020 15:01:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cmDJ0lL49sX2ZVOW1JVCI/ZGglE=; b=BPqO/o
        MsWgelZjnGwtnJikiTr9ob7OccqNk63Mvd0rq37QND7aiXsllCafXTrLW4jmYGfD
        7hKb332NNEeIz3UhtN+M0EZv03Hqjo4wytV/x+i61QgsBiIMmr//q9RbTvwH1m5F
        0QrxZ4Qo0coBsIPn/jfv8tdj9NirQADbD8KU0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CcJs0RF78FH0tQ9scI747W3FNEykMv2g
        4WDPHGNhWwbCqhDYtBDfMXAIGbLxgAA0iBi42yK4P917VODLftfCT5H0POacslno
        rSozAjlyX4VMhzfpUQ2rIsX/QVdyETUCVBNs5HuB/omm7d8a+uvEyR9garhRRgNz
        LGtaqrUlxYU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE2B09BA67;
        Tue, 24 Nov 2020 15:01:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18F379BA66;
        Tue, 24 Nov 2020 15:01:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] refspec: make @ a valid refspec
References: <20201122164641.2091160-1-felipe.contreras@gmail.com>
        <X7y5Wxu1eY4k6753@coredump.intra.peff.net>
Date:   Tue, 24 Nov 2020 12:01:10 -0800
In-Reply-To: <X7y5Wxu1eY4k6753@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 24 Nov 2020 02:42:19 -0500")
Message-ID: <xmqqlfeqjzi1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CC82C8B0-2E8F-11EB-A6C4-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I wondered if there was a good place to mention this in the refspec
> documentation, but it may just be an obvious fallout of the "@ is a
> shortcut for HEAD" definition in gitrevisions(7). The only change is
> that we're resolving the shortcut sooner so that more code can take
> advantage of it.

I too find that "@ is a shortcut for HEAD" looks ugly both at the UI
level and at the implementation level [*1*], but as long as we have
it, it is good to try to be consistent and allow "@" everywhere
where one would write "HEAD" in places where it is syntacitically
infeasible---at least we would be consistently ugly that way ;-).

The title of the change may want to be clarified to help readers of
"git shortlog".  It's not like it is only changing "@" and no other
variants valid refspec, but it forces readers to make sure that the
author did not forget to deal with ":@", "src:@", "@:dst", etc.
"make @ a synonym to HEAD in refspec" or something along the line,
perhaps.


[Footnote]

*1* I shouldn't complain too much, as my own invention to silently
turn "-" given from the command line into "@{-1}" is ugly at the
code level the same way, even though it may be better at the UI
level.
