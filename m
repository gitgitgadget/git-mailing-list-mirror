Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 994CE1F45F
	for <e@80x24.org>; Mon,  6 May 2019 23:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfEFXnh (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 19:43:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:49608 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726197AbfEFXnh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 19:43:37 -0400
Received: (qmail 9428 invoked by uid 109); 6 May 2019 23:43:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 May 2019 23:43:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5381 invoked by uid 111); 6 May 2019 23:44:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 May 2019 19:44:12 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2019 19:43:34 -0400
Date:   Mon, 6 May 2019 19:43:34 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH] coccicheck: optionally batch spatch invocations
Message-ID: <20190506234334.GA13296@sigill.intra.peff.net>
References: <20190425120758.GD8695@szeder.dev>
 <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain>
 <20190502000422.GF14763@szeder.dev>
 <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
 <20190503144211.GH14763@szeder.dev>
 <20190503174503.GA8242@sigill.intra.peff.net>
 <CA+P7+xoRGVAP4nHE=neUZGkn9RX_hxN9xVzfWexR79ZWT0ejSQ@mail.gmail.com>
 <20190506051148.GB30003@sigill.intra.peff.net>
 <CACsJy8CLjUdHCro8QJfTozMB0xVWppHuFRSLCvFSaeKO_PxAog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CLjUdHCro8QJfTozMB0xVWppHuFRSLCvFSaeKO_PxAog@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 06, 2019 at 04:34:09PM +0700, Duy Nguyen wrote:

> > However, it comes at a cost. The RSS of each spatch process goes from
> > ~50MB to ~1500MB (and peak memory usage may be even higher if make runs
> 
> 1.5G should be fine. Trying...
> 
> Even with no -j, my htop's RES column goes up 6GB and put my laptop in
> "swap every bit of memory out, including the bits handling the screen"
> mode :( I don't think it was even the peak.

Interesting if you have a different version of spatch. I'm using 1.0.4
from Debian unstable.

I had just been eyeballing the values in "top" before, but I actually
measured more carefully. My peak was actually ~1900MB.

> It's probably a bit too much to ask, but is it possible to handle N
> files at a time (instead of all files), which consumes less memory and
> runs a bit slower, but still better than the default mode? I can see
> it already gets tricky doing complicated stuff in Makefile so "no" is
> perfectly ok.

I almost did this initially but I feared that nobody would actually use
it. :) So given at least one person who wants it, I took a look. If we
rely on xargs, then it is really not too bad (and is in fact shorter
than the current code). I also wrote up a pure-shell version, but it's
rather verbose even after taking some shortcuts with whitespace
splitting.

So here's what I think we should apply:

-- >8 --
Subject: [PATCH] coccicheck: optionally batch spatch invocations

In our "make coccicheck" rule, we currently feed each source file to its
own individual invocation of spatch. This has a few downsides:

  - it repeats any overhead spatch has for starting up and reading the
    patch file

  - any included header files may get processed from multiple
    invocations. This is slow (we see the same header files multiple
    times) and may produce a resulting patch with repeated hunks (which
    cannot be applied without further cleanup)

Ideally we'd just invoke a single instance of spatch per rule-file and
feed it all source files. But spatch can be rather memory hungry when
run in this way. I measured the peak RSS going from ~90MB for a single
file to ~1900MB for all files. Multiplied by multiple rule files being
processed at the same time (for "make -j"), this can make things slower
or even cause them to fail (e.g., this is reported to happen on our
Travis builds).

Instead, let's provide a tunable knob. We'll leave the default at "1",
but it can be cranked up to "999" for maximum CPU/memory tradeoff, or
people can find points in between that serve their particular machines.

Here are a few numbers running a single rule via:

  SIZES='1 4 16 999'
  RULE=contrib/coccinelle/object_id.cocci
  for i in $SIZES; do
    make clean
    /usr/bin/time -o $i.out --format='%e | %U | %S | %M' \
      make $RULE.patch SPATCH_BATCH_SIZE=$i
  done
  for i in $SIZES; do
    printf '%4d | %s\n' $i "$(cat $i.out)"
  done

which yields:

     1 | 97.73 | 93.38 | 4.33 | 100128
     4 | 52.80 | 51.14 | 1.69 | 135204
    16 | 35.82 | 35.09 | 0.76 | 284124
   999 | 23.30 | 23.13 | 0.20 | 1903852

The implementation is done with xargs, which should be widely available;
it's in POSIX, we rely on it already in the test suite. And "coccicheck"
is really a developer-only tool anyway, so it's not a big deal if
obscure systems can't run it.

Signed-off-by: Jeff King <peff@peff.net>
---
I left the default at 1 for safety. Probably 4 or 16 would be an OK
default, but I don't have any interest in figuring out exactly what
Travis or some hypothetical average machine can handle. I'll be setting
mine to 999. ;)

Making "0" work as "unlimited" might be nice, but xargs doesn't support
that and I didn't want to make the recipe any more unreadable than it
already is.

 Makefile | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 9f1b6e8926..daba958b8f 100644
--- a/Makefile
+++ b/Makefile
@@ -1174,8 +1174,10 @@ PTHREAD_CFLAGS =
 SPARSE_FLAGS ?=
 SP_EXTRA_FLAGS =
 
-# For the 'coccicheck' target
+# For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
+# usually result in less CPU usage at the cost of higher peak memory.
 SPATCH_FLAGS = --all-includes --patch .
+SPATCH_BATCH_SIZE = 1
 
 include config.mak.uname
 -include config.mak.autogen
@@ -2790,12 +2792,9 @@ endif
 
 %.cocci.patch: %.cocci $(COCCI_SOURCES)
 	@echo '    ' SPATCH $<; \
-	ret=0; \
-	for f in $(COCCI_SOURCES); do \
-		$(SPATCH) --sp-file $< $$f $(SPATCH_FLAGS) || \
-			{ ret=$$?; break; }; \
-	done >$@+ 2>$@.log; \
-	if test $$ret != 0; \
+	if ! echo $(COCCI_SOURCES) | xargs -n $(SPATCH_BATCH_SIZE) \
+		$(SPATCH) --sp-file $< $(SPATCH_FLAGS) \
+		>$@+ 2>$@.log; \
 	then \
 		cat $@.log; \
 		exit 1; \
-- 
2.21.0.1314.g224b191707

