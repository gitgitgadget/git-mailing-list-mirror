Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C8321FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 08:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbdFJIkT (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 04:40:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:37558 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751844AbdFJIkS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 04:40:18 -0400
Received: (qmail 4357 invoked by uid 109); 10 Jun 2017 08:40:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 08:40:17 +0000
Received: (qmail 29627 invoked by uid 111); 10 Jun 2017 08:40:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 04:40:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 04:40:16 -0400
Date:   Sat, 10 Jun 2017 04:40:16 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] discover_git_directory(): avoid setting invalid
 git_dir
Message-ID: <20170610084015.ej62tkw7gb26z4no@sigill.intra.peff.net>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
 <effd58a564e54ccd3d695d91bc9c4f32255b8ab7.1496951503.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <effd58a564e54ccd3d695d91bc9c4f32255b8ab7.1496951503.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2017 at 09:53:32PM +0200, Johannes Schindelin wrote:

> When discovering a .git/ directory, we take pains to ensure that its
> repository format version matches Git's expectations, and we return NULL
> otherwise.
> 
> However, we still appended the invalid path to the strbuf passed as
> argument.
> 
> Let's just reset the strbuf to the state before we appended the .git/
> directory that was eventually rejected.
> 
> There is another early return path in that function, when
> setup_git_directory_gently_1() returns GIT_DIR_NONE or an error. In that
> case, the gitdir parameter has not been touched, therefore there is no
> need for an equivalent change in that code path.

After reading this, I thought at first this was a user-visible (albeit
obscure) bug where something like:

  git init
  git init bogus
  cd bogus
  git config core.repositoryformatversion 5

would mean that early-config barfs on seeing our bogus ".git", but that
screws up the discovery going back to the real repository root. But
that's not the case, because we always stop walking anyway when we see
such a bogus git dir.

So it's just a cleanup (though obviously a sensible one).

-Peff
