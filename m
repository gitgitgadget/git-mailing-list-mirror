Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD93DC433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 23:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9131464F0A
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 23:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhBXXwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 18:52:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:44086 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231810AbhBXXwK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 18:52:10 -0500
Received: (qmail 3558 invoked by uid 109); 24 Feb 2021 23:51:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Feb 2021 23:51:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20940 invoked by uid 111); 24 Feb 2021 23:51:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Feb 2021 18:51:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Feb 2021 18:51:29 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] dir: fix malloc of root untracked_cache_dir
Message-ID: <YDbmgXVKVsog6K+r@coredump.intra.peff.net>
References: <pull.884.git.1614177117508.gitgitgadget@gmail.com>
 <xmqqk0qxz0s5.fsf@gitster.g>
 <YDa/hT8g8FvmpXYT@coredump.intra.peff.net>
 <581ece66-6a93-eda6-67bf-3bb49f553dfc@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <581ece66-6a93-eda6-67bf-3bb49f553dfc@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 04:15:11PM -0500, Jeff Hostetler wrote:

> > When I added the FLEX_ALLOC_* helpers, I audited for existing callers to
> > convert. But I did so by looking for places where we were doing manual
> > size computations. The bug here was that it was not doing any
> > computation at all (when it need to be doing "+1"). So that's my guess
> > why it got overlooked (which is not super important, but may give a hint
> > about how to look for similar bugs).
> 
> There's another call to xmalloc() at [1] that does the st_add3()
> thing that I didn't change.  It was correctly computing the size
> so I didn't want to change it for no reason.  That and the 2 memcpy()s
> made it feel like we should have a different FLEX_ macro for this
> case -- more of a FLEX_DUP... or something.  But I didn't want to
> distract from my bug fix here.

Thanks for pointing it out. Even if we change it, I agree it's better to
keep it out of your existing bugfix patch.

But I do think that spot gets weird. We are copying all of the elements
of the struct _except_ the name field, which comes from somewhere else.
So it's tempting to do:

diff --git a/dir.c b/dir.c
index d153a63bbd..ab16db3f76 100644
--- a/dir.c
+++ b/dir.c
@@ -3287,9 +3287,9 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 	if (!eos || eos == end)
 		return -1;
 
-	*untracked_ = untracked = xmalloc(st_add3(sizeof(*untracked), eos - data, 1));
+	FLEX_ALLOC_MEM(untracked, name, data, eos - data);
 	memcpy(untracked, &ud, sizeof(ud));
-	memcpy(untracked->name, data, eos - data + 1);
+	*untracked_ = untracked;
 	data = eos + 1;
 
 	for (i = 0; i < untracked->untracked_nr; i++) {

But that's wrong! The remaining memcpy using sizeof(ud) might or might
not touch the first byte of the name field, depending on struct padding
and the value of FLEX_ARRAY. And if it does, then we'd be overwriting
the early bytes of that field with whatever was in "ud" (which I guess
is uninitialized cruft, because that is a stack variable).

So it would have to be:

  memcpy(untracked, &ud, offsetof(struct untracked_cache_dir, name));

Quite subtle. Even with a comment, I think I prefer the existing code.
If we had a macro as you suggest for "allocate a flex struct, dup most of
the contents from this other struct, and then copy in the flex bytes
from this other spot", that would make it more readable. But I'm not
sure we'd find more than one spot to use such a macro. :)

-Peff
