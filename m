Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D170D211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 14:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbfAKO0b (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 09:26:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:33672 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387925AbfAKORz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 09:17:55 -0500
Received: (qmail 28723 invoked by uid 109); 11 Jan 2019 14:17:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Jan 2019 14:17:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10028 invoked by uid 111); 11 Jan 2019 14:17:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 Jan 2019 09:17:55 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2019 09:17:53 -0500
Date:   Fri, 11 Jan 2019 09:17:53 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] tree-walk object_id refactor
Message-ID: <20190111141753.GA16754@sigill.intra.peff.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
 <20190110064030.GB20497@sigill.intra.peff.net>
 <20190111001750.GO423984@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111001750.GO423984@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 11, 2019 at 12:17:50AM +0000, brian m. carlson wrote:

> > I think this is really the only safe and sane solution. We resisted it
> > because of the cost of the extra copies (especially the
> > update_tree_entry() one). But I don't know that anybody actually
> > measured it. Do you have any performance numbers before/after this
> > series?
> 
> Unfortunately, I don't. I'm not really sure in what situations we hit
> this code path a lot, so I'm not sure what exactly we should performance
> test. If you have suggestions, I can set up some perf tests.

I think the interesting one here is the copy in update_tree_entry(),
which is called for every entry of every tree we parse for a diff. So
the command with the most noticeable impact, I think, would be something
like:

  git log -- pathspec

I couldn't demonstrate any measurable slowdown (I didn't compute the
mean to see if it gets worse, but certainly any change is within the
run-to-run noise).

I guess that is competing with the cost to access the commit objects.
Perhaps a pure tree diff would be a more precise test. Here's the most
pathological case I could come up with:

  git init
  for i in $(seq 10000); do echo $i >$i; done
  git add .
  git commit -m base
  echo change >9999
  git commit -am change
  time git diff-tree HEAD^ HEAD

which should really be spending 99% of its time inflating and walking
through the trees. And even there I couldn't measure anything.

So I'd say it's probably fine.

-Peff
