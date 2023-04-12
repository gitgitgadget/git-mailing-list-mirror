Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D733C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 09:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjDLJE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 05:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDLJE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 05:04:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714925FE5
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 02:04:25 -0700 (PDT)
Received: (qmail 19160 invoked by uid 109); 12 Apr 2023 09:04:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Apr 2023 09:04:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18166 invoked by uid 111); 12 Apr 2023 09:04:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Apr 2023 05:04:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 12 Apr 2023 05:04:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jonas Haag <jonas@lophus.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/7] t5512: stop using jgit for capabilities^{} test
Message-ID: <20230412090423.GA2187240@coredump.intra.peff.net>
References: <20230412062300.GA838367@coredump.intra.peff.net>
 <20230412063118.GC1681312@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412063118.GC1681312@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2023 at 02:31:18AM -0400, Jeff King wrote:

> Commit eb398797cd (connect: advertized capability is not a ref,
> 2016-09-09) added support for an upload-pack server responding with:
> 
>   0000000000000000000000000000000000000000        capabilities^{}
> 
> followed by a NUL and capabilities. This is not something Git itself has
> ever produced for upload-pack, but JGit does. And hence the test used
> JGit to reproduce the real-world situation. That was good for verifying
> that the incompatibility was fixed, but it's a lousy regression test for
> a few reasons:
> 
>   - hardly anybody runs it, because you have to have jgit installed
> 
>   - we're depending on jgit's behavior for the test to do anything
>     useful. In particular, this behavior is only relevant to the v0
>     protocol, but these days we ask for the v2 protocol by default. So
>     for modern jgit, this is probably testing nothing.

I was worried that changing this one might be churn. But as it turns
out, it reveals that there's a bug in the code which we've been missing
all this time because nobody was running the test!

When run with GIT_TEST_DEFAULT_HASH=sha256, this will fail because the
code uses the local idea of the hash algorithm, rather than what the
other side advertises. We have a linux-sha256 CI job, but of course it
didn't have jgit installed, so it always skipped this test (until my
patch, where it now reveals the bug).

The fix is just:

diff --git a/connect.c b/connect.c
index 66397cc911..c54adc652f 100644
--- a/connect.c
+++ b/connect.c
@@ -263,7 +263,8 @@ static int process_dummy_ref(const struct packet_reader *reader)
 		return 0;
 	name++;
 
-	return oideq(null_oid(), &oid) && !strcmp(name, "capabilities^{}");
+	return oideq(reader->hash_algo->null_oid, &oid) &&
+		!strcmp(name, "capabilities^{}");
 }
 
 static void check_no_capabilities(const char *line, int len)

I'll squash that in and update the commit message before I do the next
re-roll (but will still hold off a bit to get further comments).

-Peff
