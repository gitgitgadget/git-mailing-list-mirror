Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D48B71FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755836AbdC1TrJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:47:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:53160 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755801AbdC1TrG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:47:06 -0400
Received: (qmail 11789 invoked by uid 109); 28 Mar 2017 19:46:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:46:32 +0000
Received: (qmail 5430 invoked by uid 111); 28 Mar 2017 19:46:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:46:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:46:30 -0400
Date:   Tue, 28 Mar 2017 15:46:30 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 07/18] avoid using fixed PATH_MAX buffers for refs
Message-ID: <20170328194629.5ddehsxizajitn3q@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many functions which handle refs use a PATH_MAX-sized buffer
to do so. This is mostly reasonable as we have to write
loose refs into the filesystem, and at least on Linux the 4K
PATH_MAX is big enough that nobody would care. But:

  1. The static PATH_MAX is not always the filesystem limit.

  2. On other platforms, PATH_MAX may be much smaller.

  3. As we move to alternate ref storage, we won't be bound
     by filesystem limits.

Let's convert these to heap buffers so we don't have to
worry about truncation or size limits.

We may want to eventually constrain ref lengths for sanity
and to prevent malicious names, but we should do so
consistently across all platforms, and in a central place
(like the ref code).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout.c  |  5 ++---
 builtin/ls-remote.c | 10 ++++++----
 builtin/replace.c   | 50 +++++++++++++++++++++++++++-----------------------
 builtin/tag.c       | 15 ++++++---------
 4 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 81f07c3ef..93e8dfc82 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -889,11 +889,10 @@ static int check_tracking_name(struct remote *remote, void *cb_data)
 static const char *unique_tracking_name(const char *name, struct object_id *oid)
 {
 	struct tracking_name_data cb_data = { NULL, NULL, NULL, 1 };
-	char src_ref[PATH_MAX];
-	snprintf(src_ref, PATH_MAX, "refs/heads/%s", name);
-	cb_data.src_ref = src_ref;
+	cb_data.src_ref = xstrfmt("refs/heads/%s", name);
 	cb_data.dst_oid = oid;
 	for_each_remote(check_tracking_name, &cb_data);
+	free(cb_data.src_ref);
 	if (cb_data.unique)
 		return cb_data.dst_ref;
 	free(cb_data.dst_ref);
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 66cdd45cc..b2d7d5ce6 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -17,17 +17,19 @@ static const char * const ls_remote_usage[] = {
 static int tail_match(const char **pattern, const char *path)
 {
 	const char *p;
-	char pathbuf[PATH_MAX];
+	char *pathbuf;
 
 	if (!pattern)
 		return 1; /* no restriction */
 
-	if (snprintf(pathbuf, sizeof(pathbuf), "/%s", path) > sizeof(pathbuf))
-		return error("insanely long ref %.*s...", 20, path);
+	pathbuf = xstrfmt("/%s", path);
 	while ((p = *(pattern++)) != NULL) {
-		if (!wildmatch(p, pathbuf, 0, NULL))
+		if (!wildmatch(p, pathbuf, 0, NULL)) {
+			free(pathbuf);
 			return 1;
+		}
 	}
+	free(pathbuf);
 	return 0;
 }
 
diff --git a/builtin/replace.c b/builtin/replace.c
index f83e7b8fc..065515bab 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -93,26 +93,31 @@ typedef int (*each_replace_name_fn)(const char *name, const char *ref,
 static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
 {
 	const char **p, *full_hex;
-	char ref[PATH_MAX];
+	struct strbuf ref = STRBUF_INIT;
+	size_t base_len;
 	int had_error = 0;
 	struct object_id oid;
 
+	strbuf_addstr(&ref, git_replace_ref_base);
+	base_len = ref.len;
+
 	for (p = argv; *p; p++) {
 		if (get_oid(*p, &oid)) {
 			error("Failed to resolve '%s' as a valid ref.", *p);
 			had_error = 1;
 			continue;
 		}
-		full_hex = oid_to_hex(&oid);
-		snprintf(ref, sizeof(ref), "%s%s", git_replace_ref_base, full_hex);
-		/* read_ref() may reuse the buffer */
-		full_hex = ref + strlen(git_replace_ref_base);
-		if (read_ref(ref, oid.hash)) {
+
+		strbuf_setlen(&ref, base_len);
+		strbuf_addstr(&ref, oid_to_hex(&oid));
+		full_hex = ref.buf + base_len;
+
+		if (read_ref(ref.buf, oid.hash)) {
 			error("replace ref '%s' not found.", full_hex);
 			had_error = 1;
 			continue;
 		}
-		if (fn(full_hex, ref, &oid))
+		if (fn(full_hex, ref.buf, &oid))
 			had_error = 1;
 	}
 	return had_error;
@@ -129,21 +134,18 @@ static int delete_replace_ref(const char *name, const char *ref,
 
 static void check_ref_valid(struct object_id *object,
 			    struct object_id *prev,
-			    char *ref,
-			    int ref_size,
+			    struct strbuf *ref,
 			    int force)
 {
-	if (snprintf(ref, ref_size,
-		     "%s%s", git_replace_ref_base,
-		     oid_to_hex(object)) > ref_size - 1)
-		die("replace ref name too long: %.*s...", 50, ref);
-	if (check_refname_format(ref, 0))
-		die("'%s' is not a valid ref name.", ref);
-
-	if (read_ref(ref, prev->hash))
+	strbuf_reset(ref);
+	strbuf_addf(ref, "%s%s", git_replace_ref_base, oid_to_hex(object));
+	if (check_refname_format(ref->buf, 0))
+		die("'%s' is not a valid ref name.", ref->buf);
+
+	if (read_ref(ref->buf, prev->hash))
 		oidclr(prev);
 	else if (!force)
-		die("replace ref '%s' already exists", ref);
+		die("replace ref '%s' already exists", ref->buf);
 }
 
 static int replace_object_oid(const char *object_ref,
@@ -154,7 +156,7 @@ static int replace_object_oid(const char *object_ref,
 {
 	struct object_id prev;
 	enum object_type obj_type, repl_type;
-	char ref[PATH_MAX];
+	struct strbuf ref = STRBUF_INIT;
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
@@ -167,16 +169,17 @@ static int replace_object_oid(const char *object_ref,
 		    object_ref, typename(obj_type),
 		    replace_ref, typename(repl_type));
 
-	check_ref_valid(object, &prev, ref, sizeof(ref), force);
+	check_ref_valid(object, &prev, &ref, force);
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref, repl->hash, prev.hash,
+	    ref_transaction_update(transaction, ref.buf, repl->hash, prev.hash,
 				   0, NULL, &err) ||
 	    ref_transaction_commit(transaction, &err))
 		die("%s", err.buf);
 
 	ref_transaction_free(transaction);
+	strbuf_release(&ref);
 	return 0;
 }
 
@@ -280,7 +283,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	char *tmpfile = git_pathdup("REPLACE_EDITOBJ");
 	enum object_type type;
 	struct object_id old, new, prev;
-	char ref[PATH_MAX];
+	struct strbuf ref = STRBUF_INIT;
 
 	if (get_oid(object_ref, &old) < 0)
 		die("Not a valid object name: '%s'", object_ref);
@@ -289,7 +292,8 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	if (type < 0)
 		die("unable to get object type for %s", oid_to_hex(&old));
 
-	check_ref_valid(&old, &prev, ref, sizeof(ref), force);
+	check_ref_valid(&old, &prev, &ref, force);
+	strbuf_release(&ref);
 
 	export_object(&old, type, raw, tmpfile);
 	if (launch_editor(tmpfile, NULL, NULL) < 0)
diff --git a/builtin/tag.c b/builtin/tag.c
index 045e7ad23..0eb4e25c6 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -72,25 +72,22 @@ static int for_each_tag_name(const char **argv, each_tag_name_fn fn,
 			     const void *cb_data)
 {
 	const char **p;
-	char ref[PATH_MAX];
+	struct strbuf ref = STRBUF_INIT;
 	int had_error = 0;
 	unsigned char sha1[20];
 
 	for (p = argv; *p; p++) {
-		if (snprintf(ref, sizeof(ref), "refs/tags/%s", *p)
-					>= sizeof(ref)) {
-			error(_("tag name too long: %.*s..."), 50, *p);
-			had_error = 1;
-			continue;
-		}
-		if (read_ref(ref, sha1)) {
+		strbuf_reset(&ref);
+		strbuf_addf(&ref, "refs/tags/%s", *p);
+		if (read_ref(ref.buf, sha1)) {
 			error(_("tag '%s' not found."), *p);
 			had_error = 1;
 			continue;
 		}
-		if (fn(*p, ref, sha1, cb_data))
+		if (fn(*p, ref.buf, sha1, cb_data))
 			had_error = 1;
 	}
+	strbuf_release(&ref);
 	return had_error;
 }
 
-- 
2.12.2.845.g55fcf8b10

