Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D3C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348271AbiHSKJS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348346AbiHSKJA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:09:00 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D91BD149
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:08:55 -0700 (PDT)
Received: (qmail 17687 invoked by uid 109); 19 Aug 2022 10:08:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Aug 2022 10:08:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 950 invoked by uid 111); 19 Aug 2022 10:08:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Aug 2022 06:08:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Aug 2022 06:08:54 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/11] is_path_owned_by_current_uid(): mark "report"
 parameter as unused
Message-ID: <Yv9hNh1U5Gj3MbTL@coredump.intra.peff.net>
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the non-Windows version of this function, we never have any errors to
report, and thus the "report" parameter is unused. But we can't drop it,
because we have to maintain function call compatibility with the version
in compat/mingw.h, which does use this parameter.

Note that there's an extra level of indirection here; the common
function is actually is_path_owned_by_current_user, which is a macro
pointing to "by_current_uid" or "by_current_sid", depending on the
platform. So an alternative here is to eat the unused parameter in the
macro, since -Wunused-parameter doesn't complain about macros. But I
think the UNUSED() annotation is less obfuscated for somebody reading
the code later.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 12239fedf7..a9690126bb 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -498,7 +498,8 @@ static inline void extract_id_from_env(const char *env, uid_t *id)
 	}
 }
 
-static inline int is_path_owned_by_current_uid(const char *path, struct strbuf *report)
+static inline int is_path_owned_by_current_uid(const char *path,
+					       struct strbuf *UNUSED(report))
 {
 	struct stat st;
 	uid_t euid;
-- 
2.37.2.928.g0821088f4a
