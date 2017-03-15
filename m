Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C87A202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbdCOVbh (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:31:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:44832 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751495AbdCOVbT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:31:19 -0400
Received: (qmail 4234 invoked by uid 109); 15 Mar 2017 21:30:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 21:30:27 +0000
Received: (qmail 16667 invoked by uid 111); 15 Mar 2017 21:30:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 17:30:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 17:30:24 -0400
Date:   Wed, 15 Mar 2017 17:30:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] odb_pack_keep(): stop generating keepfile name
Message-ID: <20170315213024.jjhikkgwuhev27ec@sigill.intra.peff.net>
References: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The odb_pack_keep() function generates the name of a .keep
file and opens it. This has two problems:

  1. It requires a fixed-size buffer to create the filename
     and doesn't notice when the result is truncated.

  2. Of the two callers, one sometimes wants to open a
     filename it already has, which makes things awkward (it
     has to do so manually, and skips the leading-directory
     creation).

Instead, let's have odb_pack_keep() just open the file.
Callers can use odb_pack_name() separately to generate the
name. This simplifies the callers, and lets us drop any
buffer-size limitations.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 12 ++++++------
 cache.h              |  8 ++++----
 environment.c        |  6 ++----
 fast-import.c        | 18 +++++++++---------
 4 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index b6e7ac331..e0f70836d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1399,7 +1399,6 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		  unsigned char *sha1)
 {
 	const char *report = "pack";
-	char name[PATH_MAX];
 	int err;
 
 	if (!from_stdin) {
@@ -1412,17 +1411,17 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	}
 
 	if (keep_msg) {
+		struct strbuf name = STRBUF_INIT;
 		int keep_fd, keep_msg_len = strlen(keep_msg);
 
 		if (!keep_name)
-			keep_fd = odb_pack_keep(name, sizeof(name), sha1);
-		else
-			keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
+			keep_name = odb_pack_name(&name, sha1, "keep");
 
+		keep_fd = odb_pack_keep(keep_name);
 		if (keep_fd < 0) {
 			if (errno != EEXIST)
 				die_errno(_("cannot write keep file '%s'"),
-					  keep_name ? keep_name : name);
+					  keep_name);
 		} else {
 			if (keep_msg_len > 0) {
 				write_or_die(keep_fd, keep_msg, keep_msg_len);
@@ -1430,9 +1429,10 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 			}
 			if (close(keep_fd) != 0)
 				die_errno(_("cannot close written keep file '%s'"),
-					  keep_name ? keep_name : name);
+					  keep_name);
 			report = "keep";
 		}
+		strbuf_release(&name);
 	}
 
 	finalize_file(final_pack_name, curr_pack_name, sha1, "pack");
diff --git a/cache.h b/cache.h
index 97896e2e5..cb8f48f6f 100644
--- a/cache.h
+++ b/cache.h
@@ -1649,11 +1649,11 @@ extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
 extern char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
 
 /*
- * Create a pack .keep file in the object database's pack directory, for
- * a pack with checksum "sha1". The return value is a file descriptor opened
- * for writing, or -1 on error. The name of the keep file is written to "name".
+ * Create a pack .keep file named "name" (which should generally be the output
+ * of odb_pack_name). Returns a file descriptor opened for writing, or -1 on
+ * error.
  */
-extern int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1);
+extern int odb_pack_keep(const char *name);
 
 /*
  * mmap the index file for the specified packfile (if it is not
diff --git a/environment.c b/environment.c
index 42dc3106d..2fdba7622 100644
--- a/environment.c
+++ b/environment.c
@@ -296,18 +296,16 @@ int odb_mkstemp(char *template, size_t limit, const char *pattern)
 	return xmkstemp_mode(template, mode);
 }
 
-int odb_pack_keep(char *name, size_t namesz, const unsigned char *sha1)
+int odb_pack_keep(const char *name)
 {
 	int fd;
 
-	snprintf(name, namesz, "%s/pack/pack-%s.keep",
-		 get_object_directory(), sha1_to_hex(sha1));
 	fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 	if (0 <= fd)
 		return fd;
 
 	/* slow path */
-	safe_create_leading_directories(name);
+	safe_create_leading_directories_const(name);
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
diff --git a/fast-import.c b/fast-import.c
index 61be8b76e..41a539f97 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -940,28 +940,27 @@ static const char *create_index(void)
 
 static char *keep_pack(const char *curr_index_name)
 {
-	static char name[PATH_MAX];
 	static const char *keep_msg = "fast-import";
+	struct strbuf name = STRBUF_INIT;
 	int keep_fd;
 
-	keep_fd = odb_pack_keep(name, sizeof(name), pack_data->sha1);
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
@@ -1033,6 +1032,7 @@ static void end_packfile(void)
 			die("core git rejected index %s", idx_name);
 		all_packs[pack_id] = new_p;
 		install_packed_git(new_p);
+		free(idx_name);
 
 		/* Print the boundary */
 		if (pack_edges) {
-- 
2.12.0.613.g6e7c52a0d
