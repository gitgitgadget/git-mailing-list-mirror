Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3457D207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbcJCUff (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:35:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:51447 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751613AbcJCUfd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:35:33 -0400
Received: (qmail 17333 invoked by uid 109); 3 Oct 2016 20:35:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:35:33 +0000
Received: (qmail 29791 invoked by uid 111); 3 Oct 2016 20:35:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:35:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:35:31 -0400
Date:   Mon, 3 Oct 2016 16:35:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 10/18] alternates: provide helper for allocating alternate
Message-ID: <20161003203531.bppczvzmdfumtnb2@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Allocating a struct alternate_object_database is tricky, as
we must over-allocate the buffer to provide scratch space,
and then put in particular '/' and NUL markers.

Let's encapsulate this in a function so that the complexity
doesn't leak into callers (and so that we can modify it
later).

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     |  6 ++++++
 sha1_file.c | 28 +++++++++++++++++++---------
 sha1_name.c |  7 +------
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/cache.h b/cache.h
index 9a91378..d36b2ad 100644
--- a/cache.h
+++ b/cache.h
@@ -1391,6 +1391,12 @@ extern char *compute_alternate_path(const char *path, struct strbuf *err);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
 
+/*
+ * Allocate a "struct alternate_object_database" but do _not_ actually
+ * add it to the list of alternates.
+ */
+struct alternate_object_database *alloc_alt_odb(const char *dir);
+
 /*
  * Add the directory to the on-disk alternates file; the new entry will also
  * take effect in the current process.
diff --git a/sha1_file.c b/sha1_file.c
index 2e41b26..549cf1e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -283,7 +283,6 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 	int depth, const char *normalized_objdir)
 {
 	struct alternate_object_database *ent;
-	size_t entlen;
 	struct strbuf pathbuf = STRBUF_INIT;
 
 	if (!is_absolute_path(entry) && relative_base) {
@@ -311,14 +310,7 @@ static int link_alt_odb_entry(const char *entry, const char *relative_base,
 		return -1;
 	}
 
-	entlen = st_add(pathbuf.len, 43); /* '/' + 2 hex + '/' + 38 hex + NUL */
-	ent = xmalloc(st_add(sizeof(*ent), entlen));
-	memcpy(ent->base, pathbuf.buf, pathbuf.len);
-
-	ent->name = ent->base + pathbuf.len + 1;
-	ent->base[pathbuf.len] = '/';
-	ent->base[pathbuf.len + 3] = '/';
-	ent->base[entlen-1] = 0;
+	ent = alloc_alt_odb(pathbuf.buf);
 
 	/* add the alternate entry */
 	*alt_odb_tail = ent;
@@ -395,6 +387,24 @@ void read_info_alternates(const char * relative_base, int depth)
 	munmap(map, mapsz);
 }
 
+struct alternate_object_database *alloc_alt_odb(const char *dir)
+{
+	struct alternate_object_database *ent;
+	size_t dirlen = strlen(dir);
+	size_t entlen;
+
+	entlen = st_add(dirlen, 43); /* '/' + 2 hex + '/' + 38 hex + NUL */
+	ent = xmalloc(st_add(sizeof(*ent), entlen));
+	memcpy(ent->base, dir, dirlen);
+
+	ent->name = ent->base + dirlen + 1;
+	ent->base[dirlen] = '/';
+	ent->base[dirlen + 3] = '/';
+	ent->base[entlen-1] = 0;
+
+	return ent;
+}
+
 void add_to_alternates_file(const char *reference)
 {
 	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
diff --git a/sha1_name.c b/sha1_name.c
index faf873c..98152a6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -86,12 +86,7 @@ static void find_short_object_filename(int len, const char *hex_pfx, struct disa
 		 * alt->name/alt->base while iterating over the
 		 * object databases including our own.
 		 */
-		const char *objdir = get_object_directory();
-		size_t objdir_len = strlen(objdir);
-		fakeent = xmalloc(st_add3(sizeof(*fakeent), objdir_len, 43));
-		memcpy(fakeent->base, objdir, objdir_len);
-		fakeent->name = fakeent->base + objdir_len + 1;
-		fakeent->name[-1] = '/';
+		fakeent = alloc_alt_odb(get_object_directory());
 	}
 	fakeent->next = alt_odb_list;
 
-- 
2.10.0.618.g82cc264

