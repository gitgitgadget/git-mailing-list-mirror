Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F1381F453
	for <e@80x24.org>; Sat, 27 Oct 2018 07:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbeJ0PwX (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 11:52:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:56972 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727844AbeJ0PwX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 11:52:23 -0400
Received: (qmail 25094 invoked by uid 109); 27 Oct 2018 07:12:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 27 Oct 2018 07:12:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4463 invoked by uid 111); 27 Oct 2018 07:11:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 27 Oct 2018 03:11:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Oct 2018 03:12:21 -0400
Date:   Sat, 27 Oct 2018 03:12:21 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: can we deprecate NO_PTHREADS?, was: better wrapper to avoid #ifdef
 NO_PTHREADS
Message-ID: <20181027071220.GB17203@sigill.intra.peff.net>
References: <20181018170934.GA21138@sigill.intra.peff.net>
 <20181018180522.17642-1-pclouds@gmail.com>
 <20181023202842.GA17371@sigill.intra.peff.net>
 <852ad281-09df-c980-790c-df25e82b3331@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <852ad281-09df-c980-790c-df25e82b3331@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 26, 2018 at 10:09:46AM -0400, Ben Peart wrote:

> > Yeah, I don't think carrying around a handful of ints is going to be a
> > big deal.
> 
> Just to be complete, there _is_ an additional cost.  Today, code paths that
> are only executed when there are pthreads available are excluded from the
> binary (via #ifdef).  With this change, those code paths would now be
> included causing some code bloat to NO_PTHREAD threaded images.
> 
> One example of this is in read-cache.c where the ieot read/write functions
> aren't included for NO_PTHREAD but now would be.

Yeah. I think that is also an OK cost. It may bloat the binary a little,
but if we're not running those instructions, they're probably not
bloating CPU cache, etc.

> > I don't think we should break the build on those legacy systems, but
> > it's probably OK to stop thinking of it as "non-threaded platforms are
> > the default and must pay zero cost" and more as "threaded platforms are
> > the default, and non-threaded ones are OK to pay a small cost as long as
> > they still work".
> 
> I agree though I'm still curious if there are still no-threaded platforms
> taking new versions of git.  Perhaps we should do the depreciation warning
> you suggested elsewhere and see how much push back we get.  It's unlikely
> we'd get lucky and be able to stop supporting them completely but it's worth
> asking!

I'm trying to think how that might look. I think putting it into the
binary and warning at runtime is probably a little _too_ obnoxious. Here
are some other options ranging from less to more annoying:

  - mention it in the release notes (guaranteed not to hurt anybody, but
    also likely to be missed)

  - a build-time warning when the NO_PTHREADS is set. Also easy to miss,
    but at least hits the people who are using it.

  - rename NO_PTHREADS to NO_PTHREADS_REALLY, and error out the build
    when NO_PTHREADS is set. That would certainly get people's
    attention.

I guess it would make sense to do them in ascending order. I.e., maybe
start with something like:

diff --git a/Makefile b/Makefile
index b08d5ea258..8ac234e4c3 100644
--- a/Makefile
+++ b/Makefile
@@ -1670,6 +1670,11 @@ ifdef RUNTIME_PREFIX
 endif
 
 ifdef NO_PTHREADS
+$(warning The NO_PTHREADS flag is being considered for deprecation,)
+$(warning which would require all platforms supported by Git to have)
+$(warning some kind of threading support. If your platform does not)
+$(warning support threading, please report it by sending an email to)
+$(warning git@vger.kernel.org.)
 	BASIC_CFLAGS += -DNO_PTHREADS
 else
 	BASIC_CFLAGS += $(PTHREAD_CFLAGS)

If we get no takers, that doesn't prove much, but it builds confidence
in moving to the "REALLY" variant. And if we do get a report, we can be
told this is a bad idea before moving further.

Also, the posting of the patch itself may gather some feedback. ;)

-Peff
