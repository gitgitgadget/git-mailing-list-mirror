Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327FB20401
	for <e@80x24.org>; Wed, 14 Jun 2017 11:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbdFNLKq (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 07:10:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:39979 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbdFNLKq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 07:10:46 -0400
Received: (qmail 21557 invoked by uid 109); 14 Jun 2017 11:10:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 11:10:45 +0000
Received: (qmail 11261 invoked by uid 111); 14 Jun 2017 11:10:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jun 2017 07:10:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jun 2017 07:10:43 -0400
Date:   Wed, 14 Jun 2017 07:10:43 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: rs/strbuf-addftime-zZ, was Re: What's cooking in git.git (Jun
 2017, #04; Tue, 13)
Message-ID: <20170614111043.xlfsgclbyrqektb3@sigill.intra.peff.net>
References: <xmqqshj34ldr.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.21.1.1706141245520.171564@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.21.1.1706141245520.171564@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 14, 2017 at 12:57:06PM +0200, Johannes Schindelin wrote:

> Hi Junio,
> 
> On Tue, 13 Jun 2017, Junio C Hamano wrote:
> 
> > * rs/strbuf-addftime-zZ (2017-06-10) 2 commits
> >  - date: use localtime() for "-local" time formats
> >  - strbuf: let strbuf_addftime handle %z and %Z itself
> > 
> >  As there is no portable way to pass timezone information to
> >  strftime, some output format from "git log" and friends are
> >  impossible to produce.  Teach our own strbuf_addftime to replace %z
> >  and %Z with caller-supplied values to help working around this.
> > 
> >  Will merge to 'next'.
> 
> Hold on. Have you tried to build this branch?
> 
> -- snip --
>     CC date.o
> date.c:63:36: error: unknown type name ‘timestamp_t’
>  static struct tm *time_to_tm_local(timestamp_t time)
>                                     ^
> date.c: In function ‘show_date’:
> date.c:211:8: error: implicit declaration of function ‘time_to_tm_local’
> [-Werror=implicit-function-declaration]
>    tm = time_to_tm_local(time);
>         ^
> date.c:211:6: error: assignment makes pointer from integer without a cast
> [-Werror=int-conversion]
>    tm = time_to_tm_local(time);
>       ^
> cc1: all warnings being treated as errors
> -- snap --
> 
> I would expect this to be rebased *at least* to dddbad728c9 (timestamp_t:
> a new data type for timestamps, 2017-04-26).

Yeah, the timestamp_t mentions are from my patch (the top one). I built
it applying René's on the current master and then building on top. I
suspect Junio didn't test it in isolation, but only merged to "pu",
where it would be OK.

> But even then, it fails in t0006 on Windows with this error:
> 
> -- snip --
> ++ eval 'diff -u "$@" '
> +++ diff -u expect actual
> --- expect      2017-06-14 10:53:40.126136900 +0000
> +++ actual      2017-06-14 10:53:40.171146800 +0000
> @@ -1 +1 @@
> -1466000000 +0200 -> 2016-06-15 14:13:20 +0000 (UTC)
> +1466000000 +0200 -> 2016-06-15 14:13:20 UTC (UTC)

Ugh, I was worried about that some systems might display timezones
differently (that's why I _didn't_ check %Z in the EST5 case). But I
must admit this was not an incompatibility I was expecting. It looks
like your system strftime() turns %z into "UTC". POSIX says:

  %z
    Replaced by the offset from UTC in the ISO 8601:2000 standard format
    (+hhmm or -hhmm), or by no characters if no timezone is
    determinable.

So it seems like the mingw strftime is violating POSIX. I don't see an
easy solution beyond marking this as !MINGW. Though if we wanted a
partial test, we could test %z and %Z separately.

-Peff
