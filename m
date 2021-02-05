Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92816C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 489CD64EE8
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 18:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhBEQzy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 11:55:54 -0500
Received: from siwi.pair.com ([209.68.5.199]:20560 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233455AbhBEQtS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 11:49:18 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 335B33F40D9;
        Fri,  5 Feb 2021 13:30:54 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id BC3843F4090;
        Fri,  5 Feb 2021 13:30:53 -0500 (EST)
Subject: Re: [PATCH v2 04/14] pkt-line: optionally skip the flush packet in
 write_packetized_from_buf()
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <pull.766.v2.git.1612208747.gitgitgadget@gmail.com>
 <0832f7d324da643d7a480111d693ff5559c2b7a7.1612208747.git.gitgitgadget@gmail.com>
 <YBkf/KOv+YBZ5hQF@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <352af03f-916f-9104-d2d7-ed7457d37911@jeffhostetler.com>
Date:   Fri, 5 Feb 2021 13:30:53 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YBkf/KOv+YBZ5hQF@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/2/21 4:48 AM, Jeff King wrote:
> On Mon, Feb 01, 2021 at 07:45:37PM +0000, Johannes Schindelin via GitGitGadget wrote:
> 
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> This function currently has only one caller: `apply_multi_file_filter()`
>> in `convert.c`. That caller wants a flush packet to be written after
>> writing the payload.
>>
>> However, we are about to introduce a user that wants to write many
>> packets before a final flush packet, so let's extend this function to
>> prepare for that scenario.
> 
> I think this is a sign that the function is not very well-designed in
> the first place. It seems like the code would be easier to understand
> overall if that caller just explicitly did the flush itself. It even
> already does so in other cases!
> 

I agree.  I'll move flush to the caller and rename the write packetized
function slightly to guard against new callers assuming the old behavior
during the transition.

Jeff


> Something like (untested):
> 
>   convert.c  | 4 ++++
>   pkt-line.c | 4 ----
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/convert.c b/convert.c
> index ee360c2f07..3968ac37b9 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -890,6 +890,10 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>   	if (err)
>   		goto done;
>   
> +	err = packet_flush_gently(process->in);
> +	if (err)
> +		goto done;
> +
>   	err = subprocess_read_status(process->out, &filter_status);
>   	if (err)
>   		goto done;
> diff --git a/pkt-line.c b/pkt-line.c
> index d633005ef7..014520a9c2 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -256,8 +256,6 @@ int write_packetized_from_fd(int fd_in, int fd_out)
>   			break;
>   		err = packet_write_gently(fd_out, buf, bytes_to_write);
>   	}
> -	if (!err)
> -		err = packet_flush_gently(fd_out);
>   	return err;
>   }
>   
> @@ -277,8 +275,6 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
>   		err = packet_write_gently(fd_out, src_in + bytes_written, bytes_to_write);
>   		bytes_written += bytes_to_write;
>   	}
> -	if (!err)
> -		err = packet_flush_gently(fd_out);
>   	return err;
>   }
>   
> 
> -Peff
> 
