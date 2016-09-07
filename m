Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F089D20705
	for <e@80x24.org>; Wed,  7 Sep 2016 07:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756589AbcIGHyP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 03:54:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:39158 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756482AbcIGHyO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 03:54:14 -0400
Received: (qmail 8789 invoked by uid 109); 7 Sep 2016 07:54:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 07:54:13 +0000
Received: (qmail 1121 invoked by uid 111); 7 Sep 2016 07:54:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 07 Sep 2016 03:54:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Sep 2016 03:54:11 -0400
Date:   Wed, 7 Sep 2016 03:54:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>
Subject: [PATCH 1/2] patch-ids: turn off rename detection
Message-ID: <20160907075411.cr67cbvmy7gxv2om@sigill.intra.peff.net>
References: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160907075346.z6wtmqnfc6bsunjb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patch-id code may be running inside another porcelain
like "git log" or "git format-patch", and therefore may have
set diff_detect_rename_default, either via the diff-ui
config, or by default since 5404c11 (diff: activate
diff.renames by default, 2016-02-25). This is the case even
if a command is run with `--no-renames`, as that is applied
only to the diff-options used by the command itself.

Rename detection doesn't help the patch-id results. It
_may_ actually hurt, as minor differences in the files that
would be overlooked by patch-id's canonicalization might
result in different renames (though I'd doubt that it ever
comes up in practice).

But mostly it is just a waste of CPU to compute these
renames.

Note that we don't have to worry about compatibility here.
This patch disables renames just for the internal patch-id
comparison run by "log --cherry-pick", etc. The user-visible
"git patch-id" output depends on the patch that it is fed
(so it is up to the diff generator to use --no-renames if
they wish).

Signed-off-by: Jeff King <peff@peff.net>
---
 patch-ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/patch-ids.c b/patch-ids.c
index 082412a..77e4663 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -45,6 +45,7 @@ int init_patch_ids(struct patch_ids *ids)
 {
 	memset(ids, 0, sizeof(*ids));
 	diff_setup(&ids->diffopts);
+	ids->diffopts.detect_rename = 0;
 	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
 	diff_setup_done(&ids->diffopts);
 	hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp, 256);
-- 
2.10.0.rc2.154.gb4a4b8b

