Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1C21F462
	for <e@80x24.org>; Fri, 24 May 2019 07:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbfEXHGq (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 03:06:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:37570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388869AbfEXHGq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 03:06:46 -0400
Received: (qmail 25497 invoked by uid 109); 24 May 2019 07:06:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 May 2019 07:06:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6779 invoked by uid 111); 24 May 2019 07:07:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 May 2019 03:07:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 May 2019 03:06:44 -0400
Date:   Fri, 24 May 2019 03:06:44 -0400
From:   Jeff King <peff@peff.net>
To:     Keegan Carruthers-Smith <keegan.csmith@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git archive generates tar with malformed pax extended attribute
Message-ID: <20190524070644.GF25694@sigill.intra.peff.net>
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 08:45:23AM +0200, Keegan Carruthers-Smith wrote:

> git archive can generate a malformed tar archive. bsdtar reports the
> error "tar: Ignoring malformed pax extended attribute" when reading
> the archive. Go's "tar/archive" package also reports the error
> "archive/tar: invalid tar header". However, BusyBox's tar does not
> report the error (unsure if it just has less error logging).
> 
> I can reproduce this when generating the tar on linux and mac. I
> tested this with "git version 2.21.0" and a build of next I did today:
> "git version 2.22.0.rc1.257.g3120a18244"
> 
> Reproduction:
> 
>   $ git clone https://github.com/SSW-SCIENTIFIC/NNDD.git
>   $ cd NNDD
>   $ git archive --format tar c21b98da2ca7f007230e696b2eda5da6589fe137
> | tar tf - > /dev/null
>   tar: Ignoring malformed pax extended attribute
>   tar: Error exit delayed from previous errors.

I can't reproduce on Linux, using GNU tar (1.30) nor with bsdtar 3.3.3
(from Debian's bsdtar package). What does your "tar --version" say?

Git does write a pax header with the commit id in it as a comment.
Presumably that's what it's complaining about (but it is not malformed
according to any tar I've tried). If you feed git-archive a tree rather
than a commit, that is omitted. What does:

  git archive --format tar c21b98da2^{tree} | tar tf - >/dev/null

say? If it doesn't complain, then we know it's indeed the pax comment
field.

-Peff
