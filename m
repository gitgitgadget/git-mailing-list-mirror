Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB50AC433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 19:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B034E610C9
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 19:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbhJRTsJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 15:48:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:41162 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231542AbhJRTsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 15:48:09 -0400
Received: (qmail 3226 invoked by uid 109); 18 Oct 2021 19:45:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Oct 2021 19:45:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1632 invoked by uid 111); 18 Oct 2021 19:45:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Oct 2021 15:45:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Oct 2021 15:45:56 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] transport-helper: recognize "expecting report" error
 from send-pack
Message-ID: <YW3O9EYdHq4BhQqD@coredump.intra.peff.net>
References: <YW3MY6lAI5l+BOnP@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YW3MY6lAI5l+BOnP@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a transport helper pushes via send-pack, it passes --helper-status
to get a machine-readable status back for each ref. The previous commit
taught the send-pack code to hand back "error expecting report" if the
server did not send us the proper ref-status. And that's enough to cause
us to recognize that an error occurred for the ref and print something
sensible in our final status table.

But we do interpret these messages on the remote-helper side to turn
them back into REF_STATUS_* enum values.  Recognizing this token to turn
it back into REF_STATUS_EXPECTING_REPORT has two advantages:

  1. We now print exactly the same message in the human-readable (and
     machine-readable --porcelain) output for this situation whether the
     transport went through a helper (e.g., http) or not (e.g., ssh).

  2. If any code in the helper really cares about distinguishing
     EXPECT_REPORT from more generic error conditions, it could now do
     so. I didn't find any, so this is mostly future-proofing.

So this is mostly cosmetic for now, but it seems like the
least-surprising thing for the transport-helper code to be doing.

Signed-off-by: Jeff King <peff@peff.net>
---
Yes, the "else if" is not cuddled below. It matches the rest of the
existing if/else chain.

 t/t5541-http-push-smart.sh | 2 +-
 transport-helper.c         | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t5541-http-push-smart.sh b/t/t5541-http-push-smart.sh
index 9c61dccc24..8ca50f8b18 100755
--- a/t/t5541-http-push-smart.sh
+++ b/t/t5541-http-push-smart.sh
@@ -519,7 +519,7 @@ test_expect_success 'report error server does not provide ref status' '
 		rev-parse --verify refs/tags/will-fail &&
 	cat >expect <<-EOF &&
 	To $HTTPD_URL/smart/no_report
-	!	HEAD:refs/tags/will-fail	[remote rejected] (expecting report)
+	!	HEAD:refs/tags/will-fail	[remote failure] (remote failed to report status)
 	Done
 	EOF
 	test_cmp expect actual
diff --git a/transport-helper.c b/transport-helper.c
index e8dbdd1153..a0297b0986 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -845,6 +845,10 @@ static int push_update_ref_status(struct strbuf *buf,
 			forced = 1;
 			FREE_AND_NULL(msg);
 		}
+		else if (!strcmp(msg, "expecting report")) {
+			status = REF_STATUS_EXPECTING_REPORT;
+			FREE_AND_NULL(msg);
+		}
 	}
 
 	if (state->hint)
-- 
2.33.1.1223.g80c1dbe6e5
