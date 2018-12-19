Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1721F405
	for <e@80x24.org>; Wed, 19 Dec 2018 15:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbeLSP7b (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 10:59:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:45846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727975AbeLSP7a (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 10:59:30 -0500
Received: (qmail 24873 invoked by uid 109); 19 Dec 2018 15:59:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Dec 2018 15:59:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22327 invoked by uid 111); 19 Dec 2018 15:59:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Dec 2018 10:59:03 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2018 10:59:28 -0500
Date:   Wed, 19 Dec 2018 10:59:28 -0500
From:   Jeff King <peff@peff.net>
To:     Erin Dahlgren <eedahlgren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Simplify handling of setup_git_directory_gently()
 failure cases.
Message-ID: <20181219155928.GE14802@sigill.intra.peff.net>
References: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com>
 <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
 <20181218175418.GB31070@sigill.intra.peff.net>
 <CAP_Smy14j4WK-mkqdKTKue=j7YoNjfaZVCBA-7S8xwNqX2rKhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP_Smy14j4WK-mkqdKTKue=j7YoNjfaZVCBA-7S8xwNqX2rKhQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 18, 2018 at 12:54:02PM -0800, Erin Dahlgren wrote:

> > Might it make sense to make GIT_DIR_HIT_MOUNT_POINT more like
> > GIT_DIR_HIT_CEILING currently is, rather than the other way around?
> > I.e., something like:
> >
> >   case GIT_DIR_HIT_CEILING:
> >         if (!nongit_ok)
> >                 die(...);
> >         *nongit_ok = 1;
> >         prefix = NULL;
> >         break;
> >   case GIT_DIR_HIT_MOUNT_POINT:
> >         if (!nongit_ok)
> >                 die(...);
> >         *nongit_ok = 1;
> >         prefix = NULL;
> >         break;
> >
> > ?
> 
> After some digging, there seems to be a documented guarantee that
> "`GIT_PREFIX` is set as returned by running 'git rev-parse
> --show-prefix'". See Documentation/config/alias.txt. If the
> environment variable GIT_PREFIX is already set to something and we
> don't clear it when prefix is NULL, then the two can be out of sync.
> So that's a problem with my patch and the current handling of
> GIT_DIR_HIT_MOUNT_POINT. I'm not sure how important of a guarantee it
> is, but we should respect what's documented.

Yeah, agreed.

Another benefit of avoiding the early return is that we hit the cleanup
code at the end of the function. That saves us having to release "dir"
here. I assume we don't have to care about "gitdir" in these cases, but
hitting the cleanup code means we don't even have to think about it.

Over in:

  https://public-inbox.org/git/20181219154853.GC14802@sigill.intra.peff.net/

I suggested adding more cleanup to that block, too (though I _think_ in
these cases it would also be a noop, it's again nice to not have to
worry about it).

> Side note: One of the secondary goals of my patch was to make it
> really obvious that neither the GIT_DIR_HIT_CEILING nor the
> GIT_DIR_HIT_MOUNT_POINT case can get us into the block protected by
> (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT)). With
> your suggestion (and it's a fair one) I don't think that's feasible
> without more significant refactoring. Should I just settle with a
> comment that explains this?

Yeah, I think a comment would probably be sufficient. Though we could
also perhaps make the two cases (i.e., we found a repo or not) more
clear. Something like:

  if (!*nongit_ok || !*nongit_ok) {
	startup_info->have_repository = 1;
	startup_info->prefix = prefix;
	if (prefix) ...etc...
  } else {
	start_info->have_repository = 0;
	startup_info->prefix = NULL;
	setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
  }

That may introduce some slight repetition, but I think it's probably
clearer to deal with the cases separately (and it saves earlier code
from make-work like setting prefix=NULL when there's no repo).

The condition would also be a lot less confusing if nongit_ok were
flipped, but I think that would be a big refactor due to the way we pass
it around.

-Peff
