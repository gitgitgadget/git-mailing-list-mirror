Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70B5220323
	for <e@80x24.org>; Thu, 16 Mar 2017 14:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbdCPO1Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 10:27:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:45119 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752314AbdCPO1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 10:27:24 -0400
Received: (qmail 4661 invoked by uid 109); 16 Mar 2017 14:27:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 14:27:23 +0000
Received: (qmail 16496 invoked by uid 111); 16 Mar 2017 14:27:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Mar 2017 10:27:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Mar 2017 10:27:20 -0400
Date:   Thu, 16 Mar 2017 10:27:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 5/5] index-pack: make pointer-alias fallbacks safer
Message-ID: <20170316142720.377auysntqu7ozdz@sigill.intra.peff.net>
References: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170316142647.t6tthkcgon3rpg4m@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The final() function accepts a NULL value for certain
parameters, and falls back to writing into a reusable "name"
buffer, and then either:

  1. For "keep_name", requiring all uses to do "keep_name ?
     keep_name : name.buf". This is awkward, and it's easy
     to accidentally look at the maybe-NULL keep_name.

  2. For "final_index_name" and "final_pack_name", aliasing
     those pointers to the "name" buffer. This is easier to
     use, but the aliased pointers become invalid after the
     buffer is reused (this isn't a bug now, but it's a
     potential pitfall).

One way to make this safer would be to introduce an extra
pointer to do the aliasing, and have its lifetime match the
validity of the "name" buffer. But it's still easy to
accidentally use the wrong name (i.e., to use
"final_pack_name" instead of the aliased pointer).

Instead, let's use three separate buffers that will remain
valid through the function. That makes it safe to alias the
pointers and use them consistently. The extra allocations
shouldn't matter, as this function is not performance
sensitive.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index dcb346ab7..88d205f85 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1386,7 +1386,9 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		  unsigned char *sha1)
 {
 	const char *report = "pack";
-	struct strbuf name = STRBUF_INIT;
+	struct strbuf pack_name = STRBUF_INIT;
+	struct strbuf index_name = STRBUF_INIT;
+	struct strbuf keep_name_buf = STRBUF_INIT;
 	int err;
 
 	if (!from_stdin) {
@@ -1402,13 +1404,13 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		int keep_fd, keep_msg_len = strlen(keep_msg);
 
 		if (!keep_name)
-			odb_pack_name(&name, sha1, "keep");
+			keep_name = odb_pack_name(&keep_name_buf, sha1, "keep");
 
-		keep_fd = odb_pack_keep(keep_name ? keep_name : name.buf);
+		keep_fd = odb_pack_keep(keep_name);
 		if (keep_fd < 0) {
 			if (errno != EEXIST)
 				die_errno(_("cannot write keep file '%s'"),
-					  keep_name ? keep_name : name.buf);
+					  keep_name);
 		} else {
 			if (keep_msg_len > 0) {
 				write_or_die(keep_fd, keep_msg, keep_msg_len);
@@ -1416,14 +1418,14 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 			}
 			if (close(keep_fd) != 0)
 				die_errno(_("cannot close written keep file '%s'"),
-					  keep_name ? keep_name : name.buf);
+					  keep_name);
 			report = "keep";
 		}
 	}
 
 	if (final_pack_name != curr_pack_name) {
 		if (!final_pack_name)
-			final_pack_name = odb_pack_name(&name, sha1, "pack");
+			final_pack_name = odb_pack_name(&pack_name, sha1, "pack");
 		if (finalize_object_file(curr_pack_name, final_pack_name))
 			die(_("cannot store pack file"));
 	} else if (from_stdin)
@@ -1431,7 +1433,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 
 	if (final_index_name != curr_index_name) {
 		if (!final_index_name)
-			final_index_name = odb_pack_name(&name, sha1, "idx");
+			final_index_name = odb_pack_name(&index_name, sha1, "idx");
 		if (finalize_object_file(curr_index_name, final_index_name))
 			die(_("cannot store index file"));
 	} else
@@ -1458,7 +1460,9 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		}
 	}
 
-	strbuf_release(&name);
+	strbuf_release(&index_name);
+	strbuf_release(&pack_name);
+	strbuf_release(&keep_name_buf);
 }
 
 static int git_index_pack_config(const char *k, const char *v, void *cb)
-- 
2.12.0.623.g86ec6c963
