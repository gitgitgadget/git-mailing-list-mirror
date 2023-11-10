Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106483588A
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 22:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050E54229
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 14:10:42 -0800 (PST)
Received: (qmail 15457 invoked by uid 109); 10 Nov 2023 22:10:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Nov 2023 22:10:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1099 invoked by uid 111); 10 Nov 2023 22:10:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Nov 2023 17:10:44 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Nov 2023 17:10:41 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] commit-graph: read `OIDL` chunk with
 `pair_chunk_expect()`
Message-ID: <20231110221041.GK2758295@coredump.intra.peff.net>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <cover.1699569246.git.me@ttaylorr.com>
 <5b3c0b99f8052733bb714122582ab229556c94ef.1699569246.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b3c0b99f8052733bb714122582ab229556c94ef.1699569246.git.me@ttaylorr.com>

On Thu, Nov 09, 2023 at 05:34:14PM -0500, Taylor Blau wrote:

> @@ -435,8 +425,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
>  		error(_("commit-graph required OID fanout chunk missing or corrupted"));
>  		goto free_and_return;
>  	}
> -	if (read_chunk(cf, GRAPH_CHUNKID_OIDLOOKUP, graph_read_oid_lookup, graph)) {
> -		error(_("commit-graph required OID lookup chunk missing or corrupted"));
> +	if (pair_chunk_expect(cf, GRAPH_CHUNKID_OIDLOOKUP,
> +			      &graph->chunk_oid_lookup, graph->hash_len,
> +			      graph->num_commits)) {
> +		error(_("commit-graph OID lookup chunk is the wrong size"));
>  		goto free_and_return;

I know the original message was vague, but I think the new one is
actively misleading in the case of a missing chunk. We'll say "wrong
size", but it was not present at all!

-Peff
