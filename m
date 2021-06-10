Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCC3C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FE5613C9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhFJM7F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 08:59:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:51174 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230351AbhFJM7D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 08:59:03 -0400
Received: (qmail 7580 invoked by uid 109); 10 Jun 2021 12:57:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 12:57:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29572 invoked by uid 111); 10 Jun 2021 12:57:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 08:57:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 08:57:05 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] ll_binary_merge(): handle XDL_MERGE_FAVOR_UNION
Message-ID: <YMIMIdnDB1Jq+lzp@coredump.intra.peff.net>
References: <YMIKwsEFnkqz6PWa@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YMIKwsEFnkqz6PWa@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Prior to commit a944af1d86 (merge: teach -Xours/-Xtheirs to binary
ll-merge driver, 2012-09-08), we always reported a conflict from
ll_binary_merge() by returning "1" (in the xdl_merge and ll_merge code,
this value is the number of conflict hunks). After that commit, we
report zero conflicts if the "variant" flag is set, under the assumption
that it is one of XDL_MERGE_FAVOR_OURS or XDL_MERGE_FAVOR_THEIRS.

But this gets confused by XDL_MERGE_FAVOR_UNION. We do not know how to
do a binary union merge, but erroneously report no conflicts anyway (and
just blindly use the "ours" content as the result).

Let's tighten our check to just the cases that a944af1d86 meant to
cover. This fixes the union case (which existed already back when that
commit was made), as well as future-proofing us against any other
variants that get added later.

Note that you can't trigger this from "git merge-file --union", as that
bails on binary files before even calling into the ll-merge machinery.
The test here uses the "union" merge attribute, which does erroneously
report a successful merge.

Signed-off-by: Jeff King <peff@peff.net>
---
 ll-merge.c            |  4 +++-
 t/t6406-merge-attr.sh | 17 +++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/ll-merge.c b/ll-merge.c
index 9a8a2c365c..145deb12fa 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -91,7 +91,9 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 	 * With -Xtheirs or -Xours, we have cleanly merged;
 	 * otherwise we got a conflict.
 	 */
-	return (opts->variant ? 0 : 1);
+	return opts->variant == XDL_MERGE_FAVOR_OURS ||
+	       opts->variant == XDL_MERGE_FAVOR_THEIRS ?
+	       0 : 1;
 }
 
 static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index d5a4ac2d81..c1c458d933 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -207,4 +207,21 @@ test_expect_success 'custom merge does not lock index' '
 	git merge main
 '
 
+test_expect_success 'binary files with union attribute' '
+	git checkout -b bin-main &&
+	printf "base\0" >bin.txt &&
+	echo "bin.txt merge=union" >.gitattributes &&
+	git add bin.txt .gitattributes &&
+	git commit -m base &&
+
+	printf "one\0" >bin.txt &&
+	git commit -am one &&
+
+	git checkout -b bin-side HEAD^ &&
+	printf "two\0" >bin.txt &&
+	git commit -am two &&
+
+	test_must_fail git merge bin-main
+'
+
 test_done
-- 
2.32.0.529.g079a794268

