Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8580E201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 14:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752469AbdB1OhT (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 09:37:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:35668 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752303AbdB1OhR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 09:37:17 -0500
Received: (qmail 31441 invoked by uid 109); 28 Feb 2017 14:37:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 14:37:12 +0000
Received: (qmail 26639 invoked by uid 111); 28 Feb 2017 14:37:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 09:37:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 09:37:10 -0500
Date:   Tue, 28 Feb 2017 09:37:10 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Dmitry Neverov <dmitry.neverov@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Subject: Re: 'git submodules update' ignores credential.helper config of the
 parent repository
Message-ID: <20170228143710.smbzo6b7wefjc62r@sigill.intra.peff.net>
References: <CAC+L6n0YeX_n_AysCLtBWkA+jPHwg7HmOWq2PLj75byxOZE=qQ@mail.gmail.com>
 <CAGZ79ka8saQMKeutE415WxOQ71MnEw1A4uV3b0Pa4gcehx8pdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79ka8saQMKeutE415WxOQ71MnEw1A4uV3b0Pa4gcehx8pdw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 11:09:12AM -0800, Stefan Beller wrote:

> For worktrees these multiple config files sounded like
> the obvious solution, but I wonder if there was also
> some bike shedding about other solutions?
> 
> I could imagine that we would want to have attributes
> for specific configuration, e.g.:
> 
> --8<--
> [core]
>     repositoryformatversion = 0
>     filemode = true
>     bare = false
>     logallrefupdates = true
> [remote "origin"]
>     url = git://github.com/gitster/git
>     fetch = +refs/heads/*:refs/remotes/origin/*
> [attribute "submodules"]
>     read = true
> # this will be read and respected by submodules as well:
> [url."internal-git-miror"]
>     insteadOf = github.com
> [attribute "submodules"]
>     read = false
> # This (and the beginning of this file) will not be respected
> # by submodules
> [credential]
>     helper =
> -->8--
> 
> This would change the semantics of a config file as the attribute for
> each setting depends on the location (was attribute.FOO.read =
> {true, false} read before).

I'm not enthused by this, just because there is a hidden dependency
between attribute.* sections and other ones. They _look_ like regular
config keys, but they really aren't.

I have a feeling that something like this would create unwelcome corner
cases in the config-writer, which is otherwise does not have to care
about which existing section of a file it adds a key to.

-Peff
