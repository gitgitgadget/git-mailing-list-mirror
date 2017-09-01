Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC801F4DD
	for <e@80x24.org>; Fri,  1 Sep 2017 21:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752466AbdIAV0X (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Sep 2017 17:26:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:55322 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752392AbdIAV0W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2017 17:26:22 -0400
Received: (qmail 15615 invoked by uid 109); 1 Sep 2017 21:26:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Sep 2017 21:26:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6190 invoked by uid 111); 1 Sep 2017 21:26:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Sep 2017 17:26:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Sep 2017 17:26:20 -0400
Date:   Fri, 1 Sep 2017 17:26:20 -0400
From:   Jeff King <peff@peff.net>
To:     "josephpattara ." <josephpattara@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: HP-UX (git-2.14.0) Depot File / Source Code Build throws SHA1
 Error
Message-ID: <20170901212620.w4ml5umoydbtuspw@sigill.intra.peff.net>
References: <CAC-YKd1sTQLMUZ6k+-4K09=NOa_HaOf1gp8H51VNZjziUrxOfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC-YKd1sTQLMUZ6k+-4K09=NOa_HaOf1gp8H51VNZjziUrxOfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 01, 2017 at 03:04:36PM +0100, josephpattara . wrote:

> Dear HP-UX Git Maintainers,
> 
> Sending this email as I was trying to use the HP-UX depot file which
> was recently committed to the
> http://hpux.connectinternetsolutions.com/hppd/hpux/Development/Tools/git-2.14.0/.
> I tried to use the depot file and also attempted to build the code
> from the adapted source code (using native HP-UX compiler as mentioned
> in Installation Note) from the website.

I don't know anything about HP-UX, but I can tell you a few things from
the Git side...

> But unfortunately both of them failed with an error:
> 
> Cloning into xxxx...
> remote: Counting objects: 19813, done.
> remote: Compressing objects: 100% (9124/9124), done.
> remote: Total 19813 (delta 10340), reused 16358 (delta 8293)
> Receiving objects: 100% (19813/19813), 6.07 MiB | 9.72 MiB/s, done.
> fatal: pack is corrupted (SHA1 mismatch)
> fatal: index-pack failed

Assuming there's no corruption happening on the network, it looks like
there's a bug in the SHA-1 routines of your build. One very basic check
would be to run:

  echo foo | git hash-object --stdin

which should produce:

  257cc5642cb1a054f08cc83f2d943e56fd3ebe99

(If it does that's not a guarantee that there aren't problems with more
complex inputs, but if it produces a different sha1 that's a clear sign
of a sha1 issue).

> Looking at the dynamic link I can see the below:
> 
> _HP_DLDOPTS="-ldd" /usr/bin/git
>   /usr/lib/hpux32/libpthread.so =>        /usr/lib/hpux32/libpthread.so
>   libpthread.so.1 =>      /usr/lib/hpux32/libpthread.so.1
>   libz.so =>      /usr/local/lib/hpux32/libz.so
>   libiconv.so =>  /usr/local/lib/hpux32/libiconv.so
>   libintl.so =>   /usr/local/lib/hpux32/libintl.so
>   libc.so.1 =>    /usr/lib/hpux32/libc.so.1
>   libdl.so.1 =>   /usr/lib/hpux32/libdl.so.1
> 
>   Until recently we were using the older GIT version for HP-UX 1.8.5.3
> and I can see the older GIT had a dynamic link for libcrypto.so.

Git can build against several SHA-1 implementations. In v2.13 and up,
the default is the collision-detecting version publicized as part of the
SHAttered attacks earlier this year. We have had a few problems with it
misbehaving on uncommon platforms or compilers, so it seems a likely
candidate here.

You can try building with "make OPENSSL_SHA1=Yes" to use openssl instead
of the collision-detecting version. You can also try "make BLK_SHA1=Yes"
if you have trouble building against openssl for whatever reason.

> The clarification I have is
> 1. Is the version 2.14.0 from HPUX connect is it really usable (depot
> file and also the source code)

That I don't know. I took a peek at the diff between their source and a
pristine v2.14.0 tarball, and I don't see anything too exotic. So you
could try the upstream code from:

  https://www.kernel.org/pub/software/scm/git/git-2.14.1.tar.gz

but I suspect the problem would still exist.

> 2. Was it deliberate to remove the openssl linkage from the new GIT or
> am I really missing any special configure or build flags to enable the
> libcrypto.so linkage.

Yes, the default flipped but you can still change it. See above.

> 3. Is the SHA1 error which I get is it really to do with the missing
> libcrypto.so or I am on a wrong inference track?

I think it's likely that you're on the right track.

-Peff
