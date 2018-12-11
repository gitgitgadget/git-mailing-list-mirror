Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C40020A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 10:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeLKKoX (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 05:44:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:37950 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726104AbeLKKoX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 05:44:23 -0500
Received: (qmail 14547 invoked by uid 109); 11 Dec 2018 10:44:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Dec 2018 10:44:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3957 invoked by uid 111); 11 Dec 2018 10:43:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 11 Dec 2018 05:43:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Dec 2018 05:43:58 -0500
Date:   Tue, 11 Dec 2018 05:43:58 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 2/3] parse_hide_refs_config: handle NULL section
Message-ID: <20181211104358.GB7233@sigill.intra.peff.net>
References: <20181211104236.GA6899@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181211104236.GA6899@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This helper function looks for config in two places: transfer.hiderefs,
or $section.hiderefs, where $section is passed in by the caller (and is
"uploadpack" or "receive", depending on the context).

In preparation for callers which do not even have that context (namely
the "git-serve" command), let's handle a NULL by looking only at
transfer.hiderefs (as opposed to segfaulting).

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index f9936355cd..099e91d9cc 100644
--- a/refs.c
+++ b/refs.c
@@ -1267,7 +1267,8 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 {
 	const char *key;
 	if (!strcmp("transfer.hiderefs", var) ||
-	    (!parse_config_key(var, section, NULL, NULL, &key) &&
+	    (section &&
+	     !parse_config_key(var, section, NULL, NULL, &key) &&
 	     !strcmp(key, "hiderefs"))) {
 		char *ref;
 		int len;
-- 
2.20.0.734.gb4f2c0d2be

