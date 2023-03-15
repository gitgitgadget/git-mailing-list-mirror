Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0714AC61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 17:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjCORbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 13:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjCORba (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 13:31:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC2534C38
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 10:31:28 -0700 (PDT)
Received: (qmail 18477 invoked by uid 109); 15 Mar 2023 17:31:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Mar 2023 17:31:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2368 invoked by uid 111); 15 Mar 2023 17:31:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Mar 2023 13:31:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Mar 2023 13:31:27 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com
Subject: Re: [PATCH v2 0/8] ref-filter: ahead/behind counting, faster
 --merged option
Message-ID: <ZBIA7+85Lld+lpUS@coredump.intra.peff.net>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <xmqqedpw5se6.fsf@gitster.g>
 <74656b93-8c67-ffe3-4aea-4c184345384d@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74656b93-8c67-ffe3-4aea-4c184345384d@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2023 at 02:25:52PM -0500, Derrick Stolee wrote:

> > Having read all the patches, I am very impressed and pleased, but
> > are we losing anything by having the feature inside for-each-ref
> > compared to a new command ahead-behind?  As far as I can tell, the
> > new "for-each-ref --stdin" would still want to match refs and work
> > only on refs, but there shouldn't be any reason for ahead-behind
> > computation to limit to tips that are at the tip of a ref, so that
> > may be one downside in this updated design.  For the intended use
> > case of "let's find which branches are stale", that downside does
> > not matter in practice, but for other use cases people will think
> > of in the future, the limitation might matter (at which time we can
> > easily resurrect the other subcommand, using the internal machinery
> > we have here, so it is not a huge deal, I presume).
> 
> I think the for-each-ref implementation solves the use case we
> had in mind, I think. I'll double-check to see if we ever use
> exact commit IDs instead of reference names, but I think these
> callers are rarely interested in an exact commit ID but instead
> want the latest version of refs.

One thing I'd worry about here are race conditions.

If you have a porcelain-ish view (and I'd count "showing a web page" as
a porcelain view) that requires several commands to compute, it's
possible for there to be simultaneous ref updates between your commands.
If each command is given a refname, then the results may not be
consistent.

E.g., imagine resolving "main" to 1234abcd in step one, then somebody
updates it to 5678cdef, then you run "for-each-ref" to compute
ahead/behind, and now you show an inconsistent result: you say that
"main" points to 1234abcd, but show the wrong ahead/behind information.

Showing 1234abcd at all is out-of-date, of course, but the real problem
is the lack of atomicity. Most porcelain scripts deal with this by
resolving the refs immediately, assuming object ids are immutable (which
they are modulo games like refs/replace), and then working with them.

I don't know if this is how your current application-level code calling
ahead-behind works, or if it just accepts the possibility of a race (or
maybe the call is not presented along with other information so it's
sort-of atomic on its own). Presumably your double-checking will find
out. :)

I do otherwise like exposing this as an option of for-each-ref, as that
is the way I'd expect most normal client users to want to get at the
information. And if this is step 1 and that's good enough for now, and
we have a path forward to later expose it for general commits, that's OK
with me.

-Peff
