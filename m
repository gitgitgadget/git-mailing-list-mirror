Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BA76211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 14:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391140AbfAKOvK (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 09:51:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:33718 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730588AbfAKOvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 09:51:09 -0500
Received: (qmail 30057 invoked by uid 109); 11 Jan 2019 14:51:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Jan 2019 14:51:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10259 invoked by uid 111); 11 Jan 2019 14:51:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 Jan 2019 09:51:08 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jan 2019 09:51:06 -0500
Date:   Fri, 11 Jan 2019 09:51:06 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] match-trees: use hashcpy to splice trees
Message-ID: <20190111145106.GB16754@sigill.intra.peff.net>
References: <CAN0heSqLUWpwRdeUvYj2KnDX-QxSOnWOdKWz77RjHKJ3AFUGEQ@mail.gmail.com>
 <20190110042551.915769-1-sandals@crustytoothpaste.net>
 <20190110042551.915769-4-sandals@crustytoothpaste.net>
 <20190110064520.GC20497@sigill.intra.peff.net>
 <20190110235551.GM423984@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110235551.GM423984@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 10, 2019 at 11:55:51PM +0000, brian m. carlson wrote:

> > I think the only reason they are "struct object_id" is because that's
> > what tree_entry_extract() returns. Should we be providing another
> > function to allow more byte-oriented access?
> 
> The reason is we recursively call splice_tree, passing rewrite_here as
> the first argument. That argument is then used for read_object_file,
> which requires a struct object_id * (because it is, logically, an object
> ID).
> 
> I *think* we could fix this by copying an unsigned char *rewrite_here
> into a temporary struct object_id before we recurse, but it's not
> obvious to me if that's safe to do.

I think rewrite_here needs to be a direct pointer into the buffer, since
we plan to modify it.

I think rewrite_with is correct to be an object_id. It's either the oid
passed in from the caller, or the subtree we generated (in which case
it's the result from write_object_file).

So the "most correct" thing is probably something like this:

diff --git a/match-trees.c b/match-trees.c
index 03e81b56e1..129b13a970 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -179,7 +179,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 	char *buf;
 	unsigned long sz;
 	struct tree_desc desc;
-	struct object_id *rewrite_here;
+	unsigned char *rewrite_here;
 	const struct object_id *rewrite_with;
 	struct object_id subtree;
 	enum object_type type;
@@ -206,9 +206,16 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 			if (!S_ISDIR(mode))
 				die("entry %s in tree %s is not a tree", name,
 				    oid_to_hex(oid1));
-			rewrite_here = (struct object_id *)(desc.entry.path +
-							    strlen(desc.entry.path) +
-							    1);
+			/*
+			 * We cast here for two reasons:
+			 *
+			 *   - to flip the "char *" (for the path) to "unsigned
+			 *     char *" (for the hash stored after it)
+			 *
+			 *   - to discard the "const"; this is OK because we
+			 *     know it points into our non-const "buf"
+			 */
+			rewrite_here = (unsigned char *)desc.entry.path + strlen(desc.entry.path) + 1;
 			break;
 		}
 		update_tree_entry(&desc);
@@ -224,7 +231,7 @@ static int splice_tree(const struct object_id *oid1, const char *prefix,
 	} else {
 		rewrite_with = oid2;
 	}
-	hashcpy(rewrite_here->hash, rewrite_with->hash);
+	hashcpy(rewrite_here, rewrite_with->hash);
 	status = write_object_file(buf, sz, tree_type, result);
 	free(buf);
 	return status;

I think if I were trying to write this in a less-subtle way, I'd
probably stop trying to do it in-place, and have a copy loop more like:

  for entry in src_tree
    if match_entry(entry, prefix)
      entry = rewrite_entry(entry) /* either oid2 or subtree */
    push_entry(dst_tree)

We may even have to go that way eventually if we might ever be rewriting
to a tree with a different hash size (i.e., there is a hidden assumption
here that rewrite_here points to exactly the_hash_algo->rawsz bytes of
hash). But I think for now it's not necessary, and it's way outside the
scope of what you're trying to do here.

-Peff
