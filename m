Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0EDC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 04:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjDREAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 00:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDREAh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 00:00:37 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE80421B
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 21:00:35 -0700 (PDT)
Received: (qmail 32423 invoked by uid 109); 18 Apr 2023 04:00:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 04:00:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30405 invoked by uid 111); 18 Apr 2023 04:00:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 00:00:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 00:00:34 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH] doc: remove custom callouts format
Message-ID: <20230418040034.GC60552@coredump.intra.peff.net>
References: <20230418011828.47851-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230418011828.47851-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 07:18:28PM -0600, Felipe Contreras wrote:

> What's worse: the format of the upstream callouts is much nicer than our
> hacked version.
> 
> Compare this:
> 
>      $ git diff            (1)
>      $ git diff --cached   (2)
>      $ git diff HEAD       (3)
> 
>   1. Changes in the working tree not yet staged for the next
>      commit.
>   2. Changes between the index and your last commit; what you
>      would be committing if you run git commit without -a
>      option.
>   3. Changes in the working tree since your last commit; what
>      you would be committing if you run git commit -a
> 
> To this:
> 
>      $ git diff            (1)
>      $ git diff --cached   (2)
>      $ git diff HEAD       (3)
> 
>  1. Changes in the working tree not yet staged for the next commit.
>  2. Changes between the index and your last commit; what you would
>  be committing if you run git commit without -a option.
>  3. Changes in the working tree since your last commit; what you
>  would be committing if you run git commit -a

You don't say which is which, so I'm hoping that the top one is the new
output. :) And running doc-diff shows that it is. Good.

It does look like at least one spot is made worse, though. In
git-checkout, we have now:

          1. The following sequence checks out the master branch,
             reverts the Makefile to two revisions back, deletes hello.c
             by mistake, and gets it back from the index.
  
                 $ git checkout master             (1)
                 $ git checkout master~2 Makefile  (2)
                 $ rm -f hello.c
                 $ git checkout hello.c            (3)
  
             1. switch branch
             2. take a file out of another commit
             3. restore hello.c from the index
  
             If you want to check out all C source files out of the
             index, you can say
  
                 $ git checkout -- '*.c'
  
             Note the quotes around *.c. The file hello.c will also be
             checked out, even though it is no longer in the working
             tree, because the file globbing is used to match entries in
             the index (not in the working tree by the shell).

which is achieved through plus-continuation of each paragraph, to make
it all part of the block under item "1." in the numbered list.

But after your patch, it's:

          1. The following sequence checks out the master branch,
             reverts the Makefile to two revisions back, deletes hello.c
             by mistake, and gets it back from the index.
  
                 $ git checkout master             (1)
                 $ git checkout master~2 Makefile  (2)
                 $ rm -f hello.c
                 $ git checkout hello.c            (3)
  
              1. switch branch
              2. take a file out of another commit
              3. restore hello.c from the index
  
                 If you want to check out all C source files out of
                 the index, you can say
  
                                $ git checkout -- '*.c'
  
                            Note the quotes around *.c. The file
                            hello.c will also be checked out, even
                            though it is no longer in the working
                            tree, because the file globbing is used
                            to match entries in the index (not in the
                            working tree by the shell).

The plus-continuation seems to get attached to the final item of the
callout list, rather than to the surrounding block. I tried one or two
things to disambiguate this (like opening a new block around the
example+callout section), but couldn't get any reasonable output. It's
also weird that it keeps indenting each block further (I'd expect "Note
the quotes" to be in line with "If you want to").

This is perhaps a bug in asciidoc itself. Building with USE_ASCIIDOCTOR
is mostly good, though it seems to drop the newline between the callout
list and the next paragraph, which our custom one has:

          1. The following sequence checks out the master branch,
             reverts the Makefile to two revisions back, deletes hello.c
             by mistake, and gets it back from the index.
  
                 $ git checkout master             (1)
                 $ git checkout master~2 Makefile  (2)
                 $ rm -f hello.c
                 $ git checkout hello.c            (3)
  
              1. switch branch
              2. take a file out of another commit
              3. restore hello.c from the index
             If you want to check out all C source files out of the
             index, you can say
  
                 $ git checkout -- '*.c'
  
             Note the quotes around *.c. The file hello.c will also be
             checked out, even though it is no longer in the working
             tree, because the file globbing is used to match entries in
             the index (not in the working tree by the shell).

It's probably still worth moving forward with your patch, as I think it
takes us in the direction we want long-term (and which builds with
asciidoctor are already using). But we may want to pair it with a patch
to work around the issue with git-checkout.1 using asciidoc to avoid
regressing that section. It may require re-wording or re-organizing to
work around the bug.

-Peff
