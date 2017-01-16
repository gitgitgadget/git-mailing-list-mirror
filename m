Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C90CF20A17
	for <e@80x24.org>; Mon, 16 Jan 2017 21:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbdAPVkN (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 16:40:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:39877 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750863AbdAPVkN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 16:40:13 -0500
Received: (qmail 20724 invoked by uid 109); 16 Jan 2017 21:33:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 21:33:31 +0000
Received: (qmail 12377 invoked by uid 111); 16 Jan 2017 21:34:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Jan 2017 16:34:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2017 16:33:29 -0500
Date:   Mon, 16 Jan 2017 16:33:29 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 4/6] fsck: tighten error-checks of "git fsck <head>"
Message-ID: <20170116213329.jk26zvcp7erzfc6l@sigill.intra.peff.net>
References: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170116212231.ojoqzlajpszifaf3@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of checking reachability from the refs, you can ask
fsck to check from a particular set of heads. However, the
error checking here is quite lax. In particular:

  1. It claims lookup_object() will report an error, which
     is not true. It only does a hash lookup, and the user
     has no clue that their argument was skipped.

  2. When either the name or sha1 cannot be resolved, we
     continue to exit with a successful error code, even
     though we didn't check what the user asked us to.

This patch fixes both of these cases.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c  | 7 +++++--
 t/t1450-fsck.sh | 5 +++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index f527d8a02..c7d0590e5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -755,9 +755,11 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 		if (!get_sha1(arg, sha1)) {
 			struct object *obj = lookup_object(sha1);
 
-			/* Error is printed by lookup_object(). */
-			if (!obj)
+			if (!obj) {
+				error("%s: object missing", sha1_to_hex(sha1));
+				errors_found |= ERROR_OBJECT;
 				continue;
+			}
 
 			obj->used = 1;
 			if (name_objects)
@@ -768,6 +770,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		error("invalid parameter: expected sha1, got '%s'", arg);
+		errors_found |= ERROR_OBJECT;
 	}
 
 	/*
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index c1b2dda33..2f3b05276 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -605,4 +605,9 @@ test_expect_success 'fsck notices dangling objects' '
 	)
 '
 
+test_expect_success 'fsck $name notices bogus $name' '
+	test_must_fail git fsck bogus &&
+	test_must_fail git fsck $_z40
+'
+
 test_done
-- 
2.11.0.642.gd6f8cda6c

