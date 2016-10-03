Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 420E8207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752796AbcJCUfH (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:35:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:51443 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751613AbcJCUfF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:35:05 -0400
Received: (qmail 17319 invoked by uid 109); 3 Oct 2016 20:35:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:35:05 +0000
Received: (qmail 29773 invoked by uid 111); 3 Oct 2016 20:35:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:35:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:35:03 -0400
Date:   Mon, 3 Oct 2016 16:35:03 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 09/18] alternates: provide helper for adding to alternates
 list
Message-ID: <20161003203503.omjwvg4ocz7pjyzt@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule code wants to temporarily add an alternate
object store to our in-memory alt_odb list, but does it
manually. Let's provide a helper so it can reuse the code in
link_alt_odb_entry().

While we're adding our new add_to_alternates_memory(), let's
document add_to_alternates_file(), as the two are related.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     | 14 +++++++++++++-
 sha1_file.c | 11 +++++++++++
 submodule.c | 23 +----------------------
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/cache.h b/cache.h
index ed3d5df..9a91378 100644
--- a/cache.h
+++ b/cache.h
@@ -1388,10 +1388,22 @@ extern struct alternate_object_database {
 extern void prepare_alt_odb(void);
 extern void read_info_alternates(const char * relative_base, int depth);
 extern char *compute_alternate_path(const char *path, struct strbuf *err);
-extern void add_to_alternates_file(const char *reference);
 typedef int alt_odb_fn(struct alternate_object_database *, void *);
 extern int foreach_alt_odb(alt_odb_fn, void*);
 
+/*
+ * Add the directory to the on-disk alternates file; the new entry will also
+ * take effect in the current process.
+ */
+extern void add_to_alternates_file(const char *dir);
+
+/*
+ * Add the directory to the in-memory list of alternates (along with any
+ * recursive alternates it points to), but do not modify the on-disk alternates
+ * file.
+ */
+extern void add_to_alternates_memory(const char *dir);
+
 struct pack_window {
 	struct pack_window *next;
 	unsigned char *base;
diff --git a/sha1_file.c b/sha1_file.c
index f396823..2e41b26 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -440,6 +440,17 @@ void add_to_alternates_file(const char *reference)
 	free(alts);
 }
 
+void add_to_alternates_memory(const char *reference)
+{
+	/*
+	 * Make sure alternates are initialized, or else our entry may be
+	 * overwritten when they are.
+	 */
+	prepare_alt_odb();
+
+	link_alt_odb_entries(reference, strlen(reference), '\n', NULL, 0);
+}
+
 /*
  * Compute the exact path an alternate is at and returns it. In case of
  * error NULL is returned and the human readable error is added to `err`
diff --git a/submodule.c b/submodule.c
index 0ef2ff4..8b3274a 100644
--- a/submodule.c
+++ b/submodule.c
@@ -123,9 +123,7 @@ void stage_updated_gitmodules(void)
 static int add_submodule_odb(const char *path)
 {
 	struct strbuf objects_directory = STRBUF_INIT;
-	struct alternate_object_database *alt_odb;
 	int ret = 0;
-	size_t alloc;
 
 	ret = strbuf_git_path_submodule(&objects_directory, path, "objects/");
 	if (ret)
@@ -134,26 +132,7 @@ static int add_submodule_odb(const char *path)
 		ret = -1;
 		goto done;
 	}
-	/* avoid adding it twice */
-	prepare_alt_odb();
-	for (alt_odb = alt_odb_list; alt_odb; alt_odb = alt_odb->next)
-		if (alt_odb->name - alt_odb->base == objects_directory.len &&
-				!strncmp(alt_odb->base, objects_directory.buf,
-					objects_directory.len))
-			goto done;
-
-	alloc = st_add(objects_directory.len, 42); /* for "12/345..." sha1 */
-	alt_odb = xmalloc(st_add(sizeof(*alt_odb), alloc));
-	alt_odb->next = alt_odb_list;
-	xsnprintf(alt_odb->base, alloc, "%s", objects_directory.buf);
-	alt_odb->name = alt_odb->base + objects_directory.len;
-	alt_odb->name[2] = '/';
-	alt_odb->name[40] = '\0';
-	alt_odb->name[41] = '\0';
-	alt_odb_list = alt_odb;
-
-	/* add possible alternates from the submodule */
-	read_info_alternates(objects_directory.buf, 0);
+	add_to_alternates_memory(objects_directory.buf);
 done:
 	strbuf_release(&objects_directory);
 	return ret;
-- 
2.10.0.618.g82cc264

