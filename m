Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CEBC205C9
	for <e@80x24.org>; Thu,  5 Jan 2017 17:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbdAEREi (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jan 2017 12:04:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:35614 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754743AbdAERDo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2017 12:03:44 -0500
Received: (qmail 1937 invoked by uid 109); 5 Jan 2017 17:02:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Jan 2017 17:02:17 +0000
Received: (qmail 10201 invoked by uid 111); 5 Jan 2017 17:03:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Jan 2017 12:03:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jan 2017 12:02:15 -0500
Date:   Thu, 5 Jan 2017 12:02:15 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Stefan Schindler <stsch@boxbox.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: core.sshCommand and url.*.insteadOf for submodules
Message-ID: <20170105170214.6fmsbj6ltbmpvcfb@sigill.intra.peff.net>
References: <17f2724d-7001-203e-f0b5-cf586703a41a@boxbox.org>
 <CAGZ79kb8TTaJBmVCWK3jnr4RvGjmfmsj3-ieT87wzyFLYi5frQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kb8TTaJBmVCWK3jnr4RvGjmfmsj3-ieT87wzyFLYi5frQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 05, 2017 at 05:53:30AM -0800, Stefan Beller wrote:

> > My scenario is as follows: I use 2 SSH keys for GitHub, for private and
> > work-related repositories. My default key is my private key. So when I
> > clone a work repository and try getting the submodules, `git submodule
> > update --init` fails. This is also the case when setting
> > `core.sshCommand` and `url.*.insteadOf` (useful for substituting
> > "github.com" by some ~/.ssh/config'ured host).
> 
> which is why e.g.
> git config --global url.https://github.com/.insteadOf git://github.com/
> is not your preferred way here.
> 
> There was some discussion a couple of weeks ago, which settings
> should be kept when recursing into submodules, Jacob and Jeff cc'd.

The only discussion I recall was from last May. But that was about "-c"
config on the command-line, and the end decision was that we pass it all
down to submodules, per 89044baa8b (submodule: stop sanitizing config
options, 2016-05-04).

I think the problem here is more about propagating options from the
superproject's repo-level config into the submodules. AFAIK we do not do
that at all, but I may have missed some patches in that area.

Another approach would be conditional config includes based on the repo
path. With the patches discussed in [1], you could do something like:

  git config --global include./path/to/work/repos.path .gitconfig-work
  git config -f ~/.gitconfig-work url.foo.insteadOf bar

-Peff

[1] http://public-inbox.org/git/20160626070617.30211-1-pclouds@gmail.com/
