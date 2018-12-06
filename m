Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B10CF211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 00:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbeLFAWb (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 19:22:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56508 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728799AbeLFAWa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 19:22:30 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C7E6139788;
        Wed,  5 Dec 2018 19:22:28 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wg1bWWHJHPVoaSmrVNZYspxGYXw=; b=vt30Za
        92TN65gZ8f5voXHWB+wvUMxKJGnMpv+HrmQtV5fn5pkv4Kgz4gc43qfciV/LKiyv
        waixLnKeqdC201MWAJs11W+C63JaCCshrkJ5+nSliG3GPOdUktsOfEHtHRdhXO3K
        5AcEkgxFT64h1vIYojt7JZsqaGWJHxD8dyWMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YaLff1QgHuaoML3II4b9zD4Hmq9iFbpy
        ao8yNNVFBEMAOXw2XAulTbbGL49axsu0i5kJL6WRxFbjTLyQSq8XA2eWlpjcIblv
        D35/C6wJ6p8TfNujpwynM7yYGnmdIIAlQQvVvLFw8de9Ls82oqsjiIA0kRYINq61
        7G26EBYC6fI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BFBA839787;
        Wed,  5 Dec 2018 19:22:28 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D771539784;
        Wed,  5 Dec 2018 19:22:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a test repeatedly under load
References: <20181204163457.15717-1-szeder.dev@gmail.com>
        <20181204163457.15717-4-szeder.dev@gmail.com>
        <20181205054408.GE12284@sigill.intra.peff.net>
        <20181205103454.GJ30222@szeder.dev>
        <20181205213625.GD19936@sigill.intra.peff.net>
Date:   Thu, 06 Dec 2018 09:22:23 +0900
In-Reply-To: <20181205213625.GD19936@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 5 Dec 2018 16:36:26 -0500")
Message-ID: <xmqqefavbj28.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01FB2B16-F8ED-11E8-847C-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But the ^C case is interesting. Try running your script under "sh -x"
> and hitting ^C. The signal interrupts the first wait. In my script (or
> yours modified to use a single wait), we then proceed immediately to the
> "exit", and get output from the subshells after we've exited.
>
> But in your script with the loop, the first wait is interrupted, and
> then the _second_ wait (in the second loop iteration) picks up all of
> the exiting processes. The subsequent waits are all noops that return
> immediately, because there are no processes left.
>
> So the right number of waits is either "1" or "2". Looping means we do
> too many (which is mostly a harmless noop) or too few (in the off chance
> that you have only a single job ;) ). So it works out in practice.

Well, if you time your ^C perfectly, no number of waits is right, I
am afraid.  You spawn N processes and while looping N times waiting
for them, you can ^C out of wait before these N processes all die,
no?

> But I think a more clear way to do it is to simply wait in the signal
> trap, to cover the case when our original wait was aborted.

Sounds good.
