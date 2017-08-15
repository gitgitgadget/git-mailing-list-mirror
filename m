Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00B0B1F667
	for <e@80x24.org>; Tue, 15 Aug 2017 06:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753394AbdHOG1l (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 02:27:41 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:9545 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753366AbdHOG1j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 02:27:39 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3xWjFh28dnz5tlD;
        Tue, 15 Aug 2017 08:27:36 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id D15A9274;
        Tue, 15 Aug 2017 08:27:35 +0200 (CEST)
Subject: Re: [PATCH] t1002: stop using sum(1)
To:     Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Benoit Lecocq <benoit@openbsd.org>,
        Junio C Hamano <gitster@pobox.com>
References: <9f6e13d3-07ff-1eaa-9453-05ca26a3c1ff@web.de>
 <20170815004546.GA78174@aiede.mtv.corp.google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <53a9a3cd-f814-47a3-cc9b-977f9107614c@kdbg.org>
Date:   Tue, 15 Aug 2017 08:27:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170815004546.GA78174@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.08.2017 um 02:46 schrieb Jonathan Nieder:
> Hi,
> 
> René Scharfe wrote:
> 
>> sum(1) is a command for calculating checksums of the contents of files.
>> It was part of early editions of Unix ("Research Unix", 1972/1973, [1]).
>> cksum(1) appeared in 4.4BSD (1993) as a replacement [2], and became part
>> of POSIX.1-2008 [3].  OpenBSD 5.6 (2014) removed sum(1).
>>
>> We only use sum(1) in t1002 to check for changes in three files.  On
>> MinGW we use md5sum(1) instead.  We could switch to the standard command
>> cksum(1) for all platforms; MinGW comes with GNU coreutils now, which
>> provides sum(1), cksum(1) and md5sum(1).  Use our standard method for
>> checking for file changes instead: test_cmp.
>>
>> It's more convenient because it shows differences nicely, it's faster on
>> MinGW because we have a special implementation there based only on
>> shell-internal commands, it's simpler as it allows us to avoid stripping
>> out unnecessary entries from the checksum file using grep(1), and it's
>> more consistent with the rest of the test suite.
>>
>> We already compare changed files with their expected new contents using
>> diff(1), so we don't need to check with "test_must_fail test_cmp" if
>> they differ from their original state.  A later patch could convert the
>> direct diff(1) calls to test_cmp as well.
>>
>> With all sum(1) calls gone, remove the MinGW-specific implementation
>> from test-lib.sh as well.
>>
>> [1] http://minnie.tuhs.org/cgi-bin/utree.pl?file=V3/man/man1/sum.1
>> [2] http://minnie.tuhs.org/cgi-bin/utree.pl?file=4.4BSD/usr/share/man/cat1/cksum.0
>> [3] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/cksum.html
>> ---
>>   t/t1002-read-tree-m-u-2way.sh | 67 ++++++++++++++++++++++---------------------
>>   t/test-lib.sh                 |  3 --
>>   2 files changed, 35 insertions(+), 35 deletions(-)
> 
> Nicely analyzed.  May we forge your sign-off?
> 
> [...]
>> --- a/t/t1002-read-tree-m-u-2way.sh
>> +++ b/t/t1002-read-tree-m-u-2way.sh
> [...]
>> @@ -132,8 +138,8 @@ test_expect_success \
>>        git ls-files --stage >7.out &&
>>        test_cmp M.out 7.out &&
>>        check_cache_at frotz dirty &&
>> -     sum bozbar frotz nitfol >actual7.sum &&
>> -     if cmp M.sum actual7.sum; then false; else :; fi &&
>> +     test_cmp bozbar.M bozbar &&
>> +     test_cmp nitfol.M nitfol &&
> 
> This one is strange.  What is that '! cmp' trying to check for?
> Does the replacement capture the same thing?
> 
> E.g., does it need a '! test_cmp frotz.M frotz &&' line?

In the context that you stripped a 'diff frotz frotz1' occurs, i.e., a 
check for the expected content of the file whose content changes. 
Together with the new test_cmp lines, the new text is a stricter check 
than we have in the old text.

The patch looks good.

Reviewed-by: Johannes Sixt <j6t@kdbg.org>

-- Hannes
