Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C371F403
	for <e@80x24.org>; Sat,  9 Jun 2018 08:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753227AbeFIIcD (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 04:32:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:39926 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753203AbeFIIcC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 04:32:02 -0400
Received: (qmail 25356 invoked by uid 109); 9 Jun 2018 08:32:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Jun 2018 08:32:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2015 invoked by uid 111); 9 Jun 2018 08:32:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 09 Jun 2018 04:32:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Jun 2018 04:32:00 -0400
Date:   Sat, 9 Jun 2018 04:32:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] fsck: avoid looking at NULL blob->object
Message-ID: <20180609083159.GA6158@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 159e7b080b (fsck: detect gitmodules files,
2018-05-02) taught fsck to look at the content of
.gitmodules files. If the object turns out not to be a blob
at all, we just complain and punt on checking the content.
And since this was such an obvious and trivial code path, I
didn't even bother to add a test.

Except it _does_ do one non-trivial thing, which is call the
report() function, which wants us to pass a pointer to a
"struct object". Which we don't have (we have only a "struct
object_id"). So we erroneously passed the NULL object, which
ends up segfaulting.

It seems like we could refactor report() to just take the
object_id itself. But we pass the object pointer along to
a callback function, and indeed this ends up in
builtin/fsck.c's objreport() which does want to look at
other parts of the object (like the type).

So instead, let's just use lookup_unknown_object() to get
the real "struct object", and pass that.

Signed-off-by: Jeff King <peff@peff.net>
---
The problem is in v2.17.1, and of course the v2.18 release candidates.

 fsck.c                     |  3 ++-
 t/t7415-submodule-names.sh | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index bcae2c30e6..48e7e36869 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1036,7 +1036,8 @@ int fsck_finish(struct fsck_options *options)
 
 		blob = lookup_blob(oid);
 		if (!blob) {
-			ret |= report(options, &blob->object,
+			struct object *obj = lookup_unknown_object(oid->hash);
+			ret |= report(options, obj,
 				      FSCK_MSG_GITMODULES_BLOB,
 				      "non-blob found at .gitmodules");
 			continue;
diff --git a/t/t7415-submodule-names.sh b/t/t7415-submodule-names.sh
index a770d92a55..63c767bf99 100755
--- a/t/t7415-submodule-names.sh
+++ b/t/t7415-submodule-names.sh
@@ -151,4 +151,22 @@ test_expect_success 'fsck detects symlinked .gitmodules file' '
 	)
 '
 
+test_expect_success 'fsck detects non-blob .gitmodules' '
+	git init non-blob &&
+	(
+		cd non-blob &&
+
+		# As above, make the funny directly to avoid index restrictions.
+		mkdir subdir &&
+		cp ../.gitmodules subdir/file &&
+		git add subdir/file &&
+		git commit -m ok &&
+		tree=$(git ls-tree HEAD | sed s/subdir/.gitmodules/ | git mktree) &&
+		commit=$(git commit-tree $tree) &&
+
+		test_must_fail git fsck 2>output &&
+		grep gitmodulesBlob output
+	)
+'
+
 test_done
-- 
2.18.0.rc1.446.g4486251e51
