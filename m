Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1D4C74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 18:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCUSbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjCUSbl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 14:31:41 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B014615F
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:31:40 -0700 (PDT)
Received: (qmail 28582 invoked by uid 109); 21 Mar 2023 18:31:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Mar 2023 18:31:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2851 invoked by uid 111); 21 Mar 2023 18:31:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Mar 2023 14:31:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Mar 2023 14:31:38 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Miguel Torroja <miguel.torroja@gmail.com>,
        "Priedhorsky, Reid" <reidpr@lanl.gov>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: bug? round-trip through fast-import/fast-export loses files
Message-ID: <20230321183138.GL3119834@coredump.intra.peff.net>
References: <BBB169A5-0665-47C9-819B-6409A22AB699@lanl.gov>
 <CABPp-BEG+vp-UcpVfcZecPBnfcuTjO6JYCo7wEU5ZrDUHBUd9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEG+vp-UcpVfcZecPBnfcuTjO6JYCo7wEU5ZrDUHBUd9g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 06:57:21PM -0700, Elijah Newren wrote:

> Honestly, looking back at those two patches of mine, I think both were
> rather suboptimal.  A better solution that would handle both F->D and
> D->F would be having fast-export sort the diff_filepairs such that it
> processes the deletes before the modifies.  Another improved solution
> would be having fast-import sort the files given to it and handling
> deletes first.  Either should fix this.
> 
> Might be a good task for a new contributor.  Any takers?  (Tagging as
> #leftoverbits.)

There was a patch a while ago, but it didn't get applied:

  https://lore.kernel.org/git/1493079137-1838-1-git-send-email-miguel.torroja@gmail.com/

It got hung up on the fact that fast-export can also generate renames,
and ordering there is tricky. I stand by the sentiment from back then
that it is still worth it to order things to make the no-rename case
work, even if there are still corner cases with renames (since you can
have a cycle of renames, you should not use them if you want to be
robust against this kind of ordering dependency).

-Peff
