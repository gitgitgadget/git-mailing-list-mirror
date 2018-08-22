Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE191F954
	for <e@80x24.org>; Wed, 22 Aug 2018 19:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbeHVWtT (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 18:49:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:52128 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727678AbeHVWtT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 18:49:19 -0400
Received: (qmail 27322 invoked by uid 109); 22 Aug 2018 19:23:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Aug 2018 19:23:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3470 invoked by uid 111); 22 Aug 2018 19:23:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 22 Aug 2018 15:23:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Aug 2018 15:23:08 -0400
Date:   Wed, 22 Aug 2018 15:23:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t6018-rev-list-glob: fix 'empty stdin' test
Message-ID: <20180822192308.GB19730@sigill.intra.peff.net>
References: <20180727174811.27360-1-avarab@gmail.com>
 <20180822174820.12909-1-szeder.dev@gmail.com>
 <xmqqefeqme0p.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefeqme0p.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 22, 2018 at 11:50:46AM -0700, Junio C Hamano wrote:

> >  test_expect_failure 'rev-list should succeed with empty output on empty stdin' '
> > -	git rev-list --stdin <expect >actual &&
> > +	git rev-list --stdin </dev/null >actual &&
> >  	test_must_be_empty actual
> >  '
> 
> By the way, it may be about time to turn that expect-failure into
> expect-success.  It is somewhat unfortunate that 0c5dc743 ("t6018:
> flesh out empty input/output rev-list tests", 2017-08-02) removed
> the comment that said "we _might_ want to change the behaviour in
> these cases" and explained the tests as reminders, anticipating that
> the series will change the behaviour for three cases where the
> pending list ends up empty to make the discussion moot, but it
> changed the behaviour of only two of them, leaving the "--stdin
> reads empty" case behind.

Yeah, I think I had intended to make --stdin work there, and when I
realized at the end of the series it did not, I failed to go back and
modify that initial commit touching the test.

More discussion in the original thread:

  https://public-inbox.org/git/20170802223416.gwiezhbuxbdmbjzx@sigill.intra.peff.net/

> It may be just the matter of doing something like the attached
> patch.  I won't be committing such a behaviour change during the
> pre-release feature freeze, but we may want to consider doing this
> early in the next cycle.

Yes, definitely this is tricky enough to avoid doing during the freeze.

> diff --git a/revision.c b/revision.c
> index d12e6d8a4a..21fb413511 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2441,6 +2441,19 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
>  		object = get_reference(revs, revs->def, &oid, 0);
>  		add_pending_object_with_mode(revs, object, revs->def, oc.mode);
>  	}
> +	/* 
> +	 * Even if revs->pending is empty after all the above, if we
> +	 * handled "--stdin", then the caller really meant to give us
> +	 * an empty commit range.  Just let the traversal give an
> +	 * empty result without causing a "no input?  do you know how
> +	 * to use this command?" failure.
> +	 *
> +	 * NOTE!!!  Because "--stdin </dev/null --default HEAD" should
> +	 * default to HEAD, this must come _after_ the above block
> +	 * that deals with revs->ref fallback.
> +	 */
> +	if (read_from_stdin)
> +		revs->rev_input_given = 1;

I think this should do the right thing. All of the issues discussed in
the earlier thread were about using revs->def, and this neatly sidesteps
that by touching the flag afterwards. It's a little funny that the flag
now means two things (earlier in the function it is "we should use the
default" and later it becomes "the caller may complain").

It may be worth splitting it into two flags: rev_input_given and
rev_read_stdin. That puts the responsibility on the caller to check both
flags. But really, rev-list.c is the only caller that checks it anyway.
And it would mean this scary comment can go away. ;)

It also _could_ be useful to other callers to distinguish the two cases
(e.g., if they wanted to know whether they were free to use stdin
themselves). But I don't offhand know of any callers that need that (I
have a vague recollection that it might have come up once over the
years).

-Peff
