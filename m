Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25946207D6
	for <e@80x24.org>; Tue,  2 May 2017 03:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbdEBDHw (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 23:07:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:43599 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbdEBDHv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 23:07:51 -0400
Received: (qmail 16521 invoked by uid 109); 2 May 2017 03:07:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 02 May 2017 03:07:50 +0000
Received: (qmail 8732 invoked by uid 111); 2 May 2017 03:08:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 23:08:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 May 2017 23:07:47 -0400
Date:   Mon, 1 May 2017 23:07:47 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] credential doc: make multiple-helper behavior more
 prominent (Re: [PATCH] clone: handle empty config values in -c)
Message-ID: <20170502030747.k4hpmyyoapcinfap@sigill.intra.peff.net>
References: <20170502000515.GU28740@aiede.svl.corp.google.com>
 <20170502000856.GI39135@google.com>
 <20170502002114.GV28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170502002114.GV28740@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2017 at 05:21:14PM -0700, Jonathan Nieder wrote:

> Subject: credential doc: make multiple-helper behavior more prominent
> 
> Git's configuration system works by reading multiple configuration
> files in order, from general to specific:
> 
>  - first, the system configuration /etc/gitconfig
>  - then the user's configuration (~/.gitconfig or ~/.config/git/config)
>  - then the repository configuration (.git/config)
> 
> For single-valued configuration items, the latest value wins.  For
> multi-valued configuration items, values accumulate in that order.
> 
> For example, this allows setting a credential helper globally in
> ~/.gitconfig that git will try to use in all repositories, regardless
> of whether they additionally provide another helper.  This is usually
> a nice thing --- e.g. I can install helpers to use my OS keychain and
> to cache credentials for a short period of time globally.
> 
> Sometimes people want to be able to override an inherited setting.
> For the credential.helper setting, this is done by setting the
> configuration item to empty before giving it a new value.  This is
> already documented by the documentation is hard to find ---
> git-config(1) says to look at gitcredentials(7) and the config
> reference in gitcredentials(7) doesn't mention this issue.
> 
> Move the documentation to the config reference to make it easier to
> find.

I know I am the last person in the world to criticize somebody for being
too verbose in a commit message, but... :)

I think this background about how multi-values are handled isn't that
useful here, because we're not changing anything to do with that. We're
just moving the documentation around. So I think a more compelling
explanation would focus on the documentation locations. Like:

  The behavior of multiple credential.helper config values is explained
  in the rather-large "AVOIDING REPETITION" section of
  gitcredentials(7), but not mentions at all in the "CONFIGURATION
  OPTIONS" section. That's OK if the user is reading the manpage from
  top to bottom, but users often don't do that. The entry for
  credential.helper in git-config(1) points them to gitcredentials(7),
  which would make it reasonable for them to skip straight to the
  "CONFIGURATION OPTIONS" section.

With or without the suggested commit message, this looks like an
improvement to me.

> > After reading this I'm still a little fuzzy on why the empty helper line
> > is needed to avoid using the credential helper from /etc/gitconfig.
> 
> See "git help credentials":
> 
>        If there are multiple instances of the credential.helper configuration
>        variable, each helper will be tried in turn, and may provide a
>        username, password, or nothing. Once Git has acquired both a username
>        and a password, no more helpers will be tried.
> 
>        If credential.helper is configured to the empty string, this resets the
>        helper list to empty (so you may override a helper set by a
>        lower-priority config file by configuring the empty-string helper,
>        followed by whatever set of helpers you would like).
> 
> That's a bit obscure, though --- I didn't find it when I looked in "git
> help config".  How about this patch?

So I think this looks fine, but I wonder if we should discuss multi-vars
some in Documentation/config.txt. It would be really nice if we could
claim "the usual behavior for multi-vars is to reset the list upon
seeing an empty entry". But probably we should make sure more of them
handle that before making such a claim. :)

-Peff
