Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A56C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E561820738
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 21:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgHQVdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:33:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:33596 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbgHQVdR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 17:33:17 -0400
Received: (qmail 6741 invoked by uid 109); 17 Aug 2020 21:33:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2020 21:33:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22315 invoked by uid 111); 17 Aug 2020 21:33:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2020 17:33:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Aug 2020 17:33:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 7/7] submodule--helper: fix leak of core.worktree value
Message-ID: <20200817213316.GG1854722@coredump.intra.peff.net>
References: <20200817213228.GA1854603@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817213228.GA1854603@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the ensure_core_worktree() function, we load the core.worktree value
of the submodule repository using repo_config_get_string(). This
function copies the string, but we never free it, leaking the memory.

We can instead use the "tmp" version of that function to avoid the
allocation at all. We don't have to worry about lifetime issues, since
we never even look at the value (we just want to know if it's set).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index e09605716e..a59d8e4bda 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2101,7 +2101,7 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 {
 	const struct submodule *sub;
 	const char *path;
-	char *cw;
+	const char *cw;
 	struct repository subrepo;
 
 	if (argc != 2)
@@ -2116,7 +2116,7 @@ static int ensure_core_worktree(int argc, const char **argv, const char *prefix)
 	if (repo_submodule_init(&subrepo, the_repository, sub))
 		die(_("could not get a repository handle for submodule '%s'"), path);
 
-	if (!repo_config_get_string(&subrepo, "core.worktree", &cw)) {
+	if (!repo_config_get_string_tmp(&subrepo, "core.worktree", &cw)) {
 		char *cfg_file, *abs_path;
 		const char *rel_path;
 		struct strbuf sb = STRBUF_INIT;
-- 
2.28.0.605.g35fde94f44
