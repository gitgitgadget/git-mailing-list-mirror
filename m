Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CCBA1FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 15:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbdC1Pht (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 11:37:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:52944 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbdC1Phs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 11:37:48 -0400
Received: (qmail 29093 invoked by uid 109); 28 Mar 2017 15:37:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:37:47 +0000
Received: (qmail 16317 invoked by uid 111); 28 Mar 2017 15:38:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 11:38:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 11:37:45 -0400
Date:   Tue, 28 Mar 2017 11:37:45 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 1/2] read-cache: skip index SHA verification
Message-ID: <20170328153745.yi5fb5kkfa27q36o@sigill.intra.peff.net>
References: <1490648979-49580-1-git-send-email-git@jeffhostetler.com>
 <1490648979-49580-2-git-send-email-git@jeffhostetler.com>
 <20170327224408.2bzh5vfa6deni6fm@sigill.intra.peff.net>
 <7b40fea5-8843-b95b-5ea5-c8035ea8a36e@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b40fea5-8843-b95b-5ea5-c8035ea8a36e@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 11:27:19AM -0400, Jeff Hostetler wrote:

> > Hrm, there shouldn't be any dependency of the config on the index (and
> > there are a handful of options which impact the index already). Did you
> > try it and run into problems?
> 
> Yeah, I tried adding a new "core.verifyindex" property and the
> corresponding global variable.  But read_index() and verify_hdr()
> was being called BEFORE the config was loaded.  And it wasn't clear
> how best to solve that.
> 
> The issue was in "git status" where cmd_status() called
> status_init_config() which called gitmodules_config() before
> git_config().  but gitmodules_config() called read_index(),
> so my settings weren't loaded yet in verify_hdr().

Ugh, yeah, the callback-oriented interface suffers from these kind of
dependency cycles. You can fix it by doing a limited "basic config that
should always be loaded" git_config() call before anything else, and
then following up with the application-level config.

For something low-level that should _always_ be respected, even in
plumbing programs, I think we're better off lazy-loading the config
inside the function. The configset cache makes them more or less free.

I.e., something like:

diff --git a/read-cache.c b/read-cache.c
index e44775182..89bbf8d1e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1376,17 +1376,23 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	git_SHA_CTX c;
 	unsigned char sha1[20];
 	int hdr_version;
+	int do_checksum = 0;
 
 	if (hdr->hdr_signature != htonl(CACHE_SIGNATURE))
 		return error("bad signature");
 	hdr_version = ntohl(hdr->hdr_version);
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
 		return error("bad index version %d", hdr_version);
-	git_SHA1_Init(&c);
-	git_SHA1_Update(&c, hdr, size - 20);
-	git_SHA1_Final(sha1, &c);
-	if (hashcmp(sha1, (unsigned char *)hdr + size - 20))
-		return error("bad index file sha1 signature");
+
+	git_config_get_bool("core.checksumindex", &do_checksum);
+	if (do_checksum) {
+		git_SHA1_Init(&c);
+		git_SHA1_Update(&c, hdr, size - 20);
+		git_SHA1_Final(sha1, &c);
+		if (hashcmp(sha1, (unsigned char *)hdr + size - 20))
+			return error("bad index file sha1 signature");
+	}
+
 	return 0;
 }

-Peff
