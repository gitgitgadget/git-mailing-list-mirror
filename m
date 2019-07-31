Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E1B1F731
	for <e@80x24.org>; Wed, 31 Jul 2019 04:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfGaEiN (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 00:38:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:56500 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726439AbfGaEiN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 00:38:13 -0400
Received: (qmail 11355 invoked by uid 109); 31 Jul 2019 04:38:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 04:38:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13572 invoked by uid 111); 31 Jul 2019 04:39:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 00:39:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 00:38:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/6] setup_traverse_info(): stop copying oid
Message-ID: <20190731043811.GA27170@sigill.intra.peff.net>
References: <20190731043659.GA27028@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731043659.GA27028@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We assume that if setup_traverse_info() is passed a non-empty "base"
string, that string is pointing into a tree object and we can read the
object oid by skipping past the trailing NUL.

As it turns out, this is not true for either of the two calls, and we
may end up reading garbage bytes:

  1. In git-merge-tree, our base string is either empty (in which case
     we'd never run this code), or it comes from our traverse_path()
     helper. The latter overallocates a buffer by the_hash_algo->rawsz
     bytes, but then fills it with only make_traverse_path(), leaving
     those extra bytes uninitialized (but part of a legitimate heap
     buffer).

  2. In unpack_trees(), we pass o->prefix, which is some arbitrary
     string from the caller. In "git read-tree --prefix=foo", for
     instance, it will point to the command-line parameter, and we'll
     read 20 bytes past the end of the string.

Interestingly, tools like ASan do not detect (2) because the process
argv is part of a big pre-allocated buffer. So we're reading trash, but
it's trash that's probably part of the next argument, or the
environment.

You can convince it to fail by putting something like this at the
beginning of common-main.c's main() function:

  {
	int i;
	for (i = 0; i < argc; i++)
		argv[i] = xstrdup_or_null(argv[i]);
  }

That puts the arguments into their own heap buffers, so running:

  make SANITIZE=address test

will find problems when "read-tree --prefix" is used (e.g., in t3030).

Doubly interesting, even with the hackery above, this does not fail
prior to ea82b2a085 (tree-walk: store object_id in a separate member,
2019-01-15). That commit switched setup_traverse_info() to actually
copying the hash, rather than simply pointing to it. That pointer was
always pointing to garbage memory, but that commit started actually
dereferencing the bytes, which is what triggers ASan.

That also implies that nobody actually cares about reading these oid
bytes anyway (or at least no path covered by our tests). And manual
inspection of the code backs that up (I'll follow this patch with some
cleanups that show definitively this is the case, but they're quite
invasive, so it's worth doing this fix on its own).

So let's drop the bogus hashcpy(), along with the confusing oversizing
in merge-tree.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-tree-walking.txt | 4 +---
 builtin/merge-tree.c                         | 2 +-
 tree-walk.c                                  | 4 +---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-tree-walking.txt b/Documentation/technical/api-tree-walking.txt
index bde18622a8..59d78e0362 100644
--- a/Documentation/technical/api-tree-walking.txt
+++ b/Documentation/technical/api-tree-walking.txt
@@ -62,9 +62,7 @@ Initializing
 `setup_traverse_info`::
 
 	Initialize a `traverse_info` given the pathname of the tree to start
-	traversing from. The `base` argument is assumed to be the `path`
-	member of the `name_entry` being recursed into unless the tree is a
-	top-level tree in which case the empty string ("") is used.
+	traversing from.
 
 Walking
 -------
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 97b54caeb9..dccdaf7852 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -180,7 +180,7 @@ static struct merge_list *create_entry(unsigned stage, unsigned mode, const stru
 
 static char *traverse_path(const struct traverse_info *info, const struct name_entry *n)
 {
-	char *path = xmallocz(traverse_path_len(info, n) + the_hash_algo->rawsz);
+	char *path = xmallocz(traverse_path_len(info, n));
 	return make_traverse_path(path, info, n);
 }
 
diff --git a/tree-walk.c b/tree-walk.c
index c20b62f49e..0de4d577bb 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -179,10 +179,8 @@ void setup_traverse_info(struct traverse_info *info, const char *base)
 	info->pathlen = pathlen ? pathlen + 1 : 0;
 	info->name.path = base;
 	info->name.pathlen = pathlen;
-	if (pathlen) {
-		hashcpy(info->name.oid.hash, (const unsigned char *)base + pathlen + 1);
+	if (pathlen)
 		info->prev = &dummy;
-	}
 }
 
 char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n)
-- 
2.23.0.rc0.426.gbdee707ba7

