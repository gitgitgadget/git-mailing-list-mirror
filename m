Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4980C20193
	for <e@80x24.org>; Thu, 27 Oct 2016 20:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935096AbcJ0UzM (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 16:55:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:35021 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933171AbcJ0UzL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 16:55:11 -0400
Received: (qmail 31769 invoked by uid 109); 27 Oct 2016 20:55:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 20:55:11 +0000
Received: (qmail 23215 invoked by uid 111); 27 Oct 2016 20:55:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 27 Oct 2016 16:55:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Oct 2016 16:55:08 -0400
Date:   Thu, 27 Oct 2016 16:55:08 -0400
From:   Jeff King <peff@peff.net>
To:     Aaron Pelly <aaron@pelly.co>
Cc:     git@vger.kernel.org
Subject: Re: Expanding Includes in .gitignore
Message-ID: <20161027205508.vqw44zlbnqpj2cvd@sigill.intra.peff.net>
References: <80919456-7563-2c16-ba23-ce4fcc2777de@pelly.co>
 <20161027105026.e752znq5jv5a6xea@sigill.intra.peff.net>
 <b20b458c-440d-df09-d2c7-e510ac20492c@pelly.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b20b458c-440d-df09-d2c7-e510ac20492c@pelly.co>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 09:28:23AM +1300, Aaron Pelly wrote:

> >   - we parse possibly-hostile .gitignore files from cloned repositories.
> >     What happens when I include ask to include /etc/passwd? Probably
> >     nothing, but there are setups where it might matter (e.g., something
> >     like Travis that auto-builds untrusted repositories, and you could
> >     potentially leak the contents of files via error messages). It's
> >     nice to avoid the issue entirely.
> 
> I understand the issue.
> 
> It's not obvious to me how using a .d solves this problem though.

It doesn't by itself. But we are worried only about tracked .gitignore
files (recall that even repo-level files in $GIT_DIR/info are generated
fresh by the clone process, and don't come from the remote). If we apply
the feature only to core.excludeFile and $GIT_DIR/info/exclude, those
are already under the user's control.

It's true that we could make a similar exception for an "include"
feature, and respect include directives only in those "safe" files.
Somehow that seems more confusing to me, though, than doing adding the
feature at the file level, as it introduces slightly varying syntax
between the locations.

> > Whereas letting any of the user- or repo-level exclude files be a
> > directory, and simply reading all of the files inside, seems simple and
> > obvious.
> 
> Apart from backwards compatibility, unless there's something I'm missing.

I'm not sure what you mean. If we make:

  mkdir .git/info/exclude
  echo whatever >.git/info/exclude/local

work, I don't think we have to care about backwards compatibility. That
was nonsensical before, and never did anything useful (so somebody might
have done it, but we can assume anybody relying on it not to read the
contents is crazy).

> > It
> > can't handle all cases (some items in "00foo" want precedence over "01bar"
> > and vice versa), but I don't think there's an easy solution. That's a
> > good sign that one or more of the files should be broken up.
> 
> I've been burned by this myself by packages interfering with each other
> in /etc/sysctl.d
> 
> Could we put this down to caveat emptor? I think this sorting should be
> intuitive to most people these days, and simple to document and comprehend.

Yeah, I think caveat emptor is fine there. Sorry if I implied otherwise.

-Peff
