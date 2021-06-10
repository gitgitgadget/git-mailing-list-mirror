Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D86BC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F53613DE
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFJNAk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:00:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:51196 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhFJNAk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:00:40 -0400
Received: (qmail 7598 invoked by uid 109); 10 Jun 2021 12:58:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Jun 2021 12:58:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29648 invoked by uid 111); 10 Jun 2021 12:58:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Jun 2021 08:58:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Jun 2021 08:58:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] ll_union_merge(): pass name labels to ll_xdl_merge()
Message-ID: <YMIMg+uXDjzS70g5@coredump.intra.peff.net>
References: <YMIKwsEFnkqz6PWa@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YMIKwsEFnkqz6PWa@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since cd1d61c44f (make union merge an xdl merge favor, 2010-03-01), we
pass NULL to ll_xdl_merge() for the "name" labels of the ancestor, ours
and theirs buffers. We usually use these for annotating conflict markers
left in a file. For a union merge, these shouldn't matter; the point of
it is that we'd never leave conflict markers in the first place.

But there is one code path where we may dereference them: if the file
contents appear to be binary, ll_binary_merge() will give up and pass
them to warning() to generate a message for the user (that was true even
when cd1d61c44f was written, though the warning was in ll_xdl_merge()
back then).

That can result in a segfault, though on many systems (including glibc),
the printf routines will helpfully just say "(null)" instead. We can
extend our binary-union test in t6406 to check stderr, which catches the
problem on all systems.

This also fixes a warning from "gcc -O3". Unlike lower optimization
levels, it inlines enough to see that the NULL can make it to warning()
and complains:

  In function ‘ll_binary_merge’,
      inlined from ‘ll_xdl_merge’ at ll-merge.c:115:10,
      inlined from ‘ll_union_merge’ at ll-merge.c:151:9:
  ll-merge.c:74:4: warning: ‘%s’ directive argument is null [-Wformat-overflow=]
     74 |    warning("Cannot merge binary files: %s (%s vs. %s)",
        |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     75 |     path, name1, name2);
        |     ~~~~~~~~~~~~~~~~~~~

Signed-off-by: Jeff King <peff@peff.net>
---
 ll-merge.c            | 2 +-
 t/t6406-merge-attr.sh | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/ll-merge.c b/ll-merge.c
index 145deb12fa..0ee34d8a01 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -151,7 +151,7 @@ static int ll_union_merge(const struct ll_merge_driver *drv_unused,
 	o = *opts;
 	o.variant = XDL_MERGE_FAVOR_UNION;
 	return ll_xdl_merge(drv_unused, result, path_unused,
-			    orig, NULL, src1, NULL, src2, NULL,
+			    orig, orig_name, src1, name1, src2, name2,
 			    &o, marker_size);
 }
 
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index c1c458d933..8494645837 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -221,7 +221,8 @@ test_expect_success 'binary files with union attribute' '
 	printf "two\0" >bin.txt &&
 	git commit -am two &&
 
-	test_must_fail git merge bin-main
+	test_must_fail git merge bin-main 2>stderr &&
+	grep -i "warning.*cannot merge.*HEAD vs. bin-main" stderr
 '
 
 test_done
-- 
2.32.0.529.g079a794268
