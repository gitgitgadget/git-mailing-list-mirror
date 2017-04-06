Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76F461FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 20:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932089AbdDFU60 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 16:58:26 -0400
Received: from siwi.pair.com ([209.68.5.199]:63033 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752300AbdDFU6X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 16:58:23 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4CA7E8465B;
        Thu,  6 Apr 2017 16:58:22 -0400 (EDT)
Subject: Re: [PATCH v3 2/2] p0005-status: time status on very large repo
To:     Thomas Gummerer <t.gummerer@gmail.com>
References: <20170406134508.31711-1-git@jeffhostetler.com>
 <20170406134508.31711-3-git@jeffhostetler.com> <20170406221453.GA32223@hank>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <590f6863-801b-58e9-3700-962168f8315e@jeffhostetler.com>
Date:   Thu, 6 Apr 2017 16:58:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170406221453.GA32223@hank>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/6/2017 6:14 PM, Thomas Gummerer wrote:
> On 04/06, git@jeffhostetler.com wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>> ---
>>  t/perf/p0005-status.sh | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 61 insertions(+)
>>  create mode 100755 t/perf/p0005-status.sh
>>
>> diff --git a/t/perf/p0005-status.sh b/t/perf/p0005-status.sh
>> new file mode 100755
>> index 0000000..704cebc
>> --- /dev/null
>> +++ b/t/perf/p0005-status.sh
>> @@ -0,0 +1,61 @@
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
>> +
>> +fill_index () {
>> +	make_paths $1 $2 $3 $4 |
>> +	sed "s/^/100644 $EMPTY_BLOB	/" |
>> +	git update-index --index-info
>> +	return 0
>> +}
>> +
>> +br_work1=xxx_work1_xxx
>> +dir_new=xxx_dir_xxx
>> +
>> +## (5, 10, 9) will create 999,999 files.
>> +## (4, 10, 9) will create  99,999 files.
>> +depth=5
>> +width=10
>> +files=9
>> +
>> +## Inflate the index with thousands of empty files and commit it.
>> +## Use reset to actually populate the worktree.
>> +test_expect_success 'inflate the index' '
>> +	git reset --hard &&
>> +	git branch $br_work1 &&
>> +	git checkout $br_work1 &&
>> +	fill_index $dir_new $depth $width $files &&
>> +	git commit -m $br_work1 &&
>> +	git reset --hard
>> +'
>> +
>> +## The number of files in the branch.
>> +nr_work1=$(git ls-files | wc -l)
>
> The above seems to be repeated (or at least very similar to what you
> have in your other series [1].  Especially in this perf test wouldn't
> it be better just use test_perf_large_repo, and let whoever runs the
> test decide what constitutes a large repository for them?
>
> The other advantage of that would be that it is more of a real-world
> scenario, instead of a synthetic distribution of the files, which
> would give us some better results I think.
>
> Is there anything I'm missing that would make using
> test_perf_large_repo not a good option here?

Yes, it is copied from the other series.  I make the same change
that Rene just suggested on it to use awk to create the list.

I did this because I need very large repos.  From what I can tell
the common usage is to set test_perf_large_repo to linux.git, but
that only has 58K files.  And it defaults to git.git which only
has 3K files.

Internally, I test against the Windows source tree with 3.1M files,
but I can't share that :-)

So I created this test to generate artificial, but large and
reproducible repos for evaluation.

I could change the default depth to 4 (giving a 100K tree), but
I'm really interested in 1M+ repos.  For small-ish values of n
the difference between O(n) and O(n log n) operations can hide
in system and I/O noise; not so for very large n....

>
> [1]: http://public-inbox.org/git/20170406163442.36463-3-git@jeffhostetler.com/
>
>> +test_perf "read-tree status work1 ($nr_work1)" '
>> +	git read-tree HEAD &&
>> +	git status
>> +'
>> +
>> +test_done
>> --
>> 2.9.3
>>
