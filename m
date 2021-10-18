Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C41AFC433F5
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A210B61263
	for <git@archiver.kernel.org>; Mon, 18 Oct 2021 17:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhJRRRv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Oct 2021 13:17:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:41020 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231739AbhJRRRu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Oct 2021 13:17:50 -0400
Received: (qmail 2875 invoked by uid 109); 18 Oct 2021 17:15:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Oct 2021 17:15:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32593 invoked by uid 111); 18 Oct 2021 17:15:38 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Oct 2021 13:15:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Oct 2021 13:15:37 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH 2/2] gpg-interface: fix leak of strbufs in
 get_ssh_key_fingerprint()
Message-ID: <YW2ruTL2XReEeIAh@coredump.intra.peff.net>
References: <YW2qpuosxr9PNwVa@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YW2qpuosxr9PNwVa@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We read stdout from gpg into a strbuf, then split it into a list of
strbufs, pull out one element, and return it. But we don't free either
the original stdout buffer, nor the list returned from strbuf_split().

This patch fixes both. Note that we have to detach the returned string
from its strbuf before calling strbuf_list_free(), as that would
otherwise throw it away.

Signed-off-by: Jeff King <peff@peff.net>
---
 gpg-interface.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index c60b9cd19d..800d8caa67 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -711,6 +711,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 	int ret = -1;
 	struct strbuf fingerprint_stdout = STRBUF_INIT;
 	struct strbuf **fingerprint;
+	char *fingerprint_ret;
 
 	/*
 	 * With SSH Signing this can contain a filename or a public key
@@ -737,7 +738,10 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
 		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
 			  signing_key);
 
-	return strbuf_detach(fingerprint[1], NULL);
+	fingerprint_ret = strbuf_detach(fingerprint[1], NULL);
+	strbuf_list_free(fingerprint);
+	strbuf_release(&fingerprint_stdout);
+	return fingerprint_ret;
 }
 
 /* Returns the first public key from an ssh-agent to use for signing */
-- 
2.33.1.1223.g80c1dbe6e5
