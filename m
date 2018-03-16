Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C957B1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeCPUGm (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:06:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:59826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751468AbeCPUGl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:06:41 -0400
Received: (qmail 7557 invoked by uid 109); 16 Mar 2018 20:06:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Mar 2018 20:06:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32473 invoked by uid 111); 16 Mar 2018 20:07:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Mar 2018 16:07:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Mar 2018 16:06:39 -0400
Date:   Fri, 16 Mar 2018 16:06:39 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
Message-ID: <20180316200639.GA1845@sigill.intra.peff.net>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <20180314192736.70602-1-dstolee@microsoft.com>
 <878tasdpqo.fsf@evledraar.gmail.com>
 <CAM0VKjknPZj-qHzf5nVr_RdHtB+pq2+APc1tesexP-eFSP9n_A@mail.gmail.com>
 <xmqq370z3m5o.fsf@gitster-ct.c.googlers.com>
 <CAM0VKjmVgiWsqo8rQWwP9+mEq0tLinc8xoUM=8XdMP3VTBwJxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjmVgiWsqo8rQWwP9+mEq0tLinc8xoUM=8XdMP3VTBwJxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 08:48:49PM +0100, SZEDER Gábor wrote:

> I came up with a different explanation back then: we are only interested
> in commit objects when creating the commit graph, and only a small-ish
> fraction of all objects are commit objects, so the "enumerate objects in
> packfiles" approach has to look at a lot more objects:
> 
>   # in my git fork
>   $ git rev-list --all --objects |cut -d' ' -f1 |\
>     git cat-file --batch-check='%(objecttype) %(objectsize)' >type-size
>   $ grep -c ^commit type-size
>   53754
>   $ wc -l type-size
>   244723 type-size
> 
> I.e. only about 20% of all objects are commit objects.
> 
> Furthermore, in order to look at an object it has to be zlib inflated
> first, and since commit objects tend to be much smaller than trees and
> especially blobs, there are a lot less bytes to inflate:
> 
>   $ grep ^commit type-size |cut -d' ' -f2 |avg
>   34395730 / 53754 = 639
>   $ cat type-size |cut -d' ' -f2 |avg
>   3866685744 / 244723 = 15800
> 
> So a simple revision walk inflates less than 1% of the bytes that the
> "enumerate objects packfiles" approach has to inflate.

I don't think this is quite accurate. It's true that we have to
_consider_ every object, but Git is smart enough not to inflate each one
to find its type. For loose objects we just inflate the header. For
packed objects, we either pick the type directly out of the packfile
header (for a non-delta) or can walk the delta chain (without actually
looking at the data bytes!) until we hit the base.

So starting from scratch:

  git cat-file --batch-all-objects --batch-check='%(objecttype) %(objectname)' |
  grep ^commit |
  cut -d' ' -f2 |
  git cat-file --batch

is in the same ballpark for most repos as:

  git rev-list --all |
  git cat-file --batch

though in my timings the traversal is a little bit faster (and I'd
expect that to remain the case when doing it all in a single process,
since the traversal only follows commit links, whereas processing the
object list has to do the type lookup for each object before deciding
whether to inflate it).

I'm not sure, though, if that edge would remain for incremental updates.
For instance, after we take in some new objects via "fetch", the
traversal strategy would want to do something like:

  git rev-list $new_tips --not --all |
  git cat-file --batch

whose performance will depend on the refs _currently_ in the repository,
as we load them as UNINTERESTING tips for the walk. Whereas doing:

  git show-index <.git/objects/pack/the-one-new-packfile.idx |
  cut -d' ' -f2 |
  git cat-file --batch-check='%(objecttype) %(objectname)' |
  grep ^commit |
  cut -d' ' -f2 |
  git cat-file --batch

always scales exactly with the size of the new objects (obviously that's
kind of baroque and this would all be done internally, but I'm trying to
demonstrate the algorithmic complexity). I'm not sure what the plan
would be if we explode loose objects, though. ;)

-Peff
