Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C16C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 10:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B93D2089D
	for <git@archiver.kernel.org>; Wed, 27 May 2020 10:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbgE0KwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 06:52:21 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:57814 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbgE0KwV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 06:52:21 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jdtfX-0001Kv-Er; Wed, 27 May 2020 11:52:19 +0100
Subject: Re: [PATCH 4/4] blame: test the -b option, use blank oid for boundary
 commits.
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20200525215751.1735-1-philipoakley@iee.email>
 <20200525215751.1735-5-philipoakley@iee.email>
 <20200527073020.GB4006199@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <aabb67b8-b342-aab9-6213-f7c2d5758719@iee.email>
Date:   Wed, 27 May 2020 11:52:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200527073020.GB4006199@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/05/2020 08:30, Jeff King wrote:
> On Mon, May 25, 2020 at 10:57:51PM +0100, Philip Oakley wrote:
>
>> The sed script removes the last hex digit from boundary commit oids
>> '^hexx msg' -> '^hex  msg' until all leading hex's are gone, finally
>> removing the boundary commit marker.
> Thanks for documenting this, as the sed was rather hard to read:
It was hard to write as well;-) lots of dead ends in the sed language.
>
>> +test_expect_success 'test -b option, blank oid for boundary commits' '
>> +	git blame -b branch1.. -- file >actual &&
>> +	git blame branch1.. -- file >full &&
>> +	sed -e "/^\^/{
>> +		:loop;
>> +		s/^\(\^[0-9a-f]*\)[0-9a-f] \(.*\)/\1  \2/g;
>> +		tloop;
>> +		s/^\^/ /;
>> +	}" full >expected &&
> I wonder if we can make it simpler.
>
> In perl I'd probably just replace the whole string with the equivalent
> number of spaces, like:
>
>   perl -pe 's/^\^\S+/" " x length($&)/e'
I'm not a perl person, so I thought sed might be an easy target but ...
it wasn't.
>
> but I suppose some would consider that pretty magical, too. 
I'd need to look it up!

> It might be
> simpler still to just avoid testing leading whitespace:
>
>    sed 's/^\^[0-9a-f]* *//' <full >expected &&
>    sed 's/^ *//' <actual >actual.stripped &&
>    test_cmp expected actual.stripped
>
> but perhaps the indentation is a useful part of what we're testing.

The code does take care to exactly match indentation, so I felt that the
indentation should be tested.

Philip

