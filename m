Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01DC01F461
	for <e@80x24.org>; Sun, 25 Aug 2019 07:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfHYHTx (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 03:19:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:54756 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726182AbfHYHTw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 03:19:52 -0400
Received: (qmail 9741 invoked by uid 109); 25 Aug 2019 07:19:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 25 Aug 2019 07:19:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9946 invoked by uid 111); 25 Aug 2019 07:21:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 25 Aug 2019 03:21:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 25 Aug 2019 03:19:51 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH] notes: avoid potential use-after-free during insertion
Message-ID: <20190825071951.GC23806@sigill.intra.peff.net>
References: <20190825051818.9621-1-mh@glandium.org>
 <20190825071035.GB23806@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190825071035.GB23806@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 25, 2019 at 03:10:35AM -0400, Jeff King wrote:

> Curiously, I think the existing case a few lines below your patch is
> wrong, though:
> 
>         ret = combine_notes(&l->val_oid,
>                             &entry->val_oid);
>         if (!ret && is_null_oid(&l->val_oid))
>                 note_tree_remove(t, tree, n, entry);
>         free(entry);
>         return ret;
> 
> If combining the notes fails, we'll free the entry and return an error
> code, and then load_subtree() will access the freed memory. I think we
> could just object_oid instead.

Here's a patch. It's textually independent of yours, but I think it
makes sense to apply the two on a single branch.

No test, as I didn't bother to figure out what it takes to trigger the
error message, and the solution is (hopefully) an obvious improvement
even if it can't be triggered in practice.

-- >8 --
Subject: [PATCH] notes: avoid potential use-after-free during insertion

The note_tree_insert() function may free the leaf_node struct we pass in
(e.g., if it's a duplicate, or if it needs to be combined with an
existing note).

Most callers are happy with this, as they assume that ownership of the
struct is handed off. But in load_subtree(), if we see an error we'll
use the handed-off struct's key_oid to generate the die() message,
potentially accessing freed memory.

We can easily fix this by instead using the original oid that we copied
into the leaf_node struct.

Signed-off-by: Jeff King <peff@peff.net>
---
 notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/notes.c b/notes.c
index 75c028b300..3477e8e554 100644
--- a/notes.c
+++ b/notes.c
@@ -453,17 +453,17 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		l = xcalloc(1, sizeof(*l));
 		oidcpy(&l->key_oid, &object_oid);
 		oidcpy(&l->val_oid, &entry.oid);
 		if (note_tree_insert(t, node, n, l, type,
 				     combine_notes_concatenate))
 			die("Failed to load %s %s into notes tree "
 			    "from %s",
 			    type == PTR_TYPE_NOTE ? "note" : "subtree",
-			    oid_to_hex(&l->key_oid), t->ref);
+			    oid_to_hex(&object_oid), t->ref);
 
 		continue;
 
 handle_non_note:
 		/*
 		 * Determine full path for this non-note entry. The
 		 * filename is already found in entry.path, but the
 		 * directory part of the path must be deduced from the
-- 
2.23.0.478.g23872bed7d

