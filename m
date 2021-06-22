Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59335C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40BFA610C7
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 16:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFVQK5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:10:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:36056 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhFVQK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 12:10:57 -0400
Received: (qmail 5870 invoked by uid 109); 22 Jun 2021 16:08:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Jun 2021 16:08:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28403 invoked by uid 111); 22 Jun 2021 16:08:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Jun 2021 12:08:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Jun 2021 12:08:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 5/5] load_ref_decorations(): avoid parsing non-tag objects
Message-ID: <YNILCDz3LpHX7OX0@coredump.intra.peff.net>
References: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNIJw/8p0F3cPfzd@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we load the ref decorations, we parse the object pointed to by each
ref in order to get a "struct object". This is unnecessarily expensive;
we really only need the object struct, and don't even look at the parsed
contents. The exception is tags, which we do need to peel.

We can improve this by looking up the object type first (which is much
cheaper), and skipping the parse entirely for non-tags. This increases
the work slightly for annotated tags (which now do a type lookup _and_ a
parse), but decreases it a lot for other types. On balance, this seems
to be a good tradeoff.

In my git.git clone, with ~2k refs, most of which are branches, the time
to run "git log -1 --decorate" drops from 34ms to 11ms. Even on my
linux.git clone, which contains mostly tags and only a handful of
branches, the time drops from 30ms to 19ms. And on a more extreme
real-world case with ~220k refs, mostly non-tags, the time drops from
2.6s to 650ms.

That command is a lop-sided example, of course, because it does as
little non-loading work as possible. But it does show the absolute time
improvement. Even in something like a full "git log --decorate" on that
extreme repo, we'd still be saving 2s of CPU time.

Ideally we could push this even further, and avoid parsing even tags, by
relying on the packed-refs "peel" optimization (which we could do by
calling peel_iterated_oid() instead of peeling manually). But we can't
do that here. The packed-refs file only stores the bottom-layer of the
peel (so in a "tag->tag->commit" chain, it stores only the commit as the
peel result).  But the decoration code wants to peel the layers
individually, annotating the middle layers of the chain.

If the packed-refs file ever learns to store all of the peeled layers,
then we could switch to it. Or even if it stored a flag to indicate the
peel was not multi-layer (because most of them aren't), then we could
use it most of the time and fall back to a manual peel for the rare
cases.

Signed-off-by: Jeff King <peff@peff.net>
---
 log-tree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 7b823786c2..8b700e9c14 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -134,6 +134,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 			      int flags, void *cb_data)
 {
 	struct object *obj;
+	enum object_type objtype;
 	enum decoration_type type = DECORATION_NONE;
 	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
 
@@ -155,9 +156,10 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 		return 0;
 	}
 
-	obj = parse_object(the_repository, oid);
-	if (!obj)
+	objtype = oid_object_info(the_repository, oid, NULL);
+	if (type < 0)
 		return 0;
+	obj = lookup_object_by_type(the_repository, oid, objtype);
 
 	if (starts_with(refname, "refs/heads/"))
 		type = DECORATION_REF_LOCAL;
-- 
2.32.0.352.gff02c21e72
