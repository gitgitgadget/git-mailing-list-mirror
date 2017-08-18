Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9CB2208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 22:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbdHRWVs (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 18:21:48 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:38284 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbdHRWU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 18:20:59 -0400
Received: by mail-pg0-f42.google.com with SMTP id t80so44559220pgb.5
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 15:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=DwjdJoisBvmIGHAGh9gjI0Qxp7CkT15fiYUArLwpgWM=;
        b=aJVEi4uCQE0FP+jU0ZJ243mZZT5VIQB+byE0FR4bULAMBDWZAQZdch4ILE75jNxt1E
         G40G1oWuYPNSfRVuGgd7cXEipVE51xcZ6CzkfR1XuXJKgf5XIMKS10Aauhifsh9jxBlT
         tgEs63awUO3T+T404uRxYpDiAPjwDakFFhhiAsWGXAfbuywRy7KBUMjehpOwGm9NqjGa
         pKCTqaAne1j14dBBXp5hbpty6kejGfts1BO9IuYqVdMuzg5pL+GhWO6gqKbHnQLz12Te
         6mIAkuIcwRk3CpEpDk7F8FjLHKqLRGGH87V+YTLMHZ8priOlbh4ZF6+twvjXH4xJ1O0q
         Jf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=DwjdJoisBvmIGHAGh9gjI0Qxp7CkT15fiYUArLwpgWM=;
        b=QKNmqo2cuurh4TdWLWpvqE1BdYidOVGjHizMnpZ6FvAJo4AQ643E7ezH/9/6fEFx0s
         05i6/iUXEai11wWKHy9iopJWVcuXy9vwZfH9efnw5m5NHEyiNTbbF/dbLR+49yn8e9B6
         WeTLBPBcc2bB4f9rUVKv6ZssFDrW0BlGonq1YVhI7lgHU7pRfcGp8S04CXwC4/EQ7EBN
         1Yx/XpP8ZuFPa6yWw193HGmHIosqXlU54+xdTnvea2LkJgfJCcSmMdVfHTl5EMNKqPm8
         8khZ8qGqToduZnWS4CheZXsec5K4W9Xj180u+XL7vP2y4m0e7NGSrvC9S1IHW0cjg6Us
         Ehsg==
X-Gm-Message-State: AHYfb5iRFHErUDM2ZS+pLwhvWw4wkf+w1Tj6XazgNjrPzthK2FkVz8fX
        m6lL6sHgvR0Ps+CKiBSZaA==
X-Received: by 10.84.216.20 with SMTP id m20mr7078765pli.206.1503094857774;
        Fri, 18 Aug 2017 15:20:57 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id w123sm12544006pfb.60.2017.08.18.15.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 15:20:56 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH v3 11/23] pack: move {,re}prepare_packed_git and approximate_object_count
Date:   Fri, 18 Aug 2017 15:20:26 -0700
Message-Id: <bc86b41f9b1f529499b37de2e79f6289e545afbd.1503094448.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89-goog
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1503094448.git.jonathantanmy@google.com>
In-Reply-To: <cover.1503094448.git.jonathantanmy@google.com>
References: <cover.1502220307.git.jonathantanmy@google.com> <cover.1503094448.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/gc.c   |   1 +
 bulk-checkin.c |   1 +
 cache.h        |  15 ----
 connected.c    |   2 +-
 fetch-pack.c   |   1 +
 http-backend.c |   1 +
 packfile.c     | 217 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.h     |  16 ++++-
 path.c         |   1 +
 server-info.c  |   1 +
 sha1_file.c    | 214 --------------------------------------------------------
 11 files changed, 238 insertions(+), 232 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e6b84475a..3c78fcb9b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -19,6 +19,7 @@
 #include "sigchain.h"
 #include "argv-array.h"
 #include "commit.h"
+#include "packfile.h"
 
 #define FAILED_RUN "failed to run %s"
 
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 5be7ce5c7..9a1f6c49a 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -6,6 +6,7 @@
 #include "csum-file.h"
 #include "pack.h"
 #include "strbuf.h"
