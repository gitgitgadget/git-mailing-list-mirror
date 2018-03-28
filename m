Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C551F404
	for <e@80x24.org>; Wed, 28 Mar 2018 18:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752995AbeC1STf (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 14:19:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:46442 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752743AbeC1STe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 14:19:34 -0400
Received: (qmail 15526 invoked by uid 109); 28 Mar 2018 18:19:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 28 Mar 2018 18:19:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11814 invoked by uid 111); 28 Mar 2018 18:20:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 28 Mar 2018 14:20:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2018 14:19:32 -0400
Date:   Wed, 28 Mar 2018 14:19:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Rafael Ascensao <rafa.almas@gmail.com>
Subject: Re: [PATCH 0/8] Re: git complains packed-refs is not a directory
 when used with GIT_DIR and GIT_WORK_TREE envvars.
Message-ID: <20180328181932.GB16565@sigill.intra.peff.net>
References: <20180328094733.GA1523@sigill.intra.peff.net>
 <20180328175537.17450-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180328175537.17450-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 07:55:29PM +0200, Nguyễn Thái Ngọc Duy wrote:

> >> The problem is switching relative paths relies on the old $CWD if I'm
> >> not mistaken and we need  getcwd() for this. I'd love to have one
> >> callback that says "$CWD has been switched from this path to that
> >> path, do whatever you need to" that can be called any time, before or
> >> after chdir(). I'll look more into it.
> >
> > I think it should be OK to save getcwd() and just construct the original
> > path after the fact. Here's some patches which do that in a nice way.
> 
> Heh.. I should have checked mails more often while coding ;-)

I was worried about that. I started this earlier as a "well, I could
probably just knock this out quickly" task. Many hours later, I found
there were quite a few subtleties. :)

> This is what I got, which is slightly different from your series
> because I want to call set_git_dir() just one time (by
> setup_git_directory) and never again. I think the API looks close
> enough.

Yeah, I actually think after this series we could enforce that
set_git_dir() is never called twice.

I think we could even make sure that repo_set_gitdir() is never called
twice, too, but it would involve a little more surgery (we'd have to
teach it to set up a child_notify handler, and the way it interacts with
the set_git_dir() one is subtle. I did try it and it worked, but I went
with what you saw in patch 3 because it was simpler).

> I will probably rework on top of your chdir-notify instead (and let
> yours to be merged earlier)

Thanks. I like some of the related changes you made, like including this
in the tracing output. That should be easy to do on top of mine, I
think.

I didn't look for other spots that might need similar treatment (like
the object-store bits).

-Peff
