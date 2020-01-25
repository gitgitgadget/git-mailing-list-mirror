Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CBCC35242
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3112064A
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 23:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgAYX5q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:57:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:44902 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727307AbgAYX5q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 18:57:46 -0500
Received: (qmail 21255 invoked by uid 109); 25 Jan 2020 23:57:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 23:57:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21390 invoked by uid 111); 26 Jan 2020 00:05:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jan 2020 19:05:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Jan 2020 18:57:45 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] merge-recursive: silence -Wxor-used-as-pow warning
Message-ID: <20200125235745.GA447121@coredump.intra.peff.net>
References: <20200125053542.GA744596@coredump.intra.peff.net>
 <20200125053723.GA744673@coredump.intra.peff.net>
 <xmqq4kwjcupj.fsf@gitster-ct.c.googlers.com>
 <20200125195515.GB5519@coredump.intra.peff.net>
 <CABPp-BFp3VrYjD8KTqnOff0-CDY7qO3Au7GeUDCuA46ofv1GSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFp3VrYjD8KTqnOff0-CDY7qO3Au7GeUDCuA46ofv1GSg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 25, 2020 at 12:50:38PM -0800, Elijah Newren wrote:

> Interesting.  In merge-ort (my in-development attempt at a replacement
> for merge-recursive), I'm currently storing the stages in an array
> with indices 0-2 rather than the 1-3 used by merge-recursive.  This
> removes the empty/unused array entry at the beginning, and also works
> a bit better with the masks that traverse_trees() returns (as 1<<index
> corresponds to the bit in the mask from the traverse_trees()
> callback).  In that scheme, bitflip won't work, but the subtraction
> idea still does.  So, I'd tend to agree with Junio, but I think the
> helper you added here is probably the more important improvement.

OK, that's three people who think the subtraction is more obvious. I
agree it's not that big a deal now that it's hidden in the helper (and
the code may eventually go away anyway), but it's easy enough to fix it
while we're thinking about it.

Patch is below (as an incremental on top attributed to Junio, who
proposed it; but it would be fine to squash it in with a Helped-by,
too).

> [1] merge-ort still isn't functional yet other than in extremely
> narrow circumstances, I'm still experimenting with the data
> structures, and I've written several hundred lines of code and then
> thrown it all away at least once -- and may do so again.  Whenever I
> find a useful patch I can separate and submit upstream, I have been
> doing so, but until the risk of another complete rewrite goes down,
> there's no point in me sending my half-baked ideas in for review.
> They need to be at least three-quarters baked first.  :-)

Thank you, by the way, for all of the work you have done on
merge-recursive. I generally find it one of the scariest bits of the
code to look at, so I am happy to be able to punt it off to you. :)

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] merge-recursive: use subtraction to flip stage

The flip_stage() helper uses a bit-flipping xor to switch between "2"
and "3". While clever, this relies on a property of those two numbers
that is mostly coincidence. Let's write it as a subtraction; that's more
clear and would extend to other numbers if somebody copies the logic.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-recursive.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index e6aedd3cab..aee1769a7a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1713,12 +1713,11 @@ static char *find_path_for_conflict(struct merge_options *opt,
 }
 
 /*
- * Toggle the stage number between "ours" and "theirs" (2 and 3) by flipping
- * the 1-bit.
+ * Toggle the stage number between "ours" and "theirs" (2 and 3).
  */
 static inline int flip_stage(int stage)
 {
-	return stage ^ 1;
+	return (2 + 3) - stage;
 }
 
 static int handle_rename_rename_1to2(struct merge_options *opt,
-- 
2.25.0.430.g8dfc7de6f7

