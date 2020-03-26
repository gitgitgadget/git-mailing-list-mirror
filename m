Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD188C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 07:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C46C20714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 07:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZH2m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:28:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:51790 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726279AbgCZH2m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 03:28:42 -0400
Received: (qmail 32705 invoked by uid 109); 26 Mar 2020 07:28:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 07:28:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11705 invoked by uid 111); 26 Mar 2020 07:38:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 03:38:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 03:28:40 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Norbert Kiesel <nkiesel@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: "git rebase" behavior change in 2.26.0
Message-ID: <20200326072840.GA2198456@coredump.intra.peff.net>
References: <CAM+g_Nuu2jGuNwUMS3j8=EjOrthYzfVTrUzOxQJ=aYcoBAL3Tg@mail.gmail.com>
 <20200325053908.GC651138@coredump.intra.peff.net>
 <CABPp-BF9LDfaw8=S4yqtuZ5U70Jcj_yZHq17Y7SUa17DwRqMSA@mail.gmail.com>
 <CAM+g_NtHC5ukU3jchVfud_H_m_h29UQ8vmwQoND8s_Q9Hv70Fg@mail.gmail.com>
 <CAM+g_Nvt3X4d5cjKajzDOcoDgNS4bVkj3a0KvVm4yDEW-J7v2w@mail.gmail.com>
 <CAM+g_NsUfw6zDRj8H1VNdheKFSHgC9gz7nVy0vbtpTKkYzjjtA@mail.gmail.com>
 <CABPp-BHMMw+L6fgfdVEEXnhH0w0aK6KfKA9Aq+aSuzWD0Cgr8g@mail.gmail.com>
 <CABPp-BFMN+pnOjEe2tZZJp3_Noojn5j1ip3dh8Xz9hCZoKJbxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFMN+pnOjEe2tZZJp3_Noojn5j1ip3dh8Xz9hCZoKJbxw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 25, 2020 at 11:32:31PM -0700, Elijah Newren wrote:

> > Say, WAT?!?  This attempted to run both a merge and a rebase?  That
> > appears to be yet another bug.
> 
> From git-pull.c:
> 
>     ...
>         if (is_descendant_of(merge_head, list)) {
>             /* we can fast-forward this without invoking rebase */
>             opt_ff = "--ff-only";
>             ret = run_merge();
>         }
>     }
>     ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
> 
> Perhaps that comment should read:
> 
>    /* we can fast-forward this using merge and avoid rebase...but then
> run rebase afterward anyway! */
> 
> Whoops.  Perhaps fixing this is a good micro-project candidate?  Too small?

Good find. :) Looks like this is due to a6d7eb2c7a (pull: optionally
rebase submodules (remote submodule changes only), 2017-06-23) which
changed the early return to "ret =".

I think it would be an OK size for a micro-project, but it seems like a
bug which we may want fixed sooner rather than waiting for somebody to
pick it up from the micro-project pile.

Or perhaps not. AFAICT this has been there for 2+ years without anybody
noticing.

-Peff
