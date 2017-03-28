Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1434E1FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755858AbdC1TrR (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:47:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:53163 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755801AbdC1TrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:47:16 -0400
Received: (qmail 11798 invoked by uid 109); 28 Mar 2017 19:46:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:46:43 +0000
Received: (qmail 6400 invoked by uid 111); 28 Mar 2017 19:46:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:46:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:46:40 -0400
Date:   Tue, 28 Mar 2017 15:46:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 10/18] create_branch: use xstrfmt for reflog message
Message-ID: <20170328194640.i5tp5sa374i56cuv@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We generate a reflog message that contains some fixed text
plus a branch name, and use a buffer of size PATH_MAX + 20.
This mostly works if you assume that refnames are shorter
than PATH_MAX, but:

  1. That's not necessarily true. PATH_MAX is not always the
     filesystem's limit.

  2. The "20" is not sufficiently large for the fixed text
     anyway.

Let's just switch to a heap buffer so we don't have to even
care.

Signed-off-by: Jeff King <peff@peff.net>
---
 branch.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/branch.c b/branch.c
index 6d0ca94cc..ad5a2299b 100644
--- a/branch.c
+++ b/branch.c
@@ -296,14 +296,12 @@ void create_branch(const char *name, const char *start_name,
 	if (!dont_change_ref) {
 		struct ref_transaction *transaction;
 		struct strbuf err = STRBUF_INIT;
-		char msg[PATH_MAX + 20];
+		char *msg;
 
 		if (forcing)
-			snprintf(msg, sizeof msg, "branch: Reset to %s",
-				 start_name);
+			msg = xstrfmt("branch: Reset to %s", start_name);
 		else
-			snprintf(msg, sizeof msg, "branch: Created from %s",
-				 start_name);
+			msg = xstrfmt("branch: Created from %s", start_name);
 
 		transaction = ref_transaction_begin(&err);
 		if (!transaction ||
@@ -314,6 +312,7 @@ void create_branch(const char *name, const char *start_name,
 			die("%s", err.buf);
 		ref_transaction_free(transaction);
 		strbuf_release(&err);
+		free(msg);
 	}
 
 	if (real_ref && track)
-- 
2.12.2.845.g55fcf8b10

