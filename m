Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 120252018D
	for <e@80x24.org>; Thu, 11 May 2017 06:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbdEKG0W (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 02:26:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:49129 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdEKG0V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 02:26:21 -0400
Received: (qmail 22348 invoked by uid 109); 11 May 2017 06:26:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 06:26:18 +0000
Received: (qmail 9423 invoked by uid 111); 11 May 2017 06:26:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 02:26:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 02:26:16 -0400
Date:   Thu, 11 May 2017 02:26:16 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sebastian Schuberth <sschuberth@gmail.com>,
        raphael.stolt@gmail.com, Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Possible bug in includeIf / conditional includes
Message-ID: <20170511062616.f7rg6f5cgrqeh7gf@sigill.intra.peff.net>
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com>
 <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com>
 <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 09:48:05PM +0200, Ævar Arnfjörð Bjarmason wrote:

> In both cases the conditional is the same, but the path is relative
> v.s. absolute.
> 
> Raphael: Does the config get included if you cd to
> ~/Work/git-repos/oss/? From git-config(1):

That shouldn't matter for relative paths in the "path" value; they're
never based on the cwd.  E.g., with this setup:

  export HOME=$PWD
  git config -f .gitconfig foo.bar "base value"
  git config -f .gitconfig includeIf."gitdir:$PWD/repo/".path included
  git config -f included foo.bar "HOME include"
  git init -q repo && cd repo
  git config -f included foo.bar "working tree include"
  git config -f .git/included foo.bar "GIT_DIR include"
  git config foo.bar

Looking at foo.bar should always give you one of

  HOME include - if you are in the repo that matches the includeIf
  base value - if you are not

but never the "working tree" or "GIT_DIR" includes.

> ---cut---
> The included file is expanded immediately, as if its contents had been
> found at the location of the include directive. If the value of the
> `include.path` variable is a relative path, the path is considered to
> be relative to the configuration file in which the include directive
> was found.  See below for examples.
> ---cut---
> 
> The commit that added IncludeIf (3efd0bedc6) does something with
> relative path (just skimming, need to get to other things), but unlike
> [Include] the docs don't explicitly mention what it's supposed to do
> with that, and all the examples show absolute paths.
> 
> So whether this is a bug in the code or not it seems to definitely be
> a doc bug, whatever it does with relative files should be in the docs.

The includeIf variables should behave exactly as the documentation you
quoted above. The conditional impacts whether we respect the keys in
that section, but not the meaning of the keys.

I thought that was clear, but as somebody who was involved in the
development of both the original and the conditional includes, my
opinion probably doesn't count. I wouldn't mind a patch to make that
more explicit in the documentation.

-Peff
