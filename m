Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34396C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 17:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJQRmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 13:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJQRmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 13:42:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0008B70E5A
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 10:42:15 -0700 (PDT)
Received: (qmail 27340 invoked by uid 109); 17 Oct 2022 17:42:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Oct 2022 17:42:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8869 invoked by uid 111); 17 Oct 2022 17:42:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Oct 2022 13:42:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Oct 2022 13:42:14 -0400
From:   Jeff King <peff@peff.net>
To:     Paul Wagland <pwagland@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git gc error with git 2.37.2? (Introduced in 5a5ea141e7)
Message-ID: <Y02T9ssqqwX3mfRj@coredump.intra.peff.net>
References: <ebb035c1-d313-4f8e-b850-a6e11eeb374bn@googlegroups.com>
 <2C46C994-6023-4C69-92DF-73291A6AF94D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2C46C994-6023-4C69-92DF-73291A6AF94D@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 17, 2022 at 07:10:44PM +0200, Paul Wagland wrote:

> On git-users, I started a discussion(*) about a git gc error that I was getting that started with git 2.37.2. After some followup from Mathias on that list, I have determined that the issues that I a having started with the following commit:  https://github.com/git/git/commit/5a5ea141e7 ("revision: mark blobs needed for resolve-undo as reachable", 2022-06-09)
> 
> When I compile git locally with:
>    git checkout dc8c8deaa6
>    make
>    git rev-list --objects --indexed-objects
> 
> Then it works.
> 
>    git checkout 5a5ea141e7
>    make
>    git rev-list --objects --indexed-objects
> 
> Then I get the error:
>    fatal: missing blob object ‘1d0f34d1c4314efcff527847755e4ccc77d44fb6'
> 
> How can I further diagnose how to fix this?

It sounds like there's a resolve-undo extension in your index that
references that blob, but the blob was removed from the repository
(probably by a gc prior to 5a5ea141e7, which was trying to prevent this
corruption).

I'd expect that the resolve-undo extension would eventually be dropped
once a merge is finished, but I'm not very familiar with that code. Is
the repository in question mid-merge, or does it happen all the time?

If there are no changes you need to keep in the index or working tree,
I expect that a workaround would be:

  rm -f .git/index
  git reset
  git update-index --refresh

to rewrite the index from scratch. Then the problem should not recur, as
you'd be using a version with 5a5ea141e7 from here on out.

-Peff
