Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011A420899
	for <e@80x24.org>; Mon, 31 Jul 2017 03:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbdGaDpK (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 23:45:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:53128 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751615AbdGaDpK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 23:45:10 -0400
Received: (qmail 28733 invoked by uid 109); 31 Jul 2017 03:45:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 31 Jul 2017 03:45:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22964 invoked by uid 111); 31 Jul 2017 03:45:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 30 Jul 2017 23:45:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Jul 2017 23:45:08 -0400
Date:   Sun, 30 Jul 2017 23:45:08 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 10/10] git.c: ignore pager.* when launching builtin as
 dashed external
Message-ID: <20170731034507.2fdjnvgzzt4rgvas@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <cover.1500321657.git.martin.agren@gmail.com>
 <fa91f778e1acff812ddadb313e9979c470edc43b.1500321658.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa91f778e1acff812ddadb313e9979c470edc43b.1500321658.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 17, 2017 at 10:10:52PM +0200, Martin Ågren wrote:

> When running, e.g., `git -c alias.bar=foo bar`, we expand the alias and
> execute `git-foo` as a dashed external. This is true even if git foo is
> a builtin. That is on purpose, and is motivated in a comment which was
> added in commit 441981bc ("git: simplify environment save/restore
> logic", 2016-01-26).
> 
> Shortly before we launch a dashed external, and unless we have already
> found out whether we should use a pager, we check `pager.foo`. This was
> added in commit 92058e4d ("support pager.* for external commands",
> 2011-08-18). If the dashed external is a builtin, this does not match
> that commit's intention and is arguably wrong, since it would be cleaner
> if we let the "dashed external builtin" handle `pager.foo`.
> 
> This has not mattered in practice, but a recent patch taught `git-tag`
> to ignore `pager.tag` under certain circumstances. But, when started
> using an alias, it doesn't get the chance to do so, as outlined above.
> That recent patch added a test to document this breakage.
> 
> Do not check `pager.foo` before launching a builtin as a dashed
> external, i.e., if we recognize the name of the external as a builtin.
> Change the test to use `test_expect_success`.

I think floating this change to the end like this has made it much
easier to see why we must do it. The end result looks good to me.

> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
> One could address this in run_argv(), by making the second call to
> execv_dashed_external() conditional on "!is_builtin()" whereas a builtin
> would be started as "git foo". (Possibly after unrolling and cleaning up
> the "while (1)"-loop.) That seems like the wrong fix for this particular
> issue, but might be a wanted change on its own -- or maybe not --, since
> it would mean one could relay, e.g., "-c baz" to "git -c baz foo" (but
> only for builtins...).

We shouldn't need to relay them. They get added to the environment by
the initial "git" invocation, and then are available everywhere (in
fact, it would be wrong to relay them for multi-valued config). Or did
you mean that we could potentially allow:

  [alias]
  foo = "-c baz some-builtin"

That's interesting, but I think the fact that it only works with
builtins makes it a bad idea. And you can always do:

  [alias]
  foo = "!git -c baz some-builtin"

which is equivalent.

-Peff