+#include "packfile.h"
 
 static struct bulk_checkin_state {
 	unsigned plugged:1;
diff --git a/cache.h b/cache.h
index c4d8bee52..63765d481 100644
--- a/cache.h
+++ b/cache.h
@@ -1611,21 +1611,6 @@ struct pack_entry {
 	struct packed_git *p;
 };
 
-/* A hook to report invalid files in pack directory */
-#define PACKDIR_FILE_PACK 1
-#define PACKDIR_FILE_IDX 2
-#define PACKDIR_FILE_GARBAGE 4
-extern void (*report_garbage)(unsigned seen_bits, const char *path);
-
-extern void prepare_packed_git(void);
-extern void reprepare_packed_git(void);
-
-/*
- * Give a rough count of objects in the repository. This sacrifices accuracy
- * for speed.
- */
-unsigned long approximate_object_count(void);
-
 extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
 
diff --git a/connected.c b/connected.c
index 3e3f0148c..f416b0505 100644
--- a/connected.c
+++ b/connected.c
@@ -3,7 +3,7 @@
 #include "sigchain.h"
 #include "connected.h"
 #include "transport.h"
-#include "pack.h"
+#include "packfile.h"
 
 /*
  * If we feed all the commits we want to verify to this command
diff --git a/fetch-pack.c b/fetch-pack.c
index fbbc99c88..105506e9a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -17,6 +17,7 @@
 #include "prio-queue.h"
 #include "sha1-array.h"
 #include "oidset.h"
+#include "packfile.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
diff --git a/http-backend.c b/http-backend.c
index 519025d2c..8076b1d5e 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -9,6 +9,7 @@
 #include "string-list.h"
 #include "url.h"
 #include "argv-array.h"
+#include "packfile.h"
 
 static const char content_type[] = "Content-Type";
 static const char content_length[] = "Content-Length";
diff --git a/packfile.c b/packfile.c
index 9a65aa4f6..9cf462856 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,6 +1,9 @@
 #include "cache.h"
 #include "mru.h"
 #include "pack.h"
+#include "dir.h"
+#include "mergesort.h"
+#include "packfile.h"
 
 char *odb_pack_name(struct strbuf *buf,
 		    const unsigned char *sha1,
@@ -667,3 +670,217 @@ void install_packed_git(struct packed_git *pack)
 	pack->next = packed_git;
 	packed_git = pack;
 }
+
+void (*report_garbage)(unsigned seen_bits, const char *path);
+
+static void report_helper(const struct string_list *list,
+			  int seen_bits, int first, int last)
+{
+	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX))
+		return;
+
+	for (; first < last; first++)
+		report_garbage(seen_bits, list->items[first].string);
+}
+
+static void report_pack_garbage(struct string_list *list)
+{
+	int i, baselen = -1, first = 0, seen_bits = 0;
+
+	if (!report_garbage)
+		return;
+
+	string_list_sort(list);
+
+	for (i = 0; i < list->nr; i++) {
+		const char *path = list->items[i].string;
+		if (baselen != -1 &&
+		    strncmp(path, list->items[first].string, baselen)) {
+			report_helper(list, seen_bits, first, i);
+			baselen = -1;
+			seen_bits = 0;
+		}
+		if (baselen == -1) {
+			const char *dot = strrchr(path, '.');
+			if (!dot) {
+				report_garbage(PACKDIR_FILE_GARBAGE, path);
+				continue;
+			}
+			baselen = dot - path + 1;
+			first = i;
+		}
+		if (!strcmp(path + baselen, "pack"))
+			seen_bits |= 1;
+		else if (!strcmp(path + baselen, "idx"))
+			seen_bits |= 2;
+	}
+	report_helper(list, seen_bits, first, list->nr);
+}
+
+static void prepare_packed_git_one(char *objdir, int local)
+{
+	struct strbuf path = STRBUF_INIT;
+	size_t dirnamelen;
+	DIR *dir;
+	struct dirent *de;
+	struct string_list garbage = STRING_LIST_INIT_DUP;
+
+	strbuf_addstr(&path, objdir);
+	strbuf_addstr(&path, "/pack");
+	dir = opendir(path.buf);
+	if (!dir) {
+		if (errno != ENOENT)
+			error_errno("unable to open object pack directory: %s",
+				    path.buf);
+		strbuf_release(&path);
+		return;
+	}
+	strbuf_addch(&path, '/');
+	dirnamelen = path.len;
+	while ((de = readdir(dir)) != NULL) {
+		struct packed_git *p;
+		size_t base_len;
+
+		if (is_dot_or_dotdot(de->d_name))
+			continue;
+
+		strbuf_setlen(&path, dirnamelen);
+		strbuf_addstr(&path, de->d_name);
+
+		base_len = path.len;
+		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
+			/* Don't reopen a pack we already have. */
+			for (p = packed_git; p; p = p->next) {
+				size_t len;
+				if (strip_suffix(p->pack_name, ".pack", &len) &&
+				    len == base_len &&
+				    !memcmp(p->pack_name, path.buf, len))
+					break;
+			}
+			if (p == NULL &&
+			    /*
+			     * See if it really is a valid .idx file with
+			     * corresponding .pack file that we can map.
+			     */
+			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
+				install_packed_git(p);
+		}
+
+		if (!report_garbage)
+			continue;
+
+		if (ends_with(de->d_name, ".idx") ||
+		    ends_with(de->d_name, ".pack") ||
+		    ends_with(de->d_name, ".bitmap") ||
+		    ends_with(de->d_name, ".keep"))
+			string_list_append(&garbage, path.buf);
+		else
+			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
+	}
+	closedir(dir);
+	report_pack_garbage(&garbage);
+	string_list_clear(&garbage, 0);
+	strbuf_release(&path);
+}
+
+static int approximate_object_count_valid;
+
+/*
+ * Give a fast, rough count of the number of objects in the repository. This
+ * ignores loose objects completely. If you have a lot of them, then either
+ * you should repack because your performance will be awful, or they are
+ * all unreachable objects about to be pruned, in which case they're not really
+ * interesting as a measure of repo size in the first place.
+ */
+unsigned long approximate_object_count(void)
+{
+	static unsigned long count;
+	if (!approximate_object_count_valid) {
+		struct packed_git *p;
+
+		prepare_packed_git();
+		count = 0;
+		for (p = packed_git; p; p = p->next) {
+			if (open_pack_index(p))
+				continue;
+			count += p->num_objects;
+		}
+	}
+	return count;
+}
+
+static void *get_next_packed_git(const void *p)
+{
+	return ((const struct packed_git *)p)->next;
+}
+
+static void set_next_packed_git(void *p, void *next)
+{
+	((struct packed_git *)p)->next = next;
+}
+
+static int sort_pack(const void *a_, const void *b_)
+{
+	const struct packed_git *a = a_;
+	const struct packed_git *b = b_;
+	int st;
+
+	/*
+	 * Local packs tend to contain objects specific to our
+	 * variant of the project than remote ones.  In addition,
+	 * remote ones could be on a network mounted filesystem.
+	 * Favor local ones for these reasons.
+	 */
+	st = a->pack_local - b->pack_local;
+	if (st)
+		return -st;
+
+	/*
+	 * Younger packs tend to contain more recent objects,
+	 * and more recent objects tend to get accessed more
+	 * often.
+	 */
+	if (a->mtime < b->mtime)
+		return 1;
+	else if (a->mtime == b->mtime)
+		return 0;
+	return -1;
+}
+
+static void rearrange_packed_git(void)
+{
+	packed_git = llist_mergesort(packed_git, get_next_packed_git,
+				     set_next_packed_git, sort_pack);
+}
+
+static void prepare_packed_git_mru(void)
+{
+	struct packed_git *p;
+
+	mru_clear(packed_git_mru);
+	for (p = packed_git; p; p = p->next)
+		mru_append(packed_git_mru, p);
+}
+
+static int prepare_packed_git_run_once = 0;
+void prepare_packed_git(void)
+{
+	struct alternate_object_database *alt;
+
+	if (prepare_packed_git_run_once)
+		return;
+	prepare_packed_git_one(get_object_directory(), 1);
+	prepare_alt_odb();
+	for (alt = alt_odb_list; alt; alt = alt->next)
+		prepare_packed_git_one(alt->path, 0);
+	rearrange_packed_git();
+	prepare_packed_git_mru();
+	prepare_packed_git_run_once = 1;
+}
+
+void reprepare_packed_git(void)
+{
+	approximate_object_count_valid = 0;
+	prepare_packed_git_run_once = 0;
+	prepare_packed_git();
+}
diff --git a/packfile.h b/packfile.h
index a18029184..1cfda1d00 100644
--- a/packfile.h
+++ b/packfile.h
@@ -24,12 +24,24 @@ extern char *sha1_pack_name(const unsigned char *sha1);
  */
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 
-extern unsigned int pack_open_fds;
-
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
+/* A hook to report invalid files in pack directory */
+#define PACKDIR_FILE_PACK 1
+#define PACKDIR_FILE_IDX 2
+#define PACKDIR_FILE_GARBAGE 4
+extern void (*report_garbage)(unsigned seen_bits, const char *path);
+
+extern void prepare_packed_git(void);
+extern void reprepare_packed_git(void);
 extern void install_packed_git(struct packed_git *pack);
 
