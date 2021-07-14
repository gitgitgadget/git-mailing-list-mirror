Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A8AC07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C213D61374
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 01:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbhGNBO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 21:14:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:48676 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237199AbhGNBOz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 21:14:55 -0400
Received: (qmail 15844 invoked by uid 109); 14 Jul 2021 01:12:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 14 Jul 2021 01:12:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17984 invoked by uid 111); 14 Jul 2021 01:12:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Jul 2021 21:12:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Jul 2021 21:12:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] tests: replace [de]packetize() shell+perl
 test-tool pkt-line
Message-ID: <YO455OO5q50m7WiZ@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
 <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
 <patch-3.5-c33f344ab20-20210712T164208Z-avarab@gmail.com>
 <YO38ladlVVGAmQnl@coredump.intra.peff.net>
 <875yxd3h7c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875yxd3h7c.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 01:41:27AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > This is testing the whole output, rather than just the "have" lines (as
> > the original did). It was intentionally written the other way for two
> > reasons:
> >
> >   - it keeps the focus on what we are actually testing: the .have
> >     behavior
> >
> >   - it makes the test less brittle to other changes in the script
> >
> > I can buy the argument that sometimes testing the whole output, even if
> > it is more brittle, helps us find other unexpected outcomes (e.g., the
> > stderr test_cmp vs grep thing earlier in the series). But here it just
> > seems strictly worse to me.
> >
> > It would be easy to just replace depacketize with "pktline unpack", but
> > keep the perl one-liner. I don't think it's a _huge_ deal in this case
> > either way, but I'm not enthused about the trend.
> 
> FWIW this series was spun off from an effort of fixing a bug related to
> protocol-y tests doing just such a "we can grep the output, we know we
> only need xyz", and the only test for it not failing because we picked
> the wrong xyz.
> 
> In this case yeah we could keep the grep. I do think in general that
> unless output is overly verbose we should test_cmp it, and in this case
> it's really not.
> 
> On the focus it seems it's the opposite for the two uf us. It takes my
> focus away from the test itself when reading it. I.e. I start wondering
> why the grep, is the output variable or whatever, especially in a case
> like this where we're hardly saving ourselves overall lines or reducing
> complexity.

OK. I don't really agree, but I don't feel strongly enough to argue
about it. (I guess I'm a little more invested here because you're not
writing new tests, which I would definitely not have said anything
about, but rather changing tests that I wrote. ;) ).

> >> +	test-tool pkt-line pack >in <<-\EOF &&
> >> +	0000
> >> +	EOF
> >
> > This used to just be "printf 0000". The new version is longer and less
> > efficient, but I'm OK with it on the grounds of consistency (all inputs
> > flow through "pkt-line pack", and all outputs through "pkt-line unpack").
> 
> They aren't equivalent because the pkt-line helper (and pkt-line.c in
> general) will be forgiving about the presence or lack of trailing
> newlines, but some of these tests were not.
> 
> I think we should use the helper in/out for all of those, because we're
> explicitly interested if the protocol round-trips the way we expect, and
> not per-se if the exact bytes match.

That's not at all true for flush packets, though. They _must_ be exactly
"0000", no newlines or anything else. The pkt-line tool is smart enough
to drop the newline in this case (i.e., it recognizes that this is not a
packet that says "0000", but a special flush token).

So it really is byte-equivalent to "printf 0000", and it must be.

There is a separate issue, which I didn't raise, which is that:

  printf foo | packetize

may be different than:

  test-tool pkt-line pack <<\EOF
  foo
  EOF

For the most part, I agree it is not that important. Some of the tests
really do care (because they are testing syntactic stuff), and those
should be using your new raw-stdin feature. I did briefly wonder if we
losing a little bit of accidental diversity of the tests to put them all
through a generator that will always add the newline. But it _shouldn't_
matter in general, and if it does, we should be making specific tests
where it does.

> > Now that you're using the multi-line-capable helper, these could all be
> > a single (and much more readable):
> >
> >   test-tool pkt-line pack <<-EOF
> >   $ZERO_OID $A refs/for/main/topic1
> >   $ZERO_OID $A refs/heads/foo
> >   $ZERO_OID $A refs/for/next/topic
> >   $ZERO_OID $A refs/for/main/topic2
> >   EOF
> >
> > couldn't they?
> 
> Yeah, but you never know what you'll get "let's do the small change"
> v.s. "let's avoid refactoring while we're at it" feedback :)
> 
> I figured it was easier to review with just the s/packetize/test-tool
> pkt-line pack/g, but sure, I can change it.

