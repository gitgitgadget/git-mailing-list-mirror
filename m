Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A44C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 15:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475AC20768
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 15:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgHNPLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:11:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:59186 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgHNPLi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 11:11:38 -0400
Received: (qmail 578 invoked by uid 109); 14 Aug 2020 15:11:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Aug 2020 15:11:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26444 invoked by uid 111); 14 Aug 2020 15:11:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Aug 2020 11:11:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Aug 2020 11:11:37 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] drop vcs-svn experiment
Message-ID: <20200814151137.GA4169627@coredump.intra.peff.net>
References: <20200813145515.GA891139@coredump.intra.peff.net>
 <20200813150017.GE891370@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2008141634500.54@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2008141634500.54@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 04:39:07PM +0200, Johannes Schindelin wrote:

> On Thu, 13 Aug 2020, Jeff King wrote:
> 
> > The code in vcs-svn was started in 2010 as an attempt to build a
> > remote-helper for interacting with svn repositories (as opposed to
> > git-svn). However, we never got as far as shipping a mature remote
> > helper, and the last substantive commit was e99d012a6bc in 2012.
> >
> > We do have a git-remote-testsvn, and it is even installed as part of
> > "make install". But given the name, it seems unlikely to be used by
> > anybody (you'd have to explicitly "git clone testsvn::$url", and there
> > have been zero mentions of that on the mailing list since 2013, and even
> > that includes the phrase "you might need to hack a bit to get it working
> > properly"[1]).
> >
> > We also ship contrib/svn-fe, which builds on the vcs-svn work. However,
> > it does not seem to build out of the box for me, as the link step misses
> > some required libraries for using libgit.a. Curiously, the original
> > build breakage bisects for me to eff80a9fd9 (Allow custom "comment
> > char", 2013-01-16), which seems unrelated. There was an attempt to fix
> > it in da011cb0e7 (contrib/svn-fe: fix Makefile, 2014-08-28), but on my
> > system that only switches the error message.
> 
> FWIW I got it to work, as part of my initial patches to support
> `init.defaultBranch`. I even included a patch to touch `svn-fe` up in the
> patch thicket to demonstrate how we can move from `master` as Git's
> default branch to `main`.

In my case I needed to specify both -lpthread (common for Unix systems)
and -lpcre (uncommon; I set USE_LIBPCRE).

It looks like it tries to use PTHREAD_LIBS automatically, but that's
only defined in the Makefile for most platforms, not any of the
config.mak.* we include. However, I think it would be defined if I used
autoconf.

So I can _almost_ build with:

  make PTHREAD_LIBS='-lpthread -lpcre2-8'

But it still doesn't work, because the code which uses those (and -lz,
which the Makefile does know about) is in the static libraries
(libgit.a, etc). So the -l libs need to come after that. I needed:

diff --git a/contrib/svn-fe/Makefile b/contrib/svn-fe/Makefile
index e8651aaf4b..b90cf876cd 100644
--- a/contrib/svn-fe/Makefile
+++ b/contrib/svn-fe/Makefile
@@ -74,7 +74,7 @@ endif
 endif
 
 svn-fe$X: svn-fe.o $(VCSSVN_LIB) $(XDIFF_LIB) $(GIT_LIB)
-	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(EXTLIBS) -o $@ svn-fe.o $(LIBS)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ svn-fe.o $(LIBS) $(EXTLIBS)
 
 svn-fe.o: svn-fe.c ../../vcs-svn/svndump.h
 	$(QUIET_CC)$(CC) $(CFLAGS) -I../../vcs-svn -o $*.o -c $<

So I'm sure somebody determined could get it to work, and it's
definitely salvageable. But given the lack of questions or reports about
this long-standing breakage on the list, I suspect that nobody is
actually building it in practice.

-Peff
