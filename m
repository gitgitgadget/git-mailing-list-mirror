Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55164C6FD1D
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 14:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjCWOcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjCWOcG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 10:32:06 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA7823C6C
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 07:32:01 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 507BDCA126A;
        Thu, 23 Mar 2023 10:32:01 -0400 (EDT)
Received: from [IPV6:2600:1700:840:e768:948:2c:9be7:96af] (unknown [IPv6:2600:1700:840:e768:948:2c:9be7:96af])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 16885CC8315;
        Thu, 23 Mar 2023 10:32:01 -0400 (EDT)
Message-ID: <5a6e83e6-c14b-f2bb-5ec1-669ee7d246c8@jeffhostetler.com>
Date:   Thu, 23 Mar 2023 10:32:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 4/4] unpack-trees: take care to propagate the split-index
 flag
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1497.git.1679500859.gitgitgadget@gmail.com>
 <3963d3e542896b9cdf871dc7ea13330ddac87795.1679500859.git.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <3963d3e542896b9cdf871dc7ea13330ddac87795.1679500859.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/22/23 12:00 PM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When copying the `split_index` structure from one index structure to
> another, we need to propagate the `SPLIT_INDEX_ORDERED` flag, too, if it
> is set, otherwise Git might forget to write the shared index when that
> is actually needed.
> 
> It just so _happens_ that in many instances when `unpack_trees()` is
> called, the result causes the shared index to be written anyway, but
> there are edge cases when that is not so.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   unpack-trees.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 90b92114be8..ca5e47c77c0 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1916,6 +1916,8 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>   		 * create a new one.
>   		 */
>   		o->result.split_index = o->src_index->split_index;
> +		if (o->src_index->cache_changed & SPLIT_INDEX_ORDERED)
> +			o->result.cache_changed |= SPLIT_INDEX_ORDERED;

Nice find!

>   		o->result.split_index->refcount++;
>   	} else {
>   		o->result.split_index = init_split_index(&o->result);
