Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 633271FC43
	for <e@80x24.org>; Fri,  6 Oct 2017 14:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751536AbdJFOcX (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 10:32:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:35310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751495AbdJFOcW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 10:32:22 -0400
Received: (qmail 6990 invoked by uid 109); 6 Oct 2017 14:32:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 14:32:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6640 invoked by uid 111); 6 Oct 2017 14:32:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Oct 2017 10:32:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Oct 2017 10:32:20 -0400
Date:   Fri, 6 Oct 2017 10:32:20 -0400
From:   Jeff King <peff@peff.net>
To:     "aleksander.baranowski" <aleksander.baranowski@yahoo.pl>
Cc:     git@vger.kernel.org
Subject: Re: Git config multiple values
Message-ID: <20171006143219.4bn63aoenluc77fd@sigill.intra.peff.net>
References: <4b848032-e8b6-be67-58d9-e3fcc2c11853@yahoo.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4b848032-e8b6-be67-58d9-e3fcc2c11853@yahoo.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 06, 2017 at 01:10:17PM +0200, aleksander.baranowski wrote:

> I'm currently using git version 2.14.2. There is possible to put
> multiple values into same variable with git config.

Yep, your examples should behave the same even with older versions.

> Case 1:
> # git config --global user.name Foo - returns 0
> # git config --global user.name Bar - returns 0 and replace Foo to Bar
> # git config --global user.name Foo - returns 0 and replace Bar to Foo

This is all as expected. You're hitting the first case in the manpage
synopsis here (I snipped the uninteresting options):

  git config name [value [value_regex]]

So you're doing:

  git config name value

which replaces any existing key by default. You could also do:

  git config --add name value

to add without replacing (if you had a config key that takes multiple
values).

> Case 2:
> # git config --global user.name Foo - returns 0
> # git config --global user.name Foo2 Bar - returns 0 and put second name

Here you're doing:

  git config name value value_regex

So we're replacing any values which match the regex "Bar" (and there are
none), and leaving others intact. Hence after this you will have two
user.name values.

If you wanted a name with two strings, you'd have to quote the string
from the shell to leave it as a single argument:

  git config user.name "Foo2 Bar"

> # cat ~/.gitconfig
> [user]
> 	email = aleksander.baranowski@yahoo.pl
> 	name = Foo
> 	name = Foo2

Right, this is what I'd expect.

> # git config --global user.name Foo - return 5 and message
> "warning: user.name has multiple values
> error: cannot overwrite multiple values with a single value
>        Use a regexp, --add or --replace-all to change user.name."

And this, too (though I forgot we had such a safety check).

> It's just an opinion, but this behaviour is no consistent for me.
> 
> If it's not the bug it's a feature just let me know.

It's a feature, though I agree that git-config is rather baroque. We're
mostly stuck with it for reasons of backwards compatibility, though.

-Peff
