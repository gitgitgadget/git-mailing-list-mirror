Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B643020A17
	for <e@80x24.org>; Tue, 24 Jan 2017 00:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751003AbdAXApD (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 19:45:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:43564 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbdAXApD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 19:45:03 -0500
Received: (qmail 9867 invoked by uid 109); 24 Jan 2017 00:45:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 24 Jan 2017 00:45:03 +0000
Received: (qmail 29656 invoked by uid 111); 24 Jan 2017 00:45:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Jan 2017 19:45:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jan 2017 19:45:01 -0500
Date:   Mon, 23 Jan 2017 19:45:01 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 06/12] clone: disable save_commit_buffer
Message-ID: <20170124004500.v7geae55w6zeax7m@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally git caches the raw commit object contents in
"struct commit". This makes it fast to run parse_commit()
followed by a pretty-print operation.

For commands which don't actually pretty-print the commits,
the caching is wasteful (and may use quite a lot of memory
if git accesses a large number of commits).

For fetching operations like clone, we already disable
save_commit_buffer in everything_local(), where we may
traverse. But clone also parses commits before it even gets
there; it looks at commits reachable from its refs, and from
alternate refs.

In one real-world case with a large number of tags, this
cut about 10MB off of clone's heap usage. Not spectacular,
but there's really no downside.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/clone.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5ef81927a..3fca45e7e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -858,6 +858,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	struct refspec *refspec;
 	const char *fetch_pattern;
 
+	save_commit_buffer = 0;
 	packet_trace_identity("clone");
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
-- 
2.11.0.765.g454d2182f

