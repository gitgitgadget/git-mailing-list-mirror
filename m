Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55A3020248
	for <e@80x24.org>; Wed, 10 Apr 2019 15:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbfDJPFl (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 11:05:41 -0400
Received: from siwi.pair.com ([209.68.5.199]:23141 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732830AbfDJPFk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 11:05:40 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4CF933F4094;
        Wed, 10 Apr 2019 11:05:40 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:8502:dd25:1011:b187] (unknown [IPv6:2001:4898:8010:0:6e38:dd25:1011:b187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 123AB3F4091;
        Wed, 10 Apr 2019 11:05:40 -0400 (EDT)
Subject: Re: [RFC PATCH] pack-objects: write objects packed to trace2
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20190409214420.90898-1-jonathantanmy@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <15ec5048-d062-7011-b207-ad9c8dbe29cd@jeffhostetler.com>
Date:   Wed, 10 Apr 2019 11:05:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190409214420.90898-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/9/2019 5:44 PM, Jonathan Tan wrote:
> This is useful when investigating performance of pushes, and other times
> when no progress information is written (because the pack is written to
> stdout).
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> We're trying to improve push performance, and it would be nice to be
> able to observe the number of objects sent over each push, both to
> correlate it with time taken (which is already traced) and to notice
> situations when significantly more objects are being sent than needed.
> 
> Sending this as an RFC because this patch works but is somewhat ad-hoc -
> perhaps someone else has a more comprehensive solution.
> ---
>   builtin/pack-objects.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index a154fc29f6..ac464d7d07 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -964,6 +964,7 @@ static void write_pack_file(void)
>   	if (written != nr_result)
>   		die(_("wrote %"PRIu32" objects while expecting %"PRIu32),
>   		    written, nr_result);
> +	trace2_printf("packed %d objects", nr_result);

For a simple field like this, you might want to use:

	trace2_data_intmax("pack-objects", the_repository,
			   "write_pack_file/wrote", nr_result);

This will give your message visibility in both the perf and event
targets.  The latter makes it easier for post-processing.

jeff


