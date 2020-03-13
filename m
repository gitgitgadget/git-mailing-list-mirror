Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 017E2C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 02:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4B7206F7
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 02:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgCMCag (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 22:30:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:38636 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726114AbgCMCaf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 22:30:35 -0400
Received: (qmail 16960 invoked by uid 109); 13 Mar 2020 02:30:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Mar 2020 02:30:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3842 invoked by uid 111); 13 Mar 2020 02:40:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2020 22:40:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Mar 2020 22:30:34 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>, git@jeffhostetler.com
Subject: Re: [PATCH] connected.c: reprepare packs for corner cases
Message-ID: <20200313023034.GA900007@coredump.intra.peff.net>
References: <pull.579.git.1584027403779.gitgitgadget@gmail.com>
 <xmqqzhcle23x.fsf@gitster.c.googlers.com>
 <20200312211638.GA872402@coredump.intra.peff.net>
 <20200312212613.GB872402@coredump.intra.peff.net>
 <7378a863-7e2a-455e-4635-e07938ef3381@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7378a863-7e2a-455e-4635-e07938ef3381@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 08:54:34PM -0400, Derrick Stolee wrote:

> On 3/12/2020 5:26 PM, Jeff King wrote:
> > On Thu, Mar 12, 2020 at 05:16:38PM -0400, Jeff King wrote:
> > 
> >> There we see that same reprepare happen in 882839, which is the child
> >> fetch-pack. The parent fetch probably needs to reprepare itself after
> >> fetch-pack completes.
> 
> I agree with you and Junio that where I put the reprepare was non-
> optimal. The initial reason to put it there was that I found where
> the error was happening, and thought that placing the reprepare there
> was the best way to prevent this error from popping up in another case.

To be fair to you, the place you put it is almost certainly fine in
practice. The connectivity check is likely the first time we'll actually
look at the objects in the parent process, and once we've re-scanned,
all the code after us is protected.

But I do still think it's cleaner to put it closer to the responsible
code.

Although there was one thing that puzzled me when writing the previous
email. Why isn't this a problem for non-partial clones? And the answer
is that in a normal repo, as soon as we try to look up a missing object,
we'd trigger the usual re-scan. But we _don't_ do object lookups in
check_connected(). We do this funky loop over get_all_packs() ourselves,
looking only at promisor packs. And if we didn't find the object, then
we immediately complain in that loop with no fallback to re-scan.

So that would actually argue that your patch is putting it in the right
place. It's _not_ fetch's responsibility to reprepare_packed_git(). It's
the loop in check_connected() that is skipping the usual reprepare
logic, and shouldn't.

And one fix (which you did) is to just preemptively reprepare right
above that loop. Some other solutions are:

  - teach the loop to reprepare() when we don't find an object and see
    if we picked up a new promisor pack

  - reverse the loop logic: look up each object in the usual way (in all
    packs), and see if the resulting pack is a promisor. I guess that
    produces slightly different results though if an object is in the
    new promisor pack _and_ available elsewhere; but isn't the point of
    that check_refs_are_promisor_objects_only flag that we're doing a
    clone?

> I wonder if we could do something more complicated in the long-term,
> which was recommended to me by Jeff Hostetler: add the pack to the
> packed_git list once we've indexed it. That way, we don't reprepare
> and scan the packs one-by-one, but instead we insert to the list
> a single pack that we already know about.

I don't think the parent git-fetch process even knows about the pack,
though. It just asked the remote-helper to somehow make the objects
arrive, and it doesn't know what form that took.

reprepare_packed_git() should be pretty cheap, though. If we already
have a pack in the list, we won't re-open it. Finding out if we already
had one used to be O(n), making the whole re-scan quadratic. But that
was fixed recently in ec48540fe8 (packfile.c: speed up loading lots of
packfiles, 2019-11-27), where we switched to keeping a hashmap of
loaded pack names.

-Peff
