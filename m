Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063D3C695
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEB44229
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 13:57:49 -0800 (PST)
Received: (qmail 15207 invoked by uid 109); 10 Nov 2023 21:57:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Nov 2023 21:57:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 964 invoked by uid 111); 10 Nov 2023 21:57:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Nov 2023 16:57:50 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Nov 2023 16:57:47 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/7] chunk-format: introduce `pair_chunk_expect()` helper
Message-ID: <20231110215747.GG2758295@coredump.intra.peff.net>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <cover.1699569246.git.me@ttaylorr.com>
 <af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
 <xmqqedgyw6jv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedgyw6jv.fsf@gitster.g>

On Fri, Nov 10, 2023 at 01:55:48PM +0900, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > +static int pair_chunk_expect_fn(const unsigned char *chunk_start,
> > +				size_t chunk_size,
> > +				void *data)
> > +{
> > +	struct pair_chunk_data *pcd = data;
> > +	if (chunk_size / pcd->record_size != pcd->record_nr)
> > +		return -1;
> > +	*pcd->p = chunk_start;
> > +	return 0;
> > +}
> 
> I know one of the original places did the "divide the whole by
> per-record size and see if it matches the number of records", the
> same as we see above, but the check in the above could also be
> 
> 	if (chunk_size != st_mult(pcd->record_size, pcd->record_nr))
> 		return -1;
> 
> which would also catch the case where chunk_size is not a multiple
> of the record size.  Your conversion of OOFF in midx.c loses this
> protection as the original uses the multiplication-and-compare, but
> the rewrite to call pair_chunk_expect would call the above and
> checks with the truncating-divide-and-compare.
> 
> Does the distinction matter?  I dunno.  If the record/chunk
> alignment is asserted elsewhere, then the distinction should not
> matter, but even if it were, seeing a truncating division used in
> any validation makes my skin tingle.

Yes, the distinction does matter. If pair_chunk_expect_fn() used
st_mult(), then it would die on overflow, rather than returning an
error. For commit-graph files this is propagated up, and we continue the
operation by falling back to the non-graph code. There's a test in t5318
that will fail in this case. See patches 1 and 6 in my series for more
discussion.

One of those patches calls out the truncating division issue, but to
summarize: IMHO this is OK, as what we really want to know is "is it big
enough that we can always ask for NR records of size ELEM", which
division gives us. If we do want to be more precise, but also avoid
die(), we'd need a variant of st_mult() that returns a boolean. I didn't
think it was worth it for this case (but arguably it is something that
would be useful to have in general).

-Peff
