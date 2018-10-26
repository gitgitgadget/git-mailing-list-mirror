Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9E7B1F453
	for <e@80x24.org>; Fri, 26 Oct 2018 07:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbeJZQen (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 12:34:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:55438 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725914AbeJZQen (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 12:34:43 -0400
Received: (qmail 1386 invoked by uid 109); 26 Oct 2018 07:58:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 26 Oct 2018 07:58:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26120 invoked by uid 111); 26 Oct 2018 07:57:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 26 Oct 2018 03:57:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2018 03:58:41 -0400
Date:   Fri, 26 Oct 2018 03:58:41 -0400
From:   Jeff King <peff@peff.net>
To:     Raphael Stolt <raphael.stolt@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Possible bug in referenced configuration file loading
Message-ID: <20181026075841.GB3119@sigill.intra.peff.net>
References: <CAM-9DY2KVjq2879TJUNhBsRBbAjScMS7U5scP-fAY0NsvCan9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM-9DY2KVjq2879TJUNhBsRBbAjScMS7U5scP-fAY0NsvCan9A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 09:30:51AM +0200, Raphael Stolt wrote:

> Configuration for global ignore patterns in ~/.config/git/config:
> 
> [core]
>     excludesfile = .gitignore
> 
> doesn't get looked up per default in ~/.config/git/ which might be
> considered a bug as the .gitignore file isn't loaded. It's only loaded
> when .gitignore is located in $HOME or explicitly referenced via
> ~/.config/git/.gitignore.

I don't think we ever defined or documented any behavior for relative
paths in core.excludesFile (nor most other path-based config options).

I suspect it also changes depending on the command, as well as whether
it is a bare or non-bare repository. Because I think it is probably just
wherever the cwd happens to be at the time we parse the config, which is
usually at the top of the working tree (non-bare) or inside the
repository (bare).

> Configuration for a conditional include also in ~/.config/git/config:
> 
> [includeIf "gitdir:~/Work/git-repos/"]
>     path = .oss-gitconfig
> 
> does get looked up per default in ~/.config/git/ and  therefor the
> .oss-gitconfig is loaded.

Whereas config includes have always explicitly advertised from day one
the behavior of relative paths (that they match the surrounding config
file).

I am not opposed to coming up with a rule for relative paths in
excludesFile and other config options. The "pretend as if it is next to
the enclosed config file" rule is sensible to me, but that is not
surprising since I was the one who implemented it for includes. ;)

We'd potentially break some people's config, but I suspect such config
is flaky already (see above).

It would be nice if this were implemented via git_config_pathname() for
consistency, but beware that some options already do specify a behavior
for relative paths, and we would have to make sure not to break that
(e.g., see the documentation and implementation for core.hooksPath).

-Peff
