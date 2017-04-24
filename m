Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89813207BD
	for <e@80x24.org>; Mon, 24 Apr 2017 02:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164385AbdDXC6s (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 22:58:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60822 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1164382AbdDXC6r (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 22:58:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 38D1D7D746;
        Sun, 23 Apr 2017 22:58:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XxxDm8ZOMWxyD8gJOebKPWqxwk0=; b=T9r4nr
        6aeaLEKV58EX8TiHrzNvP9Mlj2YgwmeFNPCZ4FE0XR80fXY1UnCCcO+DjP+BbdK4
        jrMNlKpuUwVE7TNvDGufcxWaQuM0rAvRqrle02reLIqZwiXEZLH/j1VB0Cfj9MrZ
        cBuk3+lxEa9YfNgv4UangIdcqAbJiDsFmkRIk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NOqLB/Tc38FY/KzbOS0AcF3rCtiiOMow
        /XA9sC5Ueyxmid1/w4GUNOD7ksb6Jd0PtvXmN7Pe+Vwbj8FPMfBTxEF5wpP1N33I
        Lt2Q8WBbwG4+1ATZSty5Q5hga3DJRFFR8AhI63RopdpdVdBV+DWJZfZtKtUH8Y4P
        5XT5t15vGIQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2FA087D745;
        Sun, 23 Apr 2017 22:58:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 846B47D744;
        Sun, 23 Apr 2017 22:58:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
        <20170420165230.5951-1-szeder.dev@gmail.com>
        <20170421201527.wdtxhox3p4g35gex@sigill.intra.peff.net>
        <xmqqk26a4q69.fsf@gitster.mtv.corp.google.com>
        <20170424014339.nuh7ixlqudfnftzp@sigill.intra.peff.net>
Date:   Sun, 23 Apr 2017 19:58:44 -0700
In-Reply-To: <20170424014339.nuh7ixlqudfnftzp@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 23 Apr 2017 21:43:40 -0400")
Message-ID: <xmqqwpaa1pgb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE998984-2899-11E7-84D3-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Apr 23, 2017 at 05:14:54PM -0700, Junio C Hamano wrote:
>
>> OK.  I am wondering why we do not do 
>> 
>> 	rm -fr "$TRASH_DIRECTORY"
>> 
>> and do this instead:
>> 
>> 	cd "$(dirname "$remove_trash")" &&
>> 	rm -rf "$(basename "$remove_trash")"
>> 
>> in the original.  It feels somewhat unnatural.
>
> I assumed the "cd" was there because some systems may be unhappy
> removing a directory which is our current working directory. That might
> just be superstition, though.

Ahh, OK, that makes sense.  I forgot about that.

> The use of "basename" in the second does seem superfluous, since the
> trash directory should be the full path (I suspect it wasn't in the
> early days, though).
>
>> So perhaps we can simplify and make it more robust by doing this?
>> [...]
>> +		if test -z "$debug"
>> +		then
>> +			test -d "$TRASH_DIRECTORY" ||
>> +			error "Tests passed but trash directory already removed before test cleanup; aborting"
>> +
>> +			rm -fr "$TRASH_DIRECTORY" ||
>> +			error "Tests passed but test cleanup failed; aborting"
>> +		fi
>
> That looks fine, assuming the answer to the "is the cwd important"
> question is "no".

And I do think the answer would be "yes", unfortunately.  There are
systems that do not even allow a file to be removed while it is
open, so...

