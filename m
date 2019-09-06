Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625011F461
	for <e@80x24.org>; Fri,  6 Sep 2019 06:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389471AbfIFG4I (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 02:56:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:41762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732161AbfIFG4I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 02:56:08 -0400
Received: (qmail 15021 invoked by uid 109); 6 Sep 2019 06:56:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Sep 2019 06:56:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2159 invoked by uid 111); 6 Sep 2019 06:57:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Sep 2019 02:57:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Sep 2019 02:56:06 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, stolee@gmail.com,
        git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] commit-graph.c: die on un-parseable commits
Message-ID: <20190906065606.GC5122@sigill.intra.peff.net>
References: <cover.1567563244.git.me@ttaylorr.com>
 <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
 <20190904030456.GA28836@sigill.intra.peff.net>
 <xmqqsgpao06z.fsf@gitster-ct.c.googlers.com>
 <20190906063503.GB5122@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190906063503.GB5122@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 02:35:03AM -0400, Jeff King wrote:

> > Fair enough.  Forcing later users to reattempt parsing (and failing
> > the same way) would be safer and it should also be sufficient as we
> > are talking about how to handle a broken repository, i.e. an error
> > case.
> 
> One of the tricky things, and the reason I used a "corrupt" flag in my
> earlier sketch, is that the state after we encounter a parse error is
> unknown. So imagine parse_commit_buffer() sees that one of the parent
> lines is bogus, and we return an error. The caller gets to see whatever
> half-parsed state we managed to come up with.
> 
> So far so good. But now imagine we call parse_commit_buffer() again, and
> we re-parse. How does that interact with the half-parsed state? Some of
> it works OK (e.g., lookup_tree() would find the same tree). Some not so
> much (I think we'd keep appending parents at each call).
> 
> I guess this might not be too bad to handle. Value fields like
> timestamp_t are OK to overwrite. Pointers to objects likewise, since the
> memory is owned elsewhere. If we see existing parent pointers in an
> object we're parsing, we could probably free them under the assumption
> they're leftover cruft. Likewise for the "tag" field of "struct tag",
> which is owned by the struct and should be freed.
> 
> Blobs and trees don't actually parse anything into their structs. So
> it's really just special-casing those two items.

So here's something a bit more concrete to play with. Using the patch
below, we maintain the invariant that if you called parse_commit() or
equivalent and got a successful return, then commit->tree is always
non-NULL. That fixes the second "missing tree" test from elsewhere in
this thread:

  https://public-inbox.org/git/042a8ba8b2a98c269f9cd1a8e88488b80d686f0d.1567720960.git.me@ttaylorr.com/

_without_ applying the third patch (though the error message we expect
in the test does not tweaked). And it likely also protects most of the
other callers of get_commit_tree_oid(), assuming somewhere in their code
path they call parse_commit() and actually check the error code.

Likewise, tag->tagged is always non-NULL after a successful tag parse,
which should fix the segfault discussed recently in:

  https://public-inbox.org/git/20190824230944.GA14132@jessup.stsp.name/

as well as probably others.

And callers are still able to view the broken objects, but they have to
ignore the error return from the parse functions.

This seems like a promising direction. I'd probably break it into a few
separate patches, and it would be nice to have some tests (especially
one where we actually do try to parse multiple times).

---
diff --git a/commit.c b/commit.c
index a98de16e3d..47e36fd13e 100644
--- a/commit.c
+++ b/commit.c
@@ -398,20 +398,37 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	struct object_id parent;
 	struct commit_list **pptr;
 	struct commit_graft *graft;
+	struct tree *tree;
 	const int tree_entry_len = the_hash_algo->hexsz + 5;
 	const int parent_entry_len = the_hash_algo->hexsz + 7;
 
 	if (item->object.parsed)
 		return 0;
-	item->object.parsed = 1;
+
+	if (item->parents) {
+		/*
+		 * Presumably this is leftover from an earlier failed parse;
+		 * clear it out in preparation for us re-parsing (we'll hit the
+		 * same error, but that's good, since it lets our caller know
+		 * the result cannot be trusted.
+		 */
+		free_commit_list(item->parents);
+		item->parents = NULL;
+	}
+
 	tail += size;
 	if (tail <= bufptr + tree_entry_len + 1 || memcmp(bufptr, "tree ", 5) ||
 			bufptr[tree_entry_len] != '\n')
 		return error("bogus commit object %s", oid_to_hex(&item->object.oid));
 	if (get_oid_hex(bufptr + 5, &parent) < 0)
 		return error("bad tree pointer in commit %s",
 			     oid_to_hex(&item->object.oid));
-	set_commit_tree(item, lookup_tree(r, &parent));
+	tree = lookup_tree(r, &parent);
+	if (!tree)
+		return error("bad tree pointer %s in commit %s",
+			     oid_to_hex(&parent),
+			     oid_to_hex(&item->object.oid));
+	set_commit_tree(item, tree);
 	bufptr += tree_entry_len + 1; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
 
@@ -450,6 +467,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	if (check_graph)
 		load_commit_graph_info(r, item);
 
+	item->object.parsed = 1;
 	return 0;
 }
 
diff --git a/tag.c b/tag.c
index 5db870edb9..3dcebb4715 100644
--- a/tag.c
+++ b/tag.c
@@ -141,7 +141,11 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 
 	if (item->object.parsed)
 		return 0;
-	item->object.parsed = 1;
+
+	if (item->tag) {
+		/* Left over from an earlier failed parse */
+		FREE_AND_NULL(item->tag);
+	}
 
 	if (size < the_hash_algo->hexsz + 24)
 		return -1;
@@ -167,10 +171,15 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 	} else if (!strcmp(type, tag_type)) {
 		item->tagged = (struct object *)lookup_tag(r, &oid);
 	} else {
-		error("Unknown type %s", type);
-		item->tagged = NULL;
+		return error("unknown tag type '%s' in %s",
+			     type, oid_to_hex(&item->object.oid));
 	}
 
+	if (!item->tagged)
+		return error("bad tag pointer to %s in %s",
+			     oid_to_hex(&oid),
+			     oid_to_hex(&item->object.oid));
+
 	if (bufptr + 4 < tail && starts_with(bufptr, "tag "))
 		; 		/* good */
 	else
@@ -187,6 +196,7 @@ int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, u
 	else
 		item->date = 0;
 
+	item->object.parsed = 1;
 	return 0;
 }
 
