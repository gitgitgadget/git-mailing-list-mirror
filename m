Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE71920966
	for <e@80x24.org>; Wed,  5 Apr 2017 19:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933446AbdDETGW (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Apr 2017 15:06:22 -0400
Received: from siwi.pair.com ([209.68.5.199]:42902 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933995AbdDETGQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2017 15:06:16 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id F0B7C84653;
        Wed,  5 Apr 2017 15:06:14 -0400 (EDT)
Subject: Re: [PATCH v6] read-cache: force_verify_index_checksum
To:     Jeff King <peff@peff.net>
References: <20170405180625.12439-1-git@jeffhostetler.com>
 <20170405180625.12439-2-git@jeffhostetler.com>
 <20170405182533.a5divj63zfkfejui@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <91d35c27-f0e3-0dca-dc87-5ab086e18e59@jeffhostetler.com>
Date:   Wed, 5 Apr 2017 15:06:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170405182533.a5divj63zfkfejui@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/5/2017 2:25 PM, Jeff King wrote:
> On Wed, Apr 05, 2017 at 06:06:25PM +0000, git@jeffhostetler.com wrote:
>
>> ---
>>  builtin/fsck.c  |  1 +
>>  cache.h         |  2 ++
>>  read-cache.c    |  7 +++++++
>>  t/t1450-fsck.sh | 13 +++++++++++++
>>  4 files changed, 23 insertions(+)
>
> This version is delightfully simple. Thanks for sticking with it.
>
>> +test_expect_success 'detect corrupt index file in fsck' '
>> +	cp .git/index .git/index.backup &&
>> +	test_when_finished "mv .git/index.backup .git/index" &&
>> +	echo zzzzzzzz >zzzzzzzz &&
>> +	test_when_finished "rm zzzzzzzz" &&
>> +	git add zzzzzzzz &&
>> +	sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index.yyy &&
>> +	rm .git/index &&
>> +	mv .git/index.yyy .git/index &&
>> +	test_when_finished "rm .git/index" &&
>> +	test_must_fail git fsck --cache
>> +'
>
> I was surprised by the second when-finished "rm". The earlier "mv"
> should be enough to restore everything. I guess you're trying to
> overcome the tendency of "mv" to complain about overwriting on some
> platforms.

Yeah, just being cautious. (I spend a lot of time on Windows.)

>
> But wouldn't that make the first when-finished "mv" potentially a
> problem, if it happens before the "rm .git/index" line?
>
> Perhaps "mv -f" would make it all simpler (ordinarily I'd suggest just
> "git reset --hard", but since we're corrupting the index, it may be
> better not to rely on git for the restore). So maybe just:
>
>   cp .git/index .git/index.backup &&
>   test_when_finished "mv -f .git/index.backup .git/index" &&
>   ...
>
> I think the "rm zzzzzzzz" can go, too. We don't typically worry too much
> about accumulating random files in the working tree. The important thing
> is that the index is restored to a sane state.
>
> -Peff
>

Good point.  Let me take another stab at it.
Thanks
Jeff
