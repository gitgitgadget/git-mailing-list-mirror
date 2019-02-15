Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63B4F1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 17:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfBORZ3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 12:25:29 -0500
Received: from siwi.pair.com ([209.68.5.199]:29416 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfBORZ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 12:25:29 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 54E1B3F4024;
        Fri, 15 Feb 2019 12:25:28 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 190893F401C;
        Fri, 15 Feb 2019 12:25:28 -0500 (EST)
Subject: Re: [PATCH v6 00/15] Trace2 tracing facility
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Junio C Hamano <gitster@pobox.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
 <pull.108.v6.git.gitgitgadget@gmail.com> <87a7iyk0r8.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0aff8302-371e-cb5e-fe5e-f08e45456559@jeffhostetler.com>
Date:   Fri, 15 Feb 2019 12:25:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <87a7iyk0r8.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/14/2019 7:33 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Feb 06 2019, Jeff Hostetler via GitGitGadget wrote:
> 
>> V6 addresses: [] The remaining hdr-check warning in trace2/tr2_tls.h
>>
>> There are no other outstanding comments that I'm aware of.
> 
> Not a comment on this, just a follow-up question. I started looking into
> whether this could be driven by config instead of getenv(). A lot easier
> to set up in some cases than injecting env variables, especialy if the
> log target supported a strftime() string, is any of that something
> you've looked into already (so I don't do dupe work...).
> 
> There's the chicken & egg problem with wanting to do traces way before
> we get to reading config, so I expect that such a facility would need to
> work by always trace record at the beginning until we get far enough to
> write the config, and then either stop and throw away the buffer, or
> write out the existing trace to the configured target, and continue.
> 

Yes, I beat my head against the config settings for quite a while
before settling on using an env var.

I wanted to get the:
() full process elapsed time,
() the full original argv,
() all of the command dispatch, run-dashed, and alias expansion,
() and for my atexit() to run last.
So I hooked into main() before the config is loaded.

In most commands, the config is processed about the same time as
parse_options() is called.  And we have to insert code in
git_default_config() to load my settings.  This happens after all
of the .git dir discovery, "-c" and "-C" processing, alias expansion,
command dispatch and etc.  And the argv received in the cmd_*()
function has been modified.  So we lose some information.  (I tried
this for a while and didn't like the results.)

I also tried using read_early_config() various places, but there
were problems here too.  Too early and the "-c" settings weren't
parsed yet.  And there was an issue about when .git dir was discovered,
so local config settings weren't ready yet.

I also recall having a problem when doing an early iteration with
side effects (or rather the early iteration caused something to be
set that caused the real iteration (in cmd_*()) to short-cut), but
I don't remember the details.

So we have a custom installer that also sets the environment variable
after git is installed and haven't had any problems.


I hesitate to say we should always start allocating a bunch of data
and spinning up the TLS data and etc. before we know if tracing is
wanted.  Just seems expensive for most users.


I could see having a "~/.git_tr2_config" or something similar in
some place like "/etc" that only contained the Trace2 settings.
It would be safe to read very early inside main() and we would not
consider it to be part of the real config.  For example, "git config"
would not know about it.  Then you could enforce a system-wide
setting without any of the env var issues.


WRT the strftime() question, we could either add syntax to the
env var value (or the tr2 config setting) to have some tokens
for that.  I just stuck with absolute pathnames since I started
by copying what was done for GIT_TRACE.

Jeff


