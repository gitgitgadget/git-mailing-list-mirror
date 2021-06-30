Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C41C11F67
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 02:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3608D61D90
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 02:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhF3Csh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 22:48:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:37018 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231938AbhF3Csh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 22:48:37 -0400
Received: (qmail 22290 invoked by uid 109); 30 Jun 2021 02:46:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 02:46:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1225 invoked by uid 111); 30 Jun 2021 02:46:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Jun 2021 22:46:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Jun 2021 22:46:08 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] xmmap: inform Linux users of tuning knobs on ENOMEM
Message-ID: <YNva8PWFJ24QX2yF@coredump.intra.peff.net>
References: <20210629081108.28657-1-e@80x24.org>
 <20210630000132.GA2653@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210630000132.GA2653@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 12:01:32AM +0000, Eric Wong wrote:

> This series is now down to a single patch.
> 
> I wanted to make things more transparent to users without
> privileges to raise sys.vm.max_map_count and/or RLIMIT_DATA;
> but it doesn't seem possible to account for libc/zlib/etc. doing
> mmap() without our knowledge (usually via malloc).

Oh, I should have read this one before reviewing the inner parts of v1. :)

In general I agree that trying to manage our map count can never be
foolproof. As you note, other parts of the system may contribute to that
count. But even within Git, we don't have any mechanism for unmapping
many non-packfiles. So if you have 30,000 packs, you may hit the limit
purely via the .idx files (and ditto for the new .rev files, and
probably commit-graph files, etc).

That said, I'm not opposed to handling xmmap() failures more gracefully,
as your series did. It's not foolproof, but it might help in some cases.

> So I think giving users some information to feed their sysadmins
> is the best we can do in this situation:

This seems OK to me, too. Translators might complain a bit about the
message-lego. I don't have a strong opinion.

-Peff
