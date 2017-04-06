Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16BDB209F2
	for <e@80x24.org>; Thu,  6 Apr 2017 13:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934602AbdDFN0U (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 09:26:20 -0400
Received: from siwi.pair.com ([209.68.5.199]:10072 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757082AbdDFN0S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 09:26:18 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 66CBD84642;
        Thu,  6 Apr 2017 09:26:17 -0400 (EDT)
Subject: Re: [PATCH v1 2/2] p0005-status: time status on very large repo
To:     Jonathan Nieder <jrnieder@gmail.com>
References: <20170405195600.54801-1-git@jeffhostetler.com>
 <20170405195600.54801-3-git@jeffhostetler.com>
 <20170405213355.GH8741@aiede.mtv.corp.google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <db545f25-b0a7-2359-e6f5-7a89860c4022@jeffhostetler.com>
Date:   Thu, 6 Apr 2017 09:26:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170405213355.GH8741@aiede.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/5/2017 5:33 PM, Jonathan Nieder wrote:
> Hi,
>
> git@jeffhostetler.com wrote:
>
>> +++ b/t/perf/p0005-status.sh
>> @@ -0,0 +1,70 @@
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
>
> Makes sense.
>
>> +
>> +br_work1=xxx_work1_xxx
>> +
>> +new_dir=xxx_dir_xxx
>> +
>> +## (5, 10, 9) will create 999,999 files.
>> +## (4, 10, 9) will create  99,999 files.
>> +depth=5
>> +width=10
>> +files=9
>> +
>> +export br_work1
>> +
>> +export new_dir
>> +
>> +export depth
>> +export width
>> +export files
>
> Why are these exported?  test_expect_success code (unlike test_per
> code) runs in the same shell as outside, so it doesn't seem necessary.

I'm still trying to grok all of the shell wizardry hidden
in the test_* functions, so some may be novice mistakes here.
However, I couldn't get some of the steps to run in an earlier
draft of it without them.  But I copied this from p0004-read-tree
that I posted in an earlier patch and this version is much simpler
so they may not be necessary here.  I'll double check.

>
>> +
>> +## Inflate the index with thousands of empty files and commit it.
>> +test_expect_success 'inflate the index' '
>> +	git reset --hard &&
>
> What does this line do?

I used update-index to add 1M files and commit it instead of
creating the actual files.  This step causes git to do a full
checkout to populate those 1M files.  The reset --hard is
faster than doing "git checkout HEAD".

>
>> +	git branch $br_work1 &&
>> +	git checkout $br_work1 &&
>
> Is it useful for these parameters to exist in the test script?  I'd
> find this easier to read if it named the branch explicitly.  For
> example:
>
> 	test_expect_success 'set up large index' '
> 		git checkout -B million &&
> 		# (4, 10, 9) would create 99,999 files.
> 		# (5, 10, 9) creates 999,999 files.
> 		fill_index dir 5 10 9 &&
> 		git commit -m "large commit"
> 	'

I got burned when playing with p3400-rebase.sh where
it uses fixed name branches with somewhat common names
such as "upstream".

And since the test script copies $GIT_BUILD_DIR repo
into the trash-directory.* (which the user can override)
we run the risk of also colliding with "dir" or other
such common-ish names.

So I created the variables and gave them unlikely values
and used them as placeholders in the actual test.  If the
user has a collision, they can change the variable's
initialization in one place and not have to guess what
the usage is in the rest of the script.  (Especially
since the trend here is for the receiving function to
just use $1 and $2 type arguments.)

>
>> +'
>> +
>> +## The number of files in the xxx_work1_xxx branch.
>> +nr_work1=$(git ls-files | wc -l)
>> +export nr_work1
>> +
>> +test_perf "read-tree status work1 ($nr_work1)" '
>> +	git read-tree HEAD &&
>> +	git status
>> +'
>
> Looks reasonable.
>
> Thanks and hope that helps,
> Jonathan
>

I'll send out a cleaned up version (and fix the grammar
thing in the commit message).
Thanks
Jeff
