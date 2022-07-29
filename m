Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB35C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 18:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiG2SiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 14:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiG2SiB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 14:38:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE4565678
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 11:38:00 -0700 (PDT)
Received: (qmail 22065 invoked by uid 109); 29 Jul 2022 18:38:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jul 2022 18:38:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27609 invoked by uid 111); 29 Jul 2022 18:37:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Jul 2022 14:37:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Jul 2022 14:37:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] revisions API: don't leak memory on argv elements
 that need free()-ing
Message-ID: <YuQpBwUt8rAE9oym@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com>
 <patch-6.6-4a581a4a6ce-20220713T130511Z-avarab@gmail.com>
 <YtV4KmrTBkmcx6m3@coredump.intra.peff.net>
 <220718.86zgh6wiwa.gmgdl@evledraar.gmail.com>
 <YtWAMP0ROFseFs6B@coredump.intra.peff.net>
 <220729.86pmhoidsc.gmgdl@evledraar.gmail.com>
 <YuQg5M/cSLtqOgdw@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YuQg5M/cSLtqOgdw@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 02:03:16PM -0400, Jeff King wrote:

> On Fri, Jul 29, 2022 at 09:07:40AM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> > > In that case, we could replace your patch 5 in favor of just calling
> > > strvec_clear() at the end of bisect_rev_setup().
> > 
> > 5/6 is doing that, or rather at the end of check_ancestors() and
> > bisect_next_all(), but those call bisect_rev_setup() and pass it the
> > strvec, so in terms of memory management it amounts to the same thing.
> 
> Right, but my point is that we do not need to complicate the interface
> and ownership rules for bisect_rev_setup() by passing around the extra
> variable.

Just to be clear, what I'm proposing is to replace your 5/6 with the
patch below.

It passes the leak-checker, but I don't think that should be a surprise.
The end result should be the same as your patch, and anyway I don't
think your series actually marks any scripts as PASSING_SANITIZE_LEAK
as a result of fixing this (presumably because there are other leaks in
those scripts, too).

The more interesting question is whether it causes any use-after-free
bugs. I don't think it does, and certainly SANITIZE=address agrees.

-- >8 --
Subject: [PATCH] bisect: stop leaking strvec in bisect_rev_setup()

Back when 8a534b6124 (bisect: use argv_array API, 2011-09-13) was
written, it was not safe to free the argv we had passed to
setup_revisions() until the actual traversal was done.

But since then, we've had many cleanups that makes this safe; e.g.,
df835d3a0c (add_rev_cmdline(): make a copy of the name argument,
2013-05-25) and 31faeb2088 (object_array_entry: fix memory handling of
the name field, 2013-05-25). The comment here is now out-dated; we can
just clear the strvec rather than leaking.

Note that there's still a small leak because of the way
setup_revisions() handles removed elements internally. That will be
fixed in a subsequent patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index 421470bfa5..9cce23e929 100644
--- a/bisect.c
+++ b/bisect.c
@@ -670,7 +670,7 @@ static void bisect_rev_setup(struct repository *r, struct rev_info *revs,
 		read_bisect_paths(&rev_argv);
 
 	setup_revisions(rev_argv.nr, rev_argv.v, revs, NULL);
-	/* XXX leak rev_argv, as "revs" may still be pointing to it */
+	strvec_clear(&rev_argv);
 }
 
 static void bisect_common(struct rev_info *revs)
-- 
2.37.1.804.g1775fa20e0

