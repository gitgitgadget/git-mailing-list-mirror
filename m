Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E75BA1F93C
	for <e@80x24.org>; Mon,  5 Aug 2019 15:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfHEPeP (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 11:34:15 -0400
Received: from siwi.pair.com ([209.68.5.199]:45772 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbfHEPeO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 11:34:14 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D43B13F4088;
        Mon,  5 Aug 2019 11:34:12 -0400 (EDT)
Received: from [IPv6:2600:1700:840:e760:7d97:91ff:d255:c7c7] (unknown [IPv6:2600:1700:840:e760:7d97:91ff:d255:c7c7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AAC6C3F4047;
        Mon,  5 Aug 2019 11:34:12 -0400 (EDT)
Subject: Re: [RFC PATCH v2 2/2] trace2: don't overload target directories
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     stolee@gmail.com
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1564771000.git.steadmon@google.com>
 <a779e272df958702c0df06ab58f1f6d6f8086a30.1564771000.git.steadmon@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b1009a3e-92c6-248c-8d15-f4bb5cc71a11@jeffhostetler.com>
Date:   Mon, 5 Aug 2019 11:34:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <a779e272df958702c0df06ab58f1f6d6f8086a30.1564771000.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/2/2019 6:02 PM, Josh Steadmon wrote:
> trace2 can write files into a target directory. With heavy usage, this
> directory can fill up with files, causing difficulty for
> trace-processing systems.
> 
> This patch adds a config option (trace2.maxFiles) to set a maximum
> number of files that trace2 will write to a target directory. The
> following behavior is enabled when the maxFiles is set to a positive
> integer:
>    When trace2 would write a file to a target directory, first check
>    whether or not the directory is overloaded. A directory is overloaded
>    if there is a sentinel file declaring an overload, or if the number of
>    files exceeds trace2.maxFiles. If the latter, create a sentinel file
>    to speed up later overload checks.
> 
> The assumption is that a separate trace-processing system is dealing
> with the generated traces; once it processes and removes the sentinel
> file, it should be safe to generate new trace files again.
> 
> The default value for trace2.maxFiles is zero, which disables the
> overload check.
> 
> The config can also be overridden with a new environment variable:
> GIT_TRACE2_MAX_FILES.
> 
> Potential future work:
> * Write a message into the sentinel file (should match the requested
>    trace2 output format).
> * Add a performance test to make sure that contention between multiple
>    processes all writing to the same target directory does not become an
>    issue.


This looks much nicer than the V1 version.  Having it be a
real feature rather than a test feature helps.

I don't see anything wrong with this.  I do worry about the
overhead a bit.  If you really have that many files in the
target directory, having every command count them at startup
might be an issue.

As an alternative, you might consider doing something like
this:

[] have an option to make the target directory path expand to
    something like "<path>/yyyymmdd/" and create the per-process
    files as "<path>/yyyymmdd/<sid>".

If there are 0, 1 or 2 directories, logging is enabled.
We assume that the post-processor is keeping up and all is well.
We need to allow 2 so that we continue to log around midnight.

If there are 3 or more directories, logging is disabled.
The post-processor is more than 24 hours behind for whatever
reason.  We assume here that the post-processor will process
and delete the oldest-named directory, so it is a valid measure
of the backlog.

I suggest "yyyymmdd" here for simplicity in this discussion
as daily log rotation is common.  If that's still overloading,
you could make it a longer prefix of the <sid>.  And include
the hour, for example.

I suggest 3 as the cutoff lower bound, because we need to allow
2 for midnight rotation.  But you may want to increase it to
allow for someone to be offline for a long weekend, for example.

Anyway, this is just a suggestion.  It would give you the
throttling, but without the need for every command to count
the contents of the target directory.

And it would still allow your post-processor to operate in
near real-time on the contents of the current day's target
directory or to hang back if that causes too much contention.

Feel free to ignore this :-)

Jeff

