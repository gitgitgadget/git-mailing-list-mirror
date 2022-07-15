Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FEBC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 17:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiGORiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 13:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiGORis (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 13:38:48 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C939633F
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 10:38:45 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9CEF23F4117;
        Fri, 15 Jul 2022 13:38:44 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1014:b119:7239:9c6d:a761:10fc:c1])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 4AC203F4090;
        Fri, 15 Jul 2022 13:38:44 -0400 (EDT)
Subject: Re: [PATCH] fetch-pack: write effective filter to trace2
To:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
References: <20220715172943.2681492-1-jonathantanmy@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <770e3c15-90ea-7d6c-4854-608c0ad8cbaa@jeffhostetler.com>
Date:   Fri, 15 Jul 2022 13:38:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20220715172943.2681492-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/15/22 1:29 PM, Jonathan Tan wrote:
> Administrators of a managed Git environment (like the one at $DAYJOB)
> might want to quantify the performance change of fetches with and
> without partial clone from the client's point of view. Therefore, log
> the effective filter being sent to the server whenever a fetch (or
> clone) occurs. Note that this is not necessarily the same as what's
> specified on the CLI, because during a fetch, the configured filter is
> used whenever a filter is not specified on the CLI.
> 
> This is implemented for protocol v0, v1, and v2.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>   fetch-pack.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fetch-pack.c b/fetch-pack.c
> index cb6647d657..dec8743bec 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -392,7 +392,10 @@ static int find_common(struct fetch_negotiator *negotiator,
>   	if (server_supports_filtering && args->filter_options.choice) {
>   		const char *spec =
>   			expand_list_objects_filter_spec(&args->filter_options);
> +		trace2_data_string("fetch", the_repository, "fetch/effective-filter", spec);
>   		packet_buf_write(&req_buf, "filter %s", spec);
> +	} else {
> +		trace2_data_string("fetch", the_repository, "fetch/effective-filter", "none");
>   	}
>   	packet_buf_flush(&req_buf);
>   	state_len = req_buf.len;
> @@ -1328,9 +1331,12 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>   		const char *spec =
>   			expand_list_objects_filter_spec(&args->filter_options);
>   		print_verbose(args, _("Server supports filter"));
> +		trace2_data_string("fetch", the_repository, "fetch/effective-filter", spec);
>   		packet_buf_write(&req_buf, "filter %s", spec);
> -	} else if (args->filter_options.choice) {
> -		warning("filtering not recognized by server, ignoring");
> +	} else {
> +		if (args->filter_options.choice)
> +			warning("filtering not recognized by server, ignoring");
> +		trace2_data_string("fetch", the_repository, "fetch/effective-filter", "none");
>   	}
>   
>   	if (server_supports_feature("fetch", "packfile-uris", 0)) {
> 

This looks nice.  Thanks!
Jeff
