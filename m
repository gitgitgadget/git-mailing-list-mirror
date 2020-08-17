Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBABDC433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D10C620738
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgHQVdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:33:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:33590 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728445AbgHQVdP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 17:33:15 -0400
Received: (qmail 6730 invoked by uid 109); 17 Aug 2020 21:33:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2020 21:33:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22310 invoked by uid 111); 17 Aug 2020 21:33:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2020 17:33:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Aug 2020 17:33:13 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 6/7] config: fix leak in git_config_get_expiry_in_days()
Message-ID: <20200817213313.GF1854722@coredump.intra.peff.net>
References: <20200817213228.GA1854603@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817213228.GA1854603@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use git_config_get_string() to retrieve the expiry value in a newly
allocated string. But after parsing it, we never free it, leaking the
memory.

We could fix this with a free() obviously, but there's an even better
solution: we can use the non-allocating "tmp" variant of the function;
we only need it to be valid for the lifetime of our parse function.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index f0367c76ad..2bdff4457b 100644
--- a/config.c
+++ b/config.c
@@ -2300,11 +2300,11 @@ int git_config_get_expiry(const char *key, const char **output)
 
 int git_config_get_expiry_in_days(const char *key, timestamp_t *expiry, timestamp_t now)
 {
-	char *expiry_string;
+	const char *expiry_string;
 	intmax_t days;
 	timestamp_t when;
 
-	if (git_config_get_string(key, &expiry_string))
+	if (git_config_get_string_tmp(key, &expiry_string))
 		return 1; /* no such thing */
 
 	if (git_parse_signed(expiry_string, &days, maximum_signed_value_of_type(int))) {
-- 
2.28.0.605.g35fde94f44

