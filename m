Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B35731F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 18:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755491AbcHXSF4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 14:05:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:60617 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754904AbcHXSFp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 14:05:45 -0400
Received: (qmail 14850 invoked by uid 109); 24 Aug 2016 18:05:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 18:05:44 +0000
Received: (qmail 5282 invoked by uid 111); 24 Aug 2016 18:05:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 14:05:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 14:05:41 -0400
Date:   Wed, 24 Aug 2016 14:05:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] for-each-ref: add %(upstream:gone) to mark missing refs
Message-ID: <20160824180541.jrliwgkrqu2siywd@sigill.intra.peff.net>
References: <20160819215023.10770-1-oystwa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160819215023.10770-1-oystwa@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 11:50:23PM +0200, Øystein Walle wrote:

> git branch -vv will show "gone" next to a remote tracking branch if it
> does not exist. for-each-ref is suitable for parsing but had no way of
> showing this information.
> 
> This introduces "%(upstream:gone)" to display "gone" in the formatted
> output if the ref does not exist or an empty string otherwise, analogous
> to git branch -vv.

Hmm. So this sounds like the minimum thing to implement "branch -vv"
output, but it feels sort of weirdly non-orthogonal. I guess you'd say:

  %(upstream:track)%(upstream:gone)

and assume that only one of them will show any data.

I almost wonder if %(upstream:track) should just output some specific
token for the "gone" case, which matches what "branch -vv" does.

(I'm also not sure we can match "branch -vv" exactly here anyway, as it
looks like "[%(upstream): %(upstream:track)"], but our
"%(upstream:track)" uses its own brackets.)

I suppose that is a backwards-incompatible change for
"%(upstream:track)", but I'm not sure how much we have promised about
its format. The error cases seem totally undocumented.

> ---
>  Documentation/git-for-each-ref.txt |  5 +++--
>  ref-filter.c                       | 10 +++++++++-
>  t/t6300-for-each-ref.sh            | 12 ++++++++++++
>  3 files changed, 24 insertions(+), 3 deletions(-)

The code itself looks OK to me (assuming we want upstream:gone as the
interface), with a few minor nits in the test:

> +test_expect_success 'Check that :gone produces expected results' '
> +	cat >expected <<-\EOF &&
> +gone
> +	EOF

The "<<-" will strip leading tabs, meaning you can indent "gone" here to
match the rest of the test.

> +	test_when_finished "git config branch.master.merge refs/heads/master" &&
> +	git config branch.master.merge refs/heads/does-not-exist &&

I thought this could be test_config, but it is not clever enough to
restore an old value, only to remove a value we just added. So this is
probably the best solution.

> +	git for-each-ref \
> +		--format="%(upstream:gone)" \
> +		refs/heads >actual &&
> +	test_cmp expected actual
> +'

This tests only that we show "gone"; do you want to add a second branch
and make sure that it shows nothing? Maybe you could even use a new
branch name, which makes test_config applicable again:

  cat >expected <<-\EOF &&
  master 
  no-upstream gone
  EOF
  git branch refs/heads/no-upstream &&
  test_config branch.no-upstream.remote . &&
  test_config branch.no-upstream.merge refs/heads/does-not-exist &&
  git for-each-ref --format="%(refname:short) %(upstream:gone)" >actual &&
  test_cmp expected actual

-Peff
