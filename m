Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF3238DD9
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458192139
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 13:38:14 -0800 (PST)
Received: (qmail 483 invoked by uid 109); 9 Nov 2023 21:38:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 21:38:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14606 invoked by uid 111); 9 Nov 2023 21:38:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 16:38:15 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 16:38:13 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/9] commit-graph: use fanout value for graph size
Message-ID: <20231109213813.GB2728242@coredump.intra.peff.net>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <20231109072435.GF2698043@coredump.intra.peff.net>
 <ZU1NNcP/ARxK6D89@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZU1NNcP/ARxK6D89@nand.local>

On Thu, Nov 09, 2023 at 04:20:53PM -0500, Taylor Blau wrote:

> On Thu, Nov 09, 2023 at 02:24:35AM -0500, Jeff King wrote:
> > @@ -323,7 +320,8 @@ static int graph_read_oid_lookup(const unsigned char *chunk_start,
> >  {
> >  	struct commit_graph *g = data;
> >  	g->chunk_oid_lookup = chunk_start;
> > -	g->num_commits = chunk_size / g->hash_len;
> > +	if (chunk_size / g->hash_len != g->num_commits)
> > +		return error(_("commit-graph OID lookup chunk is the wrong size"));
> >  	return 0;
> >  }
> 
> My understanding is that you need this error message to come from
> graph_read_oid_lookup() in order to pass the "detect incorrect fanout
> final value" test, but I wish that we didn't have to, since having the
> more-or-less duplicate error messages in the latter "reader notices
> fanout/lookup table mismatch" is somewhat unfortunate.

I'm not sure what you mean here. We notice the problem in the reading
code, which is used in turn by the verify code. So both of these tests:

> >  test_expect_success 'detect incorrect fanout final value' '
> >  	corrupt_graph_and_verify $GRAPH_BYTE_FANOUT2 "\01" \
> > -		"oid table and fanout disagree on size"
> > +		"OID lookup chunk is the wrong size"
> >  '
> >
> >  test_expect_success 'detect incorrect OID order' '
> > @@ -850,7 +850,8 @@ test_expect_success 'reader notices too-small oid fanout chunk' '
> >  test_expect_success 'reader notices fanout/lookup table mismatch' '
> >  	check_corrupt_chunk OIDF 1020 "FFFFFFFF" &&
> >  	cat >expect.err <<-\EOF &&
> > -	error: commit-graph oid table and fanout disagree on size
> > +	error: commit-graph OID lookup chunk is the wrong size
> > +	error: commit-graph required OID lookup chunk missing or corrupted
> >  	EOF
> >  	test_cmp expect.err err
> >  '

will see a message regardless of where we put it. Or by "duplicate" did
you mean the two-line:

  > > +   error: commit-graph OID lookup chunk is the wrong size
  > > +   error: commit-graph required OID lookup chunk missing or corrupted

output. That's because our chunk of the return value from read_chunk()
is a bit lazy, and does not distinguish "missing chunk" (where we should
write a string saying so) from errors produced by the callback (where a
more specific error message has already been written). That's true of
all of the read_chunk() callers, including the midx ones.

This is one of the ways that pair_chunk_expect() could do better without
adding a lot of code, because it can check the return value from
read_chunk(). It doesn't help the other cases (like OIDF) that still
have to call read_chunk() themselves, though. Possibly read_chunk()
should just take a flag to indicate that it should complain when the
chunk is missing. And then callers could just do:

  if (read_chunk(cf, id, our_callback, CHUNK_REQUIRED)
	return -1; /* no need to complain; either our_callback() did, or
	              read_chunk() itself */

-Peff
