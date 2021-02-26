Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81119C433DB
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 19:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4097864EB7
	for <git@archiver.kernel.org>; Fri, 26 Feb 2021 19:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBZTxF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 14:53:05 -0500
Received: from siwi.pair.com ([209.68.5.199]:14225 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229622AbhBZTxE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 14:53:04 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id D2CC43F40F4;
        Fri, 26 Feb 2021 14:52:22 -0500 (EST)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 9B84A3F40DA;
        Fri, 26 Feb 2021 14:52:22 -0500 (EST)
Subject: Re: [PATCH v4 01/12] pkt-line: eliminate the need for static buffer
 in packet_write_gently()
To:     Jeff King <peff@peff.net>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <2d6858b1625aa3c96688c6c6a9157c2d2b16f43e.1613598529.git.gitgitgadget@gmail.com>
 <YDihb2Kspbh4FIlW@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9304ac66-f493-2150-95e3-15303c914ee3@jeffhostetler.com>
Date:   Fri, 26 Feb 2021 14:52:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YDihb2Kspbh4FIlW@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/26/21 2:21 AM, Jeff King wrote:
> On Wed, Feb 17, 2021 at 09:48:37PM +0000, Jeff Hostetler via GitGitGadget wrote:
> 
>> Change the API of `write_packetized_from_fd()` to accept a scratch space
>> argument from its caller to avoid similar issues here.
> 
> OK, but...
> 
>> diff --git a/convert.c b/convert.c
>> index ee360c2f07ce..41012c2d301c 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -883,9 +883,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>>   	if (err)
>>   		goto done;
>>   
>> -	if (fd >= 0)
>> -		err = write_packetized_from_fd(fd, process->in);
>> -	else
>> +	if (fd >= 0) {
>> +		struct packet_scratch_space scratch;
>> +		err = write_packetized_from_fd(fd, process->in, &scratch);
>> +	} else
>>   		err = write_packetized_from_buf(src, len, process->in);
> 
> Isn't this just putting the buffer onto the stack anyway? Your
> scratch_space struct is really just a big array. You'd want to make
> it static here, but then we haven't really solved anything. :)

Yeah, I was letting the caller decide how to provide the buffer.
They could put it on the stack or allocate it once across a whole
set of files or use a static buffer -- the caller has context for
what works best that we don't have here.  For example, the caller
may know that is not in threaded code at all, but we cannot assume
that here.

> 
> I think instead that:
> 
>> -int write_packetized_from_fd(int fd_in, int fd_out)
>> +int write_packetized_from_fd(int fd_in, int fd_out,
>> +			     struct packet_scratch_space *scratch)
>>   {
>> -	static char buf[LARGE_PACKET_DATA_MAX];
>>   	int err = 0;
>>   	ssize_t bytes_to_write;
>>   
>>   	while (!err) {
>> -		bytes_to_write = xread(fd_in, buf, sizeof(buf));
>> +		bytes_to_write = xread(fd_in, scratch->buffer,
>> +				       sizeof(scratch->buffer));
>>   		if (bytes_to_write < 0)
>>   			return COPY_READ_ERROR;
>>   		if (bytes_to_write == 0)
>>   			break;
>> -		err = packet_write_gently(fd_out, buf, bytes_to_write);
>> +		err = packet_write_gently(fd_out, scratch->buffer,
>> +					  bytes_to_write);
>>   	}
> 
> ...just heap-allocating the buffer in this function would be fine. It's
> one malloc for the whole sequence of pktlines, which is unlikely to be a
> problem.

Right, I think it would be fine to malloc it here, but I didn't
want to assume that everyone would think that.

I'll change it.

Thanks
Jeff

