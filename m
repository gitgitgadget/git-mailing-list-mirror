Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B933AC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A3D60F39
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhHPVDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:03:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:49060 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233135AbhHPVC4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:02:56 -0400
Received: (qmail 24611 invoked by uid 109); 16 Aug 2021 21:02:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 21:02:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19005 invoked by uid 111); 16 Aug 2021 21:02:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 17:02:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 17:02:22 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Message-ID: <YRrSXhbaZMLMq+1/@coredump.intra.peff.net>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com>
 <YRaYnDR6RlgJRr/P@coredump.intra.peff.net>
 <01b501d792cc$f4071ed0$dc155c70$@nexbridge.com>
 <YRqwIAL/JgJp+RyI@coredump.intra.peff.net>
 <01c501d792df$5fcb24b0$1f616e10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01c501d792df$5fcb24b0$1f616e10$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 04:43:25PM -0400, Randall S. Becker wrote:

> >Oh. Then the notion from my other mail of "if it's die(), then other tests would presumably see similar failures" might be true. ;)
> 
> When running 
> 
> /home/git/git/t/trash directory.t9001-send-email: git send-email --from="Example <nobody@example.com>" --to=nobody@example.com --smtp-server="/home/git/git/t/trash directory.t9001-send-email/fake.sendmail" --transfer-encoding=8bit 0001-Second.patch longline.patch
> fatal: longline.patch:35 is longer than 998 characters
> warning: no patches were sent
> /home/git/git/t/trash directory.t9001-send-email: echo $?
> 162

Well, that's a promising start to finding the source. :)

> So this is strange. Where is perl run? I'd like to catch the completion inside git.

This will all go through execv_dashed_external() in git.c. So we should
just be exiting with the status code we got from the child via wait().

You could try:

  - running it as git-send-email (with a dash), which will exec the perl
    script directly, rather than going through the main git binary

  - instrumenting run-command.c:wait_or_whine() to see how it interprets
    the value. If perl really is returning 255, then perhaps your
    platform's WIFSIGNALED() is confused by that.

If the problem does only show when going through the git binary, then I
suspect:

  git -c alias.foo='!perl -e die' foo

may be an easier reproduction.

-Peff
