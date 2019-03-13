Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B9120248
	for <e@80x24.org>; Wed, 13 Mar 2019 16:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbfCMQyi (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 12:54:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:49044 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725888AbfCMQyi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 12:54:38 -0400
Received: (qmail 17049 invoked by uid 109); 13 Mar 2019 16:54:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Mar 2019 16:54:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12750 invoked by uid 111); 13 Mar 2019 16:53:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 12:53:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 12:53:21 -0400
Date:   Wed, 13 Mar 2019 12:53:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] rebase -i: demonstrate obscure loose object cache bug
Message-ID: <20190313165320.GA717@sigill.intra.peff.net>
References: <pull.161.git.gitgitgadget@gmail.com>
 <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com>
 <87k1h2bvpb.fsf@evledraar.gmail.com>
 <20190313163516.GA26045@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190313163516.GA26045@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 12:35:16PM -0400, Jeff King wrote:

> On Wed, Mar 13, 2019 at 05:11:44PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> > > And this is where the loose object cache interferes with this feature:
> > > if *some* loose object was read whose hash shares the same first two
> > > digits with a commit that was not yet created when that loose object was
> > > created, then we fail to find that new commit by its short name in
> > > `get_oid()`, and the interactive rebase fails with an obscure error
> > > message like:
> > >
> > > 	error: invalid line 1: pick 6568fef
> > > 	error: please fix this using 'git rebase --edit-todo'.
> 
> Are we 100% sure this part is necessary? From my understanding of the
> problem, even without any ambiguity get_oid() could fail due to just
> plain not finding the object in question.

Sorry, I was being dumb. We do need a two-digit collision, not because
we need an ambiguity, but because the loose-object cache is filled in
one directory at a time. So we must be unlucky enough to hit the same
directory twice, and using these objects ensures that unluckiness. And
the commit message does describe this.

If we didn't want to depend on a particular hash, we could simply do it
N times, where N is enough to get us any two entries which collide in
the first byte. By the birthday paradox, that's 50% at only 2^4. But 50%
is not very good odds for the test working. You'd need 257 iterations to
ensure a collision by the pigeon-hole principle. That's enough that I
kind of prefer the found collision here, even if we'll have to update it
for a new hash (it is correctly marked with SHA1, so I don't think
finding it later will be a problem).

By the way, while reading the test more carefully, I did notice two
funny things:

> +test_expect_failure SHA1 'loose object cache vs re-reading todo list' '
> +	GIT_REBASE_TODO=.git/rebase-merge/git-rebase-todo &&
> +	export GIT_REBASE_TODO &&
> +	write_script append-todo.sh <<-\EOS &&
> +	# For values 5 and 6, this yields SHA-1s with the same first two digits
> +	echo "pick $(git rev-parse --short \
> +		$(printf "%s\\n" \
> +			"tree $EMPTY_TREE" \
> +			"author A U Thor <author@example.org> $1 +0000" \
> +			"committer A U Thor <author@example.org> $1 +0000" \
> +			"" \
> +			"$1" |
> +		  git hash-object -t commit -w --stdin))" >>$GIT_REBASE_TODO

Here we redirect the output into $GIT_REBASE_TODO, not stdout.

> +	shift
> +	test -z "$*" ||
> +	echo "exec $0 $*" >>$GIT_REBASE_TODO

And here we do the same thing. That second redirection is unnecessary.

I also find it interesting that it iterates over its arguments by
recursive processes. Wouldn't:

  for i in "$@"; do
	echo "pick ..." >>$GIT_REBASE_TODO
  done

be a bit more efficient (as well as more obvious?).

-Peff
