Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D206C4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 22:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FE96101E
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 22:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhHKWXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 18:23:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:44824 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232212AbhHKWXO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 18:23:14 -0400
Received: (qmail 23533 invoked by uid 109); 11 Aug 2021 22:22:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Aug 2021 22:22:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15679 invoked by uid 111); 11 Aug 2021 22:22:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Aug 2021 18:22:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Aug 2021 18:22:49 -0400
From:   Jeff King <peff@peff.net>
To:     Joel Klinghed <the_jk@spawned.biz>
Cc:     Joel Klinghed via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] commit: restore --edit when combined with --fixup
Message-ID: <YRRNuQWkgWxQyfU0@coredump.intra.peff.net>
References: <pull.1014.git.1628689758413.gitgitgadget@gmail.com>
 <YRQx/jXdydxMGBmS@coredump.intra.peff.net>
 <127626db-302e-426c-a158-35f46205e1d6@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <127626db-302e-426c-a158-35f46205e1d6@www.fastmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 12, 2021 at 12:10:28AM +0200, Joel Klinghed wrote:

> > Is the goal that they might leave notes for themselves, which they can
> > view in the meantime before they run "rebase --autosquash"?
> > 
> 
> At my work we use "fixup!" when pushing fixes to a review, using
> the modified body to outline what issue the commit is addressing,
> helping the reviewers to see intent and not just the end result.
> All "fixup!" are then ofc. squashed before integration.
> Same can be achieved with -m but --edit is generally
> easier to work with in my experience.
> 
> I've also once or twice used it to avoid a "fixup!" of a "fixup!" instead
> of looking up the original target commit hash but that's just me being
> lazy.

Ah, thanks for explaining. That makes sense.

> I'll add a test to check for previous behavior.

This is what I worked up, in case it helps.

diff --git a/t/t7502-commit-porcelain.sh b/t/t7502-commit-porcelain.sh
index 38a532d81c..3e4364066f 100755
--- a/t/t7502-commit-porcelain.sh
+++ b/t/t7502-commit-porcelain.sh
@@ -940,4 +940,22 @@ EOF
 	)
 '
 
+test_expect_success 'commit --fixup respects --edit' '
+	echo broken >foo.c &&
+	git add foo.c &&
+	git commit -m "wip of foo.c" &&
+	echo fixed >foo.c &&
+	(
+		test_set_editor "$TEST_DIRECTORY/t7500/add-content" &&
+		git commit --fixup HEAD --edit foo.c
+	) &&
+	cat >expect <<-\EOF &&
+	fixup! wip of foo.c
+
+	commit message
+	EOF
+	git log -1 --pretty=format:%B HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done

-Peff
