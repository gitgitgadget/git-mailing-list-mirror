Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EACAE20899
	for <e@80x24.org>; Mon, 14 Aug 2017 23:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbdHNXHA (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 19:07:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:38730 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752836AbdHNXHA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 19:07:00 -0400
Received: (qmail 30319 invoked by uid 109); 14 Aug 2017 23:07:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 23:07:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6886 invoked by uid 111); 14 Aug 2017 23:07:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 19:07:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Aug 2017 19:06:57 -0400
Date:   Mon, 14 Aug 2017 19:06:57 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, jrnieder@gmail.com,
        ramsay@ramsayjones.plus.com, peartben@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 0/2] clang-format
Message-ID: <20170814230657.bmn7exoqmqw3tlyh@sigill.intra.peff.net>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170814213046.107576-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 02:30:44PM -0700, Brandon Williams wrote:

> Changes in v2:
>  * Changed a couple rules to be more inline with our coding style.
>  * Added a Makefile build rule to run git-clang-format on the diff of the
>    working tree to suggest style changes.
> 
> I found that the llvm project also has the git-clang-format tool which will
> allow for doing formating changes based on diffs so that the parts of the code
> you didn't touch won't be formated.  It also has a nice '-p' option to only
> apply hunks of suggested changes.  I also saw what Ramsay did and attempted to
> add a Makefile rule to run clang-format.  This bit may need more tweaking to
> get it right.

One more oddity I found while playing with this that Git folks might run
into:

  $ git init tmp && cd tmp
  $ git commit --allow-empty -m foo
  $ echo "[mysection]mykey" >>.git/config
  $ git clang-format-5.0
  Traceback (most recent call last):
    File "/usr/bin/git-clang-format-5.0", line 579, in <module>
      main()
    File "/usr/bin/git-clang-format-5.0", line 62, in main
      config = load_git_config()
    File "/usr/bin/git-clang-format-5.0", line 194, in load_git_config
      name, value = entry.split('\n', 1)
  ValueError: need more than 1 value to unpack

  $ sed -i 's/mykey/&=true/' .git/config
  $ git clang-format-5.0
  no modified files to format

So it looks like they do their own config parsing and it's not quite
compatible. :(

That's not the end of the world, and something we can try to fix
upstream. I just wanted to mention it here so other people don't waste
time trying to track down the problem.

-Peff
