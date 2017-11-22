Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA1120954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbdKVWB6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:01:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:38052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751303AbdKVWB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:01:58 -0500
Received: (qmail 4327 invoked by uid 109); 22 Nov 2017 22:01:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Nov 2017 22:01:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5110 invoked by uid 111); 22 Nov 2017 22:02:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 22 Nov 2017 17:02:14 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Nov 2017 17:01:56 -0500
Date:   Wed, 22 Nov 2017 17:01:56 -0500
From:   Jeff King <peff@peff.net>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2] Teach stash to parse -m/--message like commit does
Message-ID: <20171122220155.GD2854@sigill>
References: <20171122212031.5988-1-phil.hord@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171122212031.5988-1-phil.hord@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 01:20:30PM -0800, Phil Hord wrote:

> `git stash push -m foo` uses "foo" as the message for the stash. But
> `git stash push -m"foo"` does not parse successfully.  Similarly
> `git stash push --message="My stash message"` also fails.  The stash
> documentation doesn't suggest this syntax should work, but gitcli
> does and my fingers have learned this pattern long ago for `commit`.
> 
> Teach `git stash` and `git store` to parse -mFoo and --message=Foo
> the same as `git commit` would do.  Even though it's an internal
> function, add similar support to create_stash() for consistency.

I definitely approve of the goal. The implementation looks pretty
straightforward given the current parsing scheme.

Many of our other scripts lean on "rev-parse --parseopt" to handle
options.  E.g.:

OPTIONS="\
git foo [options]
--
m,message=     stash message
"
foo() {
	for i in "$@"; do echo " pre: $i"; done
	eval "$(echo -n "$OPTIONS" | git rev-parse --parseopt -- "$@")"
	for i in "$@"; do echo "post: $i"; done
}
foo -mmsg
foo -m msg
foo --message=msg
foo --message msg

should convert each of those into "-m msg". It also handles unique
partial options like "--mess", though IMHO that is not that big a deal.

Would it be possible to convert stash to use --parseopt? I'm fine if the
answer is "no", or even "yes, but it's tricky so let's do this in the
meantime". But I think that's the endgame we should be shooting for (or,
of course, doing the whole thing in C, which I think somebody else is
working on).

-Peff
