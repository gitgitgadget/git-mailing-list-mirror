Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A89C388F7
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 02:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F326921D91
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 02:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732372AbgKKCfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 21:35:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:53874 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732023AbgKKCfu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 21:35:50 -0500
Received: (qmail 10313 invoked by uid 109); 11 Nov 2020 02:35:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Nov 2020 02:35:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11762 invoked by uid 111); 11 Nov 2020 02:35:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 21:35:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 21:35:49 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 9/9] add -i: verify in the tests that colors can be
 overridden
Message-ID: <20201111023549.GB806755@coredump.intra.peff.net>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com>
 <38355ec98f04783367d74e38cda3ce5d6632c7ac.1605051739.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38355ec98f04783367d74e38cda3ce5d6632c7ac.1605051739.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 10, 2020 at 11:42:19PM +0000, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Now that the Perl version produces the same output as the built-in
> version (mostly fixing bugs in the latter), let's add a regression test
> to verify that it stays this way.
> 
> Note that we only `grep` for the colored error message instead of
> verifying that the entire `stderr` consists of just this one line: when
> running the test script via `dash`, using the `-x` option to trace the
> commands, the sub-shell in `force_color` causes those commands to be
> traced into `err.raw` because we set, but do not export
> `BASH_XTRACEFD`).

Your reasoning here confuses me. If we are using dash, then surely
BASH_XTRACEFD does not matter either way? Perhaps the subshell is
important if we are running bash, though.

Either way, being forgiving to the use of "-x" is a nice convenience and
I approve.

> +test_expect_success 'colors can be overridden' '
> +	test_config color.interactive.header red &&
> +	test_config color.interactive.help green &&
> +	test_config color.interactive.prompt yellow &&
> +	test_config color.interactive.error blue &&
> +	test_config color.diff.frag magenta &&
> +	test_config color.diff.context cyan &&
> +	test_config color.diff.old bold &&
> +	test_config color.diff.new "bold red" &&

Since you are being so thorough, and since it is already in the output,
maybe color color.diff.meta, too? Like:

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 28549a41a2..cca866c8f4 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -594,6 +594,7 @@ test_expect_success 'colors can be overridden' '
 	test_config color.interactive.help green &&
 	test_config color.interactive.prompt yellow &&
 	test_config color.interactive.error blue &&
+	test_config color.diff.meta italic &&
 	test_config color.diff.frag magenta &&
 	test_config color.diff.context cyan &&
 	test_config color.diff.old bold &&
@@ -625,9 +626,9 @@ test_expect_success 'colors can be overridden' '
 	  1:        +3/-0        +1/-1 <YELLOW>c<RESET>olor-test
 	<YELLOW>Patch update<RESET>>> <RED>           staged     unstaged path<RESET>
 	* 1:        +3/-0        +1/-1 <YELLOW>c<RESET>olor-test
-	<YELLOW>Patch update<RESET>>> <BOLD>diff --git a/color-test b/color-test<RESET>
-	<BOLD>--- a/color-test<RESET>
-	<BOLD>+++ b/color-test<RESET>
+	<YELLOW>Patch update<RESET>>> <ITALIC>diff --git a/color-test b/color-test<RESET>
+	<ITALIC>--- a/color-test<RESET>
+	<ITALIC>+++ b/color-test<RESET>
 	<MAGENTA>@@ -1,3 +1,3 @@<RESET>
 	<CYAN> context<RESET>
 	<BOLD>-old<RESET>

-Peff
