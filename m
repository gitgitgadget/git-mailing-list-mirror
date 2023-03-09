Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F67FC6FD1F
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 06:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCIGLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 01:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCIGLv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 01:11:51 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC24C78CC
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 22:11:50 -0800 (PST)
Received: (qmail 6279 invoked by uid 109); 9 Mar 2023 06:11:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 06:11:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28338 invoked by uid 111); 9 Mar 2023 06:11:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 01:11:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 01:11:49 -0500
From:   Jeff King <peff@peff.net>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 4/5] format-patch: do not respect diff.noprefix
Message-ID: <ZAl4pZV08a6Bgoip@coredump.intra.peff.net>
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The output of format-patch respects diff.noprefix, but this usually ends
up being a hassle for people receiving the patch, as they have to
manually specify "-p0" in order to apply it.

I don't think there was any specific intention for it to behave this
way. The noprefix option is handled by git_diff_ui_config(), and
format-patch exists in a gray area between plumbing and porcelain.
People do look at the output, and we'd expect it to colorize things,
respect their choice of algorithm, and so on. But this particular option
creates problems for the receiver (in theory so does diff.mnemonicprefix,
but since we are always formatting commits, the mnemonic prefixes will
always be "a/" and "b/").

So let's disable it. The slight downsides are:

  - people who have set diff.noprefix presumably like to see their
    patches without prefixes. If they use format-patch to review their
    series, they'll see prefixes. On the other hand, it is probably a
    good idea for them to look at what will actually get sent out.

    We could try to play games here with "is stdout a tty", as we do for
    color. But that's not a completely reliable signal, and it's
    probably not worth the trouble. If you want to see the patch with
    the usual bells and whistles, then you are better off using "git
    log" or "git show".

  - if a project really does have a workflow that likes prefix-less
    patches, and the receiver is prepared to use "-p0", then the sender
    now has to manually say "--no-prefix" for each format-patch
    invocation. That doesn't seem _too_ terrible given that the receiver
    has to manually say "-p0" for each git-am invocation.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c           | 9 +++++++++
 t/t4014-format-patch.sh | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index a70fba198f9..eaf511aab86 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1085,6 +1085,15 @@ static int git_format_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	/*
+	 * ignore some porcelain config which would otherwise be parsed by
+	 * git_diff_ui_config(), via git_log_config(); we can't just avoid
+	 * diff_ui_config completely, because we do care about some ui options
+	 * like color.
+	 */
+	if (!strcmp(var, "diff.noprefix"))
+		return 0;
+
 	return git_log_config(var, value, cb);
 }
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index f3313b8c58f..f5a41fd47ed 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2386,4 +2386,9 @@ test_expect_success 'interdiff: solo-patch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format-patch does not respect diff.noprefix' '
+	git -c diff.noprefix format-patch -1 --stdout >actual &&
+	grep "^--- a/blorp" actual
+'
+
 test_done
-- 
2.40.0.rc2.537.g928a61c97db

