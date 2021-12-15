Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DC3C433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 16:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhLOQay (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 11:30:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:52442 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244829AbhLOQap (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 11:30:45 -0500
Received: (qmail 17831 invoked by uid 109); 15 Dec 2021 16:30:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Dec 2021 16:30:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5902 invoked by uid 111); 15 Dec 2021 16:30:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Dec 2021 11:30:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Dec 2021 11:30:43 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v2 1/1] upload-pack.c: increase output buffer size
Message-ID: <YboYM7YKcRx1RuJY@coredump.intra.peff.net>
References: <YbizfdGq+RSu9BGe@coredump.intra.peff.net>
 <20211214194626.33814-1-jacob@gitlab.com>
 <20211214194626.33814-2-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211214194626.33814-2-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 14, 2021 at 08:46:26PM +0100, Jacob Vosmaer wrote:

> When serving a fetch, git upload-pack copies data from a git
> pack-objects stdout pipe to its stdout. This commit increases the size
> of the buffer used for that copying from 8192 to 65515, the maximum
> sideband-64k packet size.
> 
> Previously, this buffer was allocated on the stack. Because the new
> buffer size is nearly 64KB, we switch this to a heap allocation.
> 
> On GitLab.com we use GitLab's pack-objects cache which does writes of
> 65515 bytes. Because of the default 8KB buffer size, propagating these
> cache writes requires 8 pipe reads and 8 pipe writes from
> git-upload-pack, and 8 pipe reads from Gitaly (our Git RPC service).
> If we increase the size of the buffer to the maximum Git packet size,
> we need only 1 pipe read and 1 pipe write in git-upload-pack, and 1
> pipe read in Gitaly to transfer the same amount of data. In benchmarks
> with a pure fetch and 100% cache hit rate workload we are seeing CPU
> utilization reductions of over 30%.

Thanks, this patch looks good to me.

>  struct output_state {
> -	char buffer[8193];
> +	/*
> +	 * We do writes no bigger than LARGE_PACKET_DATA_MAX - 1, because with
> +	 * sideband-64k the band designator takes up 1 byte of space. Because
> +	 * relay_pack_data keeps the last byte to itself, we make the buffer 1
> +	 * byte bigger than the intended maximum write size.
> +	 */
> +	char buffer[(LARGE_PACKET_DATA_MAX - 1) + 1];

I don't have an opinion on the "-1 / +1" thing mentioned elsewhere. What
I care much more about is that the comment explains what is going on,
and what you wrote here is easy to understand.

> @@ -269,7 +275,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>  			     const struct string_list *uri_protocols)
>  {
>  	struct child_process pack_objects = CHILD_PROCESS_INIT;
> -	struct output_state output_state = { { 0 } };
> +	struct output_state *output_state = xcalloc(1, sizeof(struct output_state));

I think this hunk is worth doing. As Ævar noted, we do sometimes have
pretty big stack variables elsewhere, so we might have been able to get
away with it here.  But running out of stack can be unpredictable and
annoying. Given how easy and low-cost it is to put it on the heap here,
I'm glad to just do it preemptively.

> @@ -438,11 +444,12 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>  	}
>  
>  	/* flush the data */
> -	if (output_state.used > 0) {
> -		send_client_data(1, output_state.buffer, output_state.used,
> +	if (output_state->used > 0) {
> +		send_client_data(1, output_state->buffer, output_state->used,
>  				 pack_data->use_sideband);
>  		fprintf(stderr, "flushed.\n");
>  	}
> +	free(output_state);
>  	if (pack_data->use_sideband)
>  		packet_flush(1);
>  	return;

There's a "fail:" label just below here. But since it does not return,
and just calls die(), then I agree you don't need to worry about freeing
in that case (and there are no other returns from the function). So this
single free is sufficient.

-Peff
