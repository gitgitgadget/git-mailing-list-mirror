Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63033C7618A
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 19:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjCOTpM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjCOTpC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 15:45:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E56EA7
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 12:45:00 -0700 (PDT)
Received: (qmail 20009 invoked by uid 109); 15 Mar 2023 19:45:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Mar 2023 19:45:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3838 invoked by uid 111); 15 Mar 2023 19:44:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Mar 2023 15:44:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Mar 2023 15:44:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 1/8] for-each-ref: add --stdin option
Message-ID: <ZBIgOwP5HhR1RJZp@coredump.intra.peff.net>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <a1d9e0f6ff6660c9264673be18bc24956f74eb9c.1678468864.git.gitgitgadget@gmail.com>
 <ZBIFEXuE5Um9Z4zM@coredump.intra.peff.net>
 <xmqqpm99om1p.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpm99om1p.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2023 at 12:24:18PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... we may
> > want some kind of "literal" mode, that takes in a list of refs rather
> > than a list of patterns, and does a sorted-merge with the list of
> > available refs (or uses a hash table, I guess, but for-each-ref also
> > tries to avoid even being linear in the total number of refs, so you'd
> > still want to find the lowest/highest to bound the iteration).
> 
> Exactly.
> 
> I actually was wondering if "literal" mode can just take a list of
> <things>, and when a <thing> is not a refname, use it as if it
> were. I.e. %(refname) would parrot it, while %(refname:short) would
> not shorten and still parrot it, if the <thing> is 73876f4861c, but
> something like %(subject) would still work.

Yeah, I think that would nicely solve the quadratic issue _and_ the
"we are stuck using only ref tips" issue. I like it.

> For that, I suspect ref-filter.c::filter_refs() would need to learn
> a different kind fo finter->kind that iterates over the literal
> "refs" that was fed from the standard input, instead of calling
> for_each_fullref_in() for the given hierarchy, but the new iterator
> should be able to reuse the ref_filter_hander() for the heavy
> lifting.

Yeah, that sounds about right from my recollection of the code. I
suspect there may be other sharp edges (e.g., asking for %(upstream)
isn't meaningful for a non-ref). But softening those is actually
something I think we want to do in the long run, as it helps with the
long-term goal of sharing pretty-printing code between ref-filter,
cat-file, and pretty.c.

-Peff
