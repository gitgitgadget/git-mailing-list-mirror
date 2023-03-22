Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149B5C6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 17:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCVRhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 13:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCVRhn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 13:37:43 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E14862FDF
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 10:37:31 -0700 (PDT)
Received: (qmail 10413 invoked by uid 109); 22 Mar 2023 17:37:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Mar 2023 17:37:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15864 invoked by uid 111); 22 Mar 2023 17:37:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Mar 2023 13:37:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Mar 2023 13:37:17 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/6] fast-export: drop const when storing anonymized values
Message-ID: <20230322173717.GA5795@coredump.intra.peff.net>
References: <20230322173636.GA5643@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230322173636.GA5643@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We store anonymized values as pointers to "const char *", since they are
conceptually const to callers who use them. But they are actually
allocated strings whose memory is owned by the struct.

The ownership mismatch hasn't been a big deal since we never free() them
(they are held until the program ends), but let's switch them to "char *"
in preparation for changing that.

Since most code only accesses them via anonymize_str(), it can continue
to narrow them to "const char *" in its return value.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 78493c6d2bf..f422819c82a 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -110,7 +110,7 @@ static struct decoration idnums;
 static uint32_t last_idnum;
 struct anonymized_entry {
 	struct hashmap_entry hash;
-	const char *anon;
+	char *anon;
 	const char orig[FLEX_ARRAY];
 };
 
-- 
2.40.0.595.g9b96b494d8c

