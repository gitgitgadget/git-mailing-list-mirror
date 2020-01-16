Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FAAC33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 18:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6551720684
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 18:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395469AbgAPSTn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:19:43 -0500
Received: from cloud.peff.net ([104.130.231.41]:38080 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2395346AbgAPSTm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 13:19:42 -0500
Received: (qmail 31638 invoked by uid 109); 16 Jan 2020 18:19:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 Jan 2020 18:19:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8422 invoked by uid 111); 16 Jan 2020 18:26:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2020 13:26:06 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Jan 2020 13:19:40 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] t7800: don't rely on reuse_worktree_file()
Message-ID: <20200116181940.GA2945961@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A test in t7800 tries to make sure that when git-difftool runs an
external tool that fails, it stops looking at files. Our fake failing
tool prints the file name it was asked to diff before exiting non-zero,
and then we confirm the output contains only that file.

However, this subtly relies on our internal reuse_worktree_file().
Because we're diffing between branches, the command run by difftool
might see:

  - the git-stored filename (e.g., "file"), if we decided that the
    working tree contents were up-to-date with the object in the index
    and HEAD, and we could reuse them

  - a temporary filename (e.g. "/tmp/abc123_file") if we had to dump the
    contents from the object database

If the latter case happens, then the test fails, because it's expecting
the string "file". I discovered this when debugging something unrelated
with reuse_worktree_file(). I _thought_ it should be able to be
triggered by a racy-git situation, but running:

  ./t7800-difftool.sh --stress --run=2,13

never seems to fail. However, by my reading of reuse_worktree_file(),
this would probably always fail under Cygwin, because it sets
NO_FAST_WORKING_DIRECTORY. At any rate, since reuse_worktree_file()
is meant to be an optimization that may or may not trigger, our test
should be robust either way.

Instead of checking the filename, let's just make sure we got a single
line of output (which would not be true if we continued after the first
failure).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7800-difftool.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 6bac9ed180..29b92907e2 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -125,15 +125,14 @@ test_expect_success 'difftool stops on error with --trust-exit-code' '
 	test_when_finished "rm -f for-diff .git/fail-right-file" &&
 	test_when_finished "git reset -- for-diff" &&
 	write_script .git/fail-right-file <<-\EOF &&
-	echo "$2"
+	echo failed
 	exit 1
 	EOF
 	>for-diff &&
 	git add for-diff &&
-	echo file >expect &&
 	test_must_fail git difftool -y --trust-exit-code \
 		--extcmd .git/fail-right-file branch >actual &&
-	test_cmp expect actual
+	test_line_count = 1 actual
 '
 
 test_expect_success 'difftool honors exit status if command not found' '
-- 
2.25.0.318.gee4019ba55
