Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 507642036D
	for <e@80x24.org>; Tue, 21 Nov 2017 21:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdKUVHy (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 16:07:54 -0500
Received: from siwi.pair.com ([209.68.5.199]:44440 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751351AbdKUVHd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 16:07:33 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id E94D48450B;
        Tue, 21 Nov 2017 16:07:32 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8A3FB844F0;
        Tue, 21 Nov 2017 16:07:32 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com
Subject: [PATCH v5 06/10] index-pack: refactor writing of .keep files
Date:   Tue, 21 Nov 2017 21:07:16 +0000
Message-Id: <20171121210720.21376-7-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171121210720.21376-1-git@jeffhostetler.com>
References: <20171121210720.21376-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

In a subsequent commit, index-pack will be taught to write ".promisor"
files which are similar to the ".keep" files it knows how to write.
Refactor the writing of ".keep" files, so that the implementation of
writing ".promisor" files becomes easier.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 99 ++++++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 46 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 8ec459f..4f305a7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1389,15 +1389,58 @@ static void fix_unresolved_deltas(struct sha1file *f)
 	free(sorted_by_pos);
 }
 
+static const char *derive_filename(const char *pack_name, const char *suffix,
+				   struct strbuf *buf)
+{
+	size_t len;
+	if (!strip_suffix(pack_name, ".pack", &len))
+		die(_("packfile name '%s' does not end with '.pack'"),
+		    pack_name);
+	strbuf_add(buf, pack_name, len);
+	strbuf_addch(buf, '.');
+	strbuf_addstr(buf, suffix);
+	return buf->buf;
+}
+
+static void write_special_file(const char *suffix, const char *msg,
+			       const char *pack_name, const unsigned char *sha1,
+			       const char **report)
+{
+	struct strbuf name_buf = STRBUF_INIT;
+	const char *filename;
+	int fd;
+	int msg_len = strlen(msg);
+
+	if (pack_name)
+		filename = derive_filename(pack_name, suffix, &name_buf);
+	else
+		filename = odb_pack_name(&name_buf, sha1, suffix);
+
+	fd = odb_pack_keep(filename);
+	if (fd < 0) {
+		if (errno != EEXIST)
+			die_errno(_("cannot write %s file '%s'"),
+				  suffix, filename);
+	} else {
+		if (msg_len > 0) {
+			write_or_die(fd, msg, msg_len);
+			write_or_die(fd, "\n", 1);
+		}
+		if (close(fd) != 0)
+			die_errno(_("cannot close written %s file '%s'"),
+				  suffix, filename);
+		*report = suffix;
+	}
+	strbuf_release(&name_buf);
+}
+
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
-		  const char *keep_name, const char *keep_msg,
-		  unsigned char *sha1)
+		  const char *keep_msg, unsigned char *sha1)
 {
 	const char *report = "pack";
 	struct strbuf pack_name = STRBUF_INIT;
 	struct strbuf index_name = STRBUF_INIT;
-	struct strbuf keep_name_buf = STRBUF_INIT;
 	int err;
 
 	if (!from_stdin) {
@@ -1409,28 +1452,9 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 			die_errno(_("error while closing pack file"));
 	}
 
-	if (keep_msg) {
-		int keep_fd, keep_msg_len = strlen(keep_msg);
-
-		if (!keep_name)
-			keep_name = odb_pack_name(&keep_name_buf, sha1, "keep");
-
-		keep_fd = odb_pack_keep(keep_name);
-		if (keep_fd < 0) {
-			if (errno != EEXIST)
-				die_errno(_("cannot write keep file '%s'"),
-					  keep_name);
-		} else {
-			if (keep_msg_len > 0) {
-				write_or_die(keep_fd, keep_msg, keep_msg_len);
-				write_or_die(keep_fd, "\n", 1);
-			}
-			if (close(keep_fd) != 0)
-				die_errno(_("cannot close written keep file '%s'"),
-					  keep_name);
-			report = "keep";
-		}
-	}
+	if (keep_msg)
+		write_special_file("keep", keep_msg, final_pack_name, sha1,
+				   &report);
 
 	if (final_pack_name != curr_pack_name) {
 		if (!final_pack_name)
@@ -1472,7 +1496,6 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 	strbuf_release(&index_name);
 	strbuf_release(&pack_name);
-	strbuf_release(&keep_name_buf);
 }
 
 static int git_index_pack_config(const char *k, const char *v, void *cb)
@@ -1615,26 +1638,13 @@ static void show_pack_info(int stat_only)
 	}
 }
 
-static const char *derive_filename(const char *pack_name, const char *suffix,
-				   struct strbuf *buf)
-{
-	size_t len;
-	if (!strip_suffix(pack_name, ".pack", &len))
-		die(_("packfile name '%s' does not end with '.pack'"),
-		    pack_name);
-	strbuf_add(buf, pack_name, len);
-	strbuf_addstr(buf, suffix);
-	return buf->buf;
-}
-
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0;
 	const char *curr_index;
 	const char *index_name = NULL, *pack_name = NULL;
-	const char *keep_name = NULL, *keep_msg = NULL;
-	struct strbuf index_name_buf = STRBUF_INIT,
-		      keep_name_buf = STRBUF_INIT;
+	const char *keep_msg = NULL;
+	struct strbuf index_name_buf = STRBUF_INIT;
 	struct pack_idx_entry **idx_objects;
 	struct pack_idx_option opts;
 	unsigned char pack_sha1[20];
@@ -1745,9 +1755,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (from_stdin && !startup_info->have_repository)
 		die(_("--stdin requires a git repository"));
 	if (!index_name && pack_name)
-		index_name = derive_filename(pack_name, ".idx", &index_name_buf);
-	if (keep_msg && !keep_name && pack_name)
-		keep_name = derive_filename(pack_name, ".keep", &keep_name_buf);
+		index_name = derive_filename(pack_name, "idx", &index_name_buf);
 
 	if (verify) {
 		if (!index_name)
@@ -1795,13 +1803,12 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	if (!verify)
 		final(pack_name, curr_pack,
 		      index_name, curr_index,
-		      keep_name, keep_msg,
+		      keep_msg,
 		      pack_sha1);
 	else
 		close(input_fd);
 	free(objects);
 	strbuf_release(&index_name_buf);
-	strbuf_release(&keep_name_buf);
 	if (pack_name == NULL)
 		free((void *) curr_pack);
 	if (index_name == NULL)
-- 
2.9.3

