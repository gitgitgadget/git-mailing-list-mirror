Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2AD61F406
	for <e@80x24.org>; Thu, 11 Jan 2018 10:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933025AbeAKKHh (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 05:07:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:41006 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932982AbeAKKHh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 05:07:37 -0500
Received: (qmail 26950 invoked by uid 109); 11 Jan 2018 10:07:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Jan 2018 10:07:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21835 invoked by uid 111); 11 Jan 2018 10:08:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Jan 2018 05:08:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jan 2018 05:07:35 -0500
Date:   Thu, 11 Jan 2018 05:07:35 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] run-command.c: print env vars when GIT_TRACE is set
Message-ID: <20180111100734.GA17274@sigill.intra.peff.net>
References: <20180110104835.22905-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180110104835.22905-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 05:48:35PM +0700, Nguyễn Thái Ngọc Duy wrote:

> Occasionally submodule code could execute new commands with GIT_DIR set
> to some submodule. GIT_TRACE prints just the command line which makes it
> hard to tell that it's not really executed on this repository.
> 
> Print env variables in this case. Note that the code deliberately ignore
> variables unsetting because there are so many of them (to keep git
> environment clean for the next process) and really hard to read.

I like this, and I'm pretty sure it would have helped me debug at least
once in the past. I did notice one funny thing, though I think it was
largely there before.

The output for a single command is pretty shell-like due to the quoting:

  $ GIT_TRACE=1 ./git upload-pack . >/dev/null
  [...]run_command: 'git-upload-pack' '.'

You could copy and paste that to a shell if you wanted.  And with
environment variables, that remains so:

  $ GIT_TRACE=1 ./git ls-remote https://github.com/git/git >/dev/null
  [...]run_command: 'GIT_DIR=.git' 'git-remote-https' 'https://[...]'

But if we're actually running a command via the shell, it all gets
quoted as one argument:

  $ GIT_TRACE=1 GIT_PAGER='foo | bar' ./git log
  [...]run_command: 'LV=-c' 'foo | bar'

which is kind of weird, as that's not something that can be run in a
shell. This isn't introduced by your patch at all, but I noticed it more
because of the shell-like environment variable output.

We actually used to print a separate:

  exec: /bin/sh -c 'foo | bar'

line when we invoked a shell, which would arguably be the right place to
show the env variables for such a case. But that went away with
3967e25be1 (run-command: prepare command before forking, 2017-04-19).

I think it might be helpful if we added back in "/bin/sh -c" to the
run_command line when "use_shell" is in effect (and when we're not doing
our "skip the shell" trickery).  But that's totally orthogonal to your
patch.

And anyway, it's just tracing output, so I don't think it's incredibly
important either way. It was just something I noticed while looking at
your patch's output.

-Peff
