Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4980420899
	for <e@80x24.org>; Tue, 15 Aug 2017 01:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbdHOBrK (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 21:47:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:38894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752986AbdHOBrH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 21:47:07 -0400
Received: (qmail 6184 invoked by uid 109); 15 Aug 2017 01:47:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 15 Aug 2017 01:47:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7729 invoked by uid 111); 15 Aug 2017 01:47:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 14 Aug 2017 21:47:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Aug 2017 21:47:05 -0400
Date:   Mon, 14 Aug 2017 21:47:05 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     llvm-dev@lists.llvm.org, Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 0/2] clang-format
Message-ID: <20170815014704.thmpoz5xteuhqh3d@sigill.intra.peff.net>
References: <20170808012554.186051-1-bmwill@google.com>
 <20170814213046.107576-1-bmwill@google.com>
 <20170814230657.bmn7exoqmqw3tlyh@sigill.intra.peff.net>
 <CAGZ79kZgRTzWiufZUE02YYOJpH66x_hShBfcv=4RWDn-qR2LUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kZgRTzWiufZUE02YYOJpH66x_hShBfcv=4RWDn-qR2LUg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 14, 2017 at 04:15:40PM -0700, Stefan Beller wrote:

> + llvm-dev@lists.llvm.org
> 
> The Git community is currently discussing adopting a coding style
> defined by clang-format, here is a bug report:

Since we've added a cc, let me try to give a little more context.

> > One more oddity I found while playing with this that Git folks might run
> > into:
> >
> >   $ git init tmp && cd tmp
> >   $ git commit --allow-empty -m foo
> >   $ echo "[mysection]mykey" >>.git/config
> >   $ git clang-format-5.0
> >   Traceback (most recent call last):
> >     File "/usr/bin/git-clang-format-5.0", line 579, in <module>
> >       main()
> >     File "/usr/bin/git-clang-format-5.0", line 62, in main
> >       config = load_git_config()
> >     File "/usr/bin/git-clang-format-5.0", line 194, in load_git_config
> >       name, value = entry.split('\n', 1)
> >   ValueError: need more than 1 value to unpack
> >
> >   $ sed -i 's/mykey/&=true/' .git/config
> >   $ git clang-format-5.0
> >   no modified files to format
> >
> > So it looks like they do their own config parsing and it's not quite
> > compatible. :(

In Git's config files, doing this:

  [mysection]
  mykey

is a shorthand for setting mysection.mkykey to "true". And the output
from "git config --list" will show just the keyname without a value,
like:

  mysection.mykey

instead of:

  some.key=this one has a value

There's a possible patch elsewhere in the thread:

  https://public-inbox.org/git/xmqqzib1sp6z.fsf@gitster.mtv.corp.google.com/

I'm happy to see it is running "git config --list", which means it's
responding to syntactic funny-ness in the output of that command, not in
the original config (and other features like includes should Just Work
without the script caring).

I'm tempted to say that "config --list" should normalize this case into:

  mysection.mykey=true

Normally we avoid coercing values without knowing the context in which
they'll be used. But the syntax in the original file means the user is
telling us it's a boolean and they expect it to be treated that way.

The only downside is if the user is wrong, it might be coerced into
the string "true" instead of throwing an error. That seems like a minor
drawback for eliminating a potentially confusing corner case from the
plumbing output.

-Peff
