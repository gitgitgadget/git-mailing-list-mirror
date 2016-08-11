Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336471F859
	for <e@80x24.org>; Thu, 11 Aug 2016 09:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbcHKJYj (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 05:24:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:53514 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751072AbcHKJYi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 05:24:38 -0400
Received: (qmail 403 invoked by uid 109); 11 Aug 2016 09:24:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 09:24:36 +0000
Received: (qmail 8335 invoked by uid 111); 11 Aug 2016 09:24:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 Aug 2016 05:24:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Aug 2016 05:24:35 -0400
Date:	Thu, 11 Aug 2016 05:24:35 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v5 1/4] provide an initializer for "struct object_info"
Message-ID: <20160811092434.dtb73p3jrskxy32f@sigill.intra.peff.net>
References: <20160811092030.my5c4x6wplxaf7wz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160811092030.my5c4x6wplxaf7wz@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

An all-zero initializer is fine for this struct, but because
the first element is a pointer, call sites need to know to
use "NULL" instead of "0". Otherwise some static checkers
like "sparse" will complain; see d099b71 (Fix some sparse
warnings, 2013-07-18) for example.  So let's provide an
initializer to make this easier to get right.

But let's also comment that memset() to zero is explicitly
OK[1]. One of the callers embeds object_info in another
struct which is initialized via memset (expand_data in
builtin/cat-file.c). Since our subset of C doesn't allow
assignment from a compound literal, handling this in any
other way is awkward, so we'd like to keep the ability to
initialize by memset(). By documenting this property, it
should make anybody who wants to change the initializer
think twice before doing so.

There's one other caller of interest. In parse_sha1_header(),
we did not initialize the struct fully in the first place.
This turned out not to be a bug because the sub-function it
calls does not look at any other fields except the ones we
did initialize. But that assumption might not hold in the
future, so it's a dangerous construct. This patch switches
it to initializing the whole struct, which protects us
against unexpected reads of the other fields.

[1] Obviously using memset() to initialize a pointer
    violates the C standard, but we long ago decided that it
    was an acceptable tradeoff in the real world.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c | 5 ++---
 cache.h            | 7 +++++++
 sha1_file.c        | 6 ++----
 streaming.c        | 2 +-
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2dfe626..2cbc31e 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -28,7 +28,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	char *buf;
 	unsigned long size;
 	struct object_context obj_context;
-	struct object_info oi = {NULL};
+	struct object_info oi = OBJECT_INFO_INIT;
 	struct strbuf sb = STRBUF_INIT;
 	unsigned flags = LOOKUP_REPLACE_OBJECT;
 
@@ -378,8 +378,7 @@ static int batch_objects(struct batch_options *opt)
 	data.mark_query = 0;
 
 	if (opt->all_objects) {
-		struct object_info empty;
-		memset(&empty, 0, sizeof(empty));
+		struct object_info empty = OBJECT_INFO_INIT;
 		if (!memcmp(&data.info, &empty, sizeof(empty)))
 			data.skip_object_info = 1;
 	}
diff --git a/cache.h b/cache.h
index 95a0bd3..b2e4969 100644
--- a/cache.h
+++ b/cache.h
@@ -1550,6 +1550,13 @@ struct object_info {
 		} packed;
 	} u;
 };
+
+/*
+ * Initializer for a "struct object_info" that wants no items. You may
+ * also memset() the memory to all-zeroes.
+ */
+#define OBJECT_INFO_INIT {NULL}
+
 extern int sha1_object_info_extended(const unsigned char *, struct object_info *, unsigned flags);
 
 /* Dumb servers support */
diff --git a/sha1_file.c b/sha1_file.c
index 02940f1..b8cc76b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1730,11 +1730,9 @@ static int parse_sha1_header_extended(const char *hdr, struct object_info *oi,
 
 int parse_sha1_header(const char *hdr, unsigned long *sizep)
 {
-	struct object_info oi;
+	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.sizep = sizep;
-	oi.typename = NULL;
-	oi.typep = NULL;
 	return parse_sha1_header_extended(hdr, &oi, LOOKUP_REPLACE_OBJECT);
 }
 
@@ -2738,7 +2736,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 {
 	enum object_type type;
-	struct object_info oi = {NULL};
+	struct object_info oi = OBJECT_INFO_INIT;
 
 	oi.typep = &type;
 	oi.sizep = sizep;
diff --git a/streaming.c b/streaming.c
index 811fcc2..431254b 100644
--- a/streaming.c
+++ b/streaming.c
@@ -135,7 +135,7 @@ struct git_istream *open_istream(const unsigned char *sha1,
 				 struct stream_filter *filter)
 {
 	struct git_istream *st;
-	struct object_info oi = {NULL};
+	struct object_info oi = OBJECT_INFO_INIT;
 	const unsigned char *real = lookup_replace_object(sha1);
 	enum input_source src = istream_source(real, type, &oi);
 
-- 
2.9.2.790.gaa5bc72

