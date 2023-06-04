Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDC1C7EE2A
	for <git@archiver.kernel.org>; Sun,  4 Jun 2023 06:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjFDGaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Jun 2023 02:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDGaM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2023 02:30:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2656BD
        for <git@vger.kernel.org>; Sat,  3 Jun 2023 23:30:11 -0700 (PDT)
Received: (qmail 1223 invoked by uid 109); 4 Jun 2023 06:30:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 04 Jun 2023 06:30:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17817 invoked by uid 111); 4 Jun 2023 06:30:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 04 Jun 2023 02:30:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 4 Jun 2023 02:30:10 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     paul@mad-scientist.net, git@vger.kernel.org
Subject: Re: Anyone know why git ls-remote output might be corrupted?
Message-ID: <20230604063010.GA47137@coredump.intra.peff.net>
References: <b6f210da2c3cc7746b984b797ad89687cba2d1f8.camel@mad-scientist.net>
 <CABPp-BF9Xjww=BBkL4qQcENo-UCHd8eEj334ho1iO1EMbGxhZw@mail.gmail.com>
 <20230604060048.GA38176@coredump.intra.peff.net>
 <20230604062556.GA42964@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230604062556.GA42964@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 04, 2023 at 02:25:57AM -0400, Jeff King wrote:

> It does look like glibc's stdio will throw away buffer contents that get
> EAGAIN. Doing:
> 
>   perl -MFcntl -e '
>     fcntl(STDOUT, F_GETFL, $flags);
>     $flags |= O_NONBLOCK;
>     fcntl(STDOUT, F_SETFL, $flags);
>     exec @ARGV;
>   ' git ls-remote . | (sleep 1; tee output) | sha256sum
> 
> does result in some missing writes and broken input that looks like
> what's going on in this thread (in this case, it's writing to my
> terminal, which isn't fast enough to keep up; but you could also pipe to
> something like "tee output | sha256sum" to see that the output changes
> with each run). And naturally you'll need a big enough output from
> ls-remote to fill the pipe buffer.

Sorry for some slight confusion above. I edited my example command to
show piping to "sha256sum", but didn't modify the paragraph below it
(originally I was not piping anywhere, just sending to the terminal).

Adding the "sleep 1" means that the command will always fail (ls-remote
easily writes all of its output and hits EAGAIN before the other side
reads anything). But it means that the output is deterministic (the
first PIPE_BUF bytes make it through, and nothing else does). Removing
the sleep makes the output non-deterministic, but much more interesting
(you get missing chunks in the interior of the output).

So perhaps:

  perl ... git ls-remote . | tee output | sha256sum

is the most interesting case, because you'll get one of several possible
broken outputs, which you can identify by the changing sha256 output
(and then see the actual breakage by peeking at the "output" file).

-Peff
