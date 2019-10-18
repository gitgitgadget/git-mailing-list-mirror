Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5FE1F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 05:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390308AbfJRFBA (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 01:01:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:51762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727627AbfJRFBA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 01:01:00 -0400
Received: (qmail 9512 invoked by uid 109); 18 Oct 2019 05:01:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 05:01:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14481 invoked by uid 111); 18 Oct 2019 05:04:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:04:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 01:00:59 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 20/23] fsck: rename vague "oid" local variables
Message-ID: <20191018050059.GT17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In fsck_commit() and fsck_tag(), we have local "oid" variables used for
parsing parent and tagged-object oids. Let's give these more specific
names in preparation for the functions taking an "oid" parameter for the
object we're checking.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsck.c b/fsck.c
index 50c93200ed..42e7d1f71f 100644
--- a/fsck.c
+++ b/fsck.c
@@ -767,7 +767,7 @@ static int fsck_ident(const char **ident,
 static int fsck_commit(struct commit *commit, const char *buffer,
 		       unsigned long size, struct fsck_options *options)
 {
-	struct object_id tree_oid, oid;
+	struct object_id tree_oid, parent_oid;
 	unsigned author_count;
 	int err;
 	const char *buffer_begin = buffer;
@@ -786,7 +786,7 @@ static int fsck_commit(struct commit *commit, const char *buffer,
 	}
 	buffer = p + 1;
 	while (skip_prefix(buffer, "parent ", &buffer)) {
-		if (parse_oid_hex(buffer, &oid, &p) || *p != '\n') {
+		if (parse_oid_hex(buffer, &parent_oid, &p) || *p != '\n') {
 			err = report(options, &commit->object.oid, commit->object.type, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
 			if (err)
 				return err;
@@ -823,7 +823,7 @@ static int fsck_commit(struct commit *commit, const char *buffer,
 static int fsck_tag(struct tag *tag, const char *buffer,
 		    unsigned long size, struct fsck_options *options)
 {
-	struct object_id oid;
+	struct object_id tagged_oid;
 	int ret = 0;
 	char *eol;
 	struct strbuf sb = STRBUF_INIT;
@@ -837,7 +837,7 @@ static int fsck_tag(struct tag *tag, const char *buffer,
 		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
 		goto done;
 	}
-	if (parse_oid_hex(buffer, &oid, &p) || *p != '\n') {
+	if (parse_oid_hex(buffer, &tagged_oid, &p) || *p != '\n') {
 		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
 		if (ret)
 			goto done;
-- 
2.23.0.1228.gee29b05929

