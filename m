Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C678F202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752358AbdCOV1i (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:27:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:44819 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752119AbdCOV1h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:27:37 -0400
Received: (qmail 3961 invoked by uid 109); 15 Mar 2017 21:27:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 21:27:36 +0000
Received: (qmail 11318 invoked by uid 111); 15 Mar 2017 21:27:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 17:27:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 17:27:33 -0400
Date:   Wed, 15 Mar 2017 17:27:33 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/6] index-pack: factor out pack/idx finalization
Message-ID: <20170315212733.73cw22dm36oc5im4@sigill.intra.peff.net>
References: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The procedure for moving the ".pack" and the ".idx" files
into place is the same. Rather than repeat the code, let's
factor it into a helper function.

This has the added benefit of clarifying the lifetime of
"final_pack_name". In the original code it is sometimes
redirected to our reusable "name" buffer; after we reuse
that buffer, the contents are nonsense (but nobody looks at
it, so this is not a bug, just a maintenance issue). In the
new code, the pointer modification is contained in the
helper function.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f4b87c6c9..187c0550c 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1380,6 +1380,23 @@ static void fix_unresolved_deltas(struct sha1file *f)
 	free(sorted_by_pos);
 }
 
+static void finalize_file(const char *final_name, const char *curr_name,
+			  unsigned char *sha1, const char *ext)
+{
+	if (final_name != curr_name) {
+		char name[PATH_MAX];
+		if (!final_name) {
+			snprintf(name, sizeof(name), "%s/pack/pack-%s.%s",
+				 get_object_directory(), sha1_to_hex(sha1),
+				 ext);
+			final_name = name;
+		}
+		if (finalize_object_file(curr_name, final_name))
+			die(_("cannot store %s file"), ext);
+	} else if (from_stdin)
+		chmod(final_name, 0444);
+}
+
 static void final(const char *final_pack_name, const char *curr_pack_name,
 		  const char *final_index_name, const char *curr_index_name,
 		  const char *keep_name, const char *keep_msg,
@@ -1422,27 +1439,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		}
 	}
 
-	if (final_pack_name != curr_pack_name) {
-		if (!final_pack_name) {
-			snprintf(name, sizeof(name), "%s/pack/pack-%s.pack",
-				 get_object_directory(), sha1_to_hex(sha1));
-			final_pack_name = name;
-		}
-		if (finalize_object_file(curr_pack_name, final_pack_name))
-			die(_("cannot store pack file"));
-	} else if (from_stdin)
-		chmod(final_pack_name, 0444);
-
-	if (final_index_name != curr_index_name) {
-		if (!final_index_name) {
-			snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
-				 get_object_directory(), sha1_to_hex(sha1));
-			final_index_name = name;
-		}
-		if (finalize_object_file(curr_index_name, final_index_name))
-			die(_("cannot store index file"));
-	} else
-		chmod(final_index_name, 0444);
+	finalize_file(final_pack_name, curr_pack_name, sha1, "pack");
+	finalize_file(final_index_name, curr_index_name, sha1, "idx");
 
 	if (!from_stdin) {
 		printf("%s\n", sha1_to_hex(sha1));
-- 
2.12.0.613.g6e7c52a0d

