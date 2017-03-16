Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B87B520323
	for <e@80x24.org>; Thu, 16 Mar 2017 14:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbdCPO1L (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 10:27:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:45112 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752131AbdCPO1K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 10:27:10 -0400
Received: (qmail 4637 invoked by uid 109); 16 Mar 2017 14:27:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 14:27:09 +0000
Received: (qmail 16046 invoked by uid 111); 16 Mar 2017 14:27:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 10:27:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 10:27:06 -0400
Date:   Thu, 16 Mar 2017 10:27:06 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/5] sha1_file.c: make pack-name helper globally accessible
Message-ID: <20170316142706.kt56a43phiuhhra7@sigill.intra.peff.net>
References: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We provide sha1_pack_name() and sha1_pack_index_name(), but
the more generic form (which takes its own strbuf and an
arbitrary extension) is only used to implement the other
two.  Let's make it available, but clean up a few things:

  1. Name it odb_pack_name(), as the original
     sha1_get_pack_name() is long but not all that
     descriptive.

  2. Switch the strbuf argument to the beginning, so that it
     matches similar path-building functions like
     git_path_buf().

  3. Clean up the out-dated docstring and move it to the
     public declaration.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h     |  9 +++++++++
 sha1_file.c | 17 ++++++-----------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 68ad06e15..97896e2e5 100644
--- a/cache.h
+++ b/cache.h
@@ -1639,6 +1639,15 @@ extern void pack_report(void);
  */
 extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
 
+/*
+ * Generate the filename to be used for a pack file with checksum "sha1" and
+ * extension "ext". The result is written into the strbuf "buf", overwriting
+ * any existing contents. A pointer to buf->buf is returned as a convenience.
+ *
+ * Example: odb_pack_name(out, sha1, "idx") => ".git/objects/pack/pack-1234..idx"
+ */
+extern char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
+
 /*
  * Create a pack .keep file in the object database's pack directory, for
  * a pack with checksum "sha1". The return value is a file descriptor opened
diff --git a/sha1_file.c b/sha1_file.c
index 2ee3c617a..56ef09cd3 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -277,31 +277,26 @@ static const char *alt_sha1_path(struct alternate_object_database *alt,
 	return buf->buf;
 }
 
-/*
- * Return the name of the pack or index file with the specified sha1
- * in its filename.  *base and *name are scratch space that must be
- * provided by the caller.  which should be "pack" or "idx".
- */
-static char *sha1_get_pack_name(const unsigned char *sha1,
-				struct strbuf *buf,
-				const char *which)
+ char *odb_pack_name(struct strbuf *buf,
+		     const unsigned char *sha1,
+		     const char *ext)
 {
 	strbuf_reset(buf);
 	strbuf_addf(buf, "%s/pack/pack-%s.%s", get_object_directory(),
-		    sha1_to_hex(sha1), which);
+		    sha1_to_hex(sha1), ext);
 	return buf->buf;
 }
 
 char *sha1_pack_name(const unsigned char *sha1)
 {
 	static struct strbuf buf = STRBUF_INIT;
-	return sha1_get_pack_name(sha1, &buf, "pack");
+	return odb_pack_name(&buf, sha1, "pack");
 }
 
 char *sha1_pack_index_name(const unsigned char *sha1)
 {
 	static struct strbuf buf = STRBUF_INIT;
-	return sha1_get_pack_name(sha1, &buf, "idx");
+	return odb_pack_name(&buf, sha1, "idx");
 }
 
 struct alternate_object_database *alt_odb_list;
-- 
2.12.0.623.g86ec6c963

