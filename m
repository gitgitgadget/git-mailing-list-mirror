Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4EF1EE49A3
	for <git@archiver.kernel.org>; Sun, 20 Aug 2023 00:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjHTAfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Aug 2023 20:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjHTAes (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Aug 2023 20:34:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B20BAF102
        for <git@vger.kernel.org>; Sat, 19 Aug 2023 16:53:43 -0700 (PDT)
Received: (qmail 26376 invoked by uid 109); 19 Aug 2023 23:53:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 19 Aug 2023 23:53:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22906 invoked by uid 111); 19 Aug 2023 23:53:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 19 Aug 2023 19:53:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 19 Aug 2023 19:53:42 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] fsck: use enum object_type for fsck_walk callback
Message-ID: <20230819235342.GA600744@coredump.intra.peff.net>
References: <20230819235123.GA600613@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230819235123.GA600613@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We switched the function interface for fsck callbacks in a1aad71601
(fsck.h: use "enum object_type" instead of "int", 2021-03-28). However,
we accidentally flipped the type back to "int" as part of 0b4e9013f1
(fsck: mark unused parameters in various fsck callbacks, 2023-07-03).
The mistake happened because that commit was written before a1aad71601
and rebased forward, and I screwed up while resolving the conflict.

Curiously, the compiler does not warn about this mismatch, at least not
when using gcc and clang on Linux (nor in any of our CI environments).
Based on 28abf260a5 (builtin/fsck.c: don't conflate "int" and "enum" in
callback, 2021-06-01), I'd guess that this would cause the AIX xlc
compiler to complain. I noticed because clang-18's UBSan now identifies
mis-matched function calls at runtime, and does complain of this case
when running the test suite.

I'm not entirely clear on whether this mismatch is a problem in
practice. Compilers are certainly free to make enums smaller than "int"
if they don't need the bits, but I suspect that they have to promote
back to int for function calls (though I didn't dig in the standard, and
I won't be surprised if I'm simply wrong and the real-world impact would
depend on the ABI).

Regardless, switching it back to enum is obviously the right thing to do
here; the switch to "int" was simply a mistake.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index c1d0290026..611925905e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -206,7 +206,7 @@ static int traverse_reachable(void)
 	return !!result;
 }
 
-static int mark_used(struct object *obj, int type UNUSED,
+static int mark_used(struct object *obj, enum object_type type UNUSED,
 		     void *data UNUSED, struct fsck_options *options UNUSED)
 {
 	if (!obj)
-- 
2.42.0.rc2.418.g602d5859fc

