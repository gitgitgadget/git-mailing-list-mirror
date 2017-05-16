Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 561C2201A7
	for <e@80x24.org>; Tue, 16 May 2017 03:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750970AbdEPDyC (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 23:54:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:52387 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750759AbdEPDyB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 23:54:01 -0400
Received: (qmail 29777 invoked by uid 109); 16 May 2017 03:54:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 May 2017 03:54:00 +0000
Received: (qmail 24200 invoked by uid 111); 16 May 2017 03:54:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 23:54:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 23:53:58 -0400
Date:   Mon, 15 May 2017 23:53:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Rannaud <eric.rannaud@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly
 to --exec
Message-ID: <20170516035357.2wutcd2tyax4tjyn@sigill.intra.peff.net>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net>
 <xmqqr2zp31vg.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr2zp31vg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 16, 2017 at 12:40:51PM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Interesting. The "exec" string is still run with a shell. E.g.:
> > ...
> > I wonder if this is falling afoul of the optimization in run-command's
> > prepare_shell_cmd() to skip shell invocations for "simple" commands.
> > ...
> > So I suspect if you added an extraneous semi-colon, your case would work
> > again (and that would confirm for us that this is indeed the problem).
> 
> Wow, that's a brilliant analysis.

If it's right. :) It's all theory at this point.

My /bin/sh isn't bash, but I should be able to build with
SHELL_PATH=/bin/bash to reproduce. But I can't:

   $ bash
   $ foo() { echo >&2 "in foo"; }
   $ export -f foo
   $ bash -c foo
   in foo

   $ strace -f 2>&1 git.compile rebase -x 'foo;' HEAD^ | grep foo
   Executing: foo;
   [pid  1788] execve("/bin/bash", ["/bin/bash", "-c", "foo;", "foo;"], [/* 60 vars */] <unfinished ...>
   foo;: foo: command not found

So I'm not sure why the direct "bash -c" can find it, but somehow the
variable doesn't make it through to the "bash -c" at the lower level.
Replacing "foo;" with "env" shows the environment, but BASH_FUNC_foo
isn't set in it. I'm not sure where it's getting eaten, though.

> The "semicolon" trick is way too obscure, but perhaps can be
> documented as an escape hatch?

Yeah, I agree this should be documented if it can't be fixed. I wasn't
sure if we were giving up just yet.

Either way, though, it wouldn't hurt to mention optimizing out "maybe
shell" optimization, because it can occasionally produce user-visible
effects. Where would be a good place? In git(1), I guess?

It's almost something that could go in gitcli(7), but it's not really
about the CLI in particular. In most cases the shell-exec'd commands are
from config, but not always (as this case shows). So git-config(1)
probably isn't the right place.

AFAIK, we don't talk about this behavior at all in the existing
documentation. And I really don't know where we'd put it that somebody
would find it without having to read the documentation exhaustively.

-Peff
