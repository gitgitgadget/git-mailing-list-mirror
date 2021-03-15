Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CEEC433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 19:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9970164EF9
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 19:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbhCOT5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 15:57:13 -0400
Received: from siwi.pair.com ([209.68.5.199]:40099 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233828AbhCOT46 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 15:56:58 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id A36A83F40B7;
        Mon, 15 Mar 2021 15:56:50 -0400 (EDT)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3CDD93F4096;
        Mon, 15 Mar 2021 15:56:50 -0400 (EDT)
Subject: Re: [PATCH v5 11/12] simple-ipc: add Unix domain socket
 implementation
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <pull.766.v5.git.1615302157.gitgitgadget@gmail.com>
 <f2e3b046cc8f8ad5662f65262810c7414cc1569d.1615302157.git.gitgitgadget@gmail.com>
 <xmqq7dmfzx8q.fsf@gitster.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9e6a041c-0581-73ab-0139-8c6d507075b3@jeffhostetler.com>
Date:   Mon, 15 Mar 2021 15:56:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq7dmfzx8q.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/9/21 7:08 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +/*
>> + * This value was chosen at random.
>> + */
>> +#define WAIT_STEP_MS (50)
> 
> ... and never used.  Is this supposed to be used as the hardcoded
> value 50 below ...
> 

Let me fix that before you move this to "next".
Looks like I just missed that one.


>> +
>> +/*
>> + * Try to connect to the server.  If the server is just starting up or
>> + * is very busy, we may not get a connection the first time.
>> + */
>> +static enum ipc_active_state connect_to_server(
>> +	const char *path,
>> +	int timeout_ms,
>> +	const struct ipc_client_connect_options *options,
>> +	int *pfd)
>> +{
>> +	int wait_ms = 50;
> 
> ... here?
> 
>> +	int k;
>> +
>> +	*pfd = -1;
>> +
>> +	for (k = 0; k < timeout_ms; k += wait_ms) {
>> +		int fd = unix_stream_connect(path, options->uds_disallow_chdir);
>> +
>> +		if (fd != -1) {
>> +			*pfd = fd;
>> +			return IPC_STATE__LISTENING;
>> +		}
>> +
>> +		if (errno == ENOENT) {
>> +			if (!options->wait_if_not_found)
>> +				return IPC_STATE__PATH_NOT_FOUND;
>> +
>> +			goto sleep_and_try_again;
>> +		}
>> + ...
>> +		return IPC_STATE__OTHER_ERROR;
>> +
>> +	sleep_and_try_again:
>> +		sleep_millisec(wait_ms);
> 
> Or, since there is nothing like exponential back-off implemented
> here which may want to modify wait_ms variable, perhaps use the
> constant directly here and where k is incremented?
> 
>> +/*
>> + * A randomly chosen timeout value.
>> + */
>> +#define MY_CONNECTION_TIMEOUT_MS (1000)
> 
> Even if it may have been "randomly chosen", there should be some
> criteria to judge if the value is sensible, right?  IOW, I have a
> suspicion that I would regret if I randomly chose 5 (or 3600000)
> instead of 1000.  How would we figure that 1000 acceptable but not
> 5?
> 
> Perhaps explain that criterion here, e.g. "... value that ought to
> be long enough to establish connection locally as long as the box is
> not loaded unusably heavily" or something?
> 

Will do.  Thanks!
Jeff
