Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCACC433DB
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C3C64EDA
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 20:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhBJUcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Feb 2021 15:32:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:56796 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232346AbhBJUcg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Feb 2021 15:32:36 -0500
Received: (qmail 1064 invoked by uid 109); 10 Feb 2021 20:31:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Feb 2021 20:31:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23360 invoked by uid 111); 10 Feb 2021 20:31:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Feb 2021 15:31:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Feb 2021 15:31:55 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bryan Turner <bturner@atlassian.com>, SURA <surak8806@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] mailmap: only look for .mailmap in work tree
Message-ID: <YCRCu60a2MuGooiL@coredump.intra.peff.net>
References: <CAD6AYr-BD08FcbnVfHpOUt7ZwFH0PgoATgyegKnBQ3GOe9isdA@mail.gmail.com>
 <YB148VZJqKIPC8P2@coredump.intra.peff.net>
 <CAGyf7-EB=J1j1LOUiUBHE+g-hA1WXUNy3F4y84rCRwzGc2zo_A@mail.gmail.com>
 <YCLGgpfkJzg5nP7v@coredump.intra.peff.net>
 <xmqqv9b1ylyj.fsf@gitster.c.googlers.com>
 <YCQGqeHB4rXi6dG0@coredump.intra.peff.net>
 <xmqqblcr3crp.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblcr3crp.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 12:10:02PM -0800, Junio C Hamano wrote:

> >> OK.  Do we know at this point that cwd is always/already at the root
> >> level of the working tree?
> >
> > I think so. If we're in a non-bare repository, we'd have chdir'd during
> > the setup/discovery steps. At any rate, this patch could not possibly be
> > making such a situation _worse_, as we were previously reading it
> > unconditionally.
> 
> But the point of the patch is to ensure that we only read from the
> top of the working tree---I wanted to make sure that we previously
> weren't reading it from any subdirectory the command started.

Ah, I see. I assume that part already worked, or people would be
complaining that "git shortlog" does not work from a subdirectory. :)

It doesn't look like we actually cover that in the test suite, though.
We can do that pretty easily:

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index bf7a8add53..93caf9a46d 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -923,4 +923,13 @@ test_expect_success 'shortlog on stdin respects mailmap from repo' '
 	test_cmp expect actual
 '
 
+test_expect_success 'find top-level mailmap from subdir' '
+	git clone loc-bare loc-wt &&
+	cp loc-bare/.mailmap loc-wt &&
+	mkdir loc-wt/subdir &&
+	git -C loc-wt/subdir log -1 --format=%aE >actual &&
+	echo new@example.com >expect &&
+	test_cmp expect actual
+'
+
 test_done

I'll resend the whole thing with that squashed in, plus Eric's
documentation suggestion.

-Peff
