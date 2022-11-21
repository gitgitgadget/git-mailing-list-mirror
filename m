Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3678C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 19:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiKUT1G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiKUT06 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 14:26:58 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC68CBA4
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 11:26:57 -0800 (PST)
Received: (qmail 12544 invoked by uid 109); 21 Nov 2022 19:26:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Nov 2022 19:26:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26687 invoked by uid 111); 21 Nov 2022 19:26:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Nov 2022 14:26:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Nov 2022 14:26:55 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] fixing parse_object() check for type mismatch
Message-ID: <Y3vQ/6QcTEFfpjLt@coredump.intra.peff.net>
References: <Y3Up5Vi75Up8LaGQ@coredump.intra.peff.net>
 <20221116211419.439356-1-jonathantanmy@google.com>
 <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net>
 <Y3fXYKj8PdS4EKLB@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y3fXYKj8PdS4EKLB@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 02:05:04PM -0500, Taylor Blau wrote:

> On Thu, Nov 17, 2022 at 05:37:29PM -0500, Jeff King wrote:
> > I'm adding Taylor to the cc as the author of t6102, when we were
> > tracking down all of these "oops, it's not really a blob" cases. This
> > fixes one of the lingering cases from that test script.
> >
> >   [1/2]: parse_object(): drop extra "has" check before checking object type
> >   [2/2]: parse_object(): check on-disk type of suspected blob
> >
> >  object.c                               | 5 ++---
> >  t/t6102-rev-list-unexpected-objects.sh | 4 ++--
> >  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> A blast from the past :-).
> 
> I took a careful look at both of these patches and they looked good to
> me, so let's start merging them down.

I saw this hit 'next', but I think Ævar's simplification suggestion is
worth taking. So here is a patch on top to do so (the original branch is
jk/parse-object-type-mismatch for the benefit of any newly-returned
maintainers).

I was going to do a "helped-by", but since the only thing in the patch
is the suggested change, I just handed over authorship. :)

I didn't forge a signoff, and I think mine is sufficient under DCO's
part (b), but Ævar please indicate if that's OK.

-- >8 --
From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Subject: [PATCH] parse_object(): simplify blob conditional

Commit 8db2dad7a0 (parse_object(): check on-disk type of suspected blob,
2022-11-17) simplified the conditional for checking if we might have a
blob. But we can simplify it further. In:

  !obj || (obj && obj->type == OBJ_BLOB)

the short-circuit "OR" means "obj" will always be true on the right-hand
side. The compiler almost certainly optimized that out anyway, but
dropping it makes the conditional easier to understand for humans.

Signed-off-by: Jeff King <peff@peff.net>
---
 object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object.c b/object.c
index fad1a5af4a..682b852a46 100644
--- a/object.c
+++ b/object.c
@@ -286,7 +286,7 @@ struct object *parse_object_with_flags(struct repository *r,
 			return &commit->object;
 	}
 
-	if ((!obj || (obj && obj->type == OBJ_BLOB)) &&
+	if ((!obj || obj->type == OBJ_BLOB) &&
 	    oid_object_info(r, oid, NULL) == OBJ_BLOB) {
 		if (!skip_hash && stream_object_signature(r, repl) < 0) {
 			error(_("hash mismatch %s"), oid_to_hex(oid));
-- 
2.38.1.950.g65ed8c1df8

