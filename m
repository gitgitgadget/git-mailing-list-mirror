Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C340B1F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 04:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407185AbfJRE6m (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 00:58:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:51722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728791AbfJRE6l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 00:58:41 -0400
Received: (qmail 9466 invoked by uid 109); 18 Oct 2019 04:58:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:58:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14365 invoked by uid 111); 18 Oct 2019 05:01:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:01:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:58:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 13/23] fsck: only provide oid/type in fsck_error callback
Message-ID: <20191018045840.GM17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

None of the callbacks actually care about having a "struct object";
they're happy with just the oid and type information. So let's give
ourselves more flexibility to avoid having a "struct object" by just
passing the broken-down fields.

Note that the callback already takes a "type" field for the fsck message
type. We'll rename that to "msg_type" (and use "object_type" for the
object type) to make the distinction explicit.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 17 ++++++++++-------
 fsck.c         | 11 +++++++----
 fsck.h         |  6 ++++--
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 59c77c1baa..8d13794b14 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -104,23 +104,26 @@ static int objerror(struct object *obj, const char *err)
 }
 
 static int fsck_error_func(struct fsck_options *o,
-	struct object *obj, int type, const char *message)
+			   const struct object_id *oid,
+			   enum object_type object_type,
+			   int msg_type, const char *message)
 {
-	switch (type) {
+	switch (msg_type) {
 	case FSCK_WARN:
 		/* TRANSLATORS: e.g. warning in tree 01bfda: <more explanation> */
 		fprintf_ln(stderr, _("warning in %s %s: %s"),
-			   printable_type(&obj->oid, obj->type),
-			   describe_object(&obj->oid), message);
+			   printable_type(oid, object_type),
+			   describe_object(oid), message);
 		return 0;
 	case FSCK_ERROR:
 		/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
 		fprintf_ln(stderr, _("error in %s %s: %s"),
-			   printable_type(&obj->oid, obj->type),
-			   describe_object(&obj->oid), message);
+			   printable_type(oid, object_type),
+			   describe_object(oid), message);
 		return 1;
 	default:
-		BUG("%d (FSCK_IGNORE?) should never trigger this callback", type);
+		BUG("%d (FSCK_IGNORE?) should never trigger this callback",
+		    msg_type);
 	}
 }
 
diff --git a/fsck.c b/fsck.c
index 124c0184d4..c036ba09ab 100644
--- a/fsck.c
+++ b/fsck.c
@@ -305,7 +305,8 @@ static int report(struct fsck_options *options, struct object *object,
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(options, object, msg_type, sb.buf);
+	result = options->error_func(options, &object->oid, object->type,
+				     msg_type, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
 
@@ -983,13 +984,15 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 }
 
 int fsck_error_function(struct fsck_options *o,
-	struct object *obj, int msg_type, const char *message)
+			const struct object_id *oid,
+			enum object_type object_type,
+			int msg_type, const char *message)
 {
 	if (msg_type == FSCK_WARN) {
-		warning("object %s: %s", fsck_describe_object(o, &obj->oid), message);
+		warning("object %s: %s", fsck_describe_object(o, oid), message);
 		return 0;
 	}
-	error("object %s: %s", fsck_describe_object(o, &obj->oid), message);
+	error("object %s: %s", fsck_describe_object(o, oid), message);
 	return 1;
 }
 
diff --git a/fsck.h b/fsck.h
index 4397cab20f..f81aedf12f 100644
--- a/fsck.h
+++ b/fsck.h
@@ -27,10 +27,12 @@ typedef int (*fsck_walk_func)(struct object *obj, int type, void *data, struct f
 
 /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
 typedef int (*fsck_error)(struct fsck_options *o,
-	struct object *obj, int type, const char *message);
+			  const struct object_id *oid, enum object_type object_type,
+			  int msg_type, const char *message);
 
 int fsck_error_function(struct fsck_options *o,
-	struct object *obj, int type, const char *message);
+			const struct object_id *oid, enum object_type object_type,
+			int msg_type, const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
-- 
2.23.0.1228.gee29b05929

