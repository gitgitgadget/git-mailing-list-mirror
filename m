Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544C1C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 18:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346558AbiFJSdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 14:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346477AbiFJSdL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 14:33:11 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D4C38DAE
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 11:33:09 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AF52211F155;
        Fri, 10 Jun 2022 14:33:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hVojDV5yM46S7kWmAw4TK9qZuxM8rnbObt6DSS
        +fPa8=; b=e7W23HETJE2jhytVC6zK/me+Eoqv70voXE1f7LPm48W2MweKxto4vj
        HL9C8dNkW3vm/OcgjYnqQbN60qax0DpKmefUYxofTg1wkCWL70NCtsNhzL3EtYZA
        zPyY/6kp86hCYyn/7lHGtzebZB/ZSBjulGdJDwuXRNDY69zQvzZW0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A241C11F154;
        Fri, 10 Jun 2022 14:33:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AC71B11F151;
        Fri, 10 Jun 2022 14:33:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Volker =?utf-8?Q?Wei=C3=9Fmann?= <volker.weissmann@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org
Subject: Re: git bisect outputs list of commits in the wrong order
References: <3352fbbd-d555-fc51-1eac-692fdb5e4ae0@gmx.de>
        <xmqqsfoce8d7.fsf@gitster.g>
        <YqOJQKSH4eTo4cGn@coredump.intra.peff.net>
Date:   Fri, 10 Jun 2022 11:33:04 -0700
In-Reply-To: <YqOJQKSH4eTo4cGn@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 10 Jun 2022 14:11:12 -0400")
Message-ID: <xmqqmteke5cv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C5547CC4-E8EB-11EC-AA5E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Jun 10, 2022 at 10:28:04AM -0700, Junio C Hamano wrote:
>
>> I looked at an "scripted" version in the ancient past and it seems
>> to have computed by iterating over
>> 
>> 	git rev-list bisect/bad --not $good_revs
>> 
>> which would have given these intermediate ones roughly in the
>> reverse chronological order.  It could be that the behaviour
>> regressed when the scripted version was rewritten in C, but I dunno.
>> 
>> Christian (as an "area" expert for bisect), do you have any
>> comments?
>
> It would probably be nice to show them as --oneline, as well. I'd guess
> that a human reading the subjects of a handful of commits could quickly
> make a good guess as to the actual culprit.

True, too.

The scripted version fed the output from above iteration each to
"show-branch" (as "git log --oneline" was probably not so widely
used or may not have been available back then), to make them human
readable.  We should be able to use pretty.c::pretty_print_commit()
with CMT_FMT_ONELINE to do that more easily these days.

By the way, welcome back ;-)


