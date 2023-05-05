Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA437C77B75
	for <git@archiver.kernel.org>; Fri,  5 May 2023 21:16:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjEEVQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 17:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjEEVQQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 17:16:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F794EDC
        for <git@vger.kernel.org>; Fri,  5 May 2023 14:16:11 -0700 (PDT)
Received: (qmail 4617 invoked by uid 109); 5 May 2023 21:16:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 May 2023 21:16:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4229 invoked by uid 111); 5 May 2023 21:16:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 May 2023 17:16:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 May 2023 17:16:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: doc-diff: specify date
Message-ID: <20230505211610.GA3197168@coredump.intra.peff.net>
References: <20230503232349.59997-1-felipe.contreras@gmail.com>
 <xmqq8re3inn4.fsf@gitster.g>
 <20230505014610.GA2366370@coredump.intra.peff.net>
 <xmqqzg6jgw47.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzg6jgw47.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 04, 2023 at 10:55:52PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> >  			GIT_VERSION=omitted \
> >> > +			GIT_DATE=1970-01-01 \
> >> >  			SOURCE_DATE_EPOCH=0 \
> >> >  			DESTDIR="$tmp/installed/$dname+" \
> >> >  			install-man &&
> >> 
> >> I wonder what the existing SOURCE_DATE_EPOCH was trying to do there,
> >> though.
> >
> > It used to be necessary so that we had a reproducible build. Otherwise,
> > asciidoc uses the mtime of the file, and diffing two versions would have
> > tons of uninteresting date-differences.
> >
> > After 28fde3a1 I doubt it is necessary, as the header uses $GIT_DATE
> > instead (it's possible the mtime may be used elsewhere, but I didn't see
> > any spot after grepping a built xml file. And at any rate, if it does
> > not produce a visible difference, that is enough for doc-diff).
> 
> Thanks for confirming my suspicion.  I guess leaving it there still
> would not hurt.  It can be removed whenever somebody motivated
> enough comes and shows a well-reasoned patch that explains why it no
> longer is necessary ;-)

-- >8 --
Subject: [PATCH] doc-diff: drop SOURCE_DATE_EPOCH override

The original doc-diff script set SOURCE_DATE_EPOCH to make asciidoc's
output deterministic. Otherwise, the mtime of the source files would end
up in the footer of the manpage, causing noisy and uninteresting diff
hunks.

But this has been unused since 28fde3a1f4 (doc: set actual revdate for
manpages, 2023-04-13), as the footer uses the externally-specified
GIT_DATE instead (that needs to be set consistently, too, which it now
is as of the previous commit).

Asciidoc sets several automatic attributes based on the mtime (or manual
epoch), so it's still possible to write a document that would need
SOURCE_DATE_EPOCH set to be deterministic. But if we wrote such a thing,
it's probably a mistake, and we're better off having doc-diff loudly
show it.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/doc-diff | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 554a78a12d..fb09e0ac0e 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -154,7 +154,6 @@ render_tree () {
 			$makemanflags \
 			GIT_VERSION=omitted \
 			GIT_DATE=1970-01-01 \
-			SOURCE_DATE_EPOCH=0 \
 			DESTDIR="$tmp/installed/$dname+" \
 			install-man &&
 		mv "$tmp/installed/$dname+" "$tmp/installed/$dname"
-- 
2.40.1.802.gdef2a8734a