Well, yes, but that seems like a _much_ smaller change than all of the
rewriting you were doing elsewhere, which is actually changing what
we're checking (albeit in a way that is functionally equivalent). I can
live with it either way, but it just seemed weird to go so far in some
hunks and then not here.

> >> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
> >> index e5d3d15ba8d..e6c8338b648 100755
> >> --- a/t/t5562-http-backend-content-length.sh
> >> +++ b/t/t5562-http-backend-content-length.sh
> >> @@ -53,12 +53,13 @@ test_expect_success 'setup' '
> >>  	test_commit c1 &&
> >>  	hash_head=$(git rev-parse HEAD) &&
> >>  	hash_prev=$(git rev-parse HEAD~1) &&
> >> -	{
> >> -		packetize "want $hash_head" &&
> >> -		printf 0000 &&
> >> -		packetize "have $hash_prev" &&
> >> -		packetize "done"
> >> -	} >fetch_body &&
> >> +	test-tool pkt-line pack >fetch_body <<-EOF &&
> >> +	want $hash_head
> >> +	0000
> >> +	have $hash_prev
> >> +	done
> >> +	0000
> >> +	EOF
> >
> > There's a flush packet at the end of your input in the post-image that
> > doesn't seem to be in the original.
> 
> Yeah, but isn't round-tripping through the helper the right thing here?

I'm not sure I understand. In the original, the final bytes in
fetch_body would be "0008done". In yours, it will be "0009done\n0000".
The extra newline is OK, but that added flush packet is not an
equivalent protocol input to feed to git-http-backend. I expect that Git
doesn't complain because after the "done" there shouldn't be anything
said, so the bytes are simply dropped.

Going through pkt-line is good and reasonable, if that's what you mean
by round-tripping. Your input just has an extra "0000" on the final line
of the here-doc.

> >> -	depacketize <output >output.raw &&
> >> +	test-tool pkt-line unpack <output >actual &&
> >> +
> >> +	cat >expect <<-EOF &&
> >> +	$(git rev-parse HEAD) HEAD
> >> +	$(git rev-parse refs/heads/main) refs/heads/main
> >> +	0000
> >> +	EOF
> >>  
> >> -	# just pick out the value of main, which avoids any protocol
> >> -	# particulars
> >> -	perl -lne "print \$1 if m{^(\\S+) refs/heads/main}" <output.raw >actual &&
> >> -	git -C "$repo" rev-parse main >expect &&
> >>  	test_cmp expect actual
> >>  '
> >
> > This is another case where you're checking the output for more than the
> > original did, ignoring the comment. :) When using depacketize, the bits
> > after the "\0" were encoded and kept, so it was necessary. The pkt-line
> > helper just throws those bits away, so it's OK (I'm a little surprised
> > that discarding those bits wasn't a roadblock for converting some tests,
> > but I guess we didn't have any low-level protocol tests that cared).
> 
> ... I see you got to this bit in 4/5.

I'm not sure I was completely clear. Yes, if there is a NUL in the
input, we must use 4/5's raw-stdin mode. But here I am talking about the
_unpack_ operation.

For a v0 protocol response that buries capabilities after a NUL,
depacketize will show it (the "\0" escape is literally part of the
output):

  $ git init foo
  $ cd foo
  $ git commit --allow-empty -m foo
  $ git upload-pack . | depacketize
  2b78ba01d65c1b0a44c0ac0dd8275e7802b74f41 HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow deepen-since deepen-not deepen-relative no-progress include-tag multi_ack_detailed symref=HEAD:refs/heads/main object-format=sha1 agent=git/2.32.0.663.g7cfef204d6
  2b78ba01d65c1b0a44c0ac0dd8275e7802b74f41 refs/heads/main
  FLUSH

whereas the pkt-line helper will not:

  $ git upload-pack . | ../t/helper/test-tool pkt-line unpack
  2b78ba01d65c1b0a44c0ac0dd8275e7802b74f41 HEAD
  2b78ba01d65c1b0a44c0ac0dd8275e7802b74f41 refs/heads/main
  0000

That's more convenient in many cases, but I was just saying I was
surprised we did not have any tests that ever tested any of the bits
past the NUL (we do, of course, but they are using real Git commands to
make sure the correct stuff happened, and not peeking at the protocol
themselves).

I think it's OK to proceed. If we later do want a test that looks past
the NUL, we can add that feature to the pkt-line helper. Though looking
at the helper implementation, it does not even seem intentional; it
simply treats the packet data as a C string, feeding it to printf. So if
you do want to be thorough in checking expected packet data in outputs,
it is definitely throwing away some of that data.

-Peff
