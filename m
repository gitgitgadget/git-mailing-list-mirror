Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2669A1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 15:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbeCTP6R (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 11:58:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:36060 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751553AbeCTP6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 11:58:16 -0400
Received: (qmail 25562 invoked by uid 109); 20 Mar 2018 15:58:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Mar 2018 15:58:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 382 invoked by uid 111); 20 Mar 2018 15:59:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Mar 2018 11:59:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Mar 2018 11:58:14 -0400
Date:   Tue, 20 Mar 2018 11:58:14 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Brian Henderson <henderson.bj@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [BUG] log --graph corrupts patch
Message-ID: <20180320155814.GA32366@sigill.intra.peff.net>
References: <897b7471-037a-78d9-fc11-0624ef657b4d@talktalk.net>
 <20180320060931.GE15813@sigill.intra.peff.net>
 <1e686ea0-90ac-f3f4-7bcf-6951c9253598@talktalk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e686ea0-90ac-f3f4-7bcf-6951c9253598@talktalk.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 09:58:14AM +0000, Phillip Wood wrote:

> > Are you using any exotic filters for your pager? If you use "git
> > --no-pager" does the problem persist?
> 
> Hi Peff, thanks for taking the time to check this, I had forgotten about
> the pager. I'm using diff-highlight and it seems that is causing the
> problems.

Heh. Lucky guess. Unsurprisingly, I use diff-highlight, too. But I did
not see it because I never bothered to upgrade my personal copy of the
script, which has been working for me for ages, to the one in contrib/.

But indeed, I can easily reproduce the problem with that version of the
script. Here's a pretty minimal reproduction:

-- >8 --

cat >bad <<\EOF
* commit whatever
| other stuff irrelevant
|
| diff --git a/foo b/foo
| --- a/foo
| --- b/foo
| @@ -100,6 +100,9
|  some
|  context
|  lines
| +some
| +new
| +lines
|  -context line with a leading minus
|  and other
|  context
EOF

contrib/diff-highlight/diff-highlight <bad

-- 8< --

which produce:

...
|  -context line with a leading minus
| +some
| +new
| +lines
...

The issue bisects to 7e4ffb4c17 (diff-highlight: add support for --graph
output, 2016-08-29). I think the problem is the "\s+" at the end of the
$GRAPH regex, which soaks up the space for the context, and accidentally
treats the "-" line as a preimage removal.

But just switching that to "\s" doesn't quite work. We may have an
arbitrary number of spaces between the graph ascii-art and the diff.
E.g., if you have a commit at the base of a branch (the test in
contrib/diff-highlight shows this case).

So I think you'd have to record the indent of the previous hunk header,
and then make sure that the indent matched that. But even there, I think
we're subject to false positives if a commit message contains a hunk
header (it's indented an extra 4 characters, but we'd accidentally soak
that up thinking it was graph indentation).

To make it bullet-proof, I think we'd have to actually parse the graph
structure, finding a "*" line and then accepting only an indent that
matched it.

-Peff
