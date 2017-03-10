Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16DD91FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933500AbdCJTfD (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:35:03 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:37309 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932789AbdCJTfB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:35:01 -0500
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v2AJYr5Y016583
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2017 19:34:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v2AJYraq002813
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 10 Mar 2017 19:34:53 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id v2AJYpFv023362;
        Fri, 10 Mar 2017 19:34:52 GMT
Received: from [10.175.181.186] (/10.175.181.186)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 10 Mar 2017 11:34:51 -0800
Subject: Re: [RFC][PATCH] index-pack: add testcases found using AFL
To:     Jeff King <peff@peff.net>
References: <20170310151556.18490-1-vegard.nossum@oracle.com>
 <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
Cc:     gitster@pobox.com, git@vger.kernel.org
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <eec5ab2a-7fe7-b47f-8073-a8212a9634f1@oracle.com>
Date:   Fri, 10 Mar 2017 20:34:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170310190641.i7geazhrlmzzfna6@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/03/2017 20:06, Jeff King wrote:
> On Fri, Mar 10, 2017 at 04:15:56PM +0100, Vegard Nossum wrote:
>
>> I've used AFL to generate a corpus of pack files that maximises the edge
>> coverage for 'git index-pack'.
>>
>> This is a supplement to (and not a replacement for) the regular test cases
>> where we know exactly what each test is checking for. These testcases are
>> more useful for avoiding regressions in edge cases or as a starting point
>> for future fuzzing efforts.
>>
>> To see the output of running 'git index-pack' on each file, you can do
>> something like this:
>>
>>   make -C t GIT_TEST_OPTS="--run=34 --verbose" t5300-pack-object.sh
>>
>> I observe the following coverage changes (for t5300 only):
>>
>>   path                  old%  new%    pp
>>   ----------------------------------------
>>   builtin/index-pack.c  74.3  76.6   2.3
>>   pack-write.c          79.8  80.4    .6
>>   patch-delta.c         67.4  81.4  14.0
>>   usage.c               26.6  35.5   8.9
>>   wrapper.c             42.0  46.1   4.1
>>   zlib.c                58.7  64.1   5.4
>
> I'm not sure how I feel about this. More coverage is good, I guess, but
> we don't have any idea what these packfiles are doing, or whether
> index-pack is behaving sanely in the new lines. The most we can say is
> that we tested more lines of code and that nothing segfaulted or
> triggered something like ASAN.
>
> That's something I guess, but I'm not enthused by the idea of just
> dumping a bunch of binary test cases that nobody, not even the author,
> understands.

I understand your concern. This is how I see it:

Negatives:

  - 'make test' takes 1 second longer to run

  - 548K data added to git.git

Positives:

  - regularly exercising more of the code, especially some of the corner
cases which are not caught by the rest of the test suite, possibly
catching bugs in a security-critical bit of git before it makes it into
a release

  - no impact to existing code, everything self-contained in 1 directory

  - giving more people access to the testcases I discovered without
having to repeat the effort of setting up AFL, fixing up SHA1 checksums,
minimising the corpus, running AFL for a week, etc. (each step by itself
is pretty small, but taken altogether I think it's worthwhile not
to have to repeat that).

Then I guess you have to weigh the negatives and positives. For me it's
a clear net win, but others may see it differently.

For sure, I (or somebody else) can go through each testcase and figure
out what it's doing, what it's doing differently from the existing
manual testcases in t5300, and what its expected output should be. It's
not that I couldn't understand what each testcase is doing if I tried,
but I don't think it's worth the effort. I've run everything under
valgrind and the only thing that turned up were some suspicious-looking
allocations (which AFAICT should be safe to ignore because of git's
built-in limits). Otherwise it's mostly hitting sanity checks:

error: inflate: data stream error (incorrect header check)
fatal: pack has 4 unresolved deltas
fatal: pack has bad object at offset 12: delta base offset is out of bound
fatal: invalid tag
...

These are errors you wouldn't see normally and which the existing
testcases don't check for (or not exhaustively or systematically, in any
case).

If somebody were to look at the code and say: "hey, that check looks a
bit off" (which is something I personally do all the time), then being
able to quickly find an input to execute exactly that line of code is
extremely valuable -- and you can do that simply by running the
testcases through gcov.

Anyway, the patch/data is there, use it or don't.


Vegard
