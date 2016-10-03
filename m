Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EA89207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 20:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752966AbcJCUfz (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:35:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:51455 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbcJCUfy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:35:54 -0400
Received: (qmail 17419 invoked by uid 109); 3 Oct 2016 20:35:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:35:54 +0000
Received: (qmail 29826 invoked by uid 111); 3 Oct 2016 20:36:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:36:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:35:51 -0400
Date:   Mon, 3 Oct 2016 16:35:51 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 12/18] alternates: use a separate scratch space
Message-ID: <20161003203551.tmqp5rll6nqkewxz@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The alternate_object_database struct uses a single buffer
both for storing the path to the alternate, and as a scratch
buffer for forming object names. This is efficient (since
otherwise we'd end up storing the path twice), but it makes
life hard for callers who just want to know the path to the
alternate. They have to remember to stop reading after
"alt->name - alt->base" bytes, and to subtract one for the
trailing '/'.

It would be much simpler if they could simply access a
NUL-terminated path string. We could encapsulate this in a
function which puts a NUL in the scratch buffer and returns
the string, but that opens up questions about the lifetime
of the result. The first time another caller uses the
alternate, the scratch buffer may get other data tacked onto
it.

Let's instead just store the root path separately from the
scratch buffer. There aren't enough alternates being stored
for the duplicated data to matter for performance, and this
keeps things simple and safe for the callers.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c              | 10 ++--------
 builtin/submodule--helper.c | 11 +++--------
 cache.h                     |  5 ++++-
 sha1_file.c                 | 28 ++++++++++++----------------
 sha1_name.c                 |  3 ++-
 transport.c                 |  4 +---
 6 files changed, 24 insertions(+), 37 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 055dfdc..f01b81e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -644,14 +644,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		fsck_object_dir(get_object_directory());
 
 		prepare_alt_odb();
-		for (alt = alt_odb_list; alt; alt = alt->next) {
-			/* directory name, minus trailing slash */
-			size_t namelen = alt->name - alt->base - 1;
-			struct strbuf name = STRBUF_INIT;
-			strbuf_add(&name, alt->base, namelen);
-			fsck_object_dir(name.buf);
-			strbuf_release(&name);
-		}
+		for (alt = alt_odb_list; alt; alt = alt->next)
+			fsck_object_dir(alt->path);
 	}
 
 	if (check_full) {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e3fdc0a..fd72c90 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -492,20 +492,16 @@ static int add_possible_reference_from_superproject(
 {
 	struct submodule_alternate_setup *sas = sas_cb;
 
-	/* directory name, minus trailing slash */
-	size_t namelen = alt->name - alt->base - 1;
-	struct strbuf name = STRBUF_INIT;
-	strbuf_add(&name, alt->base, namelen);
-
 	/*
 	 * If the alternate object store is another repository, try the
 	 * standard layout with .git/modules/<name>/objects
 	 */
-	if (ends_with(name.buf, ".git/objects")) {
+	if (ends_with(alt->path, ".git/objects")) {
 		char *sm_alternate;
 		struct strbuf sb = STRBUF_INIT;
 		struct strbuf err = STRBUF_INIT;
-		strbuf_add(&sb, name.buf, name.len - strlen("objects"));
+		strbuf_add(&sb, alt->path, strlen(alt->path) - strlen("objects"));
+
 		/*
 		 * We need to end the new path with '/' to mark it as a dir,
 		 * otherwise a submodule name containing '/' will be broken
@@ -533,7 +529,6 @@ static int add_possible_reference_from_superproject(
 		strbuf_release(&sb);
 	}
 
-	strbuf_release(&name);
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index d36b2ad..e1996c5 100644
--- a/cache.h
+++ b/cache.h
@@ -1382,8 +1382,11 @@ extern void remove_scheduled_dirs(void);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
+
 	char *name;
-	char base[FLEX_ARRAY]; /* more */
+	char *scratch;
+
+	char path[FLEX_ARRAY];
 } *alt_odb_list;
 extern void prepare_alt_odb(void);
 extern void read_info_alternates(const char * relative_base, int depth);
diff --git a/sha1_file.c b/sha1_file.c
index ccf59ba..70c3e2f 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -208,7 +208,7 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 				 const unsigned char *sha1)
 {
 	fill_sha1_path(alt->name, sha1);
-	return alt->base;
+	return alt->scratch;
 }
 
 /*
@@ -261,8 +261,7 @@ static int alt_odb_usable(struct strbuf *path, const char *normalized_objdir)
 	 * thing twice, or object directory itself.
 	 */
 	for (alt = alt_odb_list; alt; alt = alt->next) {
-		if (path->len == alt->name - alt->base - 1 &&
-		    !memcmp(path->buf, alt->base, path->len))
+		if (!strcmp(path->buf, alt->path))
 			return 0;
 	}
 	if (!fspathcmp(path->buf, normalized_objdir))
@@ -401,13 +400,14 @@ struct alternate_object_database *alloc_alt_odb(const char *dir)
 	size_t entlen;
 
 	entlen = st_add(dirlen, 43); /* '/' + 2 hex + '/' + 38 hex + NUL */
-	ent = xmalloc(st_add(sizeof(*ent), entlen));
-	memcpy(ent->base, dir, dirlen);
+	FLEX_ALLOC_STR(ent, path, dir);
+	ent->scratch = xmalloc(entlen);
+	xsnprintf(ent->scratch, entlen, "%s/", dir);
 
-	ent->name = ent->base + dirlen + 1;
-	ent->base[dirlen] = '/';
-	ent->base[dirlen + 3] = '/';
-	ent->base[entlen-1] = 0;
+	ent->name = ent->scratch + dirlen + 1;
+	ent->scratch[dirlen] = '/';
+	ent->scratch[dirlen + 3] = '/';
+	ent->scratch[entlen-1] = 0;
 
 	return ent;
 }
@@ -1485,11 +1485,8 @@ void prepare_packed_git(void)
 		return;
 	prepare_packed_git_one(get_object_directory(), 1);
 	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next) {
-		alt->name[-1] = 0;
-		prepare_packed_git_one(alt->base, 0);
-		alt->name[-1] = '/';
-	}
+	for (alt = alt_odb_list; alt; alt = alt->next)
+		prepare_packed_git_one(alt->path, 0);
 	rearrange_packed_git();
 	prepare_packed_git_mru();
 	prepare_packed_git_run_once = 1;
@@ -3670,8 +3667,7 @@ static int loose_from_alt_odb(struct alternate_object_database *alt,
 	struct strbuf buf = STRBUF_INIT;
 	int r;
 
-	/* copy base not including trailing '/' */
-	strbuf_add(&buf, alt->base, alt->name - alt->base - 1);
+	strbuf_addstr(&buf, alt->path);
 	r = for_each_loose_file_in_objdir_buf(&buf,
 					      data->cb, NULL, NULL,
 					      data->data);
diff --git a/sha1_name.c b/sha1_name.c
index 98152a6..770ea4f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -94,12 +94,13 @@ static void find_short_object_filename(int len, const char *hex_pfx, struct disa
 	for (alt = fakeent; alt && !ds->ambiguous; alt = alt->next) {
 		struct dirent *de;
 		DIR *dir;
+
 		/*
 		 * every alt_odb struct has 42 extra bytes after the base
 		 * for exactly this purpose
 		 */
 		xsnprintf(alt->name, 42, "%.2s/", hex_pfx);
-		dir = opendir(alt->base);
+		dir = opendir(alt->scratch);
 		if (!dir)
 			continue;
 
diff --git a/transport.c b/transport.c
index 94d6dc3..4bc4eea 100644
--- a/transport.c
+++ b/transport.c
@@ -1084,9 +1084,7 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 	const struct ref *extra;
 	struct alternate_refs_data *cb = data;
 
-	e->name[-1] = '\0';
-	other = xstrdup(real_path(e->base));
-	e->name[-1] = '/';
+	other = xstrdup(real_path(e->path));
 	len = strlen(other);
 
 	while (other[len-1] == '/')
-- 
2.10.0.618.g82cc264

