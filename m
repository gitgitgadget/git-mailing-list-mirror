Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2CD31F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751681AbeCPUts (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:49:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:59940 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750826AbeCPUtr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:49:47 -0400
Received: (qmail 9094 invoked by uid 109); 16 Mar 2018 20:49:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Mar 2018 20:49:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 465 invoked by uid 111); 16 Mar 2018 20:50:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Mar 2018 16:50:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Mar 2018 16:49:45 -0400
Date:   Fri, 16 Mar 2018 16:49:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
Message-ID: <20180316204945.GA12333@sigill.intra.peff.net>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
 <878tasdpqo.fsf@evledraar.gmail.com>
 <CAM0VKjknPZj-qHzf5nVr_RdHtB+pq2+APc1tesexP-eFSP9n_A@mail.gmail.com>
 <xmqq370z3m5o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq370z3m5o.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 11:33:55AM -0700, Junio C Hamano wrote:

> It is not so surprising that history walking runs rings around
> enumerating objects in packfiles, if packfiles are built well.
> 
> A well-built packfile tends to has newer objects in base form and
> has delta that goes in backward direction (older objects are
> represented as delta against newer ones).  This helps warlking from
> the tips of the history quite a bit, because your delta base cache
> will tend to have the base object (i.e. objects in the newer part of
> the history you just walked) that will be required to access the
> "next" older part of the history more often than not.
> 
> Trying to read the objects in the pack in their object name order
> would essentially mean reading them in a cryptgraphically random
> order.  Half the time you will end up wanting to access an object
> that is near the tip of a very deep delta chain even before you've
> accessed any of the base objects in the delta chain.

I coincidentally was doing some experiments in this area a few weeks
ago, and found a few things:

  1. The ordering makes a _huge_ difference for accessing trees and
     blobs.

  2. Pack order (not pack-idx order) is actually the best order, since
     it tends to follow the delta patterns (it's close to traversal
     order, but packs delta families more tightly).

  3. None of this really matters for commits, since we almost never
     store them as deltas anyway.

Here are a few experiments people can do themselves to demonstrate (my
numbers here are all from linux.git, which is sort of a wort-case
for bad ordering because its size stresses the default delta cache):

  [every object in sha1 order: slow]
  $ time git cat-file --batch-all-objects --batch >/dev/null
  real	8m44.041s
  user	8m31.359s
  sys	0m12.262s

  [every object from a traversal: faster, but --objects traversals are
   actually CPU heavy due to all of the hash lookups for each tree. Note
   not just wall-clock time but the CPU since it's split across two
   processes]
  $ time git rev-list --objects --all |
         cut -d' ' -f2 |
	 git cat-file --batch >/dev/null
  real	1m2.667s
  user	0m58.537s
  sys	0m32.392s

  [every object in pack order: fastest. This is due to skipping the
   traversal overhead, and should use our delta cache quite efficiently.
   I'm assuming a single pack and no loose objects here, but the
   performance should generalize since accessing the "big" pack
   dominates]
  $ time git show-index <$(ls .git/objects/pack/*.idx) |
         sort -n |
         cut -d' ' -f2 |
	 git cat-file --batch >/dev/null
  real	0m51.718s
  user	0m50.963s
  sys	0m7.068s

  [just commits, sha1 order: not horrible]
  $ time git cat-file --batch-all-objects --batch-check='%(objecttype) %(objectname)' |
         grep ^commit |
	 cut -d' ' -f2 |
	 git cat-file --batch >/dev/null
  real	0m8.115s
  user	0m14.033s
  sys	0m1.170s

  [just commits, pack order: slightly worse due to the extra piping, but
   obviously that could be done more quickly internally]
  $ time git show-index <$(ls .git/objects/pack/*.idx) |
         sort -n |
         cut -d' ' -f2 |
	 git cat-file --batch-check='%(objecttype) %(objectname)' |
         grep ^commit |
	 cut -d' ' -f2 |
	 git cat-file --batch >/dev/null
  real	0m21.670s
  user	0m24.867s
  sys	0m9.600s

  [and the reason is that hardly any commits get deltas]
  $ git cat-file --batch-all-objects --batch-check='%(objecttype) %(deltabase)' |
    grep ^commit >commits
  $ wc -l commits
  692596
  $ grep -v '0000000000000000000000000000000000000000' commits | wc -l
  18856

For the purposes of this patch series, I don't think the order matters
much, since we're only dealing with commits. For doing --batch-check, I
think the sha1 ordering given by "cat-file --batch-all-objects" is
convenient, and doesn't have a big impact on performance. But it's
_awful_ for --batch. I think we may want to add a sorting option to just
return the objects in the original packfile order.

-Peff
