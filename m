Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 246A520A17
	for <e@80x24.org>; Tue, 24 Jan 2017 00:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbdAXAsZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 19:48:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:43579 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751293AbdAXAsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 19:48:25 -0500
Received: (qmail 10084 invoked by uid 109); 24 Jan 2017 00:48:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 00:48:08 +0000
Received: (qmail 13362 invoked by uid 111); 24 Jan 2017 00:49:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Jan 2017 19:49:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jan 2017 19:48:05 -0500
Date:   Mon, 23 Jan 2017 19:48:05 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/12] receive-pack: treat namespace .have lines like
 alternates
Message-ID: <20170124004805.nu3w47isrb4bxgi5@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Namely, de-duplicate them. We use the same set as the
alternates, since we call them both ".have" (i.e., there is
no value in showing one versus the other).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8f8762e4a..c55e2f993 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -251,8 +251,9 @@ static void show_ref(const char *path, const unsigned char *sha1)
 }
 
 static int show_ref_cb(const char *path_full, const struct object_id *oid,
-		       int flag, void *unused)
+		       int flag, void *data)
 {
+	struct oidset *seen = data;
 	const char *path = strip_namespace(path_full);
 
 	if (ref_is_hidden(path, path_full))
@@ -263,8 +264,11 @@ static int show_ref_cb(const char *path_full, const struct object_id *oid,
 	 * refs, so that the client can use them to minimize data
 	 * transfer but will otherwise ignore them.
 	 */
-	if (!path)
+	if (!path) {
+		if (oidset_insert(seen, oid))
+			return 0;
 		path = ".have";
+	}
 	show_ref(path, oid->hash);
 	return 0;
 }
@@ -287,7 +291,7 @@ static void write_head_info(void)
 
 	for_each_alternate_ref(show_one_alternate_ref, &seen);
 	oidset_clear(&seen);
-	for_each_ref(show_ref_cb, NULL);
+	for_each_ref(show_ref_cb, &seen);
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1);
 
-- 
2.11.0.765.g454d2182f

