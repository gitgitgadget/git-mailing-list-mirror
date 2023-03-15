Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B1AC74A5B
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 18:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjCOSCe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 14:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCOSCa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 14:02:30 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEA281CEF
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 11:02:20 -0700 (PDT)
Received: (qmail 18772 invoked by uid 109); 15 Mar 2023 18:02:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 15 Mar 2023 18:02:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2833 invoked by uid 111); 15 Mar 2023 18:02:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Mar 2023 14:02:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Mar 2023 14:02:18 -0400
From:   Jeff King <peff@peff.net>
To:     Sebastian Gniazdowski <sgniazdowski@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: A nice, beauty progress metter for Git Clone + a feature request
Message-ID: <ZBIIKqAIF+aF8vvx@coredump.intra.peff.net>
References: <CAKc7PVD_65vB5+meeO3xcu4ASbqr85LBGUO8Ntb7SvbO+NNHmQ@mail.gmail.com>
 <CAKc7PVA14_mjZeuED1Ee0Mu5YoCSrR4FNNhSEKFHmnKnc-gESQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKc7PVA14_mjZeuED1Ee0Mu5YoCSrR4FNNhSEKFHmnKnc-gESQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2023 at 11:37:49AM +0000, Sebastian Gniazdowski wrote:

> Check out: https://asciinema.org/a/566216
> 
> Feature request is: add a pipe={cmd} option to git, that would just
> pass through the git clone --progress output into {cmd}. This is
> EXTREMELY EASY TO DO SO, ONLY
> 
> FILE *pipe=popen(cmd_option_str, "w") ;
> 
> is needed, and one can then write to `pipe` file handler.

I think it would be neat to have options for prettier progress output.
Unfortunately, it's not quite that easy.

Imagine we had a config option, progress.command or something, which
specified a shell command to which we'd pipe machine-readable progress,
and it would turn it into something pretty. There are two gotchas I can
think of immediately:

  1. Progress is often created by multiple processes. For example, in a
     clone, you might see progress output from index-pack as it receives
     the pack and resolves the delta. But then you might also see
     progress during the checkout phase, as we write out the worktree
     files.

     One solution is to say that each progress command is independent,
     and we'd simply run it twice, once for each context. That's easy to
     do, but restricts some fancier options that a command could do.

     Another is for the parent clone command to kick off a progress
     process, and then tell child processes (perhaps through the
     environment) which descriptor they can use to talk to the progress
     command.

  2. Sometimes progress is shoved through a single descriptor along with
     other human-readable messages. I'm thinking specifically of the
     output you get from a clone/fetch _before_ we start receiving pack
     bytes from the server. There the server is giving progress on
     preparing the fetch. It comes over a sideband channel through Git's
     protocol, along with any regular stderr messages, and the client
     side just dumps it all to the local stderr.

     Obviously the remote side is not going to run our custom progress
     command. But it would be possible to add a protocol extension that
     says "hey, please send machine-readable progress data over sideband
     4" or something.

Now, none of that is _strictly_ necessary. We could just dump the same
human-readable progress to the progress command that we dump to stderr
now, and it could scrape it for things that look like progress, and pass
everything else through. But then, you can already do that with:

  git clone --progress ... 2>&1 | my-progress-scraper

(and it looks like the asciinema you showed is probably just a
syntactically nicer version of that with support from the shell?).

-Peff
