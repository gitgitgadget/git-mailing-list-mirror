Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C174201C2
	for <e@80x24.org>; Mon, 13 Mar 2017 11:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752127AbdCMLHs (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 07:07:48 -0400
Received: from aserp1040.oracle.com ([141.146.126.69]:16887 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbdCMLHq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 07:07:46 -0400
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v2DB7bce016480
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2017 11:07:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v2DB7aoq023173
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Mar 2017 11:07:37 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v2DB7Zqh004630;
        Mon, 13 Mar 2017 11:07:35 GMT
Received: from [10.175.235.212] (/10.175.235.212)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Mar 2017 04:07:35 -0700
Subject: Re: [RFC][PATCH] index-pack: add testcases found using AFL
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <20170310151556.18490-1-vegard.nossum@oracle.com>
 <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
 <CACBZZX5fGU9C-z94KbMAs_AegOSGtq8nbrkRe-NxBCHYsDswkA@mail.gmail.com>
 <20170312123212.3rnqyx3dvi5yppk5@sigill.intra.peff.net>
 <xmqq7f3uuzuu.fsf@gitster.mtv.corp.google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <ee3f01f0-2dc1-f919-223c-dad6032fa396@oracle.com>
Date:   Mon, 13 Mar 2017 12:07:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq7f3uuzuu.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/03/2017 19:14, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> One further devil's advocate:
>>
>> If people really _do_ care about coverage, arguably the AFL tests are a
>> pollution of that concept. Because they are running the code, but doing
>> a very perfunctory job of testing it. IOW, our coverage of "code that
>> doesn't segfault or trigger ASAN" is improved, but our coverage of "code
>> that has been tested to be correct" is not (and since the tests are
>> lumped together, it's hard to get anything but one number).
>>
>> So I dunno. I remain on the fence about the patch.
>
> Yeah, I have been disturbed by your earlier remark "binary test
> cases that nobody, not even the author, understands", and the above
> summarizes it more clearly.
>
> Continuously running fuzzer tests on the codebase would have value,
> but how exactly are these fuzzballs generated?  Don't they depend on
> the code being tested?  IOW, how effective is a set of fuzzballs
> that forces the code to take more branches in the current codepath
> for the purpose of testing new code that updates the codepath,
> changing the structure of the codeflow?  Unless a new set of
> fuzzballs to match the updated codeflow is generated, wouldn't the
> test coverage with these fuzzballs erode over time, making them less
> and less useful baggage we carry around, without nobody noticing that
> they no longer are effective to help test coverage?

Yes, the testcases are generated based on the feedback from the
instrumented code, so they are very clearly shaped by the code itself.

However, I think it's more useful to think of these testcases not as
"binary test that nobody knows what they are doing", but as "(sometimes
invalid) packfiles which tickle interesting code paths in the packfile
parser".

With this perspective it becomes clearer that while they were generated
from the code, they also in a sense describe the packfile format itself.

I did a few experiments in changing the code of the packfile reader in
various small ways (e.g. deleting a check, reordering some code) to see
the effects of the testcases found by fuzzing, and I have to admit it
was fairly disappointing. The testcases I added did not catch a single
buggy change, whereas the other testcases did catch many of them.

So I guess you are right -- these testcases are maybe really not that
useful as part of the test suite without explicit comparison between the
expected and actual results.

Forget about the patch, I will just put the testcases in a separate repo
instead. Maybe I will convert some of them into "real" tests.

Thanks, and sorry for the noise.


Vegard
