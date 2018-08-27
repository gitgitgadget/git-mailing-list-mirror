Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF9C31F404
	for <e@80x24.org>; Mon, 27 Aug 2018 23:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbeH1DmQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 23:42:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:58138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727067AbeH1DmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 23:42:16 -0400
Received: (qmail 11230 invoked by uid 109); 27 Aug 2018 23:53:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Aug 2018 23:53:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27243 invoked by uid 111); 27 Aug 2018 23:53:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 27 Aug 2018 19:53:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Aug 2018 19:53:21 -0400
Date:   Mon, 27 Aug 2018 19:53:21 -0400
From:   Jeff King <peff@peff.net>
To:     Stas Bekman <stas@stason.org>
Cc:     git@vger.kernel.org
Subject: Re: GIT_TRACE doesn't show content filter files it's operating on
Message-ID: <20180827235321.GB11663@sigill.intra.peff.net>
References: <3fdc0c24-bbee-e7b3-ec43-7e926cee71e1@stason.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fdc0c24-bbee-e7b3-ec43-7e926cee71e1@stason.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 04:23:34PM -0700, Stas Bekman wrote:

> I'm debugging the workings of a configured git content filter
> (nbstripout) and I'm trying to get GIT_TRACE to show me the files it's
> operating on, but it doesn't. Consider:
> 
> $ GIT_TRACE=1 git pull origin master
> [...] removed irrelevant sections of the output
> 16:49:28.846707 run-command.c:640       trace: run_command: git merge
> FETCH_HEAD
> 16:49:28.849309 git.c:344               trace: built-in: git merge
> FETCH_HEAD
> Updating 1ea49ad..ae0ba93
> 16:49:28.863291 run-command.c:640       trace: run_command: nbstripout
> 16:49:28.864700 run-command.c:640       trace: run_command: nbstripout
> 16:49:28.866060 run-command.c:640       trace: run_command: nbstripout
> [...] many more of the same
> 
> How can I get GIT_TRACE's run_command to show the arguments passed to
> the filter? I looked at various other debug environment variables in
> git's manual, but I don't see anything that would enable that level of
> debug.

GIT_TRACE should always show the arguments. But unless you specify
arguments in the clean/smudge filter config, then Git won't pass any.
The stdin/stdout stream is all that matters.

So e.g.:

  $ echo '* filter=foo' >.gitattributes
  $ git config filter.foo.clean 'myfilter'
  $ GIT_TRACE=1 git add .
  19:42:16.516401 [pid=14112] git.c:415             trace: built-in: git add .
  19:42:16.517454 [pid=14112] run-command.c:637     trace: run_command: myfilter

  $ git config filter.foo.clean 'myfilter --foo'
  $ touch .gitattributes ;# make sure we actually read it again ;)
  $ GIT_TRACE=1 git add .
  19:42:58.122942 [pid=14156] git.c:415             trace: built-in: git add .
  19:42:58.124023 [pid=14156] run-command.c:637     trace: run_command: 'myfilter --foo'

You can use "%f" to pass the name of the file, like:

  $ git config filter.foo.clean 'myfilter %f'
  $ touch .gitattributes
  $ GIT_TRACE=1 git add .
  19:44:51.187177 [pid=14318] git.c:415             trace: built-in: git add .
  19:44:51.188256 [pid=14318] run-command.c:637     trace: run_command: 'myfilter '\''.gitattributes'\'''

Of course that won't be helpful if your filter actually respects the
argument. For a "clean" filter that might be OK (e.g., if it just tells
your filter to read from the filesystem instead of stdin), but it's
almost certainly not what you want for a "smudge" filter.

You can work around it with some shell hackery:

  git config filter.foo.clean 'f() { echo >&2 "cleaning $1"; myfilter ...; }; f %f'

and then even without GIT_TRACE, you get:

  $ git add .
  cleaning .gitattributes

Or if you really just want to trigger for GIT_TRACE, try just this:

  $ git config filter.foo.clean 'f() { myfilter; }; f %f'
  19:52:52.874064 [pid=14719] git.c:415             trace: built-in: git add .
  19:52:52.875115 [pid=14719] run-command.c:637     trace: run_command: 'f() { myfilter; }; f '\''.gitattributes'\'''

There you get the name in the trace output, but the invoked command
doesn't actually do anything with it.

-Peff
