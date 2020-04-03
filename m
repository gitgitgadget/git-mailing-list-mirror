Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98E9C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E3F2077D
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391065AbgDCSa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:30:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:60856 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2390874AbgDCSa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 14:30:58 -0400
Received: (qmail 29425 invoked by uid 109); 3 Apr 2020 18:30:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Apr 2020 18:30:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21503 invoked by uid 111); 3 Apr 2020 18:41:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Apr 2020 14:41:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Apr 2020 14:30:57 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] commit-graph: error out on invalid commit oids in
 'write --stdin-commits'
Message-ID: <20200403183057.GA659224@coredump.intra.peff.net>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
 <20190805080240.30892-4-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190805080240.30892-4-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 05, 2019 at 10:02:40AM +0200, SZEDER Gábor wrote:

> While 'git commit-graph write --stdin-commits' expects commit object
> ids as input, it accepts and silently skips over any invalid commit
> object ids, and still exits with success:
> 
>   # nonsense
>   $ echo not-a-commit-oid | git commit-graph write --stdin-commits
>   $ echo $?
>   0
>   # sometimes I forgot that refs are not good...
>   $ echo HEAD | git commit-graph write --stdin-commits
>   $ echo $?
>   0
>   # valid tree OID, but not a commit OID
>   $ git rev-parse HEAD^{tree} | git commit-graph write --stdin-commits
>   $ echo $?
>   0
>   $ ls -l .git/objects/info/commit-graph
>   ls: cannot access '.git/objects/info/commit-graph': No such file or directory
> 
> Check that all input records are indeed valid commit object ids and
> return with error otherwise, the same way '--stdin-packs' handles
> invalid input; see e103f7276f (commit-graph: return with errors during
> write, 2019-06-12).

Can you explain more why the old behavior is a problem? For reasons (see
below), we want to do something like:

  git for-each-ref --format='%(objectname)' |
  git commit-graph write --stdin-commits

In v2.23 and earlier, that worked exactly like --reachable, but now it
will blow up if there are any refs that point to a non-commit (e.g., a
tag of a blob).

It can be worked around by asking for %(objecttype) and %(*objecttype)
and grepping the result, but that's awkward and much less efficient
(especially if you have a lot of annotated tags, as we may have to open
and parse each one).

Now obviously you could just use --reachable for the code above. But
here are two plausible cases where you might not want to do that:

 - you're limiting the graph to only a subset of refs (e.g., you want to
   graph refs/heads/ and refs/tags, but not refs/some-other-weird-area/).

 - you're generating an incremental graph update. You know somehow that
   a few refs were updated, and you want to feed those tips to generate
   the incremental, but not the rest of the refs (not because it would
   be wrong to do so, but in the name of keeping it O(size of change)
   and not O(number of refs in the repo).

The latter is the actual case that bit us. I suppose one could do
something like:

  git rev-list --no-walk <maybe-commits |
  git commit-graph write --stdin-commits

to use rev-list as a filter, but that feels kind of baroque.

Normally I'm in favor of more error checking instead of less, but in
this case it feels like it's putting scripted use at a disadvantage
versus the internal code (e.g., the auto-write for git-fetch uses the
"--reachable" semantics for its internal invocation).

-Peff

PS As an aside, I think the internal git-fetch write could benefit from
   this same trick: feed the set of newly-stored ref tips to the
   commit-graph machinery, rather than using for_each_ref().
