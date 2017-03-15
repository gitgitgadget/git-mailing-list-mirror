Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B62B202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754083AbdCOVfz (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:35:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:44844 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754076AbdCOVfy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:35:54 -0400
Received: (qmail 4137 invoked by uid 109); 15 Mar 2017 21:29:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 21:29:12 +0000
Received: (qmail 14340 invoked by uid 111); 15 Mar 2017 21:29:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 17:29:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 17:29:08 -0400
Date:   Wed, 15 Mar 2017 17:29:08 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] fast-import: replace fixed buffer with odb_pack_name
Message-ID: <20170315212908.tw2a7fqo3kgpa33w@sigill.intra.peff.net>
References: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This removes the possibility of truncating the filename
without realizing it.

Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 6c13472c4..61be8b76e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -966,15 +966,15 @@ static char *keep_pack(const char *curr_index_name)
 
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
-- 
2.12.0.613.g6e7c52a0d

