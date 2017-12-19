Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2058E1F404
	for <e@80x24.org>; Tue, 19 Dec 2017 11:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964956AbdLSLjC (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 06:39:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:42994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751578AbdLSLi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 06:38:58 -0500
Received: (qmail 1480 invoked by uid 109); 19 Dec 2017 11:38:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Dec 2017 11:38:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1350 invoked by uid 111); 19 Dec 2017 11:39:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 19 Dec 2017 06:39:23 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Dec 2017 06:38:56 -0500
Date:   Tue, 19 Dec 2017 06:38:56 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
Message-ID: <20171219113855.GA24558@sigill.intra.peff.net>
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
 <xmqq4lp2cisd.fsf@gitster.mtv.corp.google.com>
 <20171208101455.GC1899@sigill.intra.peff.net>
 <1654a696-73d5-c9ef-0fc2-bd82aaf2cabb@web.de>
 <xmqqd13p83sb.fsf@gitster.mtv.corp.google.com>
 <20171208212832.GC7355@sigill.intra.peff.net>
 <f1584860-d0d6-db82-0a49-021924c3e2b7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1584860-d0d6-db82-0a49-021924c3e2b7@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 18, 2017 at 08:18:17PM +0100, René Scharfe wrote:

> > I'd actually argue the other way: the simplest interface is one where
> > the string list owns all of its pointers. That keeps the
> > ownership/lifetime issues clear, and it's one less step for the caller
> > to have to remember to do at the end (they do have to clear() the list,
> > but they must do that anyway to free the array of items).
> > 
> > It does mean that some callers may have to remember to free a temporary
> > buffer right after adding its contents to the list. But that's a lesser
> > evil, I think, since the memory ownership issues are all clearly
> > resolved at the time of add.
> > 
> > The big cost is just extra copies/allocations.
> 
> An interface requiring callers to allocate can be used to implement a
> wrapper that does all allocations for them -- the other way around is
> harder.  It can be used to avoid object duplication, but duplicates
> functions.  No idea if that's worth it.

Sure, but would anybody actually want to _use_ the non-wrapped version?
That's the same duality we have now with string_list.

> > Having a "format into a string" wrapper doesn't cover _every_ string you
> > might want to add to a list, but my experience with argv_array_pushf
> > leads me to believe that it covers quite a lot of cases.
> 
> It would fit in with the rest of the API -- we have string_list_append()
> as a wrapper for string_list_append_nodup()+xstrdup() already.  We also
> have similar functions for strbuf and argv_array.  I find it a bit sad
> to reimplement xstrfmt() yet again instead of using it directly, though.

I dunno, I think could provide some safety and some clarity. IOW, why
_don't_ we like:

  string_list_append_nodup(list, xstrfmt(fmt, ...));

? I think because:

  1. It's a bit long and ugly.

  2. It requires a magic "nodup", because we're violating the memory
     ownership boundary.

  3. It doesn't provide any safety for the case where strdup_strings is
     not set, making it easy to leak accidentally.

Doing:

  string_list_appendf(list, fmt, ...);

pushes the memory ownership semantics "under the hood" of the
string_list API. And as opposed to being a simple wrapper, it could
assert that strdup_strings is set (we already do some similar assertions
in the split functions).

-Peff
