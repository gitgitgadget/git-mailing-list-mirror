Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45F4C32771
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 17:57:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiIZR5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 13:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiIZR5K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 13:57:10 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91D560CF
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 10:35:07 -0700 (PDT)
Received: (qmail 27500 invoked by uid 109); 26 Sep 2022 17:35:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Sep 2022 17:35:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10333 invoked by uid 111); 26 Sep 2022 17:35:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Sep 2022 13:35:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Sep 2022 13:35:04 -0400
From:   Jeff King <peff@peff.net>
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com
Subject: Re: [PATCH] read-cache: avoid misaligned reads in index v4
Message-ID: <YzHiyPkCgVHym3H4@coredump.intra.peff.net>
References: <pull.1366.git.1663962236069.gitgitgadget@gmail.com>
 <Yy4nkEnhuzt2iH+R@coredump.intra.peff.net>
 <e5954e90-6b5c-46a6-0842-b3d7d1e06b33@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5954e90-6b5c-46a6-0842-b3d7d1e06b33@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2022 at 08:39:10AM -0700, Victoria Dye wrote:

> > So this can just be:
> > 
> >   ce->ce_stat_data.sd_mtime.sec = get_be32(ondisk + offsetof(struct ondisk_cache_entry, mtime));
> > 
> > which is mercifully shorter.
> > 
> > Assuming we dismiss the rest of what I said as not worth it for a
> > minimal fix, I do think that simplification is worth rolling a v2.
> 
> That makes sense from a technical perspective, but I included the starting
> entry offset for readability reasons. It might be confusing to someone
> unfamiliar with C struct memory alignment to see every other 'get_be32'
> refer to the exact entry it's reading via the 'offsetof()', but have that
> information absent only for a few entries. And, the double 'offsetof()'
> would still be used by the 'mtime.nsec'/'ctime.nsec' fields anyway.

Ah, right, I wasn't looking close enough. I was thinking that you were
reading the whole struct via a single function call, but of course that
is not true with get_be32(), and the nsec loads just below make that
obvious.

> In any case, if this patch is intended to be a short-lived change on the way
> to a more complete refactor and/or I'm being overzealous on the readability,
> I'd be happy to change it. :) 

No, I was just mis-reading it. I think what you've got here is a good
stopping point to fix the immediate problem.

-Peff
