Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0871F597
	for <e@80x24.org>; Tue, 24 Jul 2018 04:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbeGXFYs (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 01:24:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:57016 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388219AbeGXFYs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 01:24:48 -0400
Received: (qmail 28367 invoked by uid 109); 24 Jul 2018 04:20:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 04:20:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24414 invoked by uid 111); 24 Jul 2018 04:20:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 00:20:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 00:20:17 -0400
Date:   Tue, 24 Jul 2018 00:20:17 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
Message-ID: <20180724042017.GA13248@sigill.intra.peff.net>
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net>
 <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 23, 2018 at 04:51:38PM -0400, Ben Peart wrote:

> > Hmm.. this means cache-tree is fully valid, unless you have changes in
> > index. We're quite aggressive in repairing cache-tree since aecf567cbf
> > (cache-tree: create/update cache-tree on checkout - 2014-07-05). If we
> > have very good cache-tree records and still spend 33s on
> > traverse_trees, maybe there's something else.
> 
> I'm not at all familiar with the cache-tree and couldn't find any
> documentation on it other than index-format.txt which says "it helps speed
> up tree object generation for a new commit."  In this particular case, no
> new commit is being created so I don't know that the cache-tree would help.

It's basically an index extension that mirrors the tree structure within
the index, telling you the sha1 of the three that _would_ be generated
from any particular path. So any time you're walking a tree alongside
the index, in theory you should be able to say "the cache-tree for this
subset of the index matches the tree" and skip over a bunch of entries.

At least that's my view of it. unpack_trees() has always been a
terrifying beast that I've avoided looking too closely at.

> After a quick look at the code, the only place I can find that tries to use
> cache_tree_matches_traversal() is in unpack_callback() and that only happens
> if n == 1 and in the "git checkout" case, n == 2. Am I missing something?

Looks like it's trying to special-case "diff-index --cached". Which
kind-of makes sense. In the non-cached case, we're thinking not only
about the relationship between the index and the tree, but also whether
the on-disk files are up to date.

And that would be the same for checkout. We want to know not only
whether there are changes to make to the index, but also whether the
on-disk files need to be updated from the index.

But I assume in your case that we've just refreshed the index quickly
using fsmonitor. So I think in the long run what you want is:

  1. fsmonitor tells us which index entries are not clean

  2. based on the unclean list, we invalidate cache-tree entries for
     those paths

  3. if we have a valid cache-tree entry, we should be able to skip
     digging into that tree; if not, then we walk the index and tree as
     normal, adding/deleting index entries and updating (or complaining
     about) modified on-disk files

I think the "n" adds an extra layer of complexity. n==2 means we're
doing a "2-way" merge. Moving from tree X to tree Y, and dealing with
the index as we go. Naively I _think_ we'd be OK to just extend the rule
to "if both subtrees match each other _and_ match the valid cache-tree,
then we can skip".

Again, I'm a little out of my area of expertise here, but cargo-culting
like this:

diff --git a/sha1-file.c b/sha1-file.c
index de4839e634..c105af70ce 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1375,6 +1375,7 @@ static void *read_object(const unsigned char *sha1, enum object_type *type,
 
 	if (oid_object_info_extended(the_repository, &oid, &oi, 0) < 0)
 		return NULL;
+	trace_printf("reading %s %s", type_name(*type), sha1_to_hex(sha1));
 	return content;
 }
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 66741130ae..cfdad4133d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1075,6 +1075,23 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
 				o->cache_bottom += matches;
 				return mask;
 			}
+		} else if (n == 2 && S_ISDIR(names->mode) &&
+			   names[0].mode == names[1].mode &&
+			   !strcmp(names[0].path, names[1].path) &&
+			   !oidcmp(names[0].oid, names[1].oid)
+			   /* && somehow account for modified on-disk files */) {
+			int matches;
+
+			/*
+			 * we know that the two trees have the same oid, so we
+			 * only need to look at one of them
+			 */
+			matches = cache_tree_matches_traversal(o->src_index->cache_tree,
+							       names, info);
+			if (matches) {
+				o->cache_bottom += matches;
+				return mask;
+			}
 		}
 
 		if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,

seems to avoid the tree reads when running "GIT_TRACE=1 git checkout".
It also totally empties the index. ;) So clearly we have to do a bit
more there. Probably rather than just bumping o->cache_bottom forward,
we'd need to actually move those entries into the new index. Or maybe
it's something else entirely (I did say cargo-culting, right?).

-Peff
