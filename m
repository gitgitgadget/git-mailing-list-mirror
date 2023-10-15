Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D563A110A
	for <git@vger.kernel.org>; Sun, 15 Oct 2023 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEE5D9
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 20:17:33 -0700 (PDT)
Received: (qmail 10412 invoked by uid 109); 15 Oct 2023 03:17:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Oct 2023 03:17:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28513 invoked by uid 111); 15 Oct 2023 03:17:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 14 Oct 2023 23:17:36 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 14 Oct 2023 23:17:32 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 21/20] t5319: make corrupted large-offset test more robust
Message-ID: <20231015031732.GB554702@coredump.intra.peff.net>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231014004348.GA43880@coredump.intra.peff.net>
 <xmqq4jitt2ie.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4jitt2ie.fsf@gitster.g>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 12:42:01PM -0700, Junio C Hamano wrote:

> > The set of objects created in the test is deterministic. But the delta
> > selection seems not to be (which is not too surprising, as it is
> > multi-threaded).
> 
> So, the offsets of the objects are also not deterministic?

Hmm, yeah, you're right. The pack clearly is not deterministic, and so
neither will its offsets be.

And thus...

> >   b. The "objects64" setup could use --delta-base-offset. This would fix
> >      our problem, but earlier tests have many hard-coded offsets. Using
> >      OFS_DELTA would change the locations of objects in the pack (this
> >      might even be OK because I think most of the offsets are within the
> >      .idx file, but it seems brittle and I'm afraid to touch it).
> 
> I am not sure I follow, as it does not sound a solution to anything
> if the offsets are not deterministic (and "earlier tests" that have
> hard coded offsets are broken no matter what, which is not a problem
> this patch introduces).  Puzzled, but not curious enough to think
> about it further, as you have already rejected this approach ;-)

...yes, my "this might even be OK" is true. So it would work to solve
the problem by using --delta-base-offset. Those earlier tests are
actually OK (they munge only the idx and the midx, not the pack). And if
we have delta base offsets, then walking delta chains never requires
looking at the pack idx.

I'm not sure if that is any less subtle than the solution I did come up
with, though.

The most unsubtle thing is cleaning up the broken .idx immediately
after generating the midx. I didn't want to do that because it disrupts
the state of the objects64 directory. But we could always turn its setup
into a function or something. I dunno. It is probably not worth spending
too many brain cycles on. My hope is that nobody ever has to touch this
test ever again. ;)

> > @@ -1129,8 +1129,10 @@ test_expect_success 'reader bounds-checks large offset table' '
> >  		git multi-pack-index --object-dir=../objects64 write &&
> >  		midx=../objects64/pack/multi-pack-index &&
> >  		corrupt_chunk_file $midx LOFF clear &&
> > -		test_must_fail git cat-file \
> > -			--batch-check --batch-all-objects 2>err &&
> > +		# using only %(objectsize) is important here; see the commit
> > +		# message for more details
> > +		test_must_fail git cat-file --batch-all-objects \
> > +			--batch-check="%(objectsize)" 2>err &&
> 
> A rather unfriendly message to readers, as it is unclear which
> commit you are talking about, and a fun thing is that you cannot
> say which one.

Yeah, I had a similar thought process. I sort of assume anybody working
on git.git is capable of turning to "git blame" in a situation like
this. But maybe:

  # using only %(objectsize) is important here; run "git blame"
  # on these lines for more details

would spell it out more clearly.

-Peff
