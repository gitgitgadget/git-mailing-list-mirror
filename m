Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02BF51F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 04:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395205AbfJRE7z (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 00:59:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:51746 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726315AbfJRE7z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 00:59:55 -0400
Received: (qmail 9494 invoked by uid 109); 18 Oct 2019 04:59:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:59:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14429 invoked by uid 111); 18 Oct 2019 05:03:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:03:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:59:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 17/23] fsck: drop blob struct from fsck_finish()
Message-ID: <20191018045953.GQ17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since fsck_blob() no longer requires us to have a "struct blob", we
don't need to create one. Which also means we don't need to worry about
handling the case that lookup_blob() returns NULL (we'll still catch
wrongly-identified blobs when we read the actual object contents and
type from disk).

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/fsck.c b/fsck.c
index 6e9640a1a6..4ff0ceb4ac 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1013,7 +1013,6 @@ int fsck_finish(struct fsck_options *options)
 
 	oidset_iter_init(&gitmodules_found, &iter);
 	while ((oid = oidset_iter_next(&iter))) {
-		struct blob *blob;
 		enum object_type type;
 		unsigned long size;
 		char *buf;
@@ -1021,31 +1020,22 @@ int fsck_finish(struct fsck_options *options)
 		if (oidset_contains(&gitmodules_done, oid))
 			continue;
 
-		blob = lookup_blob(the_repository, oid);
-		if (!blob) {
-			struct object *obj = lookup_unknown_object(oid);
-			ret |= report(options, &obj->oid, obj->type,
-				      FSCK_MSG_GITMODULES_BLOB,
-				      "non-blob found at .gitmodules");
-			continue;
-		}
-
 		buf = read_object_file(oid, &type, &size);
 		if (!buf) {
-			if (is_promisor_object(&blob->object.oid))
+			if (is_promisor_object(oid))
 				continue;
 			ret |= report(options,
-				      &blob->object.oid, blob->object.type,
+				      oid, OBJ_BLOB,
 				      FSCK_MSG_GITMODULES_MISSING,
 				      "unable to read .gitmodules blob");
 			continue;
 		}
 
 		if (type == OBJ_BLOB)
-			ret |= fsck_blob(&blob->object.oid, buf, size, options);
+			ret |= fsck_blob(oid, buf, size, options);
 		else
 			ret |= report(options,
-				      &blob->object.oid, blob->object.type,
+				      oid, type,
 				      FSCK_MSG_GITMODULES_BLOB,
 				      "non-blob found at .gitmodules");
 		free(buf);
-- 
2.23.0.1228.gee29b05929

