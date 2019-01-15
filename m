Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ECFE1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 17:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732369AbfAORM2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 12:12:28 -0500
Received: from siwi.pair.com ([209.68.5.199]:25793 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729574AbfAORM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 12:12:28 -0500
X-Greylist: delayed 510 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 12:12:27 EST
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 1360C3F40D0;
        Tue, 15 Jan 2019 12:03:57 -0500 (EST)
Received: from [IPv6:2001:4898:6808:13e:11c:9e7c:c322:5d17] (unknown [IPv6:2001:4898:8010:0:ea51:9e7c:c322:5d17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BCE203F4024;
        Tue, 15 Jan 2019 12:03:56 -0500 (EST)
Subject: Re: [PATCH 0/8] WIP: trace2: a new trace facility
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.29.git.gitgitgadget@gmail.com>
 <20190115010528.GJ162110@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <5df8db4b-c772-c202-5f58-58e9498f6bc0@jeffhostetler.com>
Date:   Tue, 15 Jan 2019 12:03:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20190115010528.GJ162110@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/14/2019 8:05 PM, Jonathan Nieder wrote:
> Hi,
> 
> Jeff Hostetler wrote:
> 
>> This patch series contains a new trace2 facility that hopefully addresses
>> the recent trace- and structured-logging-related discussions. The intent is
>> to eventually replace the existing trace_ routines (or to route them to the
>> new trace2_ routines) as time permits.
> 
> I've been running with these patches since last October.  A few
> thoughts:
> 
> I like the API.

Great, thanks.  Hopefully you're getting some good/actionable data from
it.


> The logs are a bit noisy and especially wide.  For my use, the
> function name is not too important since we can get that from the file
> and line number.  Should we have a way to omit some fields, or is that
> for post-processing?

Yes, the events are a little wide and noisy, at least in this draft.

Part of this is to flesh out the trace2 API (which should be relatively
fixed) and make sure we have enough event types to emit useful
information.  This is independent of some of the detail events (like
region/data events within status or index reading/writing). Some of
those detail events might be kept if they're useful or temporary
demonstration events or events you could include in a private build for
a limited period of time.  So some of the noise might be those
demonstration events (stuff that you'd want for testing in a perf view,
but not need archived, for example).

Also, for the events that have a "category" field, I'd eventually
like to have a filter setting to include/omit them.  This is something
like the GIT_TRACE_<name> feature we currently have, but limited to
always writing to the same file.  I had this in an earlier version,
but haven't brought it over yet.

And yes, I have a post-processing step that filters fields and
generates a summary record for each process instance.  My previous
draft tried to do that summary inside the git.exe process and it was
suggested that we move that out, so this version emits the raw data
as it occurs and I get the summary after the fact.  This has turned
out nicely, even if the Trace2 stream is a little noisy.

There are some fields that I'd like to omit from my JSON stream that
I'm not using in my summary, such as the filename and line number.
These got carried along since the PERF view needed them.  I think they
make sense in the PERF view, but not so much in the EVENT view.
I'm filtering them out in my post-processing, but I think we could
just omit them.


> We don't find the JSON easy to parse and would prefer a binary format.

I'm going to have to push back a little on this one.  JSON is easy to
process in PERL, C#, various databases, and etc.  Processing a non-text
format in bash is just asking for pain and suffering.

Can you elaborate on the problems you're having with JSON?

When you say "binary" what kind of binary do you mean?  Is this BSON?
Or are you suggesting protocol buffers?  If the latter, is there a C
binding for that? (Every example I've seen talks about C++.)

In my gvfs-trace2-v4 branch, I've refactored the code and now have
a vtable-like mechanism that allows multiple Trace2 "targets" to be
defined.  See trace2/tr2_tgt_perf.c vs trace2/tr2_tgt_events.c.  The
former generates the GIT_TR2_PERF view and the latter generates the
JSON event view.

You could add a self-contained target vtable that generates a binary
view if you wanted.  (Just let it key off of a different GIT_TR2_
environment variable.)


> When I apply the patches, Git complains about whitespace problems
> (trailing whitespace, etc).
> 
> Aside from that kind of easily correctible issue (trailing
> whitespace), I'd be in favor of taking these patches pretty much as-is
> and making improvements in tree.  Any objections to that, or do you
> have other thoughts on where this should go?
> 
> If that sounds reasonable to you, I can send a clean version of these
> based against current "master".  If I understand correctly, then
> 
>   https://github.com/jeffhostetler/git
> 
> branch
> 
>   gvfs-trace2-v4
> 
> contains some improvements, so as a next step I'd try to extract those
> as incremental patches on top.  What do you think?
> 
> Thanks,
> Jonathan

The gvfs-trace2-v4 version has lots of improvements over the version
I last posted on the mailing list.  We should go with it.

I'm not surprised that there are merge conflicts, since mine is based
upon the recent GVFS release and has some gvfs-specific commits in it.

Let me rebase that branch onto the upstream/master and clean up the
mess and send out another patch set.

Hopefully, I can get that out tomorrow.

Jeff
