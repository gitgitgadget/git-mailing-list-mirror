Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC8E21F516
	for <e@80x24.org>; Tue, 26 Jun 2018 12:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935173AbeFZMnS (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 08:43:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:55278 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932438AbeFZMnS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 08:43:18 -0400
Received: (qmail 8223 invoked by uid 109); 26 Jun 2018 12:43:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Jun 2018 12:43:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29135 invoked by uid 111); 26 Jun 2018 12:43:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Jun 2018 08:43:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jun 2018 08:43:16 -0400
Date:   Tue, 26 Jun 2018 08:43:16 -0400
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: curious about wording in "man git-config", ENVIRONMENT
Message-ID: <20180626124316.GA15419@sigill.intra.peff.net>
References: <alpine.LFD.2.21.1806260608270.6007@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1806260608270.6007@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 06:18:26AM -0400, Robert P. J. Day wrote:

> 
>   ENVIRONMENT
>     GIT_CONFIG
>       Take the configuration from the given file instead of
>       .git/config. Using the "--global" option forces this to
>       ~/.gitconfig. Using the "--system" option forces this to
>       $(prefix)/etc/gitconfig.
> 
>   is the phrase "forces this to" really what you want to use here?
> maybe i misunderstand what this option does, doesn't it simply mean
> that it will use a different (specified) file from the default,
> depending on the context (local, global, system)?
> 
>   it just seems weird to say that the option "forces" the use of what
> are clearly the default files. thoughts?

I agree it's weird. I think it's trying to mean "behaves as if it was
set to", but with the additional notion that the command-line argument
would take precedence over the environment (which is our usual rule).
But then we should just say those things explicitly.

Just looking at mentions of GIT_CONFIG in that manpage and knowing the
history, I think:

 - the environment section should say something like:

     GIT_CONFIG
       If set and no other specific-file options are given, behaves as
       if `--file=$GIT_CONFIG` was provided on the command-line.

 - possibly the manpage should mention that GIT_CONFIG is historical and
   should not be used in new code (we could also consider an actual
   deprecation period and removal of the feature, though aside from
   documentation confusion I do not think it is hurting anyone)

 - the description of --file should not mention it at all. Instead it
   should reference the "FILES" section which describes the whole lookup
   sequence

 - mention of GIT_CONFIG should be dropped from the FILES section. We
   don't want to point people towards using it. And if they come across
   it in the wild, they can find it in the ENVIRONMENT section.

 - references to "--global" should stop mentioning ~/.gitconfig,
   since in a post-XDG world it could be elsewhere (they're better to
   refer to the "--global" description or the FILES section)

 - references to "--system" should stop mentioning $(prefix)/etc/gitconfig,
   since it can be configured separately from the prefix (and in most
   packaged builds which set prefix=/usr, $(sysconfdir) is not
   $(prefix)/etc).

-Peff
