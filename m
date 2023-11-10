Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FE13C6AB
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A3244B8
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 14:08:29 -0800 (PST)
Received: (qmail 15399 invoked by uid 109); 10 Nov 2023 22:08:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Nov 2023 22:08:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1064 invoked by uid 111); 10 Nov 2023 22:08:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Nov 2023 17:08:31 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Nov 2023 17:08:28 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] chunk-format: introduce `pair_chunk_expect()` helper
Message-ID: <20231110220828.GI2758295@coredump.intra.peff.net>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <cover.1699569246.git.me@ttaylorr.com>
 <af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>

On Thu, Nov 09, 2023 at 05:34:11PM -0500, Taylor Blau wrote:

> +static int pair_chunk_expect_fn(const unsigned char *chunk_start,
> +				size_t chunk_size,
> +				void *data)
> +{
> +	struct pair_chunk_data *pcd = data;
> +	if (chunk_size / pcd->record_size != pcd->record_nr)
> +		return -1;
> +	*pcd->p = chunk_start;
> +	return 0;
> +}

I think this is taking us backwards in terms of the output the user sees
(see the message I just sent elsewhere in the thread). The user won't be
able to tell the difference between a missing chunk and one with the
wrong size.

And we miss the opportunity to give more details about the expected and
detected sizes of the chunks.

If the two-line error message really bothers you, then...

> +int pair_chunk_expect(struct chunkfile *cf,
> +		      uint32_t chunk_id,
> +		      const unsigned char **p,
> +		      size_t record_size,
> +		      size_t record_nr)
> +{
> +	struct pair_chunk_data pcd = {
> +		.p = p,
> +		.record_size = record_size,
> +		.record_nr = record_nr,
> +	};
> +	return read_chunk(cf, chunk_id, pair_chunk_expect_fn, &pcd);
> +}

...this is where we could take a CHUNK_REQUIRED flag, and so:

  ret = read_chunk(...);
  /* pair_chunk_expect_fn() wrote an error already for other cases */
  if (ret == CHUNK_MISSING)
	error("chunk not found");
  return ret;

And then the callers become a very nice:

  if (pair_chunk_expect(cf, id, &ptr, size, nr, CHUNK_REQUIRED))
	return -1;

You probably would need to pass some kind of string giving more context
for the error messages, though. We can show the chunk id, but the
context of "commit-graph" vs "midx" is important.

-Peff
