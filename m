Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC98C48BDF
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D50D61457
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhFOK6h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:58:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:55878 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231516AbhFOK6g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 06:58:36 -0400
Received: (qmail 7450 invoked by uid 109); 15 Jun 2021 10:56:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Jun 2021 10:56:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13480 invoked by uid 111); 15 Jun 2021 10:56:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Jun 2021 06:56:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Jun 2021 06:56:31 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Luke Shumaker <lukeshu@lukeshu.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 1/2] subtree: fix the GIT_EXEC_PATH sanity check to work
 on Windows
Message-ID: <YMiHX6H/k1Z8C6Ws@coredump.intra.peff.net>
References: <pull.978.git.1623316412.gitgitgadget@gmail.com>
 <a91ac6c18938116c4a74e19466da456b67376fa5.1623316412.git.gitgitgadget@gmail.com>
 <87bl8d6xoq.wl-lukeshu@lukeshu.com>
 <nycvar.QRO.7.76.6.2106111213050.57@tvgsbejvaqbjf.bet>
 <875yyk7c3j.wl-lukeshu@lukeshu.com>
 <nycvar.QRO.7.76.6.2106141330410.57@tvgsbejvaqbjf.bet>
 <xmqqtulzyhyh.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtulzyhyh.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 11:33:58AM +0900, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> `test FILE1 -ef FILE2` checks wether the inode is the same.  And it's
> >> POSIX, so I'm assuming that it's sufficiently portable, though I
> >> haven't actually tested whether things other than Bash implement it.
> >
> > It's not POSIX. From
> > https://pubs.opengroup.org/onlinepubs/009695399/utilities/test.html:
> >
> > 	Some additional primaries newly invented or from the KornShell
> > 	appeared in an early proposal as part of the conditional command
> > 	([[]]): s1 > s2, s1 < s2, str = pattern, str != pattern,
> > 	f1 -nt f2, f1 -ot f2, and f1 -ef f2.
> >
> > Having said that, it appears that Bash implements it (what non-standard
> > behavior _doesn't_ it implement ;-))
> >
> > And since Git for Windows ships with Bash, we can actually use it!
> 
> So,... is contrib/subtree for Windows only?

I read it as "this workaround is needed only on Windows, and will kick
in only there; on other platforms, the "-ef" code will not run at all,
so we don't have to worry about its portability".

But having seen the earlier part of the thread, it looks like "are we on
Windows" is predicated on "! type -p cygpath", which seems a bit loose.
I also think "-p" is a bash-ism, so we'd want to avoid it before
determining whether we're on Windows to avoid a chicken-and-egg on other
platforms.

-Peff
