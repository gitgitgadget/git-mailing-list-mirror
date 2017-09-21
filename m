Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B724320281
	for <e@80x24.org>; Thu, 21 Sep 2017 06:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbdIUGVn (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 02:21:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:45706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751524AbdIUGVn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 02:21:43 -0400
Received: (qmail 5950 invoked by uid 109); 21 Sep 2017 06:21:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 06:21:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20024 invoked by uid 111); 21 Sep 2017 06:22:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 21 Sep 2017 02:22:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Sep 2017 02:21:40 -0400
Date:   Thu, 21 Sep 2017 02:21:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/4] cat-file: handle NULL object_context.path
Message-ID: <20170921062140.cyfjv7rfuppqpblh@sigill.intra.peff.net>
References: <20170921062043.la2f3pjsnojirzyw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170921062043.la2f3pjsnojirzyw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit dc944b65f1 (get_sha1_with_context: dynamically
allocate oc->path, 2017-05-19) changed the rules that
callers must follow for seeing if we parsed a path in the
object name. The rules switched from "check if the oc.path
buffer is empty" to "check if the oc.path pointer is NULL".
But that commit forgot to update some sites in
cat_one_file(), meaning we might dereference a NULL pointer.

You can see this by making a path-aware request like
--textconv without specifying --path, and giving an object
name that doesn't have a path in it. Like:

  git cat-file --textconv HEAD

which will reliably segfault.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/cat-file.c          | 4 ++--
 t/t8010-cat-file-filters.sh | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 4ccbfaac31..1ea25331d3 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -97,7 +97,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		return !has_object_file(&oid);
 
 	case 'w':
-		if (!path[0])
+		if (!path)
 			die("git cat-file --filters %s: <object> must be "
 			    "<sha1:path>", obj_name);
 
@@ -107,7 +107,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		break;
 
 	case 'c':
-		if (!path[0])
+		if (!path)
 			die("git cat-file --textconv %s: <object> must be <sha1:path>",
 			    obj_name);
 
diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
index d8242e467e..0f86c19174 100755
--- a/t/t8010-cat-file-filters.sh
+++ b/t/t8010-cat-file-filters.sh
@@ -51,6 +51,11 @@ test_expect_success '--path=<path> complains without --textconv/--filters' '
 	grep "path.*needs.*filters" err
 '
 
+test_expect_success '--textconv/--filters complain without path' '
+	test_must_fail git cat-file --textconv HEAD &&
+	test_must_fail git cat-file --filters HEAD
+'
+
 test_expect_success 'cat-file --textconv --batch works' '
 	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
 	test_config diff.txt.textconv "tr A-Za-z N-ZA-Mn-za-m <" &&
-- 
2.14.1.1051.g8c9143ec35

