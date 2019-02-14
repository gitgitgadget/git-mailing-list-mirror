Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED611F453
	for <e@80x24.org>; Thu, 14 Feb 2019 05:53:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393953AbfBNFw6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 00:52:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:43768 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726155AbfBNFu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 00:50:56 -0500
Received: (qmail 898 invoked by uid 109); 14 Feb 2019 05:50:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 05:50:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6961 invoked by uid 111); 14 Feb 2019 05:51:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 00:51:06 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 00:50:54 -0500
Date:   Thu, 14 Feb 2019 00:50:54 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/10] ref-filter: drop unused buf/sz pairs
Message-ID: <20190214055054.GH20578@sigill.intra.peff.net>
References: <20190214054736.GA20091@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214054736.GA20091@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The grab_tag_values() and grab_commit_values() functions take both the
"struct object" as well as the buf/sz pair for the actual object bytes.
However, neither function uses the latter, as they pull the data
directly from the parsed object struct.

Let's get rid of these misleading parameters.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 422a9c9ae3..c9333b3181 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -913,7 +913,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
 }
 
 /* See grab_values */
-static void grab_tag_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_tag_values(struct atom_value *val, int deref, struct object *obj)
 {
 	int i;
 	struct tag *tag = (struct tag *) obj;
@@ -935,7 +935,7 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 }
 
 /* See grab_values */
-static void grab_commit_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_commit_values(struct atom_value *val, int deref, struct object *obj)
 {
 	int i;
 	struct commit *commit = (struct commit *) obj;
@@ -1269,12 +1269,12 @@ static void grab_values(struct atom_value *val, int deref, struct object *obj, v
 {
 	switch (obj->type) {
 	case OBJ_TAG:
-		grab_tag_values(val, deref, obj, buf, sz);
+		grab_tag_values(val, deref, obj);
 		grab_sub_body_contents(val, deref, obj, buf, sz);
 		grab_person("tagger", val, deref, obj, buf, sz);
 		break;
 	case OBJ_COMMIT:
-		grab_commit_values(val, deref, obj, buf, sz);
+		grab_commit_values(val, deref, obj);
 		grab_sub_body_contents(val, deref, obj, buf, sz);
 		grab_person("author", val, deref, obj, buf, sz);
 		grab_person("committer", val, deref, obj, buf, sz);
-- 
2.21.0.rc1.567.g648f076c3f

