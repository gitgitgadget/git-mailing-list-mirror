Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C6AA1FAFB
	for <e@80x24.org>; Wed, 29 Mar 2017 03:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751834AbdC2DSm (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 23:18:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:53388 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751716AbdC2DSm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 23:18:42 -0400
Received: (qmail 6538 invoked by uid 109); 29 Mar 2017 03:18:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Mar 2017 03:18:39 +0000
Received: (qmail 19288 invoked by uid 111); 29 Mar 2017 03:18:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 23:18:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 23:18:37 -0400
Date:   Tue, 28 Mar 2017 23:18:37 -0400
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git fails to build on Ubuntu Server 16.04
Message-ID: <20170329031836.h2j3hja4ktocbv6i@sigill.intra.peff.net>
References: <CAH8yC8kexrV8d7Tg_vCCM+GWsNH82386HEyN=XSguqZjcOuPzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8kexrV8d7Tg_vCCM+GWsNH82386HEyN=XSguqZjcOuPzQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 07:17:16PM -0400, Jeffrey Walton wrote:

> I configured with --enable-pthreads, and LIBS included -lpthread.
> 
> $ make V=1
> gcc -I/usr/local/include -g -O2 -I. -DHAVE_ALLOCA_H
> -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND -I/usr/local/include
> -I/usr/local/include  -DHAVE_PATHS_H -DHAVE_STRINGS_H -DHAVE_DEV_TTY
> -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM
> -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"'
> -DPAGER_ENV='"LESS=FRX LV=-c"' -o git-credential-store
> -Wl,-rpath,/usr/local/lib -L/usr/local/lib  credential-store.o
> common-main.o libgit.a xdiff/lib.a  -L/usr/local/lib
> -Wl,-rpath,/usr/local/lib -lz -L/usr/local/lib
> -Wl,-rpath,/usr/local/lib -lcrypto  -lrt
> /usr/bin/ld: libgit.a(run-command.o): undefined reference to symbol
> 'pthread_sigmask@@GLIBC_2.2.5'
> //lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO
> missing from command line
> collect2: error: ld returned 1 exit status
> Makefile:2053: recipe for target 'git-credential-store' failed
> make: *** [git-credential-store] Error 1

Hmm. I can reproduce with:

  LIBS=-lpthread ./configure --enable-pthreads
  make

I think the problem is that $LIBS is meaningful to autoconf, but not to
Git's Makefile. So it tricks autoconf into writing a blank PTHREAD_LIBS
variable (because it can compile a pthread program without any extra
options), but the Makefile does not include $LIBS.

Just doing:

  ./configure --enable-pthreads
  make

works fine. So should:

  ./configure
  make

which should detect pthreads. Or just:

  make

as building with pthreads is the default on Linux.

So depending on your perspective, it's either:

  - not a bug (because we do not advertise $LIBS as a meaningful input
    to the build process)

  - a bug that the configure script respects $LIBS at all, since it is
    not meaningful to the Makefile

  - a bug that the configure script does not propagate $LIBS into
    something the Makefile _does_ understand, like $EXTLIBS

  - a bug that the Makefile does not care about $LIBS

Patches welcome for any of the latter three (I do not have an opinion
myself; I don't use autoconf at all).

-Peff
