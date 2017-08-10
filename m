Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE81208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 21:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753141AbdHJVcj (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 17:32:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:35344 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752366AbdHJVci (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 17:32:38 -0400
Received: (qmail 29770 invoked by uid 109); 10 Aug 2017 21:32:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 21:32:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10356 invoked by uid 111); 10 Aug 2017 21:33:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 17:33:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 17:32:36 -0400
Date:   Thu, 10 Aug 2017 17:32:36 -0400
From:   Jeff King <peff@peff.net>
To:     "Tom G. Christensen" <tgc@jupiterrise.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] dropping support for older curl
Message-ID: <20170810213236.dej4ibsag2lxf5w2@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
 <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net>
 <873e1f31-2a96-5b72-2f20-a5816cad1b51@jupiterrise.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <873e1f31-2a96-5b72-2f20-a5816cad1b51@jupiterrise.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 10:33:18PM +0200, Tom G. Christensen wrote:

> > You've totally ignored the argument I made back then[1], and which I
> > reiterated in this thread. So I'll say it one more time: the more
> > compelling reason is not the #ifdefs, but the fact that the older
> > versions are totally untested.
> 
> Perhaps you forgot but I stated in the original thread that I build RPMS for
> RHEL/CentOS 3, 4, 5, 6 and 7. I still do and I run the testsuite every
> single time.

I didn't forget. I actually double-checked the patches you sent at the
time, but I didn't see one for the CURLPROTO issue. And indeed, it is
still broken for me:

  $ cd /path/to/curl/repo
  $ git checkout curl-7_15_5
  $ ./buildconf && ./configure --prefix=/tmp/foo && make install
  $ cd /path/to/git
  $ git checkout v2.14.0
  $ make CURLDIR=/tmp/foo V=1 http.o
  gcc -o http.o -c -MF ./.depend/http.o.d -MQ http.o -MMD -MP   -g -O0 -Wall -Werror -Wdeclaration-after-statement -Wpointer-arith -Wstrict-prototypes -Wvla -Wold-style-declaration -Wold-style-definition -Wno-error -Wno-cpp -Wno-unused-value -Wno-strict-prototypes  -I. -DUSE_LIBPCRE1 -DHAVE_ALLOCA_H -I/tmp/foo/include -DUSE_CURL_FOR_IMAP_SEND -DNO_GETTEXT -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES -DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 -DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" -DSHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_C="\"sha1dc_git.c\"" -DSHA1DC_CUSTOM_TRAILING_INCLUDE_SHA1_H="\"sha1dc_git.h\"" -DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\""  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC -DHAVE_GETDELIM  -DFREAD_READS_DIRECTORIES -DNO_STRLCPY -DSHELL_PATH='"/bin/sh"' -DPAGER_ENV='"LESS=FRX LV=-c"'  http.c
  http.c: In function ‘get_curl_allowed_protocols’:
  http.c:685:24: error: ‘CURLPROTO_HTTP’ undeclared (first use in this function); did you mean ‘CURLPROXY_HTTP’?
     allowed_protocols |= CURLPROTO_HTTP;
                          ^~~~~~~~~~~~~~
                          CURLPROXY_HTTP
  [and so on]

> I just built a pristine 2.14.0 on CentOS 5 with curl 7.15.5. No problems at
> all neither with building nor with running the testsuite.

As you can see, this does not compile for me. What's going on?

I don't see how it could work, as CURLPROTO_HTTP is not defined at all
in that version of curl.  Can you please double-check that you're
building against the correct version of curl, and that you are building
the HTTP parts of Git (which _are_ optional, and the test suite will
pass without them).

> > So IMHO this is about being honest with users about which versions we
> > _actually_ support.
> 
> I have no problem with you wanting to drop support for older curl releases
> (such as 7.15.5) but don't use the argument that it doesn't currently build
> and nobody cares.

My argument isn't quite that nobody cares. It's that we do users a
disservice by shipping a version of the code that very well may have
hidden problems like security holes (for instance, we do not handle
redirects safely in old versions of curl). So if you can get it to build
it may _seem_ fine, but it's a bit of a booby-trap waiting to spring.

I also won't claim any absolutes. I think we all agree this is a
cost/benefit tradeoff. But there are a lot of options for building on a
very old system. For instance, building without http if you don't need
it. Or building a more recent libcurl (and even linking statically for
simplicity).

I'd find arguments against the latter more compelling if recent curl
were hard to compile on old systems. I don't know whether that's the
case (certainly on a modern system, it's much easier to get newer
versions of curl to compile than older ones).

> Also FWIW Red Hat continues to support RHEL 5 with the Extended Life-cycle
> Support program until 2020-11-30.

I saw that, too. But as I understand it, they provide no code updates:
no bugfixes and no security updates. They just promise to answer the
phone and help you with troubleshooting. It's possible my perception is
wrong, though; I'm certainly not one of their customers.

-Peff
