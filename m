Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CCA61FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755722AbdC1Tqc (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:46:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:53159 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755676AbdC1Tq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:46:29 -0400
Received: (qmail 11786 invoked by uid 109); 28 Mar 2017 19:46:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:46:28 +0000
Received: (qmail 5098 invoked by uid 111); 28 Mar 2017 19:46:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:46:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:46:26 -0400
Date:   Tue, 28 Mar 2017 15:46:26 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/18] fetch: use heap buffer to format reflog
Message-ID: <20170328194626.umvxdr6s6z3anzrj@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Part of the reflog content comes from the environment, which
can be much larger than our fixed buffer. Let's use a heap
buffer so we avoid truncating it.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b5ad09d04..4ef7a08af 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -421,7 +421,7 @@ static int s_update_ref(const char *action,
 			struct ref *ref,
 			int check_old)
 {
-	char msg[1024];
+	char *msg;
 	char *rla = getenv("GIT_REFLOG_ACTION");
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -431,7 +431,7 @@ static int s_update_ref(const char *action,
 		return 0;
 	if (!rla)
 		rla = default_rla.buf;
-	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
+	msg = xstrfmt("%s: %s", rla, action);
 
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
@@ -449,11 +449,13 @@ static int s_update_ref(const char *action,
 
 	ref_transaction_free(transaction);
 	strbuf_release(&err);
+	free(msg);
 	return 0;
 fail:
 	ref_transaction_free(transaction);
 	error("%s", err.buf);
 	strbuf_release(&err);
+	free(msg);
 	return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
 			   : STORE_REF_ERROR_OTHER;
 }
-- 
2.12.2.845.g55fcf8b10

