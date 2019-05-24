Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975E91F462
	for <e@80x24.org>; Fri, 24 May 2019 06:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388689AbfEXGj5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 02:39:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:37548 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388365AbfEXGj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 02:39:57 -0400
Received: (qmail 25269 invoked by uid 109); 24 May 2019 06:39:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 May 2019 06:39:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6486 invoked by uid 111); 24 May 2019 06:40:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 May 2019 02:40:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 May 2019 02:39:55 -0400
Date:   Fri, 24 May 2019 02:39:55 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alejandro Sanchez <asanchez1987@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] am: fix --interactive HEAD tree resolution
Message-ID: <20190524063955.GD25694@sigill.intra.peff.net>
References: <20190520120636.GA12634@sigill.intra.peff.net>
 <20190520121301.GD11212@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905230858570.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1905230858570.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 23, 2019 at 09:12:27AM +0200, Johannes Schindelin wrote:

> > +	if (!get_oid("HEAD", &head)) {
> > +		struct object *obj;
> > +		struct commit *commit;
> > +
> > +		obj = parse_object_or_die(&head, NULL);
> > +		commit = object_as_type(the_repository, obj, OBJ_COMMIT, 0);
> > +		if (!commit)
> > +			die("unable to parse HEAD as a commit");
> 
> Wouldn't this be easier to read like this:
> 
> 		struct commit *commit =
> 			lookup_commit_reference(the_repository, &head);

Just the first two lines, I assume you mean; we still have to die
ourselves. There is a lookup_commit_or_die(), but weirdly it warns if
there was any tag dereferencing. I guess that would never happen here,
since we're reading HEAD (and most of the existing calls appear to be
for HEAD). So I'll go with that.

> > +test_expect_success 'interactive am can apply a single patch' '
> > +	git reset --hard base &&
> > +	printf "%s\n" y n | git am -i mbox &&
> 
> Since we want contributors to copy-edit our test cases (even if they do
> not happen to be Unix shell scripting experts), it would be better to
> write
> 
> 	test_write_lines y n | git am -i mbox &&
> 
> here. Same for similar `printf` invocations further down.

I think test_write_lines is mostly about avoiding echo chains, but it's
probably a little more readable to avoid having to say "\n". I'll adopt
that.

> > +	echo no-conflict >expect &&
> > +	git log -1 --format=%s >actual &&
> > +	test_cmp expect actual
> 
> I would prefer
> 
> 	test no-conflict = "$(git show -s --format=%s HEAD)"
> 
> or even better:
> 
> test_cmp_head_oneline () {
> 	if test "$1" != "$(git show -s --format=%s HEAD)"
> 	then
> 		echo >&4 "HEAD's oneline is '$(git show -s \
> 			--format=%s HEAD)'; expected '$1'"
> 		return 1
> 	fi
> }

This, I disagree with. IMHO comparing command output using "test" is
harder to read and produces worse debugging output (unless you do a
helper as you showed, which I think makes the readability even worse).
Not to mention that it raises questions of the shell's whitespace
handling (though that does not matter for this case).

What's your complaint with test_cmp? Is it the extra process? Could we
perhaps deal with that by having it use `read` for the happy-path?

Or do you prefer having a one-liner? I'd rather come up with a more
generic helper to cover this case, that can run any command and compare
it to a single argument (or stdin). E.g.,:

  test_cmp_cmd no-conflict git log -1 --format=%s

or

  test_cmp_cmd - git foo <<-\EOF
  multi-line
  expectation
  EOF

But I'd rather approach those issues separately and systematically, and
not hold up this bug fix.

> > +test_expect_success 'interactive am can resolve conflict' '
> > +	git reset --hard base &&
> > +	printf "%s\n" y y | test_must_fail git am -i mbox &&
> > +	echo resolved >file &&
> > +	git add -u &&
> > +	printf "%s\n" v y | git am -i --resolved &&
> 
> Maybe a comment, to explain to the casual reader what the "v" and the "y"
> are supposed to do?

OK. The "v" is actually optional, but I figured it would not hurt to
have us print the patch we just generated. I'll add a comment.

> After wrapping my head around the intentions of these commands, I agree
> that they test for the right thing.

Thanks!

-Peff
