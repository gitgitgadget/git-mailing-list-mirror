Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B074C2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 19:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11A9205ED
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 19:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgKDT2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:28:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:47738 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgKDT2d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 14:28:33 -0500
Received: (qmail 10945 invoked by uid 109); 4 Nov 2020 19:28:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Nov 2020 19:28:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13925 invoked by uid 111); 4 Nov 2020 19:28:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Nov 2020 14:28:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 4 Nov 2020 14:28:31 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Postler <johannes.postler@txture.io>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: [PATCH v2 1/3] format-patch: refactor output selection
Message-ID: <20201104192831.GA3060275@coredump.intra.peff.net>
References: <20201104192645.GA3059114@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201104192645.GA3059114@coredump.intra.peff.net>
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

We'll add a few tests as well, covering the mutual exclusion and the
fact that we are not confused by a configured output directory.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c           | 18 +++++++++---------
 t/t4014-format-patch.sh | 13 +++++++++++++
 2 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 9f939e6cdf..fbff5493d2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1942,20 +1942,20 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (rev.show_notes)
 		load_display_notes(&rev.notes_opt);
 
-	if (!output_directory && !use_stdout)
-		output_directory = config_output_directory;
+	if (use_stdout + !!output_directory > 1)
+		die(_("--stdout and --output-directory are mutually exclusive"));
 
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
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 294e76c860..e8d6156a6a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1919,6 +1919,19 @@ test_expect_success 'format-patch -o overrides format.outputDirectory' '
 	test_path_is_dir patchset
 '
 
+test_expect_success 'format-patch forbids multiple outputs' '
+	rm -fr outdir &&
+	test_must_fail \
+		git format-patch --stdout --output-directory=outdir
+'
+
+test_expect_success 'configured outdir does not conflict with output options' '
+	rm -fr outdir &&
+	test_config format.outputDirectory outdir &&
+	git format-patch --stdout &&
+	test_path_is_missing outdir
+'
+
 test_expect_success 'format-patch --base' '
 	git checkout patchid &&
 
-- 
2.29.2.559.g8ec94df761

