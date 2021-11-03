Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB89EC433EF
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6D766113B
	for <git@archiver.kernel.org>; Wed,  3 Nov 2021 11:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhKCLNV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 07:13:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:52074 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231151AbhKCLNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 07:13:16 -0400
Received: (qmail 4957 invoked by uid 109); 3 Nov 2021 11:10:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Nov 2021 11:10:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18277 invoked by uid 111); 3 Nov 2021 11:10:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Nov 2021 07:10:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 Nov 2021 07:10:35 -0400
From:   Jeff King <peff@peff.net>
To:     Steven Penny <srpen6@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: credential-store get: No such file or directory
Message-ID: <YYJuK70U8Sk7xSYl@coredump.intra.peff.net>
References: <CAP8dQmu6Dfo4KBsVk+6xeR6=+S8bOKk-kbc3ub7c0jAsH61-cg@mail.gmail.com>
 <YYHzDuoJfWknI1XM@coredump.intra.peff.net>
 <CAP8dQmvoxWDnD_rbCdBS9cnwS90YFjjXcCPWLmjMq=ck7vo1Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8dQmvoxWDnD_rbCdBS9cnwS90YFjjXcCPWLmjMq=ck7vo1Ww@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 02, 2021 at 10:57:09PM -0500, Steven Penny wrote:

> > Also, what does:
> >
> >   GIT_TRACE=1 git push
> >
> > say about what it's trying to execute?
> 
> Aha:
> 
>     22:53:19.785297 run-command.c:666       trace: run_command:
> git-remote-https origin https://github.com/89z/googleplay
>     22:53:20.024042 run-command.c:666       trace: run_command: 'git
> credential-store get'

Hmm, that's the right output, I think. Even though it's wrapped in
single-quotes I think that's just how run_command shows it. If I do
something silly like:

  [credential]
  helper = "!'git credential-store'"

then I get:

  07:07:49.063476 run-command.c:663       trace: run_command: ''\''git credential-store'\'' get'
  'git credential-store' get: 1: git credential-store: not found

> > I think it is not complaining about finding the credential file, but
> > running the credential-store helper in the first place. The "cannot run"
> > message comes from our run-command.c code.
> 
> Yeah, looks like you are right, based on the trace result.

So I'm quite confused about exactly what's failing and why. At this
point I'd probably try running it under strace to see what's actually
happening at the syscall level. I don't think you said what OS you're
on; if it's Linux, then I suspect something like:

  strace -f -e execve git push

might be interesting (dropping the "-e execve" will give much more
output which might also be interesting, but it's probably pretty big).

-Peff
