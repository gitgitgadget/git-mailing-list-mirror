Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3EA91F667
	for <e@80x24.org>; Sat, 19 Aug 2017 20:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbdHSU67 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Aug 2017 16:58:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58035 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751822AbdHSU66 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2017 16:58:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C51AAABFE9;
        Sat, 19 Aug 2017 16:58:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4MA03qfCvqf51IERbwZ/9uJaoMY=; b=QQ0pk0
        GYuYUlacfsi7ShU1WURycTWR0Iqbwg1kTvfB8NieoRWQmDkjYpci+y37bdqYim51
        FTvGWlfDsHuNQ29FGzkF17Q4uLnXplGWLwgqMczBlz+uMD+a4Ad/gM/q1s4rWM0I
        WhiiunDBwkQ6GRPPGyElp6pkvv0VvoIezl9HE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=G5P9PoEKy2EcXvOM2rxRhbfhZi/PG9XV
        2y+tSl3CkCFEaFnVJvwoPzshFHzu1guxZ9TMMkxZP7HM5nxlguDMFHnhQxu4f/rV
        +BpsrWwUXyCAVTDTQ+D1rapEEXwl6bZOHwqzwP66WDYtLxSrccCvwWsq5oCAhGHE
        LvkwzNera7o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDC6DABFE8;
        Sat, 19 Aug 2017 16:58:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D541ABFE7;
        Sat, 19 Aug 2017 16:58:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Philip Oakley <philipoakley@iee.org>,
        Kevin Willford <kcwillford@gmail.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] progress: simplify "delayed" progress API
References: <20170531150427.7820-1-kewillf@microsoft.com>
        <20170810183256.12668-2-kewillf@microsoft.com>
        <20170810232033.46ujnozvnodkguog@sigill.intra.peff.net>
        <xmqqwp69ycim.fsf@gitster.mtv.corp.google.com>
        <EA124B72FA7542DBA1C31213235F1B94@PhilipOakley>
        <20170813043940.muj7z3dvl3nh4k6a@sigill.intra.peff.net>
        <xmqqpobyw11t.fsf@gitster.mtv.corp.google.com>
        <xmqqshguuhe2.fsf@gitster.mtv.corp.google.com>
        <20170814222947.edvuz7b2hxuwcsqj@sigill.intra.peff.net>
        <xmqqy3qf8nj6.fsf_-_@gitster.mtv.corp.google.com>
Date:   Sat, 19 Aug 2017 13:58:48 -0700
In-Reply-To: <xmqqy3qf8nj6.fsf_-_@gitster.mtv.corp.google.com> (Junio
        C. Hamano's message of "Sat, 19 Aug 2017 10:39:41 -0700")
Message-ID: <xmqqlgmf8ebb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3377F4A8-8521-11E7-AC4A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> We used to expose the full power of the delayed progress API to the
> callers, so that they can specify, not just the message to show and
> expected total amount of work that is used to compute the percentage
> of work performed so far, the percent-threshold parameter P and the
> delay-seconds parameter N.  The progress meter starts to show at N
> seconds into the operation only if the amount of work completed
> exceeds P.

Oops, we inspect the doneness at N seconds and show only if we have
not yet completed P percent of the total work.

Perhaps

	... at N seconds into the operation only if we have not
	completed P per-cent of the total work.

