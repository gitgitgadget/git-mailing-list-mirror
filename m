Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFE2820248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbfDESGG (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:06:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:48690 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728683AbfDESGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:06:06 -0400
Received: (qmail 11061 invoked by uid 109); 5 Apr 2019 18:06:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:06:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28216 invoked by uid 111); 5 Apr 2019 18:06:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:06:33 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:06:04 -0400
Date:   Fri, 5 Apr 2019 14:06:04 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v2 05/13] midx: check both pack and index names for
 containment
Message-ID: <20190405180604.GE32243@sigill.intra.peff.net>
References: <20190405180306.GA21113@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405180306.GA21113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A midx file (and the struct we parse from it) contains a list of all of
the covered packfiles, mentioned by their ".idx" names (e.g.,
"pack-1234.idx", etc). And thus calls to midx_contains_pack() expect
callers to provide the idx name.

This works for most of the calls, but the one in open_packed_git_1()
tries to feed a packed_git->pack_name, which is the ".pack" name,
meaning we'll never find a match (even if the pack is covered by the
midx).

We can fix this by converting the ".pack" to ".idx" in the caller.
However, that requires allocating a new string. Instead, let's make
midx_contains_pack() a bit friendlier, and allow it take _either_ the
.pack or .idx variant.

All cleverness in the matching code is credited to René. Bugs are mine.

There's no test here, because while this does fix _a_ bug, it's masked
by another bug in that same caller. That will be covered (with a test)
in the next patch.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Jeff King <peff@peff.net>
---
I was tempted to suggest that the midx struct just store the base name
without ".idx" at all, but having callers pass that is no less tricky
than passing ".idx" (they still have to allocate a new string).

 midx.c | 36 ++++++++++++++++++++++++++++++++++--
 midx.h |  2 +-
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 8a505fd423..0ceca1938f 100644
--- a/midx.c
+++ b/midx.c
@@ -307,7 +307,39 @@ int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct mu
 	return nth_midxed_pack_entry(m, e, pos);
 }
 
-int midx_contains_pack(struct multi_pack_index *m, const char *idx_name)
+/* Match "foo.idx" against either "foo.pack" _or_ "foo.idx". */
+static int cmp_idx_or_pack_name(const char *idx_or_pack_name,
+				const char *idx_name)
+{
+	/* Skip past any initial matching prefix. */
+	while (*idx_name && *idx_name == *idx_or_pack_name) {
+		idx_name++;
+		idx_or_pack_name++;
+	}
+
+	/*
+	 * If we didn't match completely, we may have matched "pack-1234." and
+	 * be left with "idx" and "pack" respectively, which is also OK. We do
+	 * not have to check for "idx" and "idx", because that would have been
+	 * a complete match (and in that case these strcmps will be false, but
+	 * we'll correctly return 0 from the final strcmp() below.
+	 *
+	 * Technically this matches "fooidx" and "foopack", but we'd never have
+	 * such names in the first place.
+	 */
+	if (!strcmp(idx_name, "idx") && !strcmp(idx_or_pack_name, "pack"))
+		return 0;
+
+	/*
+	 * This not only checks for a complete match, but also orders based on
+	 * the first non-identical character, which means our ordering will
+	 * match a raw strcmp(). That makes it OK to use this to binary search
+	 * a naively-sorted list.
+	 */
+	return strcmp(idx_or_pack_name, idx_name);
+}
+
+int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name)
 {
 	uint32_t first = 0, last = m->num_packs;
 
@@ -317,7 +349,7 @@ int midx_contains_pack(struct multi_pack_index *m, const char *idx_name)
 		int cmp;
 
 		current = m->pack_names[mid];
-		cmp = strcmp(idx_name, current);
+		cmp = cmp_idx_or_pack_name(idx_or_pack_name, current);
 		if (!cmp)
 			return 1;
 		if (cmp > 0) {
diff --git a/midx.h b/midx.h
index 774f652530..26dd042d63 100644
--- a/midx.h
+++ b/midx.h
@@ -43,7 +43,7 @@ struct object_id *nth_midxed_object_oid(struct object_id *oid,
 					struct multi_pack_index *m,
 					uint32_t n);
 int fill_midx_entry(const struct object_id *oid, struct pack_entry *e, struct multi_pack_index *m);
-int midx_contains_pack(struct multi_pack_index *m, const char *idx_name);
+int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pack_name);
 int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
 
 int write_midx_file(const char *object_dir);
-- 
2.21.0.729.g7d31bf3764

