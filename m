Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448EFC4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 01:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiLIBhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 20:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiLIBhH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 20:37:07 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0B986F7B
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 17:37:06 -0800 (PST)
Received: (qmail 30742 invoked by uid 109); 9 Dec 2022 01:37:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Dec 2022 01:37:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19208 invoked by uid 111); 9 Dec 2022 01:37:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Dec 2022 20:37:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Dec 2022 20:37:04 -0500
From:   Jeff King <peff@peff.net>
To:     Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        johncai86@gmail.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Question: How to execute git-gc correctly on the git server
Message-ID: <Y5KRQMcUlepwNlor@coredump.intra.peff.net>
References: <CAOLTT8Tt3jW2yvm6BRU3yG+EvW1WG9wWFq6PuOcaHNNLQAaGjg@mail.gmail.com>
 <221208.86a63y9309.gmgdl@evledraar.gmail.com>
 <20221208011631.GH28810@kitsune.suse.cz>
 <Y5GLsZgmrxbBtLqo@coredump.intra.peff.net>
 <20221209004918.GI28810@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221209004918.GI28810@kitsune.suse.cz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2022 at 01:49:18AM +0100, Michal Suchánek wrote:

> > In this case it's the mtime on the object file (or the pack containing
> > it). But yes, it is far from a complete race-free solution.
> 
> So if you are pushing a branch that happens to reuse commits or other
> objects from an earlier branh that might have been collected ín the
> meantime you are basically doomed.

Basically yes. We do "freshen" the mtimes on object files when we omit
an object write (e.g., your index state ends up at the same tree as an
old one). But for a push, there is no freshening. We check the graph at
the time of the push and decide if we have everything we need (either
newly pushed, or from what we already had in the repo). And that is
what's racy; somebody might be deleting as that check is happening.

> People deleting a branch and then pushing another variant in which many
> objects are the same is a risk.
> 
> People exporting files from somewhere and adding them to the repo which
> are bit-identical when independently exported by multiple people and
> sometimes deleting branches is a risk.

Yes, both of those are risky (along with many other variants).

-Peff
