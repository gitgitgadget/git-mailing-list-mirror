Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 693AE1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 16:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbeKMCZZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 21:25:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:36070 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728103AbeKMCZY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 21:25:24 -0500
Received: (qmail 960 invoked by uid 109); 12 Nov 2018 16:31:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 16:31:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12949 invoked by uid 111); 12 Nov 2018 16:30:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 11:30:46 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 11:31:24 -0500
Date:   Mon, 12 Nov 2018 11:31:24 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/10] fast-export: add a --show-original-ids option to
 show original names
Message-ID: <20181112163124.GA5735@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-10-newren@gmail.com>
 <20181111072007.GI30850@sigill.intra.peff.net>
 <CABPp-BGNt0FcqiT=OqctjOEvY9ewNUJZ-Rs_aVEihjbQt3K8tQ@mail.gmail.com>
 <20181112125341.GH3956@sigill.intra.peff.net>
 <CABPp-BG6FJjFm7ZFWpe--n3-vXzAcrQYWXmx4M4hA_kkSPJhkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BG6FJjFm7ZFWpe--n3-vXzAcrQYWXmx4M4hA_kkSPJhkQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 07:46:14AM -0800, Elijah Newren wrote:

> So maybe my commit message should have been something
> more like:
> 
> """
> Knowing the original names (hashes) of commits can sometimes enable
> post-filtering that would otherwise be difficult or impossible.  In
> particular, the desire to rewrite commit messages which refer to other
> prior commits (on top of whatever other filtering is being done) is
> very difficult without knowing the original names of each commit.
> 
> In addition, knowing the original names (hashes) of blobs can allow
> filtering by blob-id without requiring re-hashing the content of the
> blob, and is thus useful as a small optimization.
> 
> Once we add original ids for both commits and blobs, we may as well
> add them for tags too for completeness.  Perhaps someone will have a
> use for them.
> 
> This commit teaches a new --show-original-ids option to fast-export
> which will make it add a 'original-oid <hash>' line to blob, commits,
> and tags.  It also teaches fast-import to parse (and ignore) such
> lines.
> """
> 
> ?

Yes, that makes much more sense to me (though of course I've also been
discussing it with you, so just about anything would at this point ;) ).

It's possible that somebody would want to filter on tree id's, too. A
fast-import stream just has trees incidentally as part of commit state,
but we could say something like "by the way, this tree is X". You can
even do "fast-export -t" to see subtrees, though I am not sure if that
is intentional or just an artifact of being based on the diff code.

I guess that is not all that useful, though. I was mostly thinking about
it because of your "we may as well add them for tags too for
completeness" above. But the issues around trees are sufficiently subtle
that we're probably better off not trying to handle them here. There's a
good chance we'd get it wrong, making our "let's just add this for
completeness while we're here" totally backfire.

-Peff
