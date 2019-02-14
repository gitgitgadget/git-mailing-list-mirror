Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B6D71F453
	for <e@80x24.org>; Thu, 14 Feb 2019 05:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405630AbfBNF4E (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 00:56:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:43786 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727861AbfBNF4E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 00:56:04 -0500
Received: (qmail 901 invoked by uid 109); 14 Feb 2019 05:51:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 05:51:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6964 invoked by uid 111); 14 Feb 2019 05:51:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 00:51:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 00:50:58 -0500
Date:   Thu, 14 Feb 2019 00:50:58 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 09/10] ref-filter: drop unused "obj" parameters
Message-ID: <20190214055058.GI20578@sigill.intra.peff.net>
References: <20190214054736.GA20091@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214054736.GA20091@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The grab_person() and grab_sub_body_contents() functions take both an
object struct and a buf/sz pair of the object bytes. However, they use
only the latter, since "struct object" does not contain the parsed ident
(nor the whole commit message, of course).

Let's get rid of these misleading "struct object" parameters. It's
possible we may want them in the future (e.g., to generate error
messages that mention the object id), but since these are static
functions, we can easily add them back in later (and if we do want that
information, it's likely we'd pass it through a more generalized
"parsing context" struct anyway).

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index c9333b3181..9ba18b220c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1064,7 +1064,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 }
 
 /* See grab_values */
-static void grab_person(const char *who, struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_person(const char *who, struct atom_value *val, int deref, void *buf, unsigned long sz)
 {
 	int i;
 	int wholen = strlen(who);
@@ -1192,7 +1192,7 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_sub_body_contents(struct atom_value *val, int deref, void *buf, unsigned long sz)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
@@ -1270,14 +1270,14 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
 	switch (obj->type) {
 	case OBJ_TAG:
 		grab_tag_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, obj, buf, sz);
-		grab_person("tagger", val, deref, obj, buf, sz);
+		grab_sub_body_contents(val, deref, buf, sz);
+		grab_person("tagger", val, deref, buf, sz);
 		break;
 	case OBJ_COMMIT:
 		grab_commit_values(val, deref, obj);
-		grab_sub_body_contents(val, deref, obj, buf, sz);
-		grab_person("author", val, deref, obj, buf, sz);
-		grab_person("committer", val, deref, obj, buf, sz);
+		grab_sub_body_contents(val, deref, buf, sz);
+		grab_person("author", val, deref, buf, sz);
+		grab_person("committer", val, deref, buf, sz);
 		break;
 	case OBJ_TREE:
 		/* grab_tree_values(val, deref, obj, buf, sz); */
-- 
2.21.0.rc1.567.g648f076c3f

