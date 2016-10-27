Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB0320193
	for <e@80x24.org>; Thu, 27 Oct 2016 21:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941619AbcJ0VH4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 17:07:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:35036 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934631AbcJ0VH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 17:07:56 -0400
Received: (qmail 378 invoked by uid 109); 27 Oct 2016 21:07:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 21:07:55 +0000
Received: (qmail 23593 invoked by uid 111); 27 Oct 2016 21:08:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 17:08:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2016 17:07:53 -0400
Date:   Thu, 27 Oct 2016 17:07:53 -0400
From:   Jeff King <peff@peff.net>
To:     Aaron Pelly <aaron@pelly.co>
Cc:     git@vger.kernel.org
Subject: Re: Expanding Includes in .gitignore
Message-ID: <20161027210753.btc7zbndhdocsbwa@sigill.intra.peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
 <b20b458c-440d-df09-d2c7-e510ac20492c@pelly.co>
 <20161027205508.vqw44zlbnqpj2cvd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161027205508.vqw44zlbnqpj2cvd@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 27, 2016 at 04:55:08PM -0400, Jeff King wrote:

> On Fri, Oct 28, 2016 at 09:28:23AM +1300, Aaron Pelly wrote:
> 
> > >   - we parse possibly-hostile .gitignore files from cloned repositories.
> > >     What happens when I include ask to include /etc/passwd? Probably
> > >     nothing, but there are setups where it might matter (e.g., something
> > >     like Travis that auto-builds untrusted repositories, and you could
> > >     potentially leak the contents of files via error messages). It's
> > >     nice to avoid the issue entirely.
> > 
> > I understand the issue.
> > 
> > It's not obvious to me how using a .d solves this problem though.
> 
> It doesn't by itself. But we are worried only about tracked .gitignore
> files (recall that even repo-level files in $GIT_DIR/info are generated
> fresh by the clone process, and don't come from the remote). If we apply
> the feature only to core.excludeFile and $GIT_DIR/info/exclude, those
> are already under the user's control.
> 
> It's true that we could make a similar exception for an "include"
> feature, and respect include directives only in those "safe" files.
> Somehow that seems more confusing to me, though, than doing adding the
> feature at the file level, as it introduces slightly varying syntax
> between the locations.

Actually, I suppose even a ".gitignore.d" inside the repo solves that
problem, too, because the repository is not specifying paths, only
content (it can specify symlinks outside the repository, but like other
parts of git, we should be careful not to follow them in that case).

However, as I said elsewhere, I'm not convinced this feature is all that
helpful for in-repository .gitignore files, and I think it does
introduce compatibility complications. People with older git will not
respect your .gitignore.d files. Whereas $GIT_DIR/info is purely a local
matter.

But perhaps there is a use case I'm missing.

-Peff
