Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D6720966
	for <e@80x24.org>; Mon, 10 Apr 2017 13:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753259AbdDJNek (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 09:34:40 -0400
Received: from siwi.pair.com ([209.68.5.199]:64506 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752939AbdDJNei (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 09:34:38 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B68BB84499;
        Mon, 10 Apr 2017 09:34:37 -0400 (EDT)
Subject: Re: [PATCH v7 2/3] p0004-read-tree: perf test to time read-tree
To:     Jeff King <peff@peff.net>
References: <20170407212047.64950-1-git@jeffhostetler.com>
 <20170407212047.64950-3-git@jeffhostetler.com>
 <20170408103614.w6xhbdbslonwcr65@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8430c0bf-9330-302b-d3d2-ef3611393d36@jeffhostetler.com>
Date:   Mon, 10 Apr 2017 09:34:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170408103614.w6xhbdbslonwcr65@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/8/2017 6:36 AM, Jeff King wrote:
> On Fri, Apr 07, 2017 at 09:20:46PM +0000, git@jeffhostetler.com wrote:
>
>> diff --git a/t/perf/p0004-read-tree.sh b/t/perf/p0004-read-tree.sh
>> new file mode 100755
>> index 0000000..a70e969
>
> I think p0004 is taken by your lazy-init-name-hash script already
> (which, btw, I think is missing its executable bit).
>
>> +## usage: dir depth width files
>> +fill_index() {
>> +	awk -v arg_dir=$1 -v arg_depth=$2 -v arg_width=$3 -v arg_files=$4 '
>> +		function make_paths(dir, depth, width, files, f, w) {
>> +			for (f = 1; f <= files; f++) {
>> +				print dir "/file" f
>> +			}
>> +			if (depth > 0) {
>> +				for (w = 1; w <= width; w++) {
>> +					make_paths(dir "/dir" w, depth - 1, width, files)
>> +				}
>> +			}
>> +		}
>> +		END { make_paths(arg_dir, arg_depth, arg_width, arg_files) }
>> +' </dev/null |
>> +	sed "s/^/100644 $EMPTY_BLOB	/" |
>> +	git update-index --index-info
>> +	return 0
>> +}
>
> I saw some discussion earlier on testing synthetic versus real
> repositories. The original point of the perf test suite was to find
> performance regressions between versions. So periodically you'd run:
>
>   cd t/perf
>   ./run v2.10.0 HEAD
>
> and make sure that nothing got inexplicably slower. And for that, using
> real repositories is nice, because it's showing real user-impacting
> performance changes, not synthetic benchmarks.
>
> In an ideal world, people run it against their own real repositories and
> can report back to the list when they see a problem. So running the
> whole suite against your monstrous Windows repo would be a nice
> benchmark to do periodically (I shudder to think how long it might take
> to run, though).
>
> Of course, perf scripts are also a nice way to show off your
> improvements. And synthetic repos can often exaggerate the improvement
> (which is sometimes good to see changes, but also sometimes bad if
> real-world repos don't show the improvement). And they also serve as a
> reproduction case for people who don't necessarily have access to the
> extreme repo that motivated the test in the first place.
>
> But one side effect of writing the perf test the way you have it here is
> that you _can't_ easily run it against a real repo. I think the perf
> suite could provide better tools for this. You can already say "run this
> test against repo X" with GIT_PERF_REPO. But there's no way to say
> "create a synthetic repo with parameters X,Y,Z, and run against that".
>
> IOW, I think rather than having the perf-scripts themselves create the
> synthetic repo, we should have a _library_ of synthetic repos that the
> test-runners can choose from. I'm imagining a world where your repo
> setup goes into t/perf/repos/many-files.sh (which could even take your
> depth, width, and files parameters to allow experimenting), and then you
> could run "GIT_PERF_REPO=many-files ./p0004-read-tree.sh".

Agreed, both types of repos have value.  We've also been discussing
internally the need for more test repos with specific data shapes.
Whether that is a collection of pre-built repos (like what libgit2
does) or scripts to build and persist them I don't know.

Let me take a stab at that separation.

>
>> +br_base=xxx_base_xxx
>> +br_work1=xxx_work1_xxx
>> +br_work2=xxx_work2_xxx
>> +br_work3=xxx_work3_xxx
>
> FWIW, I really dislike the extra level of indirection here. You still
> have to consistently say $br_base everywhere. Why not just call the
> branch "br_base" in the first place?
>
> My experience has been that debugging tests is much easier when as
> little state is carried in the environment as possible. Because it's
> quite often reasonable to do:
>
>   ./t1234-whatever.sh -v -i
>   cd trash*
>   git cmd-that-failed
>
> where you can pick the final line out from the failed test output. When
> the command involves $br_base, I have to dig into the script to find out
> what's in that variable.
>
> I know that perf tests need less debugging than the regular regression
> tests, but I'd hate to see this pattern get applied liberally.

That makes sense.

Thanks
Jeff

