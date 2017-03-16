Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D5920323
	for <e@80x24.org>; Thu, 16 Mar 2017 14:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752282AbdCPO1Q (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 10:27:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:45114 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752131AbdCPO1Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 10:27:16 -0400
Received: (qmail 4645 invoked by uid 109); 16 Mar 2017 14:27:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 14:27:15 +0000
Received: (qmail 16229 invoked by uid 111); 16 Mar 2017 14:27:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 10:27:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 10:27:12 -0400
Date:   Thu, 16 Mar 2017 10:27:12 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/5] odb_pack_keep(): stop generating keepfile name
Message-ID: <20170316142712.rg66wvz2fltazz44@sigill.intra.peff.net>
References: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
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
Generating the name isn't hard, and a future patch will
switch callers over to odb_pack_name() anyway.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 6 +++---
 cache.h              | 8 ++++----
 environment.c        | 6 ++----
 fast-import.c        | 4 +++-
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f4b87c6c9..a58bc6bee 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1402,10 +1402,10 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		int keep_fd, keep_msg_len = strlen(keep_msg);
 
 		if (!keep_name)
-			keep_fd = odb_pack_keep(name, sizeof(name), sha1);
-		else
-			keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
+			snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
+				 get_object_directory(), sha1_to_hex(sha1));
 
+		keep_fd = odb_pack_keep(keep_name ? keep_name : name);
 		if (keep_fd < 0) {
 			if (errno != EEXIST)
 				die_errno(_("cannot write keep file '%s'"),
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
index 6c13472c4..dad697653 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -944,7 +944,9 @@ static char *keep_pack(const char *curr_index_name)
 	static const char *keep_msg = "fast-import";
 	int keep_fd;
 
-	keep_fd = odb_pack_keep(name, sizeof(name), pack_data->sha1);
+	snprintf(name, sizeof(name), "%s/pack/pack-%s.keep",
+		 get_object_directory(), sha1_to_hex(pack_data->sha1));
+	keep_fd = odb_pack_keep(name);
 	if (keep_fd < 0)
 		die_errno("cannot create keep file");
 	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
-- 
2.12.0.623.g86ec6c963

