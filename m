Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC8851F453
	for <e@80x24.org>; Wed, 26 Sep 2018 03:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeIZJ1h (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 05:27:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:59694 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726197AbeIZJ1h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 05:27:37 -0400
Received: (qmail 14656 invoked by uid 109); 26 Sep 2018 03:16:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Sep 2018 03:16:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14605 invoked by uid 111); 26 Sep 2018 03:16:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 25 Sep 2018 23:16:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Sep 2018 23:16:52 -0400
Date:   Tue, 25 Sep 2018 23:16:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v2 3/3] transport.c: introduce core.alternateRefsPrefixes
Message-ID: <20180926031651.GA32064@sigill.intra.peff.net>
References: <20180921221832.GC11177@sigill.intra.peff.net>
 <xmqqftxzsz5x.fsf@gitster-ct.c.googlers.com>
 <20180924181011.GA24781@sigill.intra.peff.net>
 <xmqqa7o6skkl.fsf@gitster-ct.c.googlers.com>
 <20180924205022.GA26936@sigill.intra.peff.net>
 <xmqqva6ur24y.fsf@gitster-ct.c.googlers.com>
 <20180924231455.GA7702@sigill.intra.peff.net>
 <xmqq1s9hqxtt.fsf@gitster-ct.c.googlers.com>
 <20180925224645.GG4364@syl>
 <xmqq4lednnc4.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lednnc4.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 04:56:11PM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> > My reading of this is threefold:
> >
> >   1. There are some cosmetic changes that need to occur in t5410 and
> >      documentation, which are mentioned above. Those seem self
> >      explanatory, and I've applied the necessary bits already on my
> >      local version of this topic.
> >
> >   2. The core.alternateRefsCommand vs transport.* discussion was
> >      resolved in [1] as "let's use core.alternateRefsCommand and
> >      core.alternateRefsPrefixes" for now, and others contributors can
> >      change this as is needed.
> >
> >   3. We can apply Peff's patch to remove the refname requirement before
> >      mine, as well as any relevant changes in my series as have been
> >      affected by Peff's patch (e.g., documentation mentioning
> >      '%(refname)', etc).

Yeah, these three sound right to me.

> I do think it makes sense to allow alternateRefsCommand to output
> just the object names without adding any refnames, and to keep the
> parser simple, we should not even make the refname optional
> (i.e. "allow" above becomes "require"), and make the default one
> done via an invocation of for-each-ref also do the same.

Yeah, making it optional is just the worst of both worlds, IMHO. Then
callers sometimes get a real value and sometimes just whatever garbage
we fill in, and can't rely on it.

> I do not think there was a strong concensus that we need to change
> the internal C API signature, though.  If the function signature for
> the callback between each_ref_fn and alternate_ref_fn were the same,
> I would have opposed to the change, but because they are already
> different, I do not think it is necessary to keep the dummy refname
> parameter that is always passed a meaningless value.

Agreed. I adjusted my "rev-list --alternate-refs" patch for the proposed
new world order (just because it's the likely user of the refname
field). Since the function signatures aren't the same, I already had a
custom callback. It did chain to the existing each_ref_fn one, so I had
to adjust it like so:

diff --git a/revision.c b/revision.c
index 3988275fde..8dfe2fd4c0 100644
--- a/revision.c
+++ b/revision.c
@@ -1396,11 +1396,10 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 	free_worktrees(worktrees);
 }
 
-static void handle_one_alternate_ref(const char *refname,
-				     const struct object_id *oid,
+static void handle_one_alternate_ref(const struct object_id *oid,
 				     void *data)
 {
-	handle_one_ref(refname, oid, 0, data);
+	handle_one_ref(".have", oid, 0, data);
 }
 
 static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,

But I think that's fine. We have to handle the lack of name _somewhere_
in the call stack, so I'd just as soon it be here in the callback, where
we know what it will be used for (or not used at all).

> The final series would be
> 
>  1/4: peff's "refnames in alternates do nto matter"
> 
>  2/4: your "hardcoded for-each-ref becomes just a default"
> 
>  3/4: your "config can affect what command enumerates alternate's tips"
> 
>  4/4: your "with prefix config, you don't need a fully custom command"

Yep, that's what I'd expect from the new series.

-Peff
