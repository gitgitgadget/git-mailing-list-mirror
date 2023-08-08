Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7078CC001DB
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 21:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbjHHVWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbjHHVWH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 17:22:07 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4CE2133
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 14:18:00 -0700 (PDT)
Received: (qmail 12312 invoked by uid 109); 8 Aug 2023 21:18:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Aug 2023 21:18:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24462 invoked by uid 111); 8 Aug 2023 21:17:59 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Aug 2023 17:17:59 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Aug 2023 17:17:59 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] repack: free geometry struct
Message-ID: <20230808211759.GA322409@coredump.intra.peff.net>
References: <20230808185023.GA3498623@coredump.intra.peff.net>
 <ZNKer8BfwaKEeV+W@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNKer8BfwaKEeV+W@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 08, 2023 at 03:59:43PM -0400, Taylor Blau wrote:

> > I did actually put together the "put it on the stack" patch, which swaps
> > out:
> >
> >   if (geometry)
> >
> > for:
> >
> >   if (geometric_factor)
> >
> > to get around the NULL checks. But besides being noisy for little gain,
> > it ends up with some subtle gotchas, because we pass "&geometry" into
> > some functions which don't have access to "geometric_factor" (so now
> > extra call-sites have to keep track of "is this struct valid enough to
> > pass").
> 
> ...I think that storing the geometric_factor value on the pack_geometry
> struct itself gets around most of these issues.
> 
> This version is still somewhat noisy, but it's not too bad IMHO. I'm
> fine with either your approach or mine :-).

Yeah, that is much better than what I had put together, as it means that
pack_geometry is always in a consistent state, even if we didn't call
init_pack_geometry(). So it is safe to clear() it, for example, without
checking geometric_factor again. And any sub-functions can likewise
check whether it contains any useful data. So you'd need this fixup on
top of your patch:

diff --git a/builtin/repack.c b/builtin/repack.c
index 13e4f0094e..80bffc36d4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -579,7 +579,7 @@ static void midx_included_packs(struct string_list *include,
 		string_list_insert(include, xstrfmt("%s.idx", item->string));
 	for_each_string_list_item(item, names)
 		string_list_insert(include, xstrfmt("pack-%s.idx", item->string));
-	if (geometry) {
+	if (geometry->split_factor) {
 		struct strbuf buf = STRBUF_INIT;
 		uint32_t i;
 		for (i = geometry->split; i < geometry->pack_nr; i++) {

or else t5326 (and I think a few others) will fail.

I'd be happy to proceed that way if you want to clean it up with a
commit message, but I think we should do it on top of the leak-fix (I
wanted to say that the heap-to-stack conversion was low-risk, but both
of us introduced bugs while trying it ;) ).

-Peff
