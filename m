Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2281620A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 09:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbeLGJH5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 04:07:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:33822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725976AbeLGJH5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 04:07:57 -0500
Received: (qmail 29135 invoked by uid 109); 7 Dec 2018 09:07:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 07 Dec 2018 09:07:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25949 invoked by uid 111); 7 Dec 2018 09:07:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 07 Dec 2018 04:07:26 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Dec 2018 04:07:55 -0500
Date:   Fri, 7 Dec 2018 04:07:55 -0500
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 2/3] commit-graph: fix buffer read-overflow
Message-ID: <20181207090755.GB5167@sigill.intra.peff.net>
References: <cover.1544048946.git.steadmon@google.com>
 <cover.1544127439.git.steadmon@google.com>
 <af45c2337fbe2a59ac95aff3ce90a69d8c30416f.1544127439.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af45c2337fbe2a59ac95aff3ce90a69d8c30416f.1544127439.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 06, 2018 at 12:20:54PM -0800, Josh Steadmon wrote:

> diff --git a/commit-graph.c b/commit-graph.c
> index 07dd410f3c..224a5f161e 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -165,10 +165,20 @@ struct commit_graph *parse_commit_graph(void *graph_map, int fd,
>  	last_chunk_offset = 8;
>  	chunk_lookup = data + 8;
>  	for (i = 0; i < graph->num_chunks; i++) {
> -		uint32_t chunk_id = get_be32(chunk_lookup + 0);
> -		uint64_t chunk_offset = get_be64(chunk_lookup + 4);
> +		uint32_t chunk_id;
> +		uint64_t chunk_offset;
>  		int chunk_repeated = 0;
>  
> +		if (chunk_lookup + GRAPH_CHUNKLOOKUP_WIDTH >
> +		    data + graph_size) {
> +			error(_("chunk lookup table entry missing; graph file may be incomplete"));
> +			free(graph);
> +			return NULL;
> +		}

Is it possible to overflow the addition here? E.g., if I'm on a 32-bit
system and the truncated chunk appears right at the 4GB limit, in which
case we wrap back around? I guess that's pretty implausible, since it
would mean that the mmap is bumping up against the end of the address
space. I didn't check, but I wouldn't be surprised if sane operating
systems avoid allocating those addresses.

But I think you could write this as:

  if (data + graph_size - chunk_lookup < GRAPH_CHUNKLOOKUP_WIDTH)

to avoid overflow (we know that "data + graph_size" is sane because
that's our mmap, and chunk_lookup is somewhere between "data" and "data
+ graph_size", so the result is between 0 and graph_size).

I dunno. I think I've convinced myself it's a non-issue here, but it may
be good to get in the habit of writing these sorts of offset checks in
an overflow-proof order.

-Peff
