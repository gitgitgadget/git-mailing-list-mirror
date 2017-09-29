Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090F020A10
	for <e@80x24.org>; Fri, 29 Sep 2017 02:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750857AbdI2CNw (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 22:13:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62222 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750826AbdI2CNw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 22:13:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D2191997F1;
        Thu, 28 Sep 2017 22:13:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tL6P51gLOqNrGbj6Dn3awuXKJzo=; b=Pe5BDu
        nqY9c6IiaAt9zTgMgSVzsvHdjP3rMCZ2lJBVs4yLT8XbLHkmCDNt+9sop7hZXybR
        1Ks8f/3nZeALDQHbKRe9s6M87oEF33xaJWbjx6WuN3tEuE755sSsVLmAgSytwxWC
        Lj5YEgPM7pI9kKngbnlFGaAEQfkslpe35nLPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LWffKQ/X29ITqxiMbwIKjxthv459njB1
        tjlkVmDJPjmDXP4ugVGTPLvEoKp0deAL/u7R0Ehcjzi9HFx+guCo7nMzxEDFQj13
        bsa6ShUe4wZf00UFydMzG3CwIQmtinXaBd3qS652AhXg7iAY/mMQhkXkvqFhGhwh
        gqVBaOKbh4I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C9103997F0;
        Thu, 28 Sep 2017 22:13:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 357DB997EF;
        Thu, 28 Sep 2017 22:13:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 00/21] Read `packed-refs` using mmap()
References: <cover.1506325610.git.mhagger@alum.mit.edu>
        <20170925122221.ntbhwvmyvgm4igxk@sigill.intra.peff.net>
Date:   Fri, 29 Sep 2017 11:13:49 +0900
In-Reply-To: <20170925122221.ntbhwvmyvgm4igxk@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 25 Sep 2017 08:22:21 -0400")
Message-ID: <xmqqbmluz1ya.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5ED0F0C-A4BB-11E7-9E9E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Sep 25, 2017 at 09:59:57AM +0200, Michael Haggerty wrote:
>
>> This is v3 of a patch series that changes the reading and caching of
>> the `packed-refs` file to use `mmap()`. Thanks to Stefan, Peff, Dscho,
>> and Junio for their comments about v2. I think I have addressed all of
>> the feedback from v1 [1] and v2 [2].
>> 
>> This version has only minor changes relative to v2:
>> 
>> * Fixed a trivial error in the commit message for patch 08.
>> 
>> * In patch 13:
>> 
>>   * In the commit message, explain the appearance of `MMAP_TEMPORARY`
>>     even though it is not yet treated differently than `MMAP_NONE`.
>> 
>>   * In `Makefile`, don't make `USE_WIN32_MMAP` imply
>>     `MMAP_PREVENTS_DELETE`.
>> 
>>   * Correct the type of a local variable from `size_t` to `ssize_t`.
>
> Thanks, this version addresses all my nits.

Dscho's <alpine.DEB.2.21.1.1709192047450.219280@virtualbox> "does
not seem to break windows" was against the previous round, but it
seems that https://travis-ci.org/git/git/jobs/280305212 passed the
iteration of 'pu' at 044a672 which contained this version, so let's
merge this down to 'next'.

Thanks.
