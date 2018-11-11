Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB89A1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 07:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeKKQu0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 11:50:26 -0500
Received: from cloud.peff.net ([104.130.231.41]:47656 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727334AbeKKQu0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 11:50:26 -0500
Received: (qmail 725 invoked by uid 109); 11 Nov 2018 07:02:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 11 Nov 2018 07:02:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31889 invoked by uid 111); 11 Nov 2018 07:02:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 11 Nov 2018 02:02:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Nov 2018 02:02:40 -0500
Date:   Sun, 11 Nov 2018 02:02:40 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, me@ttaylorr.com, jrnieder@gmail.com
Subject: Re: [PATCH 07/10] fast-export: ensure we export requested refs
Message-ID: <20181111070240.GG30850@sigill.intra.peff.net>
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com>
 <20181111062312.16342-8-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181111062312.16342-8-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 10, 2018 at 10:23:09PM -0800, Elijah Newren wrote:

> If file paths are specified to fast-export and a ref points to a commit
> that does not touch any of the relevant paths, then that ref would
> sometimes fail to be exported.  (This depends on whether any ancestors
> of the commit which do touch the relevant paths would be exported with
> that same ref name or a different ref name.)  To avoid this problem,
> put *all* specified refs into extra_refs to start, and then as we export
> each commit, remove the refname used in the 'commit $REFNAME' directive
> from extra_refs.  Then, in handle_tags_and_duplicates() we know which
> refs actually do need a manual reset directive in order to be included.
> 
> This means that we do need some special handling for excluded refs; e.g.
> if someone runs
>    git fast-export ^master master
> then they've asked for master to be exported, but they have also asked
> for the commit which master points to and all of its history to be
> excluded.  That logically means ref deletion.  Previously, such refs
> were just silently omitted from being exported despite having been
> explicitly requested for export.

Hmm. Reading this it makes sense to me, but I remember from discussion
long ago that there were a lot of funny corner cases around "which refs
to include" and possibly even some ambiguous cases. Maybe that is all
sorted these days, with --refspec.

> ---
> NOTE: I was hoping the strmap API proposal would materialize, but I either
> missed it or it hasn't shown up.  The usage of string_list in this patch
> would be better replaced by what Peff suggested.

You didn't miss it. Junio did some manual conversions using hashmap,
which weren't too bad.  It's not entirely clear to me how often we'd be
able to use strmap instead of a full-on hashmap, so I haven't really
pursued it.

It looks like you generate the list here via append, and then sort at
the end. That's at least not quadratic. I think the string_list_remove()
is, though.

-Peff
