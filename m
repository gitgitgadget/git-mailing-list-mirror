Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89B3C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 14:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8603A611EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 14:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhKDO6a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 10:58:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:53092 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhKDO63 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 10:58:29 -0400
Received: (qmail 8697 invoked by uid 109); 4 Nov 2021 14:55:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 04 Nov 2021 14:55:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3157 invoked by uid 111); 4 Nov 2021 14:55:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 04 Nov 2021 10:55:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 4 Nov 2021 10:55:50 -0400
From:   Jeff King <peff@peff.net>
To:     Steven Penny <srpen6@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: credential-store get: No such file or directory
Message-ID: <YYP0dnBgfY16fSP7@coredump.intra.peff.net>
References: <CAP8dQmu6Dfo4KBsVk+6xeR6=+S8bOKk-kbc3ub7c0jAsH61-cg@mail.gmail.com>
 <YYHzDuoJfWknI1XM@coredump.intra.peff.net>
 <CAP8dQmvoxWDnD_rbCdBS9cnwS90YFjjXcCPWLmjMq=ck7vo1Ww@mail.gmail.com>
 <YYJuK70U8Sk7xSYl@coredump.intra.peff.net>
 <CAP8dQmsbR7V1zX=xpk+ah-5bgkOP3vJGTMBq_25m9Vhw_fADAQ@mail.gmail.com>
 <YYOrLgj3KMq6eKpp@coredump.intra.peff.net>
 <CAP8dQmtLt_2+ExGUB71nJz_PWHKRrzqQVtX7d8T6FpPqgatiFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8dQmtLt_2+ExGUB71nJz_PWHKRrzqQVtX7d8T6FpPqgatiFQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 04, 2021 at 09:12:39AM -0500, Steven Penny wrote:

> On Thu, Nov 4, 2021 at 4:43 AM Jeff King wrote:
> > It's because internally, the "git credential-store get" command is
> > assembled as a single string passed to the shell, whereas remote-https
> > is run directly via exec/spawn.
> 
> Actually, I bet that is whats causing the problem. I am using MSYS2 Git [1],
> which is not a native Windows build of Git, but one that relies on the MSYS2 DLL
> for path translations and such. I have actually built a Windows native Git, but
> its a pain, so its easier just to use the package. Anyway, the "non native"
> Windows version, probably considers Bash the shell, so any commands being passed
> to a shell probably will be looking for Bash. I dont have Bash on my system,
> because for the most part I dont want or need it. If I need a shell, I just use
> PowerShell.

OK, that would explain it, I think.

> Would it be possible for Git to just run "credential-store" directly, like other
> commands? I assume stuff like "~/.git-credentials" would be a problem, but
> couldnt you just do something like this instead (pseudocode):
> 
>     var cred string = os.Getenv("HOME") + "/.git-credentials"

Possible yes, easy no.

The "~" part is trivial; that's expanded inside the C program anyway.
The harder thing is that helper strings can be arbitrary shell commands
(if you start them with "!"), so we decide at parse time whether to
stick the "git credential-" in front and then always treat it as a shell
command, rather than carrying through the knowledge that it doesn't need
a shell. So switching that would ripple through the whole call stack and
the data structures.

Definitely not impossible, and not even _hard_, but it's not like a
one-liner change.

-Peff
