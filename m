Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA825C77B73
	for <git@archiver.kernel.org>; Fri, 19 May 2023 00:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjESAD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 20:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjESAD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 20:03:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63337E7A
        for <git@vger.kernel.org>; Thu, 18 May 2023 17:03:26 -0700 (PDT)
Received: (qmail 6087 invoked by uid 109); 19 May 2023 00:03:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 May 2023 00:03:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26636 invoked by uid 111); 19 May 2023 00:03:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 20:03:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 20:03:25 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] format-patch: free rev.message_id when exiting
Message-ID: <20230519000325.GA1975194@coredump.intra.peff.net>
References: <20230519000239.GA1975039@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230519000239.GA1975039@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We may allocate a message-id string via gen_message_id(), but we never
free it, causing a small leak. This can be demonstrated by running t9001
with a leak-checking build. The offending test is the one touched by
3ece9bf0f9 (send-email: clear the $message_id after validation,
2023-05-17), but the leak is much older than that. The test was simply
unlucky enough to trigger the leaking code path for the first time.

We can fix this by freeing the string at the end of the function. We can
also re-mark the test script as leak-free, effectively reverting
20bd08aefb (t9001: mark the script as no longer leak checker clean,
2023-05-17).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c         | 1 +
 t/t9001-send-email.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7d19578963..ab74760386 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2415,6 +2415,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	strbuf_release(&rdiff_title);
 	strbuf_release(&sprefix);
 	free(to_free);
+	free(rev.message_id);
 	if (rev.ref_message_ids)
 		string_list_clear(rev.ref_message_ids, 0);
 	free(rev.ref_message_ids);
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 2051103226..8d49eff91a 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -4,7 +4,7 @@ test_description='git send-email'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
-# no longer TEST_PASSES_SANITIZE_LEAK=true - format-patch --thread leaks
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # May be altered later in the test
-- 
2.41.0.rc0.359.g22664e20e7

