Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63BDC2BB85
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02892087E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 19:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDJTor (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:44:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:40072 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726142AbgDJTop (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 15:44:45 -0400
Received: (qmail 7640 invoked by uid 109); 10 Apr 2020 19:44:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 19:44:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2228 invoked by uid 111); 10 Apr 2020 19:55:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Apr 2020 15:55:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Apr 2020 15:44:45 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/6] config: drop useless length variable in write_pair()
Message-ID: <20200410194445.GC1363756@coredump.intra.peff.net>
References: <20200410194211.GA1363484@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200410194211.GA1363484@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We compute the length of a subset of a string, but then use that length
only to feed a "%.*s" printf placeholder for the same string. We can
just use "%s" to achieve the same thing.

The variable became useless in cb891a5989 (Use a strbuf for building up
section header and key/value pair strings., 2007-12-14), which swapped
out a write() which _did_ use the length for a strbuf_addf() call.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/config.c b/config.c
index ff7998df46..7ea588a7e0 100644
--- a/config.c
+++ b/config.c
@@ -2545,7 +2545,6 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
 {
 	int i;
 	ssize_t ret;
-	int length = strlen(key + store->baselen + 1);
 	const char *quote = "";
 	struct strbuf sb = STRBUF_INIT;
 
@@ -2564,8 +2563,7 @@ static ssize_t write_pair(int fd, const char *key, const char *value,
 	if (i && value[i - 1] == ' ')
 		quote = "\"";
 
-	strbuf_addf(&sb, "\t%.*s = %s",
-		    length, key + store->baselen + 1, quote);
+	strbuf_addf(&sb, "\t%s = %s", key + store->baselen + 1, quote);
 
 	for (i = 0; value[i]; i++)
 		switch (value[i]) {
-- 
2.26.0.414.ge3a6455e3d

