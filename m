Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E54201B0
	for <e@80x24.org>; Thu, 23 Feb 2017 00:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932634AbdBWAtW (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 19:49:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:60387 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932611AbdBWAtU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 19:49:20 -0500
Received: (qmail 5152 invoked by uid 109); 23 Feb 2017 00:42:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 00:42:38 +0000
Received: (qmail 15811 invoked by uid 111); 23 Feb 2017 00:42:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 19:42:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2017 19:42:35 -0500
Date:   Wed, 22 Feb 2017 19:42:35 -0500
From:   Jeff King <peff@peff.net>
To:     Tushar Kapila <tgkprog@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: feature request: user email config per domain
Message-ID: <20170223004235.lsfyboofmqg6btt7@sigill.intra.peff.net>
References: <CAN0Skmmjd5Y0uWz_WC69mAStucZ6nR0mjdp4-ODJz2UnTaB-eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN0Skmmjd5Y0uWz_WC69mAStucZ6nR0mjdp4-ODJz2UnTaB-eQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 22, 2017 at 06:42:02PM +0530, Tushar Kapila wrote:

> Feature request :  can we have a config for email per repo domain ?
> Something like:
> 
> git config --global domain.user.email tgkprog@test.xyz.com
> testing.abc.doman:8080
> 
> git config --global domain.user.email tgkprog@xyz.com abc.doman:80
> 
> git config --global domain.user.email tgkprog@search.com github.com
> 
> So when remote URL has github.com push as tgkprog@search.com but for
> testing.abc.doman:8080 use tgkprog@test.xyz.com ?

The idea of "the domain for this repo" doesn't really match Git's
distributed model. A repo may have no remotes at all, or multiple
remotes with different domains (or even remotes which do not have a
domain associated with them, like local files, or remote helpers which
obscure the domain name).

It sounds like you're assuming that the domain would come from looking
at remote.origin.url. Which I agree would work in the common case of
"git clone https://example.com", but I'm not comfortable with the number
of corner cases the feature has.

I'd much rather see something based on the working tree path, like Duy's
conditional config includes. Then you write something in your
~/.gitconfig like:

  [include "gitdir:/home/peff/work/"]
  path = .gitconfig-work

  [include "gitdir:/home/peff/play/"]
  path = .gitconfig-play

and set user.email as appropriate in each.

You may also set user.useConfigOnly in your ~/.gitconfig. Then you'd
have to set user.email in each individual repository, but at least Git
would complain and remind you when you forget to do so, rather than
silently using the wrong email.

-Peff
