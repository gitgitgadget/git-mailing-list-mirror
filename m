Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C1EC433F5
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F89061247
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbhKSVCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 16:02:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:35288 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235504AbhKSVCi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 16:02:38 -0500
Received: (qmail 9156 invoked by uid 109); 19 Nov 2021 20:58:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Nov 2021 20:58:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18815 invoked by uid 111); 19 Nov 2021 20:58:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Nov 2021 15:58:56 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 19 Nov 2021 15:58:55 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH] fetch-pack: ignore SIGPIPE when writing to index-pack
Message-ID: <YZgQD3lrw4+i4EMd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching, we send the incoming pack to index-pack (or
unpack-objects) via the sideband demuxer. If index-pack hits an error
(e.g., because an object fails fsck), then it will die immediately. This
may cause us to get SIGPIPE on the fetch, as we're still trying to write
pack contents from the sideband demuxer (which is typically a thread,
and thus takes down the whole fetch process).

You can see this in action with:

  ./t5702-protocol-v2.sh --stress --run=59

which ends with (wrapped for readability):

  test_must_fail: died by signal 13: git -c protocol.version=2 \
    -c transfer.fsckobjects=1 -c fetch.uriprotocols=http,https \
    clone http://127.0.0.1:5708/smart/http_parent http_child
  not ok 59 - packfile-uri with transfer.fsckobjects fails on bad object

This is mostly cosmetic. The actual error of interest (in this case, the
object that failed the fsck check) comes from index-pack straight to
stderr, so the user still sees it. They _might_ even see fetch-pack
complaining about index-pack failing, because the main thread is racing
with the sideband-demuxer. But they'll definitely see the signal death
in the exit code, which is what the test is complaining about.

We can make this more predictable by just ignoring SIGPIPE. The sideband
demuxer uses write_or_die(), so it will notice and stop (gracefully,
because we hook die_routine() to exit just the thread). And during this
section we're not writing anywhere else where we'd be concerned about
SIGPIPE preventing us from wasting effort writing to nowhere.

Signed-off-by: Jeff King <peff@peff.net>
---
I wondered if the receive-pack side would have a similar problem, but
there I think it's accepting the input directly from the network. So the
client-side push may see a premature hangup. But there the SIGPIPE goes
to pack-objects (which is writing straight to the network), and the
parent send-pack/push process detects this; see the comment near the
"141" check at the end of send-pack.c:pack_objects().

I cc'd Jonathan because it's his test, but really I think that is just
luck. AFAICT this would be a problem for any fetch where
transfer.fsckObjects detects a problem.

 fetch-pack.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index a9604f35a3..8fe3a49c1c 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -25,6 +25,7 @@
 #include "shallow.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
+#include "sigchain.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -956,6 +957,8 @@ static int get_pack(struct fetch_pack_args *args,
 			strvec_push(index_pack_args, cmd.args.v[i]);
 	}
 
+	sigchain_push(SIGPIPE, SIG_IGN);
+
 	cmd.in = demux.out;
 	cmd.git_cmd = 1;
 	if (start_command(&cmd))
@@ -986,6 +989,8 @@ static int get_pack(struct fetch_pack_args *args,
 	if (use_sideband && finish_async(&demux))
 		die(_("error in sideband demultiplexer"));
 
+	sigchain_pop(SIGPIPE);
+
 	/*
 	 * Now that index-pack has succeeded, write the promisor file using the
 	 * obtained .keep filename if necessary
-- 
2.34.0.635.gde47f84164
