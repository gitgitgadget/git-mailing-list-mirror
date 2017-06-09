Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 981801FAEB
	for <e@80x24.org>; Fri,  9 Jun 2017 05:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdFIFt7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 01:49:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:36948 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751510AbdFIFt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 01:49:58 -0400
Received: (qmail 1968 invoked by uid 109); 9 Jun 2017 05:49:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Jun 2017 05:49:58 +0000
Received: (qmail 18847 invoked by uid 111); 9 Jun 2017 05:49:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 09 Jun 2017 01:49:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jun 2017 01:49:55 -0400
Date:   Fri, 9 Jun 2017 01:49:55 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Heiduk <asheiduk@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] add setup step to filter-branch
Message-ID: <20170609054955.y52cro2c3bwhl2sh@sigill.intra.peff.net>
References: <20170603101755.13619-1-asheiduk@gmail.com>
 <xmqq1sqzuqmh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sqzuqmh.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 05, 2017 at 11:15:18AM +0900, Junio C Hamano wrote:

> Andreas Heiduk <asheiduk@gmail.com> writes:
> 
> > A specific `--setup` step in `git filter-branch` makes it much easier
> > to define the initial values of variables used in the real filters.
> > Also sourcing/defining utility functions here instead of
> > `--env-filter` improves performance and minimizes clogging the output
> > in case of errors.
> >
> > Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> > ---
> 
> I was placed on To: line, but I do not have a strong opinion on this
> change, either for or against.
> 
> "filter-branch" program itself may probably already be hard to port
> to C, but I need to point out that this makes it even harder than it
> currently is [*1*], and it is likely that it has to stay implemented
> in shell forever, though.  I do not mind that future myself, but
> those on platforms with weaker implementation of shells might.

I have a feeling that if we were ever to rewrite filter-branch, it would
probably be worth allowing people to write snippets in a better language
(possibly even a domain-specific language). I'm sure that most of the
program being written in shell doesn't help, but if we're spawning one
or more shell instances per commit (plus the Git programs they spawn!),
it's always going to be slow.

But I suspect that would be an uphill battle, as our only stable API
involves starting external processes anyway. You'd probably do better to
pick a language you like and rewrite it in using libgit2's bindings to
that language. It's not feature complete, but basic stuff like "put this
entry in the tree" is certainly mature.

>  *1* The issue is *not* that these individual filter commands expect
>      <command> written as a shell scriptlet; it is that these
>      scriptlets expect to be evaled inside a single shell process,
>      making an update to a shell variable in one command visible to
>      the next command that runs.

I think you'd need a shell "helper" that's a single long-running process
and just reads "eval the index snippet now" instructions from the C
controller. At which point I don't think Andreas's "setup" feature is
any harder to support. We just send an "eval the setup snippet"
instruction first.

I guess one way to think of that is that the C program is itself
generating a shell script.

-Peff
