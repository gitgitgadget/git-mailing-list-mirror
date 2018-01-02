Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99C31F428
	for <e@80x24.org>; Tue,  2 Jan 2018 20:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750989AbeABUEq (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 15:04:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:50954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750979AbeABUEp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 15:04:45 -0500
Received: (qmail 8273 invoked by uid 109); 2 Jan 2018 20:04:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Jan 2018 20:04:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19034 invoked by uid 111); 2 Jan 2018 20:05:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Tue, 02 Jan 2018 15:05:15 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Jan 2018 15:04:43 -0500
Date:   Tue, 2 Jan 2018 15:04:43 -0500
From:   Jeff King <peff@peff.net>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Stephan Janssen <sjanssen@you-get.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git removes existing folder when cancelling clone
Message-ID: <20180102200443.GA1703@sigill.intra.peff.net>
References: <FE0E0877-B77D-4BD6-A513-435C251D920A@you-get.com>
 <alpine.LFD.2.21.1801020610400.14363@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.21.1801020610400.14363@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 02, 2018 at 06:12:35AM -0500, Robert P. J. Day wrote:

> > I just noticed the following behaviour on macOS 10.13.2 running Git v2.15.0:
> >
> > 1. `mkdir new-folder`
> > 2. `ls` - shows new-folder
> > 3. `git clone [repo] new-folder`
> > 4. Git asks for password
> > 5. I cancel by pressing ctrl+c
> >
> > Result:
> > `ls` no longer shows new-folder.
> >
> > Expected result:
> > `ls` shows new-folder
> >
> > I’m not sure whether this might be a case of ‘works as intended’,
> > but it’s not what I’d expect.
> 
>   i'm *pretty* sure that the optional directory name you supply is
> meant to represent a directory you want git to *create* for you, not
> one that already exists. that means the behaviour you see makes sense
> -- if git assumes it was supposed to create the directory, and you
> cancel the clone, it reasonably assumes it should get rid of it.

Correct. In the early days we required that the "new-folder" directory
not exist, and the initial "git clone" would have bailed in that case.
Any directory we removed would have been one we created.

That changed in 55892d2398 (Allow cloning to an existing empty
directory, 2009-01-11), and we continue to allow only empty directories.

So I don't think there's an urgent data-loss bug here; we will only ever
destroy an empty directory. However, the original intent was to leave
the filesystem as we found it on a failed or aborted clone, and we
obviously don't do that in this case. So it might be nice if we could
restore it to an empty directory.

Restoring the original contents in the general case is hard, since other
parts of the clone may have created arbitrary files. But if we know the
original is just empty, we can simply delete everything in it, but not
the outer directory.

-Peff
