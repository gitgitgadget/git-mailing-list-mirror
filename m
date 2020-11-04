Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C227DC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B1F520780
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 13:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgKDNZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 08:25:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:47140 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729718AbgKDNZX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 08:25:23 -0500
Received: (qmail 9711 invoked by uid 109); 4 Nov 2020 13:25:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 13:25:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10143 invoked by uid 111); 4 Nov 2020 13:25:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 08:25:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 08:25:22 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Postler <johannes.postler@txture.io>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/3] format-patch: refactor output selection
Message-ID: <20201104132522.GA3030146@coredump.intra.peff.net>
References: <20201104132428.GA2491189@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104132428.GA2491189@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --stdout and --output-directory options are mutually exclusive, but
it's hard to tell from reading the code. We have three separate
conditionals that check for use_stdout, and it's only after we've set up
the output_directory fully that we check whether the user also specified
--stdout.

Instead, let's check the exclusion explicitly first, then have a single
conditional that handles stdout versus an output directory. This is
slightly easier to follow now, and also will keep things sane when we
add another output mode in a future patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 9f939e6cdf..4c391ba3ca 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1942,20 +1942,20 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.show_notes)
 		load_display_notes(&rev.notes_opt);
 
-	if (!output_directory && !use_stdout)
-		output_directory = config_output_directory;
+	if (use_stdout + !!output_directory > 1)
+		die(_("specify only one of --stdout, --output, and --output-directory"));
 
-	if (!use_stdout)
-		output_directory = set_outdir(prefix, output_directory);
-	else
+	if (use_stdout) {
 		setup_pager();
-
-	if (output_directory) {
+	} else {
 		int saved;
+
+		if (!output_directory)
+			output_directory = config_output_directory;
+		output_directory = set_outdir(prefix, output_directory);
+
 		if (rev.diffopt.use_color != GIT_COLOR_ALWAYS)
 			rev.diffopt.use_color = GIT_COLOR_NEVER;
-		if (use_stdout)
-			die(_("standard output, or directory, which one?"));
 		/*
 		 * We consider <outdir> as 'outside of gitdir', therefore avoid
 		 * applying adjust_shared_perm in s-c-l-d.
-- 
2.29.2.559.g8ec94df761

