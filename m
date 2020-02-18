Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD0BC34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F5D52064C
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 21:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgBRVkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 16:40:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:47324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726481AbgBRVkK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 16:40:10 -0500
Received: (qmail 20493 invoked by uid 109); 18 Feb 2020 21:40:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Feb 2020 21:40:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22821 invoked by uid 111); 18 Feb 2020 21:49:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Feb 2020 16:49:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Feb 2020 16:40:09 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] doc-diff: use single-colon rule in rendering Makefile
Message-ID: <20200218214009.GA53188@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When rendering the troff manpages to text via "man", we create an ad-hoc
Makefile and feed it to "make". The purpose here is two-fold:

  - reuse results from a prior interrupted render of the same tree

  - use make's -j option to build in parallel

But the second part doesn't seem to work (at least with my version of
GNU make, 4.2.1). It just runs one render at a time.

We use a double-colon "all" rule for each file, like:

  all:: foo
  foo:
    ...actual render recipe...
  all:: bar
  bar:
    ...actual render recipe...
  ...and so on...

And it's this double-colon that seems to inhibit the parallelism. We can
just switch to a regular single-colon rule. Even though we do have
multiple rules for "all" here, we don't have any recipe to execute for
"all" (we only care about triggering its dependencies), so the
distinction is irrelevant.

Signed-off-by: Jeff King <peff@peff.net>
---
This has been bugging me for a while. I'm not sure if it never worked
and I didn't notice, or if it changed in some version of make.

 Documentation/doc-diff | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 88a9b20168..1694300e50 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -127,7 +127,7 @@ generate_render_makefile () {
 	while read src
 	do
 		dst=$2/${src#$1/}
-		printf 'all:: %s\n' "$dst"
+		printf 'all: %s\n' "$dst"
 		printf '%s: %s\n' "$dst" "$src"
 		printf '\t@echo >&2 "  RENDER $(notdir $@)" && \\\n'
 		printf '\tmkdir -p $(dir $@) && \\\n'
-- 
2.25.1.795.g3fd338b409
