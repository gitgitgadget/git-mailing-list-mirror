Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39DB5C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 22:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1196220706
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 22:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbgDVWNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:13:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:36658 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725839AbgDVWNg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 18:13:36 -0400
Received: (qmail 11825 invoked by uid 109); 22 Apr 2020 22:13:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 22:13:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3284 invoked by uid 111); 22 Apr 2020 22:24:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2020 18:24:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Apr 2020 18:13:34 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/3] credential: handle partial URLs in config settings
 again
Message-ID: <20200422221334.GA571740@coredump.intra.peff.net>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.615.git.1587588665.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 08:51:02PM +0000, Johannes Schindelin via GitGitGadget wrote:

> This fixes the problem illustrated by Peff's example
> [https://lore.kernel.org/git/20200422040644.GC3559880@coredump.intra.peff.net/]
> , in maint-2.17:
> 
>   $ echo url=https://example.com |
>     git -c credential.example.com.username=foo credential fill
>   warning: url has no scheme: example.com
>   fatal: credential url cannot be parsed: example.com
> 
> The fix is necessarily different than what was proposed by brian
> [https://lore.kernel.org/git/20200422012344.2051103-1-sandals@crustytoothpaste.net/] 
> because that fix targets v2.26.x which has 46fd7b390034 (credential: allow
> wildcard patterns when matching config, 2020-02-20).
> 
> This patch series targets maint-2.17 instead (and might actually not be able
> to fix maint due to that wildcard pattern patch; I haven't had the time to
> check yet).

Yes, this will remove the die() in all versions, but in v2.26.0 and up,
that config would be silently ignored (and your new test will fail).

> Please note that Git v2.17.4 will not do what we would expect here: if any
> host name (without protocol) is specified, e.g. -c
> credential.golli.wog.username = boo, it will actually ignore the host name.
> That is, this will populate the username:
> 
>   $ echo url=https://example.com |
>     git -c credential.totally.bog.us.username=foo credential fill

That seems scary. What if it is not .username, but:

  [credential "example.com"]
  username = foo
  helper = "!echo password=bar"

? (Or you can imagine a helper that is pulling from a read-only store,
like "pass"). That would send the credential to the wrong host.

I think any fix we do here needs to make sure we are not any
reintroducing wrong-host problems (though I do admit that the usage like
my example above is probably way less common than vanilla helpers that
do the host-selection themselves).

-Peff
