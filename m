Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE804C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 15:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A267D6135A
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 15:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbhGMPSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 11:18:01 -0400
Received: from siwi.pair.com ([209.68.5.199]:51361 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236966AbhGMPSA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 11:18:00 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 295DA3F4806;
        Tue, 13 Jul 2021 11:15:10 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D57EF3F4803;
        Tue, 13 Jul 2021 11:15:09 -0400 (EDT)
Subject: Re: [PATCH v3 17/34] fsmonitor--daemon: define token-ids
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <37fdce5ec3afaa9aae5001c648fced0675dae0c4.1625150864.git.gitgitgadget@gmail.com>
 <87mtr5bpuw.fsf@evledraar.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <f38ed916-cfd8-06b2-43dc-689720a96a6e@jeffhostetler.com>
Date:   Tue, 13 Jul 2021 11:15:08 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87mtr5bpuw.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/1/21 6:58 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Jul 01 2021, Jeff Hostetler via GitGitGadget wrote:
> 
>> +	if (!test_env_value) {
>> +		struct timeval tv;
>> +		struct tm tm;
>> +		time_t secs;
>> +
>> +		gettimeofday(&tv, NULL);
>> +		secs = tv.tv_sec;
>> +		gmtime_r(&secs, &tm);
>> +
>> +		strbuf_addf(&token->token_id,
>> +			    "%"PRIu64".%d.%4d%02d%02dT%02d%02d%02d.%06ldZ",
>> +			    flush_count++,
>> +			    getpid(),
>> +			    tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
>> +			    tm.tm_hour, tm.tm_min, tm.tm_sec,
>> +			    (long)tv.tv_usec);
> 
> Just bikeshedding, but can we have tokens that mostly sort numeric-wise
> by time order? So time at the start, not the flush_count/getpid.

As I described in a rather large comment in the code, tokens are opaque
strings -- without a less-than / greater-than relationship -- just a
random string that the daemon can use (along with a sequence number) to
ensure that a later request is well-defined.

Here I'm using a counter, pid, and date-stamp.  I'd prefer using a GUID
or UUID just to drive that home, but I didn't want to add a new .lib or
.a to the build if not necessary.

Perhaps I should compute this portion as hex(hash(time())) to remove the
temptation to look inside my opaque token ??

> 
> Maybe I'm missing something, but couldn't we just re-use the trace2 SID
> + a more trivial trailer? It would have the nice property that you could
> find the trace2 SID whenever you looked at such a token (could
> e.g. split them by "/" too), and add the tv_usec, flush_count+whatever
> else is needed to make it unique after the "/", no?
> 

I would rather keep Trace2 out of this.  The SID is another opaque
string and I don't want to reach inside it.

Jeff
