Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 211761F731
	for <e@80x24.org>; Wed, 31 Jul 2019 04:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbfGaEi1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 00:38:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:56526 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728243AbfGaEi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 00:38:26 -0400
Received: (qmail 11383 invoked by uid 109); 31 Jul 2019 04:38:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 04:38:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13640 invoked by uid 111); 31 Jul 2019 04:40:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 00:40:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 00:38:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] tree-walk: harden make_traverse_path() length
 computations
Message-ID: <20190731043825.GF27170@sigill.intra.peff.net>
References: <20190731043659.GA27028@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190731043659.GA27028@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The make_traverse_path() function isn't very careful about checking its
output buffer boundaries. In fact, it doesn't even _know_ the size of
the buffer it's writing to, and just assumes that the caller used
traverse_path_len() correctly. And even then we assume that our
traverse_info.pathlen components are all correct, and just blindly write
into the buffer.

Let's improve this situation a bit:

  - have the caller pass in their allocated buffer length, which we'll
    check against our own computations

  - check for integer underflow as we do our backwards-insertion of
    pathnames into the buffer

  - check that we do not run out items in our list to traverse before
    we've filled the expected number of bytes

None of these should be triggerable in practice (especially since our
switch to size_t everywhere in a previous commit), but it doesn't hurt
to check our assumptions.

Signed-off-by: Jeff King <peff@peff.net>
---
 tree-walk.c    | 28 ++++++++++++++++++++--------
 tree-walk.h    |  2 +-
 unpack-trees.c |  3 ++-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 313780f40c..bea819d826 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -183,21 +183,32 @@ void setup_traverse_info(struct traverse_info *info, const char *base)
 		info->prev = &dummy;
 }
 
-char *make_traverse_path(char *path, const struct traverse_info *info,
+char *make_traverse_path(char *path, size_t pathlen,
+			 const struct traverse_info *info,
 			 const char *name, size_t namelen)
 {
-	size_t pathlen = info->pathlen;
+	/* Always points to the end of the name we're about to add */
+	size_t pos = st_add(info->pathlen, namelen);
 
-	path[pathlen + namelen] = 0;
+	if (pos >= pathlen)
+		BUG("too small buffer passed to make_traverse_path");
+
+	path[pos] = 0;
 	for (;;) {
-		memcpy(path + pathlen, name, namelen);
-		if (!pathlen)
+		if (pos < namelen)
+			BUG("traverse_info pathlen does not match strings");
+		pos -= namelen;
+		memcpy(path + pos, name, namelen);
+
+		if (!pos)
 			break;
-		path[--pathlen] = '/';
+		path[--pos] = '/';
+
+		if (!info)
+			BUG("traverse_info ran out of list items");
 		name = info->name;
 		namelen = info->namelen;
 		info = info->prev;
-		pathlen -= namelen;
 	}
 	return path;
 }
@@ -209,7 +220,8 @@ void strbuf_make_traverse_path(struct strbuf *out,
 	size_t len = traverse_path_len(info, namelen);
 
 	strbuf_grow(out, len);
-	make_traverse_path(out->buf + out->len, info, name, namelen);
+	make_traverse_path(out->buf + out->len, out->alloc - out->len,
+			   info, name, namelen);
 	strbuf_setlen(out, out->len + len);
 }
 
diff --git a/tree-walk.h b/tree-walk.h
index 43b56fd8ff..abe2caf4e0 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -72,7 +72,7 @@ struct traverse_info {
 };
 
 int get_tree_entry(struct repository *, const struct object_id *, const char *, struct object_id *, unsigned short *);
-char *make_traverse_path(char *path, const struct traverse_info *info,
+char *make_traverse_path(char *path, size_t pathlen, const struct traverse_info *info,
 			 const char *name, size_t namelen);
 void strbuf_make_traverse_path(struct strbuf *out,
 			       const struct traverse_info *info,
diff --git a/unpack-trees.c b/unpack-trees.c
index b154f09547..50f257bd5c 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -968,7 +968,8 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
 	ce->ce_flags = create_ce_flags(stage);
 	ce->ce_namelen = len;
 	oidcpy(&ce->oid, &n->oid);
-	make_traverse_path(ce->name, info, n->path, n->pathlen);
+	/* len+1 because the cache_entry allocates space for NUL */
+	make_traverse_path(ce->name, len + 1, info, n->path, n->pathlen);
 
 	return ce;
 }
-- 
2.23.0.rc0.426.gbdee707ba7
