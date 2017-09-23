Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090C620281
	for <e@80x24.org>; Sat, 23 Sep 2017 16:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbdIWQiV (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 12:38:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:48144 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750839AbdIWQiU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 12:38:20 -0400
Received: (qmail 21140 invoked by uid 109); 23 Sep 2017 16:38:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 16:38:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13595 invoked by uid 111); 23 Sep 2017 16:38:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 12:38:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Sep 2017 12:38:18 -0400
Date:   Sat, 23 Sep 2017 12:38:18 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] reroll ma/plugleaks; more `object_array`-fixes
Message-ID: <20170923163817.7ltmkav2ytk7n43k@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com>
 <20170923043701.4s3xuytp5hdjwmsy@sigill.intra.peff.net>
 <CAN0heSrPBDi4q9fqr=qoTbjRHpFS_VEL0O8=MFFJ4DLCuJwahA@mail.gmail.com>
 <20170923161316.yntnccqrhv5d3jza@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170923161316.yntnccqrhv5d3jza@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2017 at 12:13:16PM -0400, Jeff King wrote:

> In theory you should be able to just add "log_path=/tmp/lsan/output" to
> that, which should put all the logs in a convenient place (and stop the
> extra output from confusing any tests which capture stderr). But I can't
> seem to get log_path to do anything, contrary to the documentation.
> 
> Doing log_to_syslog=1 does work for me. I'm not sure if it's a bug or
> I'm holding it wrong. But it does seem like it should be possible to do
> what you want.

Hrm. log_path doesn't seem to work for me directly from LSAN_OPTIONS.
But if you compile with ASan, it _does_ work from there. That seems like
a bug from my reading of the documentation, but maybe I'm missing
something.

Anyway, doing:

  ASAN_OPTIONS=detect_leaks=1:abort_on_error=0:exitcode=0:log_path=/tmp/lsan/output \
  make SANITIZE=address,leak test

should pass the whole suite and give you a host of files to analyze.

I'm not sure of the best way to count things. Surely many of these are
the same leak over and over. One way to visualize is to look at the
unique entries at each level of the call stack:

  show() {
    level=$1
    perl -lne 'print $1 if /#'$level' .*? in (.*)/' * |
    sort | uniq -c | sort -rn
  }

Level 0 isn't that interesting, it's just malloc:

  $ show 0
    27217 realloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xd9f20)
    23297 __interceptor_strdup (/usr/lib/x86_64-linux-gnu/libasan.so.4+0x74490)
    19370 malloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xd9b70)
    12105 __interceptor_calloc (/usr/lib/x86_64-linux-gnu/libasan.so.4+0xd9d48)

And level 1 is just our allocators:

  $ show 1
    28321 xrealloc /home/peff/compile/git/wrapper.c:138
    25199 xstrdup /home/peff/compile/git/wrapper.c:44
    18856 do_xmalloc /home/peff/compile/git/wrapper.c:60
    12664 xcalloc /home/peff/compile/git/wrapper.c:160
      660 __getdelim (/lib/x86_64-linux-gnu/libc.so.6+0x682b7)

But level 2 starts to get interesting (and is too big to copy here).
Some of them are direct sources of leaks. But others like strbuf_grow()
are yet another level of indirection, and you'd want to jump to level 3
or 4.

If you want the "real" source of the leak, probably you'd have to mark
certain functions as uninteresting and keep walking each stack trace
until you find an interesting function to report.

-Peff
