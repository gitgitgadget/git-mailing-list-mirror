Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8DB71F42B
	for <e@80x24.org>; Thu,  4 Jan 2018 20:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeADUyJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 15:54:09 -0500
Received: from siwi.pair.com ([209.68.5.199]:48749 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752550AbeADUyI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 15:54:08 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id CA4B1844D9;
        Thu,  4 Jan 2018 15:54:07 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5CB3E844C7;
        Thu,  4 Jan 2018 15:54:06 -0500 (EST)
Subject: Re: [PATCH 28/40] pack-objects: don't pack objects in external odbs
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
 <20180103163403.11303-29-chriscool@tuxfamily.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <8de3597a-01bd-a721-fffb-20769701d0af@jeffhostetler.com>
Date:   Thu, 4 Jan 2018 15:54:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180103163403.11303-29-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/3/2018 11:33 AM, Christian Couder wrote:
> Objects managed by an external ODB should not be put into
> pack files. They should be transfered using other mechanism
> that can be specific to the external odb.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>   builtin/pack-objects.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 6c71552cdf..4ed66c7677 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -28,6 +28,7 @@
>   #include "argv-array.h"
>   #include "mru.h"
>   #include "packfile.h"
> +#include "external-odb.h"
>   
>   static const char *pack_usage[] = {
>   	N_("git pack-objects --stdout [<options>...] [< <ref-list> | < <object-list>]"),
> @@ -1026,6 +1027,9 @@ static int want_object_in_pack(const struct object_id *oid,
>   			return want;
>   	}
>   
> +	if (external_odb_has_object(oid->hash))
> +		return 0;
> +

I worry about the performance of this in light of my comments
earlier in the patch series about the expense of building the
"have" sets.

Since we've already checked for a loose object and we are about
to walk thru the local packfiles, so if we don't find it in any
of them, then we don't have it locally.  Only then do we need
to worry about external odbs.

If we don't have it locally, does the caller of this function
have sufficient "promisor" infomation infer that the object
should exist on the promisor remote?   Since you're going to
omit it from the packfile anyway, you don't really need to know
if the remote actually has it.


>   	for (entry = packed_git_mru.head; entry; entry = entry->next) {
>   		struct packed_git *p = entry->item;
>   		off_t offset;
> 

Jeff
