Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC06D1F731
	for <e@80x24.org>; Thu,  8 Aug 2019 10:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389983AbfHHK26 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 06:28:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:37590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389946AbfHHK26 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 06:28:58 -0400
Received: (qmail 11643 invoked by uid 109); 8 Aug 2019 10:28:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 08 Aug 2019 10:28:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18879 invoked by uid 111); 8 Aug 2019 10:31:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Aug 2019 06:31:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Aug 2019 06:28:57 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] --end-of-options marker
Message-ID: <20190808102857.GD12257@sigill.intra.peff.net>
References: <20190806143829.GA515@sigill.intra.peff.net>
 <20190806225853.GH118825@genre.crustytoothpaste.net>
 <20190806234319.GA19178@sigill.intra.peff.net>
 <20190807041749.GI118825@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190807041749.GI118825@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 07, 2019 at 04:17:49AM +0000, brian m. carlson wrote:

> > I think if we at least choose the left-most "--" as the official
> > end-of-options then they can't inject an option (they can only inject a
> > rev as a path). I guess that's the same as with --end-of-options. But it
> > somehow feels less clear to me than a separate marker.
> 
> I suppose if there's more than two, then interpret the first one as the
> end-of-options marker, the second one in the traditional way, and any
> subsequent ones as pathspecs matching the file "--". Writing such a
> command line would be silly, but we'd fail secure.

Yeah, I think that could work. I'd be a little concerned that the
implementation would end up complicated and confusing, just because
there are other parts of the code that treat "--" specially. That's not
a necessarily a reason to avoid it if there's a compelling reason, but I
think I favor a unique marker anyway (or at least am otherwise
ambivalent).

> That's a good point. I don't have a strong view either way, but I
> thought I'd ask about alternatives.

Discussion of alternatives is very welcome.

I think the most compelling alternative is the one I pointed out in one
of the commit messages:

  git rev-list --revision=<whatever>

which lets normal left-to-right parsing work without any complex
reasoning. It is harder to use with "$@", though.

Related, my proposal doesn't do anything for rev-parse. I think that:

  git rev-parse --end-of-options -xyz

should probably return:

  --end-of-options
  <oid of -xyz>

but I mostly consider that kind of use of rev-parse (pretending to be an
options parser for rev-list) to be vestigial. The main use of rev-parse
(in my experience) is "rev-parse --verify" to resolve a single name.

There are still some gaps there. For instance:

  git rev-parse --verify --foo

will treat "--foo" as an option (and then complain that there was no rev
argument). I don't think you can do anything too mischievous from this,
but it might be nice to tighten it up. I'm tempted to say that
"--verify" should complain if there isn't exactly one argument, but
technically things like this do work:

  git rev-parse --verify --sq "$rev"

  git rev-parse --verify --symbolic-full-name "$rev"

I don't know if anybody cares or not. We could perhaps work around it by
having --verify treat the final argument as a non-option, even if it
starts with "-". That would allow those cases, but:

  git rev-parse --verify --symbolic-full-name

would treat the latter as an argument (and currently that's always an
error anyway). Looking at rev-parse, there are other weird bits to
--verify, too. E.g., this:

  git rev-parse --verify a...b c

shows a...b, ignoring that --verify was given, and then eventually "c".

-Peff
