Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B77C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 22:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIWWHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 18:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiIWWHL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 18:07:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D232147F0E
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 15:07:10 -0700 (PDT)
Received: (qmail 14728 invoked by uid 109); 23 Sep 2022 22:07:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Sep 2022 22:07:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17451 invoked by uid 111); 23 Sep 2022 22:07:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Sep 2022 18:07:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Sep 2022 18:07:09 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] cmd-list.perl: fix identifying man sections
Message-ID: <Yy4uDW9YjpleFUHW@coredump.intra.peff.net>
References: <20220923070334.1970213-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220923070334.1970213-1-martin.agren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 23, 2022 at 09:03:34AM +0200, Martin Ågren wrote:

> This makes our git(1) manpage look as follows:
> 
>   Main porcelain commands
>        git-add(git)
>            Add file contents to the index.
> 
>   [...]
> 
>        gitk(git)
>            The Git repository browser.
> 
>        scalar(scalar)
>            A tool for managing large Git repositories.

Good catch. The patch looks good (I was going to suggest ?:, but I see
Ævar beat me to it).

I wondered if we might have caught this in a more automatic way. The
output of:

  cd Documentation
  ./doc-diff cc75e556a9^ cc75e556a9

makes the problem apparent, but I don't fault reviewers for not running
it. I rarely remember to do so. And in general you need a human looking
at doc-diff output to know if it was the intended change or not.

I wondered if it might be worth running

  ./doc-diff v2.37.0 v2.38.0-rc1

near a release to scan over all of the changes. But the diff is over
8000 lines, and I admit my eyes glazed over before I got to the
problematic hunks (even though I knew I was looking for them!). You can
limit it a bit with --diff-filter=a, which drops new entries (which
can't have regressed!), but it's still over 4000 lines.

So I dunno. I think doc-diff is a potentially useful tool, but I'm not
sure how to point the human attention at the right spot to find a bug.
Maybe "given enough eyeballs, all bugs are shallow" is our best bet
here. After all, it did find this bug before the release. :)

-Peff
