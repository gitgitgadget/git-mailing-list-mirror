Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B90CC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 10:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2638C611CE
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 10:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhF3KJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 06:09:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43388 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234057AbhF3KJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 06:09:51 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D879B1F8C6;
        Wed, 30 Jun 2021 10:07:22 +0000 (UTC)
Date:   Wed, 30 Jun 2021 10:07:22 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] xmmap: inform Linux users of tuning knobs on ENOMEM
Message-ID: <20210630100722.GB2653@dcvr>
References: <20210629081108.28657-1-e@80x24.org>
 <20210630000132.GA2653@dcvr>
 <YNva8PWFJ24QX2yF@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNva8PWFJ24QX2yF@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Wed, Jun 30, 2021 at 12:01:32AM +0000, Eric Wong wrote:
> 
> > This series is now down to a single patch.
> > 
> > I wanted to make things more transparent to users without
> > privileges to raise sys.vm.max_map_count and/or RLIMIT_DATA;
> > but it doesn't seem possible to account for libc/zlib/etc. doing
> > mmap() without our knowledge (usually via malloc).
> 
> Oh, I should have read this one before reviewing the inner parts of v1. :)
> 
> In general I agree that trying to manage our map count can never be
> foolproof. As you note, other parts of the system may contribute to that
> count. But even within Git, we don't have any mechanism for unmapping
> many non-packfiles. So if you have 30,000 packs, you may hit the limit
> purely via the .idx files (and ditto for the new .rev files, and
> probably commit-graph files, etc).

Yeah, the most annoying thing with my original series was when
I hit "inflate: out of memory" once I stopped xmmap from dying.
I suspect that would be a worse far error message for users who
aren't familiar with how malloc works.

> That said, I'm not opposed to handling xmmap() failures more gracefully,
> as your series did. It's not foolproof, but it might help in some cases.

I've also been wondering if we can maintain a watermark based
on reading the contents of /proc/sys/vm/max_map_count and the
mappings we make.   Then we could start dropping mappings
when we hit half (or some other threshold) of that sysctl.
Similar for RLIMIT_DATA (though that defaults to unlimited
on my Debian system).

OTOH, I also wonder if we're overusing mmap when we could be
just as well served with pread.

I'm not up-to-date on modern mmap performance and maybe CPU
vulnerability mitigations nowadays make mmap more compelling.
However, once upon a time in 2006, pread could be a hair quicker:

https://lore.kernel.org/git/Pine.LNX.4.64.0612182234260.3479@woody.osdl.org/T/#u
(But that info could be out-of-date...)

I'm also somewhat paranoid when it comes to mmap since rogue
processes could be truncating mmap-ed files to cause bus errors.

> > So I think giving users some information to feed their sysadmins
> > is the best we can do in this situation:
> 
> This seems OK to me, too. Translators might complain a bit about the
> message-lego. I don't have a strong opinion.

*shrug*  I saw my original patches already ended up in `seen'
(commit 7b79212a93c375365c06cab5c0018ab97a4185cf)
