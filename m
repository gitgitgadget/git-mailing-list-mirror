Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF690C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876996162B
	for <git@archiver.kernel.org>; Tue, 11 May 2021 17:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbhEKR3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 13:29:47 -0400
Received: from siwi.pair.com ([209.68.5.199]:60362 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231812AbhEKR3r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 13:29:47 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 65EC73F413A;
        Tue, 11 May 2021 13:28:40 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4FAB63F4139;
        Tue, 11 May 2021 13:28:40 -0400 (EDT)
Subject: Re: [PATCH] tr2: log parent process name
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20210507002908.1495061-1-emilyshaffer@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1cae0717-745b-5e3a-fadc-3966da00d80c@jeffhostetler.com>
Date:   Tue, 11 May 2021 13:28:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20210507002908.1495061-1-emilyshaffer@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/6/21 8:29 PM, Emily Shaffer wrote:
> It can be useful to tell who invoked Git - was it invoked manually by a
> user via CLI or script? By an IDE? Knowing where the Git invocation came
> from can help with debugging to isolate where the problem came from.
> 
> Unfortunately, there's no cross-platform reliable way to gather the name
> of the parent process. If procfs is present, we can use that; otherwise
> we will need to discover the name another way. However, the process ID
> should be sufficient regardless of platform.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
> We briefly discussed hiding this behind a config, internally. However, I
> wanted to include the parent name alongside the cmd_start event, which
> happens very early (maybe before config gathering?).
> 
> Maybe it's better to log the parent_name as its own event, since it
> shouldn't change over the lifetime of the process?
> 
> procfs is very non-portable, though - I think this won't even work on
> MacOS. So I'm curious if anybody has better suggestions for how to do
> this.
> 
>   - Emily


Look at `trace2_collect_process_info()` in `trace2.h` and
`compat/win32/trace2_win32_process_info.c`.

That function is designed to let the process call out to
platform-specific code to do things like getting the name
of the invoking process.

It is called with an enum to indicate when/why it is being
called.

On Windows, I have platform code to get the process ancestry,
the peak VM usage, and whether the process is being debugged.
Two of those were easy....  And all are very platform-specific.

They all generate events of the form:

	trace2_data_*("process", "windows/<something>", ...)

Some of my `t021[012]/` helper scripts exclude "process" category
messages from the output to make the t*.sh tests portable.


To implement a /proc lookup as you have suggested, I would
fixup the Makefile or config.mak.uname to include something
like a "HAVE_..." feature and then use that at the
bottom of trace2.h to declare a trace2_collect_process_info()
function and then have your code in compat/procinfo.c hide
behind my interface.

Your code should emits events of the form:

	trace2_data_*("process", "linux/<something>", ...)

I notice there are several `PROCFS_*` symbols currently defined
in `config.mak.uname` so maybe this should be:

	trace2_data_*("process", "procfs/<something>", ...)

(I'm not sure how similar code for Linux and the various BSD
versions would be.)


Jeff

