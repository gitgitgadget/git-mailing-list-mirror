Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0ACBEE49A0
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjHUUQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHUUQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:16:29 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3574ABE
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:16:28 -0700 (PDT)
Received: (qmail 17355 invoked by uid 109); 21 Aug 2023 20:16:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Aug 2023 20:16:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18646 invoked by uid 111); 21 Aug 2023 20:16:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Aug 2023 16:16:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Aug 2023 16:16:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Romain Chossart <romainchossart@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2 3/7] diff: show usage for unknown builtin_diff_files()
 options
Message-ID: <20230821201626.GC1798590@coredump.intra.peff.net>
References: <20230821201358.GA2663749@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821201358.GA2663749@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-diff command has many modes (comparing worktree to index, index
to HEAD, individual blobs, etc). As a result, it dispatches to many
helper functions and cannot completely parse its options until we're in
those helper functions.

Most of them, when seeing an unknown option, exit immediately by calling
usage(). But builtin_diff_files(), which is the default if no revision
or blob arguments are given, instead prints an error() and returns -1.

One obvious shortcoming here is that the user doesn't get to see the
usual usage message. But there's a much more important bug: the -1
return is fed to diff_result_code(), which is not ready to handle it.
By default, it passes the code along as an exit code. We try to avoid
negative exit codes because they get converted to unsigned values, but
it should at least consistently show up as non-zero (i.e., a failure).

But much worse is that when --exit-code is in effect, diff_result_code()
will _ignore_ the status passed in by the caller, and instead only
report on whether the diff found changes. It didn't, of course, because
we never ran the diff, and the program unexpectedly exits with success!

We can fix this bug by just calling usage(), like the other helpers do.
Another option would of course be to teach diff_result_code() to handle
this value. But as we'll see in the next few patches, it can be cleaned
up even further. Let's just fix this bug directly to start with.

Reported-by: Romain Chossart <romainchossart@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/diff.c         | 6 ++++--
 t/t4017-diff-retval.sh | 5 +++++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index b19530c996..d0e187ec18 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -269,8 +269,10 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 			options |= DIFF_SILENT_ON_REMOVED;
 		else if (!strcmp(argv[1], "-h"))
 			usage(builtin_diff_usage);
-		else
-			return error(_("invalid option: %s"), argv[1]);
+		else {
+			error(_("invalid option: %s"), argv[1]);
+			usage(builtin_diff_usage);
+		}
 		argv++; argc--;
 	}
 
diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 5bc28ad9f0..f439f469bd 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -138,4 +138,9 @@ test_expect_success 'check honors conflict marker length' '
 	git reset --hard
 '
 
+test_expect_success 'option errors are not confused by --exit-code' '
+	test_must_fail git diff --exit-code --nonsense 2>err &&
+	grep '^usage:' err
+'
+
 test_done
-- 
2.42.0.rc2.423.g967ecb4f2b

