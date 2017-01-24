Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A545920A17
	for <e@80x24.org>; Tue, 24 Jan 2017 00:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750874AbdAXAia (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 19:38:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:43549 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbdAXAia (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 19:38:30 -0500
Received: (qmail 9433 invoked by uid 109); 24 Jan 2017 00:38:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 00:38:30 +0000
Received: (qmail 28074 invoked by uid 111); 24 Jan 2017 00:39:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Jan 2017 19:39:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jan 2017 19:38:27 -0500
Date:   Mon, 23 Jan 2017 19:38:27 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/12] for_each_alternate_ref: handle failure from
 real_pathdup()
Message-ID: <20170124003827.l2rimgitsyxsvtly@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In older versions of git, if real_path() failed to resolve
the alternate object store path, we would die() with an
error. However, since 4ac9006f8 (real_path: have callers use
real_pathdup and strbuf_realpath, 2016-12-12) we use the
real_pathdup() function, which may return NULL. Since we
don't check the return value, we can segfault.

This is hard to trigger in practice, since we check that the
path is accessible before creating the alternate_object_database
struct. But it could be removed racily, or we could see a
transient filesystem error.

We could restore the original behavior by switching back to
xstrdup(real_path()).  However, dying is probably not the
best option here. This whole function is best-effort
already; there might not even be a repository around the
shared objects at all. And if the alternate store has gone
away, there are no objects to show.

So let's just quietly return, as we would if we failed to
open "refs/", or if upload-pack failed to start, etc.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/transport.c b/transport.c
index c86ba2eb8..74d0e45bd 100644
--- a/transport.c
+++ b/transport.c
@@ -1215,6 +1215,8 @@ static int refs_from_alternate_cb(struct alternate_object_database *e,
 	struct alternate_refs_data *cb = data;
 
 	other = real_pathdup(e->path);
+	if (!other)
+		return 0;
 	len = strlen(other);
 
 	while (other[len-1] == '/')
-- 
2.11.0.765.g454d2182f

