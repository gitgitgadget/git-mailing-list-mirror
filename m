Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC46B2090A
	for <e@80x24.org>; Mon, 20 Mar 2017 19:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756409AbdCTTxa (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 15:53:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:48019 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756394AbdCTTwO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 15:52:14 -0400
Received: (qmail 20430 invoked by uid 109); 20 Mar 2017 19:52:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 19:52:13 +0000
Received: (qmail 5430 invoked by uid 111); 20 Mar 2017 19:52:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 15:52:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 15:52:09 -0400
Date:   Mon, 20 Mar 2017 15:52:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 6/8] ref-filter: Add --no-contains option to
 tag/branch/for-each-ref
Message-ID: <20170320195209.oyivf2ta3m3kg264@sigill.intra.peff.net>
References: <20170318103256.27141-1-avarab@gmail.com>
 <20170318103256.27141-7-avarab@gmail.com>
 <20170320042519.srtavoxhm3fln5mw@sigill.intra.peff.net>
 <CACBZZX6FWjG1bXrk+ee8y=T5=ovxxybfrGzkkDxjskwDzhKPuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6FWjG1bXrk+ee8y=T5=ovxxybfrGzkkDxjskwDzhKPuA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 10:32:47AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I think the more relevant comparison is "--no-merged", and it behaves
> > the same way as your new --no-contains. I don't think I saw this
> > subtlety in the documentation, though. It might be worth mentioning
> > (unless I just missed it).
> 
> For --contains we explicitly document "contain the specified commit",
> i.e. you couldn't expect this to list tree-test, and indeed it
> doesn't:
> 
>     $ git tag tree-test master^{tree}
>     $ git tag -l --contains master '*test*'

Right, "--contains" cannot have a commit inside a tree, so we were
correct to skip the computation entirely. But does that mean that
"--no-contains" should be the complement of that, or should it only
include tags whose "contains" can be computed in the first place?

IOW, I don't think --contains or --merged are interesting here; they
give the right answer by skipping the computation. The question is what
the "--no-" variants should do.

> However the --[no-]merged option says "reachable [...] from the
> specified commit", which seems to me to be a bit more ambiguous as to
> whether you could expect it to print tree/blob tags.

I suspect that --no-merged behaves the way it does because it originally
came from git-branch, where you only have commits in the first place.
The other commands only learned about it during the move to ref-filter,
and nobody thought about this corner case.

So we could just treat it like a bug and fix it.  But I doubt anybody
cares that much in practice either way, so documenting it as "any use of
--contains, --no-contains, --no-merged, or --merged requires that the
ref in question be a commit" is fine, too.

-Peff
