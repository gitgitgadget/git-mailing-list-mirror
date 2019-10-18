Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52CA11F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 05:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393320AbfJRFAw (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 01:00:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:51760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727627AbfJRFAv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 01:00:51 -0400
Received: (qmail 9509 invoked by uid 109); 18 Oct 2019 05:00:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 05:00:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14476 invoked by uid 111); 18 Oct 2019 05:03:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:03:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 01:00:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 19/23] fsck: don't require an object struct in
 verify_headers()
Message-ID: <20191018050050.GS17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We only need the oid and type to pass on to report(). Let's accept the
broken-out parameters to give our callers more flexibility.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fsck.c b/fsck.c
index e1d06fb210..50c93200ed 100644
--- a/fsck.c
+++ b/fsck.c
@@ -687,7 +687,8 @@ static int fsck_tree(struct tree *item,
 }
 
 static int verify_headers(const void *data, unsigned long size,
-			  struct object *obj, struct fsck_options *options)
+			  const struct object_id *oid, enum object_type type,
+			  struct fsck_options *options)
 {
 	const char *buffer = (const char *)data;
 	unsigned long i;
@@ -695,7 +696,7 @@ static int verify_headers(const void *data, unsigned long size,
 	for (i = 0; i < size; i++) {
 		switch (buffer[i]) {
 		case '\0':
-			return report(options, &obj->oid, obj->type,
+			return report(options, oid, type,
 				FSCK_MSG_NUL_IN_HEADER,
 				"unterminated header: NUL at offset %ld", i);
 		case '\n':
@@ -713,7 +714,7 @@ static int verify_headers(const void *data, unsigned long size,
 	if (size && buffer[size - 1] == '\n')
 		return 0;
 
-	return report(options, &obj->oid, obj->type,
+	return report(options, oid, type,
 		FSCK_MSG_UNTERMINATED_HEADER, "unterminated header");
 }
 
@@ -772,7 +773,8 @@ static int fsck_commit(struct commit *commit, const char *buffer,
 	const char *buffer_begin = buffer;
 	const char *p;
 
-	if (verify_headers(buffer, size, &commit->object, options))
+	if (verify_headers(buffer, size, &commit->object.oid,
+			   commit->object.type, options))
 		return -1;
 
 	if (!skip_prefix(buffer, "tree ", &buffer))
@@ -827,7 +829,7 @@ static int fsck_tag(struct tag *tag, const char *buffer,
 	struct strbuf sb = STRBUF_INIT;
 	const char *p;
 
-	ret = verify_headers(buffer, size, &tag->object, options);
+	ret = verify_headers(buffer, size, &tag->object.oid, tag->object.type, options);
 	if (ret)
 		goto done;
 
-- 
2.23.0.1228.gee29b05929

