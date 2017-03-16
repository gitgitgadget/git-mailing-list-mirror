Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A425820323
	for <e@80x24.org>; Thu, 16 Mar 2017 14:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752311AbdCPO1U (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 10:27:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:45118 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752284AbdCPO1T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 10:27:19 -0400
Received: (qmail 4656 invoked by uid 109); 16 Mar 2017 14:27:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 14:27:18 +0000
Received: (qmail 16343 invoked by uid 111); 16 Mar 2017 14:27:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 10:27:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 10:27:15 -0400
Date:   Thu, 16 Mar 2017 10:27:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/5] replace snprintf with odb_pack_name()
Message-ID: <20170316142715.zdoikgyy3difeafk@sigill.intra.peff.net>
References: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In several places we write the name of the pack filename
into a fixed-size buffer using snprintf(), but do not check
the return value.  As a result, a very long object directory
could cause us to quietly truncate the pack filename
(potentially leading to a corrupted repository, as a newly
written packfile could be missing its .pack extension).

We can use odb_pack_name() to do this with a strbuf (and
shorten the code, as well).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 27 +++++++++++----------------
 fast-import.c        | 28 +++++++++++++---------------
 2 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index a58bc6bee..dcb346ab7 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1386,7 +1386,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		  unsigned char *sha1)
 {
 	const char *report = "pack";
-	char name[PATH_MAX];
+	struct strbuf name = STRBUF_INIT;
 	int err;
 
 	if (!from_stdin) {
@@ -1402,14 +1402,13 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		int keep_fd, keep_msg_len = strlen(keep_msg);
 
 		if (!keep_name)
-			snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
-				 get_object_directory(), sha1_to_hex(sha1));
+			odb_pack_name(&name, sha1, "keep");
 
-		keep_fd = odb_pack_keep(keep_name ? keep_name : name);
+		keep_fd = odb_pack_keep(keep_name ? keep_name : name.buf);
 		if (keep_fd < 0) {
 			if (errno != EEXIST)
 				die_errno(_("cannot write keep file '%s'"),
-					  keep_name ? keep_name : name);
+					  keep_name ? keep_name : name.buf);
 		} else {
 			if (keep_msg_len > 0) {
 				write_or_die(keep_fd, keep_msg, keep_msg_len);
@@ -1417,28 +1416,22 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 			}
 			if (close(keep_fd) != 0)
 				die_errno(_("cannot close written keep file '%s'"),
-					  keep_name ? keep_name : name);
+					  keep_name ? keep_name : name.buf);
 			report = "keep";
 		}
 	}
 
 	if (final_pack_name != curr_pack_name) {
-		if (!final_pack_name) {
-			snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
-				 get_object_directory(), sha1_to_hex(sha1));
-			final_pack_name = name;
-		}
+		if (!final_pack_name)
+			final_pack_name = odb_pack_name(&name, sha1, "pack");
 		if (finalize_object_file(curr_pack_name, final_pack_name))
 			die(_("cannot store pack file"));
 	} else if (from_stdin)
 		chmod(final_pack_name, 0444);
 
 	if (final_index_name != curr_index_name) {
-		if (!final_index_name) {
-			snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
-				 get_object_directory(), sha1_to_hex(sha1));
-			final_index_name = name;
-		}
+		if (!final_index_name)
+			final_index_name = odb_pack_name(&name, sha1, "idx");
 		if (finalize_object_file(curr_index_name, final_index_name))
 			die(_("cannot store index file"));
 	} else
@@ -1464,6 +1457,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 			input_offset += err;
 		}
 	}
+
+	strbuf_release(&name);
 }
 
 static int git_index_pack_config(const char *k, const char *v, void *cb)
diff --git a/fast-import.c b/fast-import.c
index dad697653..41a539f97 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -940,43 +940,40 @@ static const char *create_index(void)
 
 static char *keep_pack(const char *curr_index_name)
 {
-	static char name[PATH_MAX];
 	static const char *keep_msg = "fast-import";
+	struct strbuf name = STRBUF_INIT;
 	int keep_fd;
 
-	snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
-		 get_object_directory(), sha1_to_hex(pack_data->sha1));
-	keep_fd = odb_pack_keep(name);
+	odb_pack_name(&name, pack_data->sha1, "keep");
+	keep_fd = odb_pack_keep(name.buf);
 	if (keep_fd < 0)
 		die_errno("cannot create keep file");
 	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
 	if (close(keep_fd))
 		die_errno("failed to write keep file");
 
-	snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
-		 get_object_directory(), sha1_to_hex(pack_data->sha1));
-	if (finalize_object_file(pack_data->pack_name, name))
+	odb_pack_name(&name, pack_data->sha1, "pack");
+	if (finalize_object_file(pack_data->pack_name, name.buf))
 		die("cannot store pack file");
 
-	snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
-		 get_object_directory(), sha1_to_hex(pack_data->sha1));
-	if (finalize_object_file(curr_index_name, name))
+	odb_pack_name(&name, pack_data->sha1, "idx");
+	if (finalize_object_file(curr_index_name, name.buf))
 		die("cannot store index file");
 	free((void *)curr_index_name);
-	return name;
+	return strbuf_detach(&name, NULL);
 }
 
 static void unkeep_all_packs(void)
 {
-	static char name[PATH_MAX];
+	struct strbuf name = STRBUF_INIT;
 	int k;
 
 	for (k = 0; k < pack_id; k++) {
 		struct packed_git *p = all_packs[k];
-		snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
-			 get_object_directory(), sha1_to_hex(p->sha1));
-		unlink_or_warn(name);
+		odb_pack_name(&name, p->sha1, "keep");
+		unlink_or_warn(name.buf);
 	}
+	strbuf_release(&name);
 }
 
 static int loosen_small_pack(const struct packed_git *p)
@@ -1035,6 +1032,7 @@ static void end_packfile(void)
 			die("core git rejected index %s", idx_name);
 		all_packs[pack_id] = new_p;
 		install_packed_git(new_p);
+		free(idx_name);
 
 		/* Print the boundary */
 		if (pack_edges) {
-- 
2.12.0.623.g86ec6c963

