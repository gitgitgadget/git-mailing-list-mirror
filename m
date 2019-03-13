Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF04E20248
	for <e@80x24.org>; Wed, 13 Mar 2019 16:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfCMQge (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 12:36:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:49004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725856AbfCMQgd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 12:36:33 -0400
Received: (qmail 16815 invoked by uid 109); 13 Mar 2019 16:36:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Mar 2019 16:36:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12560 invoked by uid 111); 13 Mar 2019 16:35:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 12:35:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 12:35:16 -0400
Date:   Wed, 13 Mar 2019 12:35:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/4] rebase -i: demonstrate obscure loose object cache bug
Message-ID: <20190313163516.GA26045@sigill.intra.peff.net>
References: <pull.161.git.gitgitgadget@gmail.com>
 <b3fcd377652103584b6f307c6ee209980b44529f.1552472189.git.gitgitgadget@gmail.com>
 <87k1h2bvpb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1h2bvpb.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 05:11:44PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > And this is where the loose object cache interferes with this feature:
> > if *some* loose object was read whose hash shares the same first two
> > digits with a commit that was not yet created when that loose object was
> > created, then we fail to find that new commit by its short name in
> > `get_oid()`, and the interactive rebase fails with an obscure error
> > message like:
> >
> > 	error: invalid line 1: pick 6568fef
> > 	error: please fix this using 'git rebase --edit-todo'.

Are we 100% sure this part is necessary? From my understanding of the
problem, even without any ambiguity get_oid() could fail due to just
plain not finding the object in question.

> As a further improvement, is there a good reason for why we wouldn't
> pass something down to the oid machinery to say "we're only interested
> in commits". I have a WIP series somewhere to generalize that more, but
> e.g.  here locally:

We have get_oid_commit() and get_oid_committish() already. Should rebase
just be using those? (I think we probably want "commit()", because we do
not expect a "pick" line to have a tag, for example.

-Peff
