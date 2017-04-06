Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7E461FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 20:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbdDFUlO (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 16:41:14 -0400
Received: from siwi.pair.com ([209.68.5.199]:63386 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbdDFUlN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 16:41:13 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0B7768464D;
        Thu,  6 Apr 2017 16:41:08 -0400 (EDT)
Subject: Re: [PATCH v5 1/4] p0004-read-tree: perf test to time read-tree
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <20170405173809.3098-1-git@jeffhostetler.com>
 <20170405173809.3098-2-git@jeffhostetler.com>
 <6937b76e-9bbf-7ce5-8605-e09f556f8a26@web.de>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6286a37f-aa22-ff70-3127-c417a6920c35@jeffhostetler.com>
Date:   Thu, 6 Apr 2017 16:41:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <6937b76e-9bbf-7ce5-8605-e09f556f8a26@web.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/6/2017 4:20 PM, René Scharfe wrote:
> Am 05.04.2017 um 19:38 schrieb git@jeffhostetler.com:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>  t/perf/p0004-read-tree.sh | 116 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 116 insertions(+)
>>  create mode 100755 t/perf/p0004-read-tree.sh
>>
>> diff --git a/t/perf/p0004-read-tree.sh b/t/perf/p0004-read-tree.sh
>> new file mode 100755
>> index 0000000..5d8bbf5
>> --- /dev/null
>> +++ b/t/perf/p0004-read-tree.sh
>> @@ -0,0 +1,116 @@
>> +#!/bin/sh
>> +
>> +test_description="Tests performance of read-tree"
>> +
>> +. ./perf-lib.sh
>> +
>> +test_perf_default_repo
>> +test_checkout_worktree
>> +
>> +## usage: dir depth width files
>> +make_paths () {
>> +	for f in $(seq $4)
>> +	do
>> +		echo $1/file$f
>> +	done;
>> +	if test $2 -gt 0;
>> +	then
>> +		for w in $(seq $3)
>> +		do
>> +			make_paths $1/dir$w $(($2 - 1)) $3 $4
>> +		done
>> +	fi
>> +	return 0
>> +}
>
> "make_paths xxx_dir_xxx 5 10 9" takes more than a minute for me.
> Providing its results as a file would be quicker but less flexible.
> The following command prints the same result in less than a second.
>
> 	awk -v dir=xxx_dir_xxx -v depth=5 -v width=10 -v files=9 '
>         	function make_paths(dir, depth, width, files,  i)
> 	        {
>         	        for (i = 1; i <= files; i++) {
> 	                        print dir "/file" i
>         	        }
> 	                if (depth > 0) {
>         	                for (i = 1; i <= width; i++) {
> 	                                make_paths(dir "/dir" i, depth - 1, width, files)
>         	                }
>                 	}
> 	        }
> 	        END {make_paths(dir, depth, width, files)}
> 	' </dev/null
>
> It's faster because it avoids calling seq thousands of times.

Very nice!!!  I'll give that a try.  Thanks!

>
>> +
>> +fill_index () {
>> +	make_paths $1 $2 $3 $4 |
>> +	sed "s/^/100644 $EMPTY_BLOB	/" |
>
> You could add the prefix to the script above and avoid this sed call
> as well.
>
> René
>
