Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25072C4708F
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 05:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 005C46140C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 05:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhFDFN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 01:13:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55277 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhFDFN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 01:13:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8718BD018F;
        Fri,  4 Jun 2021 01:12:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RE3bjx1wdDwptL670vGy1S3KGxZQirW6inXf/j
        WyzJ4=; b=WC+OrvhDeI4mgWCY4SDD7Qsd/1b20K0Se6X67PdZofQktOst2QN7EC
        cW85b/x6s4BxVl1x6efRY4786/w3UZdrctWCwxdvQ7h2lj8pFzV+Deibe5OeWCfw
        om2aWJPIXhD/T1EE9FJYcUS7Vb5ALkJ5EWlS5rce72GVzEk+vWsfw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6EE1ED018D;
        Fri,  4 Jun 2021 01:12:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DD17AD018B;
        Fri,  4 Jun 2021 01:12:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
        <YLfc2+Te7Y3UY+Sm@nand.local>
        <YLfgy94sbmStC0mR@coredump.intra.peff.net>
        <YLfl4jkuwSCiNrrS@nand.local>
        <YLfm8cqY6EjQuhcO@coredump.intra.peff.net>
        <xmqqk0na2yyc.fsf@gitster.g>
        <YLmkI4a4J60KFY2W@coredump.intra.peff.net>
Date:   Fri, 04 Jun 2021 14:12:10 +0900
In-Reply-To: <YLmkI4a4J60KFY2W@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 3 Jun 2021 23:55:15 -0400")
Message-ID: <xmqq7dja2oyd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A952544-C4F3-11EB-99AB-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> One brief aside: I'm still not entirely convinced that NonStop isn't
> violating POSIX. Yes, as Eric noted, fsync() is allowed to return EINTR.
> But should it do so when the signal it got was set up with SA_RESTART?
>
> The sigaction(3posix) page says:
>
>      SA_RESTART   This flag affects the behavior of interruptible functions;
> 		  that is, those specified to fail with errno set to
> 		  [EINTR]. If set, and a function specified as
> 		  interruptible is interrupted by this signal, the
> 		  function shall restart and shall not fail with [EINTR]
> 		  unless otherwise specified. [...]
>
> and I could not find anywhere that it is "otherwise specified" for
> fsync(). Of course, whatever POSIX says, if NonStop needs this
> workaround, we should provide it. But this may explain why we never saw
> it on other systems.

Yeah, I think all of the above makes sense.

> It also means it's less important for this workaround to kick in
> everywhere. But given how low-cost it is, I'm just as happy to avoid
> having a separate knob to enable it.

Yes, any caller who cares about the result of fsync() is willing to
wait, and on a well benaved system, we would never see EINTR so the
loop won't iterate.  Having to carry just a handful of extra bytes
in ICache in a codepath that is not performance critical is probably
an acceptable cost for simpler code.
