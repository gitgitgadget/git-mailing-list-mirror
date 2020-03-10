Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B193C18E7A
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1992020727
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="k7E6YsXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCJSWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:22:12 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:51050 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbgCJSWL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Mar 2020 14:22:11 -0400
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1303B6088E;
        Tue, 10 Mar 2020 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1583864530;
        bh=JVvrHeA3Q5iQVhKbYrQ9D+t5T7adk6S/9anpCVWkeh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=k7E6YsXCpn1XF5bsdD5/WEm3jkNiMolifTgI/BHzh8dLlSzNxHmRraaZt1/9B+Dps
         7JfpCU19NNWQ7CgJDuLjgU1cp93DQSB18g9Kg8qHLdWn5q9tsTgNmw/GqXlRYBWIAT
         Nh4Oh2d1XW0kAnjoOzwoohsyM1JaXmNfAHB0fWZOIc9DzjLXS4kulDSp4alMkgdxTX
         VxrXN8zspD+cOsYvY5LTX3WhJZspuJsyxGE3ja/UZReIFfh4S4t17r6UIlvzT8b18H
         py1EFJvy5Yt51A+ljSxGRmkszZdNZRetx6A4RwIGZ4bTh3KfAmXG2S3AZHtsfq3IuR
         4GPcpN49KpqtQjCaiDhnRUi1BYK6JQawayKB/z92MzFiwpsQ2Aet3f3np/y/eN5thh
         n2nt+yDHWeXQgSSswTFSh6QziP5Bbrw/BuMkEq0fqqWW5wNqcTXyyoDXYM0wKodOZ6
         vXfs2amep4/mB3rQicWn+Adgxd6MgWugfUNvHFKeQvUKRSdHExS
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 2/8] convert: permit passing additional metadata to filter processes
Date:   Tue, 10 Mar 2020 18:20:40 +0000
Message-Id: <20200310182046.748959-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801
In-Reply-To: <20200310182046.748959-1-sandals@crustytoothpaste.net>
References: <20200310182046.748959-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "brian m. carlson" <bk2204@github.com>

There are a variety of situations where a filter process can make use of
some additional metadata.  For example, some people find the ident
filter too limiting and would like to include the commit or the branch
in their smudged files.  This information isn't available during
checkout as HEAD hasn't been updated at that point, and it wouldn't be
available in archives either.

Let's add a way to pass this metadata down to the filter.  We pass the
blob we're operating on, the treeish (preferring the commit over the
tree if one exists), and the ref we're operating on.  Note that we won't
pass this information in all cases, such as when renormalizing or when
we're performing diffs, since it doesn't make sense in those cases.

This series wires up the code to print this information, but doesn't
pass any of it at this point.  In a future commit, we'll have various
code paths pass the actual useful data down.

Signed-off-by: brian m. carlson <bk2204@github.com>
---
 apply.c            |  2 +-
 archive.c          |  2 +-
 builtin/cat-file.c |  2 +-
 convert.c          | 44 ++++++++++++++++++++++++++++++++++----------
 convert.h          | 12 ++++++++++--
 diff.c             |  2 +-
 entry.c            |  4 ++--
 merge-recursive.c  |  2 +-
 8 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/apply.c b/apply.c
