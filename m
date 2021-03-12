Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1345C433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42F664F80
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbhCLUaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:30:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:34224 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234675AbhCLU3z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 15:29:55 -0500
Received: (qmail 30631 invoked by uid 109); 12 Mar 2021 20:29:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 12 Mar 2021 20:29:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24764 invoked by uid 111); 12 Mar 2021 20:29:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 12 Mar 2021 15:29:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 12 Mar 2021 15:29:53 -0500
From:   Jeff King <peff@peff.net>
To:     John Ratliff <john@technoplaza.net>
Cc:     git@vger.kernel.org
Subject: Re: git credential cache and sudo
Message-ID: <YEvPQS1+1sxd/aGw@coredump.intra.peff.net>
References: <CAP8UukjW_TeswTHHfiwzc989U+wZMVcHeS1siRF0Rbg5nc3D5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UukjW_TeswTHHfiwzc989U+wZMVcHeS1siRF0Rbg5nc3D5w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 12, 2021 at 11:43:46AM -0500, John Ratliff wrote:

> When I do sudo git pull, git does not know about my credential cache.
> 
> On some servers, when I do a sudo -E git pull, it can find my
> credential cache and use it. On other servers, I think the sudo
> configuration is stripping the environment, so this doesn't work and I
> still have to enter my git credentials.
> 
> What environment variables do I need to configure sudo to preserve to
> make sudo -E git pull work with my credential cache? Or is there
> something else I can pass to git or define to get it to use my
> credential cache?

From "git help credential-cache":

  --socket <path>
    Use <path> to contact a running cache daemon (or start a new cache daemon if
    one is not started).  Defaults to $XDG_CACHE_HOME/git/credential/socket
    unless ~/.git-credential-cache/ exists in which case
    ~/.git-credential-cache/socket is used instead. If your home directory is on
    a network-mounted filesystem, you may need to change this to a local
    filesystem. You must specify an absolute path.

So probably sudo is setting $HOME (even if using $XDG_CACHE_HOME, that defaults
to $HOME/.cache).

You can specify arguments to a helper in your config file, like:

  [credential]
  helper = "cache --socket /home/youruser/.git-credential-cache/socket"

which will make the location independent of $HOME.

Note that it's a little funky to be accessing the cache as a different user than
the one who created it. This should work reliably when the cache was created by
your normal user, but then accessed as root, because root has permissions to
access the socket. But if you spawn a cache daemon as root (because the _first_
operation you perform is as root, which automatically starts a daemon to store
the cached credential), then it's likely you won't be able to access it as your
regular user.

-Peff
