Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E043C77B73
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 06:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjFDG0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 02:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjFDGZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 02:25:59 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C64B9F
        for <git@vger.kernel.org>; Sat,  3 Jun 2023 23:25:58 -0700 (PDT)
Received: (qmail 1102 invoked by uid 109); 4 Jun 2023 06:25:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 04 Jun 2023 06:25:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17785 invoked by uid 111); 4 Jun 2023 06:25:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 04 Jun 2023 02:25:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 4 Jun 2023 02:25:56 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     paul@mad-scientist.net, git@vger.kernel.org
Subject: Re: Anyone know why git ls-remote output might be corrupted?
Message-ID: <20230604062556.GA42964@coredump.intra.peff.net>
References: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
 <CABPp-BF9Xjww=BBkL4qQcENo-UCHd8eEj334ho1iO1EMbGxhZw@mail.gmail.com>
 <20230604060048.GA38176@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230604060048.GA38176@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 04, 2023 at 02:00:48AM -0400, Jeff King wrote:

> Now, why the descriptor would be in non-blocking mode, I have no idea.
> But maybe something funny going on in your python script.
> 
> I'd be curious if applying the patch from:
> 
>   https://lore.kernel.org/git/YUTo1BTp7BXOw6K9@coredump.intra.peff.net/
> 
> reports any problems. As well as whether the suggested "sleep" pipeline
> there (triggered via your script in this case) shows the problem more
> reliably.

It does look like glibc's stdio will throw away buffer contents that get
EAGAIN. Doing:

  perl -MFcntl -e '
    fcntl(STDOUT, F_GETFL, $flags);
    $flags |= O_NONBLOCK;
    fcntl(STDOUT, F_SETFL, $flags);
    exec @ARGV;
  ' git ls-remote . | (sleep 1; tee output) | sha256sum

does result in some missing writes and broken input that looks like
what's going on in this thread (in this case, it's writing to my
terminal, which isn't fast enough to keep up; but you could also pipe to
something like "tee output | sha256sum" to see that the output changes
with each run). And naturally you'll need a big enough output from
ls-remote to fill the pipe buffer.

However, Git _does_ eventually produce a non-zero exit code in this
case, because we check ferror() after running any builtin. So it
eventually ends with:

  fatal: unknown write failure on standard output

So I dunno. Maybe this is not the same thing. I do think running
the problematic case under "strace -o foo.out" may yield more
information.

-Peff
