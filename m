Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E64F1F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 05:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407379AbfJRFB2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 01:01:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:51772 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1733292AbfJRFB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 01:01:28 -0400
Received: (qmail 9525 invoked by uid 109); 18 Oct 2019 05:01:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 05:01:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14510 invoked by uid 111); 18 Oct 2019 05:04:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:04:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 01:01:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 21/23] fsck: accept an oid instead of a "struct tag" for
 fsck_tag()
Message-ID: <20191018050125.GU17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't actually look at the tag struct in fsck_tag() beyond its oid
and type (which is obviously OBJ_TAG). Just taking an oid gives our
callers more flexibility to avoid creating or parsing a struct, and
makes it clear that we are fscking just what is in the buffer, not any
pre-parsed bits from the struct.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fsck.c b/fsck.c
index 42e7d1f71f..38be501278 100644
--- a/fsck.c
+++ b/fsck.c
@@ -820,7 +820,7 @@ static int fsck_commit(struct commit *commit, const char *buffer,
 	return 0;
 }
 
-static int fsck_tag(struct tag *tag, const char *buffer,
+static int fsck_tag(const struct object_id *oid, const char *buffer,
 		    unsigned long size, struct fsck_options *options)
 {
 	struct object_id tagged_oid;
@@ -829,48 +829,48 @@ static int fsck_tag(struct tag *tag, const char *buffer,
 	struct strbuf sb = STRBUF_INIT;
 	const char *p;
 
-	ret = verify_headers(buffer, size, &tag->object.oid, tag->object.type, options);
+	ret = verify_headers(buffer, size, oid, OBJ_TAG, options);
 	if (ret)
 		goto done;
 
 	if (!skip_prefix(buffer, "object ", &buffer)) {
-		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
+		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
 		goto done;
 	}
 	if (parse_oid_hex(buffer, &tagged_oid, &p) || *p != '\n') {
-		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
+		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
 		if (ret)
 			goto done;
 	}
 	buffer = p + 1;
 
 	if (!skip_prefix(buffer, "type ", &buffer)) {
-		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
+		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
 		goto done;
 	}
 	eol = strchr(buffer, '\n');
 	if (!eol) {
-		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
+		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
 	if (type_from_string_gently(buffer, eol - buffer, 1) < 0)
-		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
+		ret = report(options, oid, OBJ_TAG, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
 	if (ret)
 		goto done;
 	buffer = eol + 1;
 
 	if (!skip_prefix(buffer, "tag ", &buffer)) {
-		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_MISSING_TAG_ENTRY, "invalid format - expected 'tag' line");
+		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG_ENTRY, "invalid format - expected 'tag' line");
 		goto done;
 	}
 	eol = strchr(buffer, '\n');
 	if (!eol) {
-		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_MISSING_TAG, "invalid format - unexpected end after 'type' line");
+		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAG, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
 	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
 	if (check_refname_format(sb.buf, 0)) {
-		ret = report(options, &tag->object.oid, tag->object.type,
+		ret = report(options, oid, OBJ_TAG,
 			     FSCK_MSG_BAD_TAG_NAME,
 			     "invalid 'tag' name: %.*s",
 			     (int)(eol - buffer), buffer);
@@ -881,12 +881,12 @@ static int fsck_tag(struct tag *tag, const char *buffer,
 
 	if (!skip_prefix(buffer, "tagger ", &buffer)) {
 		/* early tags do not contain 'tagger' lines; warn only */
-		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_MISSING_TAGGER_ENTRY, "invalid format - expected 'tagger' line");
+		ret = report(options, oid, OBJ_TAG, FSCK_MSG_MISSING_TAGGER_ENTRY, "invalid format - expected 'tagger' line");
 		if (ret)
 			goto done;
 	}
 	else
-		ret = fsck_ident(&buffer, &tag->object.oid, tag->object.type, options);
+		ret = fsck_ident(&buffer, oid, OBJ_TAG, options);
 
 done:
 	strbuf_release(&sb);
@@ -987,8 +987,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 		return fsck_commit((struct commit *) obj, (const char *) data,
 			size, options);
 	if (obj->type == OBJ_TAG)
-		return fsck_tag((struct tag *) obj, (const char *) data,
-			size, options);
+		return fsck_tag(&obj->oid, data, size, options);
 
 	return report(options, &obj->oid, obj->type,
 		      FSCK_MSG_UNKNOWN_TYPE,
-- 
2.23.0.1228.gee29b05929

