Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEC6720248
	for <e@80x24.org>; Fri, 12 Apr 2019 13:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfDLNry (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 09:47:54 -0400
Received: from siwi.pair.com ([209.68.5.199]:45526 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfDLNry (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 09:47:54 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D9A383F408D;
        Fri, 12 Apr 2019 09:47:52 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:5d6b:2c19:6eaf:1844] (unknown [IPv6:2001:4898:8010:0:46a1:2c19:6eaf:1844])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5F7673F404C;
        Fri, 12 Apr 2019 09:47:52 -0400 (EDT)
Subject: Re: [PATCH v3 00/10] trace2: load trace2 settings from system config
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com
References: <pull.169.v2.git.gitgitgadget@gmail.com>
 <pull.169.v3.git.gitgitgadget@gmail.com>
 <xmqqv9zkymzd.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b4236c9b-8fc2-3704-dfcd-ae71962ac6eb@jeffhostetler.com>
Date:   Fri, 12 Apr 2019 09:47:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqv9zkymzd.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/11/2019 10:29 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
[...]
>>       @@ -512,19 +454,28 @@
>>        + */
>>        +/* clang-format off */
>>
>>       ++	[TR2_SYSENV_CFG_PARAM]     = { "GIT_TR2_CONFIG_PARAMS",
>>       ++				       "trace2.configparams" },
>>       ++
>>       ++	[TR2_SYSENV_DST_DEBUG]     = { "GIT_TR2_DST_DEBUG",
>>       ++				       "trace2.destinationdebug" },
>>       ++
>>       ++	[TR2_SYSENV_NORMAL]        = { "GIT_TR2",
>>       ++				       "trace2.normaltarget" },
>>       ++	[TR2_SYSENV_NORMAL_BRIEF]  = { "GIT_TR2_BRIEF",
>>       ++				       "trace2.normalbrief" },
>>       ++
>>       ++	[TR2_SYSENV_EVENT]         = { "GIT_TR2_EVENT",
>>       ++				       "trace2.eventtarget" },
>>       ++	[TR2_SYSENV_EVENT_BRIEF]   = { "GIT_TR2_EVENT_BRIEF",
>>       ++				       "trace2.eventbrief" },
>>       ++	[TR2_SYSENV_EVENT_NESTING] = { "GIT_TR2_EVENT_NESTING",
>>       ++				       "trace2.eventnesting" },
>>       ++
>>       ++	[TR2_SYSENV_PERF]          = { "GIT_TR2_PERF",
>>       ++				       "trace2.perftarget" },
>>       ++	[TR2_SYSENV_PERF_BRIEF]    = { "GIT_TR2_PERF_BRIEF",
>>       ++				       "trace2.perfbrief" },
> 
> 
> With use of designated initializers, the table got a lot cleaner to
> read.  Is the above "format off" still needed (I am a bit curious
> how clang-format wants these entries to look like)?

clang-format suggests getting rid of the extra whitespace on the
lines, so we lose all of the column alignment.  Then it wants to
line-wrap some but not all of the lines.  So it is a bit of a mess
to look at.


> 
>>       ++	if (pid > 999999)
>>       ++		strbuf_addf(&tr2sid_buf, "W%06d", (int)(pid % 1000000));
>>       ++	else
>>       ++		strbuf_addf(&tr2sid_buf, "P%06d", (int)pid);
> 
> I do not think it matters too much, but this is kind-of curious.
> 
> How would the users of the log utilize the distinction between W and
> P?  Do they discard the ones with W when they care about the exact
> process that left the trace entries, or something?  If it's not a
> plausibly useful use pattern (and I do not think it is), I wonder if
> we want to go with only W (i.e. truncated to the lower N digits)
> entries, if you are shooting for a fixed-width output from this
> function.  If you want less chance of collisions, you obviously
> could use hexadecimal to gain back a few more bits.
> 
> After all, if the application does care the PID, that could be in
> the log data itself (i.e. an "start" event can say "my pid is blah").

Right. Ævar suggested adding the full or wrapped PID so that the SID
would be a fixed length.  I stuck with decimal rather than hex because
it's easier to match up a running command with '/usr/bin/ps' output,
but that's no big deal either way.  It might be simpler to just %08lx
it and be done with it.

Jeff

