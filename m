Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353A412B9E
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DrCxwElK"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE6CA2
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 09:10:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 60D2B1B134A;
	Sat, 14 Oct 2023 12:10:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/NoQ23PW/9VRsWw8xH66dcI0UbimW0uY1v1KYi
	boC0o=; b=DrCxwElKII41QyAkEgphdbZ/btm+2NMfFWjq/WRwSiGqULFyu0g2sR
	c/hhDTK9ca0yXUza8BRXKZIwpb+YG8V3dGX/GH+lYsiVwhFYSEwF1LPDLTWHYHhM
	jCX6mEzrSrkaYn8AWmd0Mn3/Bnp1AY/OucYe1K8muXGzUbJC4lRps=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 585B91B1349;
	Sat, 14 Oct 2023 12:10:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD5211B1348;
	Sat, 14 Oct 2023 12:10:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/8] commit-graph: read `BIDX` chunk with
 `pair_chunk_expect()`
In-Reply-To: <45cac29403e63483951f7766c6da3c022c68d9f0.1697225110.git.me@ttaylorr.com>
	(Taylor Blau's message of "Fri, 13 Oct 2023 15:25:30 -0400")
References: <20231009205544.GA3281950@coredump.intra.peff.net>
	<cover.1697225110.git.me@ttaylorr.com>
	<45cac29403e63483951f7766c6da3c022c68d9f0.1697225110.git.me@ttaylorr.com>
Date: Sat, 14 Oct 2023 09:10:22 -0700
Message-ID: <xmqqcyxhxk0h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2E3FED0C-6AAC-11EE-9C92-25B3960A682E-77302942!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Taylor Blau <me@ttaylorr.com> writes:

> -static int graph_read_bloom_index(const unsigned char *chunk_start,
> -				  size_t chunk_size, void *data)
> -{
> -	struct commit_graph *g = data;
> -	if (chunk_size != g->num_commits * 4) {
> -		warning("commit-graph changed-path index chunk is too small");
> -		return -1;
> -	}
> ...
> @@ -461,8 +449,10 @@ struct commit_graph *parse_commit_graph(struct repo_settings *s,
>  	}
>  
>  	if (s->commit_graph_read_changed_paths) {
> +		if (pair_chunk_expect(cf, GRAPH_CHUNKID_BLOOMINDEXES,
> +				      &graph->chunk_bloom_indexes,
> +				      st_mult(graph->num_commits, 4)) == -1)
> +			warning(_("commit-graph changed-path index chunk is too small (%d)"), graph->num_commits * 4);
>  		read_chunk(cf, GRAPH_CHUNKID_BLOOMDATA,
>  			   graph_read_bloom_data, graph);
>  	}

Overall the series looked sane, but the need for each caller to
supply error messages, when the helper perfectly well knows how many
bytes the caller expected and how many bytes there are avaiable, was
a bit disturbing, as the level of detail given per each caller will
inevitably become uneven.  Even now, some give an error() while
others give a warning(), even though I suspect all of them should be
data errors.

I wonder if it makes sense to stuff the message template in the
pair_chunk_data structure and do

static int pair_chunk_expect_fn(const unsigned char *chunk_start,
				size_t chunk_size,
				void *data)
{
	struct pair_chunk_data *pcd = data;
	if (pcd->expected_size != chunk_size)
		return error(_(pcd->message), pcd->expected_size, chunk_size);
	*pcd->p = chunk_start;
	return 0;
}