index bdc008fae2..144c19aaca 100644
--- a/apply.c
+++ b/apply.c
@@ -4349,7 +4349,7 @@ static int try_create_file(struct apply_state *state, const char *path,
 	if (fd < 0)
 		return 1;
 
-	if (convert_to_working_tree(state->repo->index, path, buf, size, &nbuf)) {
+	if (convert_to_working_tree(state->repo->index, path, buf, size, &nbuf, NULL)) {
 		size = nbuf.len;
 		buf  = nbuf.buf;
 	}
diff --git a/archive.c b/archive.c
index a8da0fcc4f..d9e92cce58 100644
--- a/archive.c
+++ b/archive.c
@@ -85,7 +85,7 @@ void *object_file_to_archive(const struct archiver_args *args,
 		size_t size = 0;
 
 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
-		convert_to_working_tree(args->repo->index, path, buf.buf, buf.len, &buf);
+		convert_to_working_tree(args->repo->index, path, buf.buf, buf.len, &buf, NULL);
 		if (commit)
 			format_subst(commit, buf.buf, buf.len, &buf);
 		buffer = strbuf_detach(&buf, &size);
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 272f9fc6d7..545fed4924 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -42,7 +42,7 @@ static int filter_object(const char *path, unsigned mode,
 			     oid_to_hex(oid), path);
 	if ((type == OBJ_BLOB) && S_ISREG(mode)) {
 		struct strbuf strbuf = STRBUF_INIT;
-		if (convert_to_working_tree(&the_index, path, *buf, *size, &strbuf)) {
+		if (convert_to_working_tree(&the_index, path, *buf, *size, &strbuf, NULL)) {
 			free(*buf);
 			*size = strbuf.len;
 			*buf = strbuf_detach(&strbuf, NULL);
diff --git a/convert.c b/convert.c
index 5ead3ce678..6261921cfb 100644
--- a/convert.c
+++ b/convert.c
@@ -797,6 +797,7 @@ static void handle_filter_error(const struct strbuf *filter_status,
 static int apply_multi_file_filter(const char *path, const char *src, size_t len,
 				   int fd, struct strbuf *dst, const char *cmd,
 				   const unsigned int wanted_capability,
+				   const struct checkout_metadata *meta,
 				   struct delayed_checkout *dco)
 {
 	int err;
@@ -855,6 +856,24 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
 	if (err)
 		goto done;
 
+	if (meta && meta->refname) {
+		err = packet_write_fmt_gently(process->in, "ref=%s\n", meta->refname);
+		if (err)
+			goto done;
+	}
+
+	if (meta && !is_null_oid(&meta->treeish)) {
+		err = packet_write_fmt_gently(process->in, "treeish=%s\n", oid_to_hex(&meta->treeish));
+		if (err)
+			goto done;
+	}
+
+	if (meta && !is_null_oid(&meta->blob)) {
+		err = packet_write_fmt_gently(process->in, "blob=%s\n", oid_to_hex(&meta->blob));
+		if (err)
+			goto done;
+	}
+
 	if ((entry->supported_capabilities & CAP_DELAY) &&
 	    dco && dco->state == CE_CAN_DELAY) {
 		can_delay = 1;
@@ -971,6 +990,7 @@ static struct convert_driver {
 static int apply_filter(const char *path, const char *src, size_t len,
 			int fd, struct strbuf *dst, struct convert_driver *drv,
 			const unsigned int wanted_capability,
+			const struct checkout_metadata *meta,
 			struct delayed_checkout *dco)
 {
 	const char *cmd = NULL;
@@ -990,7 +1010,7 @@ static int apply_filter(const char *path, const char *src, size_t len,
 		return apply_single_file_filter(path, src, len, fd, dst, cmd);
 	else if (drv->process && *drv->process)
 		return apply_multi_file_filter(path, src, len, fd, dst,
-			drv->process, wanted_capability, dco);
+			drv->process, wanted_capability, meta, dco);
 
 	return 0;
 }
@@ -1368,7 +1388,7 @@ int would_convert_to_git_filter_fd(const struct index_state *istate, const char
 	if (!ca.drv->required)
 		return 0;
 
-	return apply_filter(path, NULL, 0, -1, NULL, ca.drv, CAP_CLEAN, NULL);
+	return apply_filter(path, NULL, 0, -1, NULL, ca.drv, CAP_CLEAN, NULL, NULL);
 }
 
 const char *get_convert_attr_ascii(const struct index_state *istate, const char *path)
@@ -1406,7 +1426,7 @@ int convert_to_git(const struct index_state *istate,
 
 	convert_attrs(istate, &ca, path);
 
-	ret |= apply_filter(path, src, len, -1, dst, ca.drv, CAP_CLEAN, NULL);
+	ret |= apply_filter(path, src, len, -1, dst, ca.drv, CAP_CLEAN, NULL, NULL);
 	if (!ret && ca.drv && ca.drv->required)
 		die(_("%s: clean filter '%s' failed"), path, ca.drv->name);
 
@@ -1441,7 +1461,7 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 	assert(ca.drv);
 	assert(ca.drv->clean || ca.drv->process);
 
-	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL))
+	if (!apply_filter(path, NULL, 0, fd, dst, ca.drv, CAP_CLEAN, NULL, NULL))
 		die(_("%s: clean filter '%s' failed"), path, ca.drv->name);
 
 	encode_to_git(path, dst->buf, dst->len, dst, ca.working_tree_encoding, conv_flags);
@@ -1452,7 +1472,9 @@ void convert_to_git_filter_fd(const struct index_state *istate,
 static int convert_to_working_tree_internal(const struct index_state *istate,
 					    const char *path, const char *src,
 					    size_t len, struct strbuf *dst,
-					    int normalizing, struct delayed_checkout *dco)
+					    int normalizing,
+					    const struct checkout_metadata *meta,
+					    struct delayed_checkout *dco)
 {
 	int ret = 0, ret_filter = 0;
 	struct conv_attrs ca;
@@ -1484,7 +1506,7 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
 	}
 
 	ret_filter = apply_filter(
-		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, dco);
+		path, src, len, -1, dst, ca.drv, CAP_SMUDGE, meta, dco);
 	if (!ret_filter && ca.drv && ca.drv->required)
 		die(_("%s: smudge filter %s failed"), path, ca.drv->name);
 
@@ -1494,22 +1516,24 @@ static int convert_to_working_tree_internal(const struct index_state *istate,
 int async_convert_to_working_tree(const struct index_state *istate,
 				  const char *path, const char *src,
 				  size_t len, struct strbuf *dst,
+				  const struct checkout_metadata *meta,
 				  void *dco)
 {
-	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, dco);
+	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, dco);
 }
 
 int convert_to_working_tree(const struct index_state *istate,
 			    const char *path, const char *src,
-			    size_t len, struct strbuf *dst)
+			    size_t len, struct strbuf *dst,
+			    const struct checkout_metadata *meta)
 {
-	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, NULL);
+	return convert_to_working_tree_internal(istate, path, src, len, dst, 0, meta, NULL);
 }
 
 int renormalize_buffer(const struct index_state *istate, const char *path,
 		       const char *src, size_t len, struct strbuf *dst)
 {
-	int ret = convert_to_working_tree_internal(istate, path, src, len, dst, 1, NULL);
+	int ret = convert_to_working_tree_internal(istate, path, src, len, dst, 1, NULL, NULL);
 	if (ret) {
 		src = dst->buf;
 		len = dst->len;
diff --git a/convert.h b/convert.h
index 3710969d43..894e01c38b 100644
--- a/convert.h
+++ b/convert.h
@@ -4,10 +4,10 @@
 #ifndef CONVERT_H
 #define CONVERT_H
 
+#include "hash.h"
 #include "string-list.h"
 
 struct index_state;
-struct object_id;
 struct strbuf;
 
 #define CONV_EOL_RNDTRP_DIE   (1<<0) /* Die if CRLF to LF to CRLF is different */
@@ -57,6 +57,12 @@ struct delayed_checkout {
 	struct string_list paths;
 };
 
+struct checkout_metadata {
+	const char *refname;
+	struct object_id treeish;
+	struct object_id blob;
+};
+
 extern enum eol core_eol;
 extern char *check_roundtrip_encoding;
 const char *get_cached_convert_stats_ascii(const struct index_state *istate,
@@ -71,10 +77,12 @@ int convert_to_git(const struct index_state *istate,
 		   struct strbuf *dst, int conv_flags);
 int convert_to_working_tree(const struct index_state *istate,
 			    const char *path, const char *src,
-			    size_t len, struct strbuf *dst);
+			    size_t len, struct strbuf *dst,
+			    const struct checkout_metadata *meta);
 int async_convert_to_working_tree(const struct index_state *istate,
 				  const char *path, const char *src,
 				  size_t len, struct strbuf *dst,
+				  const struct checkout_metadata *meta,
 				  void *dco);
 int async_query_available_blobs(const char *cmd,
 				struct string_list *available_paths);
diff --git a/diff.c b/diff.c
index f2cfbf2214..12761c8017 100644
--- a/diff.c
+++ b/diff.c
@@ -4071,7 +4071,7 @@ static void prep_temp_blob(struct index_state *istate,
 	if (!temp->tempfile)
 		die_errno("unable to create temp-file");
 	if (convert_to_working_tree(istate, path,
-			(const char *)blob, (size_t)size, &buf)) {
+			(const char *)blob, (size_t)size, &buf, NULL)) {
 		blob = buf.buf;
 		size = buf.len;
 	}
diff --git a/entry.c b/entry.c
index 53380bb614..4b2d9b2dad 100644
--- a/entry.c
+++ b/entry.c
@@ -315,13 +315,13 @@ static int write_entry(struct cache_entry *ce,
 		 */
 		if (dco && dco->state != CE_NO_DELAY) {
 			ret = async_convert_to_working_tree(state->istate, ce->name, new_blob,
-							    size, &buf, dco);
+							    size, &buf, NULL, dco);
 			if (ret && string_list_has_string(&dco->paths, ce->name)) {
 				free(new_blob);
 				goto delayed;
 			}
 		} else
-			ret = convert_to_working_tree(state->istate, ce->name, new_blob, size, &buf);
+			ret = convert_to_working_tree(state->istate, ce->name, new_blob, size, &buf, NULL);
 
 		if (ret) {
 			free(new_blob);
diff --git a/merge-recursive.c b/merge-recursive.c
index 7a4e6f20fa..d92e2acf1e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -958,7 +958,7 @@ static int update_file_flags(struct merge_options *opt,
 		if (S_ISREG(contents->mode)) {
 			struct strbuf strbuf = STRBUF_INIT;
 			if (convert_to_working_tree(opt->repo->index,
-						    path, buf, size, &strbuf)) {
+						    path, buf, size, &strbuf, NULL)) {
 				free(buf);
 				size = strbuf.len;
 				buf = strbuf_detach(&strbuf, NULL);
