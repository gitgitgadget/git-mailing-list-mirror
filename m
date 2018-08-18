Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F52C1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 15:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbeHRSLO (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 14:11:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:59822 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726269AbeHRSLO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 14:11:14 -0400
Received: (qmail 14975 invoked by uid 109); 18 Aug 2018 15:03:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 18 Aug 2018 15:03:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1643 invoked by uid 111); 18 Aug 2018 15:03:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 18 Aug 2018 11:03:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Aug 2018 11:03:12 -0400
Date:   Sat, 18 Aug 2018 11:03:12 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] drop vcs-svn experiment
Message-ID: <20180818150312.GA7488@sigill.intra.peff.net>
References: <20180817190310.GA5360@sigill.intra.peff.net>
 <20180818052605.GA241538@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180818052605.GA241538@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 10:26:05PM -0700, Jonathan Nieder wrote:

> > We also ship contrib/svn-fe, which builds on the vcs-svn
> > work. However, it does not seem to build out of the box for
> > me, as the link step misses some required libraries for
> > using libgit.a.
> 
> What libraries do you mean?  It builds and runs fine for me with
> 
>  $ git diff
>  diff --git i/contrib/svn-fe/Makefile w/contrib/svn-fe/Makefile
>  index e8651aaf4b5..bd709f8d83b 100644
>  --- i/contrib/svn-fe/Makefile
>  +++ w/contrib/svn-fe/Makefile
>  @@ -4,7 +4,7 @@ CC = cc
>   RM = rm -f
>   MV = mv
>  
>  -CFLAGS = -g -O2 -Wall
>  +CFLAGS = -g -O2 -Wall -pthread
>   LDFLAGS =
>   EXTLIBS = -lz
> 
> which appears to be platform related, not due to some internal change
> in Git.

Yes, it works for me with that, too[1]. So clearly there's some system
dependence. But I suspect it's broken for every system with pthreads,
which is most of them. And older versions _do_ compile out of the box,
even on my modern system. For completeness, here's what I dug up:

 - it builds fine up through v1.8.2

 - after eff80a9fd9 (Allow custom "comment char", 2013-01-16), it breaks
   with a ton of undefined references during the link stage, including
   SHA1_* and some xdl_* functions. I still have no idea why, as that
   commit is fairly mundane, but I guess it just somehow tickles
   something in the linker or the way we build libgit.a.

 - after da011cb0e7 (contrib/svn-fe: fix Makefile, 2014-08-28), the
   error becomes:

     /usr/bin/ld: ../../libgit.a(sha1_file.o): undefined reference to symbol 'SHA1_Update@@OPENSSL_1_1_0'
     /usr/bin/ld: //usr/lib/x86_64-linux-gnu/libcrypto.so.1.1: error adding symbols: DSO missing from command line

   Presumably this did work for the author at the time. It's seems quite
   plausible that older versions of openssl did not exhibit this
   problem, and that it's system-specific. Or that it was possible to
   build with BLK_SHA1.

 - after e6b07da278 (Makefile: make DC_SHA1 the default, 2017-03-17),
   the openssl error goes away (naturally), but is replaced with:

     /usr/bin/ld: ../../libgit.a(run-command.o): undefined reference to symbol 'pthread_sigmask@@GLIBC_2.2.5'
     /usr/bin/ld: //lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO missing from command line

   If I go back to 2014-era and start building with NO_OPENSSL, then
   even da011cb0e7 fails with:

     /usr/bin/ld: ../../libgit.a(run-command.o): undefined reference to symbol 'pthread_setspecific@@GLIBC_2.2.5'

   So again, assuming it worked back then for the author of that commit,
   that's something that has changed on the system, and we can't figure
   out through bisecting git when that became common.

So that does mean it's possible that it works for some people on some
systems today (though it was also probably broken for everybody for a
year and a half in 2013 with nobody noticing).

[1] That patch actually doesn't quite work out of the box, because we
    also include config.mak, and mine overrides CFLAGS. It also doesn't
    seem to work with USE_LIBPCRE. But those are only evidence that the
    Makefile is not very mature, not that people aren't using it for
    out-of-the-box config.

> > Of course, I could be completely wrong about people using this. Maybe
> > svn-fe builds are just completely broken on my system, and maybe people
> > really do use testsvn::. But if so, they certainly aren't talking about
> > it on the mailing list. :)
> 
> My take:
> 
>  - svn-fe works fine and has been useful to me, though its Makefile
>    could likely be simplified and made more user-friendly
> 
>  - I've benefited from the test coverage of having this in-tree
> 
>  - testsvn:: is a demo and at a minimum we ought not to install it
>    with "make install"
> 
>  - keeping this in-tree for the benefit of just one user is excessive,
>    so removing it is probably the right thing

Thanks, all of that sounds sensible to me.

>  - it would be nice if the commit removing this code from Git includes
>    a note to help people find its new home
> 
> Would you mind holding off until I'm able to arrange that last bit?

Not at all. This patch was mostly meant to start the discussion. Mission
accomplished. ;)

-Peff
