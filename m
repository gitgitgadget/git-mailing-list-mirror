Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5E791F4F8
	for <e@80x24.org>; Fri, 23 Sep 2016 03:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbcIWDlR (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 23:41:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:46976 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751125AbcIWDlR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 23:41:17 -0400
Received: (qmail 24015 invoked by uid 109); 23 Sep 2016 03:41:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 03:41:16 +0000
Received: (qmail 14184 invoked by uid 111); 23 Sep 2016 03:41:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 23:41:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 23:41:13 -0400
Date:   Thu, 22 Sep 2016 23:41:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
Message-ID: <20160923034113.4rnps3nogvzxkfjx@sigill.intra.peff.net>
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
 <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
 <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com>
 <CAKoko1qch_odsEWba0rtCv-DWO0ABS2yprnwGPCgyT6-7H-LdQ@mail.gmail.com>
 <xmqqponw6e3x.fsf@gitster.mtv.corp.google.com>
 <20160922041854.7754ujcynhk7mdnh@sigill.intra.peff.net>
 <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7fa36bwm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 11:13:13AM -0700, Junio C Hamano wrote:

> In any case, I would strongly recommend against exposing this (or
> anything for that matter) "--prefix" to the end-user, especially
> because this feature is likely to be applicable to many subcommands,
> and some subcommands would want different sort of prefixing made to
> different things.

Fair enough. I was thinking that this was similar to other options like
"read-tree --prefix" or "archive --prefix". But if nobody really wants
it for anything non-internal, then certainly keeping it as an internal
feature is an easy way to avoid being stuck with a bad public interface
in the long term.

> What we internally call "prefix" and "--submodule-prefix" is closely
> related in that they both interact with pathspecs.

Yeah, I didn't think about pathspecs at all (since they are totally
disabled in patch 1, and I hadn't really read through patch 2 carefully
yet).

>  * As Stefan alluded to (much) earlier, it might be a better idea
>    to have these 'prefix' as the global option to "git" potty, not
>    to each subcommand that happens to support them;

That seems like it would be nice, but there's going to be an interim
period where some commands do not respect the global "--prefix" at all
(in the worst case, consider a third party command).

>  * It is unclear how this should interact with commands that are run
>    in a subdirectory of the working tree.  E.g. what should the
>    prefix and the pathspec look like if the command in the above
>    example is started in w/git.git/Documentation subdirectory, i.e.
> 
>     $ cd ~
>     $ git -C w/git.git/Documentation ls-files \
>         --submodule-prefix=??????? -- '???????' |
>       xargs ls -1 -l
> 
>    Should we error out if we are not at the top of the working tree
>    when --submodule-prefix is given?

Without thinking too hard on it, it seems like the submodule prefix
just needs to come after the normal "prefix" that we add when moving to
the top-level of a tree. So:

  cd foo
  git ls-files --submodule-prefix=bar

should show "foo/bar". Or another way of thinking about it is that the
submodule prefix is always relative to the current directory. Recursion
into submodule would always happen at their top-level, and so would do
the right thing.

But again, that's without thinking hard on it. There may be some corner
cases.

-Peff
