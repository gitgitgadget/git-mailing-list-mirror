Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D127BC33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBDE206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgAaJ5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:57:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:49386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728224AbgAaJ5u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 04:57:50 -0500
Received: (qmail 13390 invoked by uid 109); 31 Jan 2020 09:57:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Jan 2020 09:57:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30624 invoked by uid 111); 31 Jan 2020 10:05:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2020 05:05:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jan 2020 04:57:49 -0500
From:   Jeff King <peff@peff.net>
To:     Mike McGranahan <mike@mcgwiz.com>
Cc:     git@vger.kernel.org
Subject: [PATCH] diff: move diff.wsErrorHighlight to "basic" config
Message-ID: <20200131095749.GB2916051@coredump.intra.peff.net>
References: <CAK7jxYgJNvCp=m6rH31HNzN9Mqgaav7_YPvUMZmRb7mdYDZ_1g@mail.gmail.com>
 <20200131091917.GC2857810@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200131091917.GC2857810@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 31, 2020 at 04:19:17AM -0500, Jeff King wrote:

> All that said, I kind of wonder if diff.wsErrorHighlight ought to be
> respected by even plumbing commands. After all, it does nothing unless
> color is enabled anyway, so I don't think it runs the risk of confusing
> a user of the plumbing. It's no different than color.diff.*, which we
> respect even in the plumbing commands (if the caller has manually asked
> for color, of course).

The more I pondered this, the more it seems like the right thing. So
here's a patch to do it.

I also suspect that some of the color-moved config would benefit from
the same treatment, but I haven't yet convinced myself. Unlike this
option, which impacts a single line, the move detection covers multiple
hunks, which you'd be picking out independently. Would that be weird, or
would it make sense as it's just annotating the existing diff?

-- >8 --
Subject: [PATCH] diff: move diff.wsErrorHighlight to "basic" config

We parse diff.wsErrorHighlight in git_diff_ui_config(), meaning that it
doesn't take effect for plumbing commands, only for porcelains like
git-diff itself. This is mildly annoying as it means scripts like
add--interactive, which produce a user-visible diff with color, don't
respect the option.

We could teach that script to parse the config and pass it along as
--ws-error-highlight to the diff plumbing. But there's a simpler
solution.

It should be reasonably safe for plumbing to respect this option, as it
only kicks in when color is otherwise enabled. And anybody parsing
colorized output must already deal with the fact that color.diff.* may
change the exact output they see; those options have been part of
git_diff_basic_config() since its inception in 9a1805a872 (add a "basic"
diff config callback, 2008-01-04).

So we can just move it to the "basic" config, which fixes
add--interactive, along with any other script in the same boat, with a
very low risk of hurting any plumbing users.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c                     | 16 ++++++++--------
 t/t3701-add-interactive.sh | 13 +++++++++++++
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 8e2914c031..5e4471f15f 100644
--- a/diff.c
+++ b/diff.c
@@ -414,14 +414,6 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (!strcmp(var, "diff.wserrorhighlight")) {
-		int val = parse_ws_error_highlight(value);
-		if (val < 0)
-			return -1;
-		ws_error_highlight_default = val;
-		return 0;
-	}
-
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
@@ -450,6 +442,14 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 		return color_parse(value, diff_colors[slot]);
 	}
 
+	if (!strcmp(var, "diff.wserrorhighlight")) {
+		int val = parse_ws_error_highlight(value);
+		if (val < 0)
+			return -1;
+		ws_error_highlight_default = val;
+		return 0;
+	}
+
 	/* like GNU diff's --suppress-blank-empty option  */
 	if (!strcmp(var, "diff.suppressblankempty") ||
 			/* for backwards compatibility */
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 2182b1c030..a28182c526 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -553,6 +553,19 @@ test_expect_success 'diffs can be colorized' '
 	grep "$(printf "\\033")" output
 '
 
+test_expect_success 'colorized diffs respect diff.wsErrorHighlight' '
+	git reset --hard &&
+
+	echo "old " >test &&
+	git add test &&
+	echo "new " >test &&
+
+	printf y >y &&
+	force_color git -c diff.wsErrorHighlight=all add -p >output.raw 2>&1 <y &&
+	test_decode_color <output.raw >output &&
+	grep "old<" output
+'
+
 test_expect_success 'diffFilter filters diff' '
 	git reset --hard &&
 
-- 
2.25.0.538.g1d5d7023b0

