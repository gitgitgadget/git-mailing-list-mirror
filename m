Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21951C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 06:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCIGHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 01:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCIGHw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 01:07:52 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68FADAB97
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 22:07:46 -0800 (PST)
Received: (qmail 6249 invoked by uid 109); 9 Mar 2023 06:07:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 06:07:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28303 invoked by uid 111); 9 Mar 2023 06:07:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 01:07:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 01:07:45 -0500
From:   Jeff King <peff@peff.net>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/5] t4013: add tests for diff prefix options
Message-ID: <ZAl3sZufzTb2FRP9@coredump.intra.peff.net>
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't have any specific test coverage of diff's various prefix
options. We do incidentally invoke them in a few places, but it's worth
having a more thorough set of tests that covers all of the effects we
expect to see, and that the options kick in at the appropriate times.

This will be especially useful as the next patch adds more options.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4013-diff-various.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index dfcf3a0aaae..0bc69579898 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -616,4 +616,36 @@ test_expect_success 'diff -I<regex>: detect malformed regex' '
 	test_i18ngrep "invalid regex given to -I: " error
 '
 
+# check_prefix <patch> <src> <dst>
+# check only lines with paths to avoid dependency on exact oid/contents
+check_prefix () {
+	grep -E '^(diff|---|\+\+\+) ' "$1" >actual.paths &&
+	cat >expect <<-EOF &&
+	diff --git $2 $3
+	--- $2
+	+++ $3
+	EOF
+	test_cmp expect actual.paths
+}
+
+test_expect_success 'diff-files does not respect diff.noprefix' '
+	git -c diff.noprefix diff-files -p >actual &&
+	check_prefix actual a/file0 b/file0
+'
+
+test_expect_success 'diff-files respects --no-prefix' '
+	git diff-files -p --no-prefix >actual &&
+	check_prefix actual file0 file0
+'
+
+test_expect_success 'diff respects diff.noprefix' '
+	git -c diff.noprefix diff >actual &&
+	check_prefix actual file0 file0
+'
+
+test_expect_success 'diff respects diff.mnemonicprefix' '
+	git -c diff.mnemonicprefix diff >actual &&
+	check_prefix actual i/file0 w/file0
+'
+
 test_done
-- 
2.40.0.rc2.537.g928a61c97db

