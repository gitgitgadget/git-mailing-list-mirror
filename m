Return-Path: <SRS0=bfGv=CG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6488AC433E6
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 06:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488C720825
	for <git@archiver.kernel.org>; Fri, 28 Aug 2020 06:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgH1G0W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Aug 2020 02:26:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:43300 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbgH1G0W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Aug 2020 02:26:22 -0400
Received: (qmail 22843 invoked by uid 109); 28 Aug 2020 06:26:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 28 Aug 2020 06:26:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3448 invoked by uid 111); 28 Aug 2020 06:26:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 28 Aug 2020 02:26:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 28 Aug 2020 02:26:19 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #07; Thu, 27)
Message-ID: <20200828062619.GA2100989@coredump.intra.peff.net>
References: <xmqqh7snpxy1.fsf@gitster.c.googlers.com>
 <20200827233454.GA3973432@coredump.intra.peff.net>
 <xmqqzh6foe44.fsf@gitster.c.googlers.com>
 <20200828003940.GA80266@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200828003940.GA80266@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 08:39:40PM -0400, Taylor Blau wrote:

> > >> * tb/repack-clearing-midx (2020-08-26) 1 commit
> > >>   (merged to 'next' on 2020-08-27 at a465875cbb)
> > >>  + builtin/repack.c: invalidate MIDX only when necessary
> [...]
> Thanks indeed. I started looking into this tonight thinking that it'd be
> an easy fix, but I think there is a deeper bug that is worth
> investigating further.

I imagine this is part of it:

diff --git a/builtin/repack.c b/builtin/repack.c
index f10f52779c..2cc05f968a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -134,7 +134,7 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct multi_pack_index *m = get_multi_pack_index(the_repository);
-	strbuf_addf(&buf, "%s.pack", base_name);
+	strbuf_addf(&buf, "%s.idx", base_name);
 	if (m && midx_contains_pack(m, buf.buf))
 		clear_midx_file(the_repository);
 	strbuf_insertf(&buf, 0, "%s/", dir_name);

but maybe that is just the "easy" part you meant. Several tests still
seem to fail, which I guess is the "deeper" part. :)

If I'm understanding midx_contains_pack() correctly, then the code
looking for ".pack" could never have matched, and we would never have
deleted a midx here. Which makes me wonder why the "repack removes
multi-pack-index when deleting packs" test ever succeeded.

> Let's eject this for now. If the bug turns out to be easier than I
> thought, I'll send the patch again, otherwise I'll send it with my
> larger series when that's ready.

It's in next, so the preferred path forward is generally to do a fix on
top. Unless it's so unsalvageable that we have to revert, but I doubt
that here.

-Peff
