Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918B6C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657DC60FC1
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhINR2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:28:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:47216 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhINR2s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:28:48 -0400
Received: (qmail 24639 invoked by uid 109); 14 Sep 2021 17:27:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 17:27:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25696 invoked by uid 111); 14 Sep 2021 17:27:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 13:27:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 13:27:28 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 7/9] ls-refs: ignore very long ref-prefix counts
Message-ID: <YUDbgBfvFU+33Fuz@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUDBokYvEBnzwsIN@coredump.intra.peff.net>
 <YUDZTvI4hrqRK8Th@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUDZTvI4hrqRK8Th@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 01:18:06PM -0400, Taylor Blau wrote:

> > @@ -156,8 +163,16 @@ int ls_refs(struct repository *r, struct packet_reader *request)
> >  			data.peel = 1;
> >  		else if (!strcmp("symrefs", arg))
> >  			data.symrefs = 1;
> > -		else if (skip_prefix(arg, "ref-prefix ", &out))
> > -			strvec_push(&data.prefixes, out);
> > +		else if (skip_prefix(arg, "ref-prefix ", &out)) {
> > +			if (too_many_prefixes) {
> > +				/* ignore any further ones */
> > +			} else if (data.prefixes.nr >= MAX_ALLOWED_PREFIXES) {
> > +				strvec_clear(&data.prefixes);
> > +				too_many_prefixes = 1;
> > +			} else {
> > +				strvec_push(&data.prefixes, out);
> > +			}
> > +		}
> 
> The order of this if-statement is a little odd to me, but obviously
> correct. I might have wrote:
> 
>     if (too_many_prefixes)
>       continue;
> 
>     if (data.prefixes.nr < MAX_ALLOWED_PREFIXES) {
>       strvec_push(&data.prefixes, out);
>     } else {
>       too_many_prefixes = 1;
>       strvec_clear(&data.prefixes);
>     }
> 
> But certainly what you wrote here works just fine (so this is a cosmetic
> comment, and not a functional one).

My view of it was: check every case that may avoid us pushing a prefix,
and then finally push one. But that may have been related to my goal in
writing the patch. :)

> > +test_expect_success 'ignore very large set of prefixes' '
> > +	# generate a large number of ref-prefixes that we expect
> > +	# to match nothing; the value here exceeds MAX_ALLOWED_PREFIXES
> > +	# from ls-refs.c.
> > +	{
> > +		echo command=ls-refs &&
> > +		echo object-format=$(test_oid algo)
> > +		echo 0001 &&
> > +		perl -le "print \"refs/heads/$_\" for (1..65536+1)" &&
> > +		echo 0000
> > +	} |
> > +	test-tool pkt-line pack >in &&
> > +
> > +	# and then confirm that we see unmatched prefixes anyway (i.e.,
> > +	# that the prefix was not applied).
> > +	cat >expect <<-EOF &&
> > +	$(git rev-parse HEAD) HEAD
> > +	$(git rev-parse refs/heads/dev) refs/heads/dev
> > +	$(git rev-parse refs/heads/main) refs/heads/main
> > +	$(git rev-parse refs/heads/release) refs/heads/release
> > +	$(git rev-parse refs/tags/annotated-tag) refs/tags/annotated-tag
> > +	$(git rev-parse refs/tags/one) refs/tags/one
> > +	$(git rev-parse refs/tags/two) refs/tags/two
> 
> You could have written this as a loop over the unmatched prefixes, but I
> vastly prefer the result you came up with, which is much more explicit
> and doesn't require readers to parse out what the loop does.

I actually think that:

  git for-each-ref --format='%(objectname) %(refname)' >expect

is pretty readable (and is much more efficient, and nicely avoids the
master/main brittle-ness, which I ran into while backporting this). But:

  - this matches what the rest of the script does

  - for-each-ref doesn't report on HEAD, so we have to add that in
    separately

  - the "pkt-line unpack" will include the flush packet, so we'd have to
    add that in, too.

-Peff
