Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B921FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755801AbdC1TsG (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:48:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:53169 "EHLO cloud.peff.net"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1753948AbdC1TsF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:48:05 -0400
Received: (qmail 11816 invoked by uid 109); 28 Mar 2017 19:47:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:47:02 +0000
Received: (qmail 8187 invoked by uid 111); 28 Mar 2017 19:47:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:47:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:47:00 -0400
Date:   Tue, 28 Mar 2017 15:47:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 16/18] transport-helper: replace checked snprintf with
 xsnprintf
Message-ID: <20170328194700.yowtm7sg55loyhdg@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can use xsnprintf to do our truncation check with less
code. The error message isn't as specific, but the point is
that this isn't supposed to trigger in the first place
(because our buffer is big enough to handle any int).

Signed-off-by: Jeff King <peff@peff.net>
---
 transport-helper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index dc90a1fb7..36408046e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -347,14 +347,11 @@ static int set_helper_option(struct transport *transport,
 static void standard_options(struct transport *t)
 {
 	char buf[16];
-	int n;
 	int v = t->verbose;
 
 	set_helper_option(t, "progress", t->progress ? "true" : "false");
 
-	n = snprintf(buf, sizeof(buf), "%d", v + 1);
-	if (n >= sizeof(buf))
-		die("impossibly large verbosity value");
+	xsnprintf(buf, sizeof(buf), "%d", v + 1);
 	set_helper_option(t, "verbosity", buf);
 
 	switch (t->family) {
-- 
2.12.2.845.g55fcf8b10

