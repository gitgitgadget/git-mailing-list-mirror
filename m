Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5713AC433E0
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 09:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA9564F31
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 09:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhCEJC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:02:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:53262 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhCEJCS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 04:02:18 -0500
Received: (qmail 32379 invoked by uid 109); 5 Mar 2021 09:02:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Mar 2021 09:02:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18421 invoked by uid 111); 5 Mar 2021 09:02:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Mar 2021 04:02:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Mar 2021 04:02:16 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4 09/12] unix-socket: disallow chdir() when creating
 unix domain sockets
Message-ID: <YEHzmIOYgRtI1Ak1@coredump.intra.peff.net>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <1bfa36409d0706d5e22703f80bf95dfa1a313a83.1613598529.git.gitgitgadget@gmail.com>
 <xmqqblbzj1cs.fsf@gitster.c.googlers.com>
 <YED1DmLWd+ciySNa@coredump.intra.peff.net>
 <xmqqa6riejyp.fsf@gitster.c.googlers.com>
 <xmqqtupqbij4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtupqbij4.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 04, 2021 at 03:34:07PM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> So I dunno. I'd be OK to just rip the feature out in favor of doing
> >> those chdir()s. But that seems like a non-zero amount of work versus
> >> leaving, and the existing code has the benefit that if another caller
> >> shows up, it could benefit from the feature.
> >
> > I am OK to keep the series as-is, and leave it to a possible future
> > work to remove the need for chdir even for long paths and not having
> > to return an error with ENAMETOOLONG; when such an update happens,
> > the "fail if need to chdir" feature this patch is adding will become
> > a no-op.
> 
> For example, as this is UNIX-only codepath, I wonder if something
> like this would be a good way to avoid chdir() that would cause
> trouble.
> 
>     - obtain a fd from socket(2)
>     - check if path is too long to fit in sa->sun_path
>       - if it does, bind(2) the fd to the address
>       - if it does not, fork(2) a child and
>         - in the child, chdir(2) there and use the shortened path
> 	  to bind(2), and exit(3)
>         - the parents just wait(2)s for the child to return. By the
>           time it dies, the fd would be successfully bound to the
> 	  path.
>     - now we have a file descriptor that is bound at that path.

If the trouble is that chdir() isn't thread-safe, I wonder if fork()
creates its own headaches. :) I guess libc usually takes care of the
basics with pthread_atfork(), etc, and the child otherwise would not
need to access much data.

I don't know offhand if this trick actually works. I can imagine it
does, but it hinges on the subtlety between an integer descriptor and
the underlying "file description" (the term used in POSIX). Does binding
a socket operate on the former (like close() does not close the parent's
descriptor) or the latter (like lseek() impacts other descriptors).

I'd guess the latter, but I wasn't sure if you were suggesting this from
experience or if you just invented the technique. ;)

-Peff
