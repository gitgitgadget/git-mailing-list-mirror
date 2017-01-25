Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6206B1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbdAYXUm (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:20:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:44982 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751255AbdAYXUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:20:41 -0500
Received: (qmail 11995 invoked by uid 109); 25 Jan 2017 23:20:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 23:20:41 +0000
Received: (qmail 18092 invoked by uid 111); 25 Jan 2017 23:20:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 18:20:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 18:20:38 -0500
Date:   Wed, 25 Jan 2017 18:20:38 -0500
From:   Jeff King <peff@peff.net>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: diff --color-words breaks spacing
Message-ID: <20170125232038.bedgunhyesdytys3@sigill.intra.peff.net>
References: <CABURp0ryBtLALEnzRdoeYeUUdrzBxiT3+yTvW6B=vpqMG3p1Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABURp0ryBtLALEnzRdoeYeUUdrzBxiT3+yTvW6B=vpqMG3p1Rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 24, 2017 at 09:39:31AM -0800, Phil Hord wrote:

> I noticed some weird spacing when comparing files with git diff
> --color-words.  The space before a colored word disappears sometimes.

I _think_ this is working as designed, though it is a bit tricky (and it
may be possible to make it better).

> echo "FOO foo; foo = bar" > a
> echo "FOO foo = baz" > b
> git diff --color-words --no-index a b
> FOOfoo; foo = barbaz

It might be easier to see with --word-diff, which uses the same code but
marks it with punctuation:

  $ git diff --word-diff
  FOO[-foo;-] foo = [-bar-]{+baz+}

The key thing is that what you are seeing is the post-image, plus
word-based annotations. And the post-image does not have that space in
its context, so we would not expect to see:

  FOO [-foo;-] foo = [-bar-]{+baz+}

(you would if we showed the pre-image plus annotations; but then I think
you'd probably end up with the opposite problem when text was added).

However, we also don't see the space in the removed part. I.e., I think:

  FOO[- foo;-] foo = [-bar-]{+baz+}

would be correct. But I think because of the way word-diff is
implemented, a non-word character will never be part of the annotation.

The way it works is basically to break the string down on word
boundaries, so we have:

  pre: FOO, foo;, foo, =, bar
  post: FOO, foo, =, baz

as a set of tokens. We stick each of those on their own line and feed
them back to xdiff, so we get a diff like:

  @@ -1,5 +1,4 @@
   FOO
  -foo;
   foo
   =
  -bar
  +baz

and then walk through the post-image buffer, either inserting chunks of
context from the original buffer, or the changed lines. But the changed
lines themselves do not include the non-word characters, so we have no
idea that a space went away.

-Peff
