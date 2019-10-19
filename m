Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 521181F4C0
	for <e@80x24.org>; Sat, 19 Oct 2019 15:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbfJSPZW (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Oct 2019 11:25:22 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:50227 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfJSPZW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Oct 2019 11:25:22 -0400
Received: from [92.30.121.54] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1iLqbX-0000BB-7a; Sat, 19 Oct 2019 16:25:19 +0100
Subject: Re: [PATCH v2 5/9] pack-bitmap: introduce bitmap_walk_contains()
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20191019103531.23274-1-chriscool@tuxfamily.org>
 <20191019103531.23274-6-chriscool@tuxfamily.org>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <dce8e0b5-c4ea-f4f6-6275-1322f2d7200b@iee.email>
Date:   Sat, 19 Oct 2019 16:25:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191019103531.23274-6-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,
can I check one thing?

On 19/10/2019 11:35, Christian Couder wrote:
> From: Jeff King <peff@peff.net>
>
> We will use this helper function in a following commit to
> tell us if an object is packed.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>   pack-bitmap.c | 12 ++++++++++++
>   pack-bitmap.h |  3 +++
>   2 files changed, 15 insertions(+)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 016d0319fc..8a51302a1a 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -826,6 +826,18 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
>   	return 0;
>   }
>   
> +int bitmap_walk_contains(struct bitmap_index *bitmap_git,
> +			 struct bitmap *bitmap, const struct object_id *oid)
> +{
> +	int idx;
Excuse my ignorance here...

For the case on Windows (int/long 32 bit), is this return value 
guaranteed to be less than 2GiB, i.e. not a memory offset?

I'm just thinking ahead to the resolution of the 4GiB file limit issue 
on Git-for-Windows (https://github.com/git-for-windows/git/pull/2179)

> +
> +	if (!bitmap)
> +		return 0;
> +
> +	idx = bitmap_position(bitmap_git, oid);
> +	return idx >= 0 && bitmap_get(bitmap, idx);
> +}
> +
>   void traverse_bitmap_commit_list(struct bitmap_index *bitmap_git,
>   				 show_reachable_fn show_reachable)
>   {
> diff --git a/pack-bitmap.h b/pack-bitmap.h
> index 466c5afa09..6ab6033dbe 100644
> --- a/pack-bitmap.h
> +++ b/pack-bitmap.h
> @@ -3,6 +3,7 @@
>   
>   #include "ewah/ewok.h"
>   #include "khash.h"
> +#include "pack.h"
>   #include "pack-objects.h"
>   
>   struct commit;
> @@ -53,6 +54,8 @@ int reuse_partial_packfile_from_bitmap(struct bitmap_index *,
>   int rebuild_existing_bitmaps(struct bitmap_index *, struct packing_data *mapping,
>   			     kh_oid_map_t *reused_bitmaps, int show_progress);
>   void free_bitmap_index(struct bitmap_index *);
> +int bitmap_walk_contains(struct bitmap_index *,
> +			 struct bitmap *bitmap, const struct object_id *oid);
>   
>   /*
>    * After a traversal has been performed by prepare_bitmap_walk(), this can be
-- 
Philip
