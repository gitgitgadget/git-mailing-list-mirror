Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE89CD37B0
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 22:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjIRW3r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 18:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjIRW3q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 18:29:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8A18F
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 15:29:41 -0700 (PDT)
Received: (qmail 12953 invoked by uid 109); 18 Sep 2023 22:29:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 18 Sep 2023 22:29:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4684 invoked by uid 111); 18 Sep 2023 22:29:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 Sep 2023 18:29:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 18 Sep 2023 18:29:40 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: [PATCH 1/8] fsmonitor: prefer repo_git_path() to git_pathdup()
Message-ID: <20230918222940.GA2659298@coredump.intra.peff.net>
References: <20230918222908.GA2659096@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918222908.GA2659096@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fsmonitor_ipc__get_path() function ignores its repository argument.
It should use it when constructing repo paths (though in practice, it is
unlikely anything but the_repository is ever passed, so this is cleanup
and future proofing, not a bug fix).

Note that despite the lack of "dup" in the name, repo_git_path() behaves
like git_pathdup() and returns an allocated string.

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/fsmonitor/fsm-ipc-win32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/fsmonitor/fsm-ipc-win32.c b/compat/fsmonitor/fsm-ipc-win32.c
index 8928fa93ce..41984ea48e 100644
--- a/compat/fsmonitor/fsm-ipc-win32.c
+++ b/compat/fsmonitor/fsm-ipc-win32.c
@@ -6,6 +6,6 @@
 const char *fsmonitor_ipc__get_path(struct repository *r) {
 	static char *ret;
 	if (!ret)
-		ret = git_pathdup("fsmonitor--daemon.ipc");
+		ret = repo_git_path(r, "fsmonitor--daemon.ipc");
 	return ret;
 }
-- 
2.42.0.671.g43fbf3903a

