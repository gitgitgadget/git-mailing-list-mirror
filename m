Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC038C433E9
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 14:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B556564F4B
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 14:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbhCDOS1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Mar 2021 09:18:27 -0500
Received: from siwi.pair.com ([209.68.5.199]:59603 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241786AbhCDOSX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Mar 2021 09:18:23 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5240A3F4096;
        Thu,  4 Mar 2021 09:17:42 -0500 (EST)
Received: from ATP-Win2012.bjwce.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 0A16E3F404F;
        Thu,  4 Mar 2021 09:17:41 -0500 (EST)
Subject: Re: [PATCH v4 03/12] pkt-line: (optionally) libify the packet readers
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <e05467def4e158a5f1cfa3aafffdb5c77097859a.1613598529.git.gitgitgadget@gmail.com>
 <xmqqwnuohv4t.fsf@gitster.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6b1ce8c0-0881-77a0-deda-677e34560cc0@jeffhostetler.com>
Date:   Thu, 4 Mar 2021 09:17:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqwnuohv4t.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/3/21 2:53 PM, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
>> @@ -313,6 +316,8 @@ static int get_packet_data(int fd, char **src_buf,
>>   		if (options & PACKET_READ_GENTLE_ON_EOF)
>>   			return -1;
>>   
>> +		if (options & PACKET_READ_NEVER_DIE)
>> +			return error(_("the remote end hung up unexpectedly"));
>>   		die(_("the remote end hung up unexpectedly"));
>>   	}
> 
> This hunk treats READ_NEVER_DIE as a less quiet version of
> GENTRL_ON_EOF, i.e. the new flag allows to continue even after the
> "hung up unexpectedly" condition that usually causes the process to
> die..
> 
>> @@ -355,12 +363,19 @@ enum packet_read_status packet_read_with_status(i
>> ...
>> -	if ((unsigned)len >= size)
>> +	if ((unsigned)len >= size) {
>> +		if (options & PACKET_READ_NEVER_DIE)
>> +			return error(_("protocol error: bad line length %d"),
>> +				     len);
>>   		die(_("protocol error: bad line length %d"), len);
>> +	}
>>   
>>   	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0) {
>>   		*pktlen = -1;
> 
> In the post-context of this hunk, there is this code:
> 
> 	if ((options & PACKET_READ_DIE_ON_ERR_PACKET) &&
> 	    starts_with(buffer, "ERR "))
> 		die(_("remote error: %s"), buffer + 4);
> 
> 	*pktlen = len;
> 	return PACKET_READ_NORMAL;
> 
> But here, there is no way to override the DIE_ON_ERR with
> READ_NEVER_DIE.
> 
> The asymmetry is somewhat annoying (i.e. if "if you do not want to
> die upon ERR, don't pass DIE_ON_ERR" could be a valid suggestion to
> the callers, then "if you do not want to die upon an unexpected
> hung-up, pass GENTLE_ON_EOF" would equally be valid suggestion),
> but I'll let it pass.

I agree that there is something odd about all of these flags,
but I don't have the context on all the various caller combinations
to make a better suggestion at this time.  And I certainly don't
want to stir up a bigger mess than I already have. :-)

We did document in the .h that READ_NEVER_DIE excludes ERR packets
when READ_DIE_ON_ERR is set, so I think we're safe from unexpected
surprises.

> 
>> diff --git a/pkt-line.h b/pkt-line.h
>> index a7149429ac35..2e472efaf2c5 100644
>> --- a/pkt-line.h
>> +++ b/pkt-line.h
>> @@ -75,10 +75,14 @@ int write_packetized_from_buf_no_flush(const char *src_in, size_t len, int fd_ou
>>    *
>>    * If options contains PACKET_READ_DIE_ON_ERR_PACKET, it dies when it sees an
>>    * ERR packet.
>> + *
>> + * With `PACKET_READ_NEVER_DIE`, no errors are allowed to trigger die() (except
>> + * an ERR packet, when `PACKET_READ_DIE_ON_ERR_PACKET` is in effect).
>>    */
>>   #define PACKET_READ_GENTLE_ON_EOF     (1u<<0)
>>   #define PACKET_READ_CHOMP_NEWLINE     (1u<<1)
>>   #define PACKET_READ_DIE_ON_ERR_PACKET (1u<<2)
>> +#define PACKET_READ_NEVER_DIE         (1u<<3)
>>   int packet_read(int fd, char **src_buffer, size_t *src_len, char
>>   		*buffer, unsigned size, int options);