+/*
+ * Give a rough count of objects in the repository. This sacrifices accuracy
+ * for speed.
+ */
+unsigned long approximate_object_count(void);
+
 extern void pack_report(void);
 
 /*
diff --git a/path.c b/path.c
index e50d2befc..b533ec938 100644
--- a/path.c
+++ b/path.c
@@ -9,6 +9,7 @@
 #include "worktree.h"
 #include "submodule-config.h"
 #include "path.h"
+#include "packfile.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
diff --git a/server-info.c b/server-info.c
index 5ec5b1d82..26a6c20b7 100644
--- a/server-info.c
+++ b/server-info.c
@@ -3,6 +3,7 @@
 #include "object.h"
 #include "commit.h"
 #include "tag.h"
+#include "packfile.h"
 
 /*
  * Create the file "path" by writing to a temporary file and renaming
diff --git a/sha1_file.c b/sha1_file.c
index b77e7e3c3..51bb4d1db 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -718,220 +718,6 @@ void *xmmap(void *start, size_t length,
 	return ret;
 }
 
-void (*report_garbage)(unsigned seen_bits, const char *path);
-
-static void report_helper(const struct string_list *list,
-			  int seen_bits, int first, int last)
-{
-	if (seen_bits == (PACKDIR_FILE_PACK|PACKDIR_FILE_IDX))
-		return;
-
-	for (; first < last; first++)
-		report_garbage(seen_bits, list->items[first].string);
-}
-
-static void report_pack_garbage(struct string_list *list)
-{
-	int i, baselen = -1, first = 0, seen_bits = 0;
-
-	if (!report_garbage)
-		return;
-
-	string_list_sort(list);
-
-	for (i = 0; i < list->nr; i++) {
-		const char *path = list->items[i].string;
-		if (baselen != -1 &&
-		    strncmp(path, list->items[first].string, baselen)) {
-			report_helper(list, seen_bits, first, i);
-			baselen = -1;
-			seen_bits = 0;
-		}
-		if (baselen == -1) {
-			const char *dot = strrchr(path, '.');
-			if (!dot) {
-				report_garbage(PACKDIR_FILE_GARBAGE, path);
-				continue;
-			}
-			baselen = dot - path + 1;
-			first = i;
-		}
-		if (!strcmp(path + baselen, "pack"))
-			seen_bits |= 1;
-		else if (!strcmp(path + baselen, "idx"))
-			seen_bits |= 2;
-	}
-	report_helper(list, seen_bits, first, list->nr);
-}
-
-static void prepare_packed_git_one(char *objdir, int local)
-{
-	struct strbuf path = STRBUF_INIT;
-	size_t dirnamelen;
-	DIR *dir;
-	struct dirent *de;
-	struct string_list garbage = STRING_LIST_INIT_DUP;
-
-	strbuf_addstr(&path, objdir);
-	strbuf_addstr(&path, "/pack");
-	dir = opendir(path.buf);
-	if (!dir) {
-		if (errno != ENOENT)
-			error_errno("unable to open object pack directory: %s",
-				    path.buf);
-		strbuf_release(&path);
-		return;
-	}
-	strbuf_addch(&path, '/');
-	dirnamelen = path.len;
-	while ((de = readdir(dir)) != NULL) {
-		struct packed_git *p;
-		size_t base_len;
-
-		if (is_dot_or_dotdot(de->d_name))
-			continue;
-
-		strbuf_setlen(&path, dirnamelen);
-		strbuf_addstr(&path, de->d_name);
-
-		base_len = path.len;
-		if (strip_suffix_mem(path.buf, &base_len, ".idx")) {
-			/* Don't reopen a pack we already have. */
-			for (p = packed_git; p; p = p->next) {
-				size_t len;
-				if (strip_suffix(p->pack_name, ".pack", &len) &&
-				    len == base_len &&
-				    !memcmp(p->pack_name, path.buf, len))
-					break;
-			}
-			if (p == NULL &&
-			    /*
-			     * See if it really is a valid .idx file with
-			     * corresponding .pack file that we can map.
-			     */
-			    (p = add_packed_git(path.buf, path.len, local)) != NULL)
-				install_packed_git(p);
-		}
-
-		if (!report_garbage)
-			continue;
-
-		if (ends_with(de->d_name, ".idx") ||
-		    ends_with(de->d_name, ".pack") ||
-		    ends_with(de->d_name, ".bitmap") ||
-		    ends_with(de->d_name, ".keep"))
-			string_list_append(&garbage, path.buf);
-		else
-			report_garbage(PACKDIR_FILE_GARBAGE, path.buf);
-	}
-	closedir(dir);
-	report_pack_garbage(&garbage);
-	string_list_clear(&garbage, 0);
-	strbuf_release(&path);
-}
-
-static int approximate_object_count_valid;
-
-/*
- * Give a fast, rough count of the number of objects in the repository. This
- * ignores loose objects completely. If you have a lot of them, then either
- * you should repack because your performance will be awful, or they are
- * all unreachable objects about to be pruned, in which case they're not really
- * interesting as a measure of repo size in the first place.
- */
-unsigned long approximate_object_count(void)
-{
-	static unsigned long count;
-	if (!approximate_object_count_valid) {
-		struct packed_git *p;
-
-		prepare_packed_git();
-		count = 0;
-		for (p = packed_git; p; p = p->next) {
-			if (open_pack_index(p))
-				continue;
-			count += p->num_objects;
-		}
-	}
-	return count;
-}
-
-static void *get_next_packed_git(const void *p)
-{
-	return ((const struct packed_git *)p)->next;
-}
-
-static void set_next_packed_git(void *p, void *next)
-{
-	((struct packed_git *)p)->next = next;
-}
-
-static int sort_pack(const void *a_, const void *b_)
-{
-	const struct packed_git *a = a_;
-	const struct packed_git *b = b_;
-	int st;
-
-	/*
-	 * Local packs tend to contain objects specific to our
-	 * variant of the project than remote ones.  In addition,
-	 * remote ones could be on a network mounted filesystem.
-	 * Favor local ones for these reasons.
-	 */
-	st = a->pack_local - b->pack_local;
-	if (st)
-		return -st;
-
-	/*
-	 * Younger packs tend to contain more recent objects,
-	 * and more recent objects tend to get accessed more
-	 * often.
-	 */
-	if (a->mtime < b->mtime)
-		return 1;
-	else if (a->mtime == b->mtime)
-		return 0;
-	return -1;
-}
-
-static void rearrange_packed_git(void)
-{
-	packed_git = llist_mergesort(packed_git, get_next_packed_git,
-				     set_next_packed_git, sort_pack);
-}
-
-static void prepare_packed_git_mru(void)
-{
-	struct packed_git *p;
-
-	mru_clear(packed_git_mru);
-	for (p = packed_git; p; p = p->next)
-		mru_append(packed_git_mru, p);
-}
-
-static int prepare_packed_git_run_once = 0;
-void prepare_packed_git(void)
-{
-	struct alternate_object_database *alt;
-
-	if (prepare_packed_git_run_once)
-		return;
-	prepare_packed_git_one(get_object_directory(), 1);
-	prepare_alt_odb();
-	for (alt = alt_odb_list; alt; alt = alt->next)
-		prepare_packed_git_one(alt->path, 0);
-	rearrange_packed_git();
-	prepare_packed_git_mru();
-	prepare_packed_git_run_once = 1;
-}
-
-void reprepare_packed_git(void)
-{
-	approximate_object_count_valid = 0;
-	prepare_packed_git_run_once = 0;
-	prepare_packed_git();
-}
-
 static void mark_bad_packed_object(struct packed_git *p,
 				   const unsigned char *sha1)
 {
-- 
2.14.1.480.gb18f417b89-goog

