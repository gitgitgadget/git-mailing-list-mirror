Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6699D202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 21:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754074AbdCOVfr (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 17:35:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:44843 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754065AbdCOVfq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 17:35:46 -0400
Received: (qmail 4060 invoked by uid 109); 15 Mar 2017 21:28:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 21:28:59 +0000
Received: (qmail 13904 invoked by uid 111); 15 Mar 2017 21:29:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Mar 2017 17:29:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Mar 2017 17:28:56 -0400
Date:   Wed, 15 Mar 2017 17:28:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/6] index-pack: drop fixed-size buffer for pack filenames
Message-ID: <20170315212856.fetjp5cyu4l6juc7@sigill.intra.peff.net>
References: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315212617.6x57bvltinuozv4q@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We write the name of the pack filename into a fixed-size
buffer using snprintf(), but do not check the return value.
As a result, a very long object directory could cause us to
quietly truncate the pack filename (leading to a corrupted
repository, as the packfile would be missing its .pack
extension).

We can use odb_pack_name() to fix this (and make the code
simpler, too).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 187c0550c..b6e7ac331 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1384,13 +1384,9 @@ static void finalize_file(const char *final_name, const char *curr_name,
 			  unsigned char *sha1, const char *ext)
 {
 	if (final_name != curr_name) {
-		char name[PATH_MAX];
-		if (!final_name) {
-			snprintf(name, sizeof(name), "%s/pack/pack-%s.%s",
-				 get_object_directory(), sha1_to_hex(sha1),
-				 ext);
-			final_name = name;
-		}
+		struct strbuf buf = STRBUF_INIT;
+		if (!final_name)
+			final_name = odb_pack_name(&buf, sha1, ext);
 		if (finalize_object_file(curr_name, final_name))
 			die(_("cannot store %s file"), ext);
 	} else if (from_stdin)
-- 
2.12.0.613.g6e7c52a0d

