Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699E9C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 04:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB8B61A42
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 04:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbhCZEMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 00:12:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:49444 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCZELg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 00:11:36 -0400
Received: (qmail 28451 invoked by uid 109); 26 Mar 2021 04:11:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 04:11:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7316 invoked by uid 111); 26 Mar 2021 04:11:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 00:11:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 00:11:34 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v4 3/4] Makefile/coccicheck: allow for setting xargs
 concurrency
Message-ID: <YF1e9mIQUKEOPSbn@coredump.intra.peff.net>
References: <20210306192525.15197-1-avarab@gmail.com>
 <cover.1616414951.git.avarab@gmail.com>
 <9d5814dacdc281389c4cb163ddbe4b749e6c0852.1616414951.git.avarab@gmail.com>
 <YFuSSqbAjTmaEMCB@coredump.intra.peff.net>
 <877dlwotjc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dlwotjc.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 25, 2021 at 03:29:11AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I don't understand this 9999 comment. The original was sometimes setting
> > $limit to the empty string, and then doing:
> >
> >  xargs $limit
> >
> > How is that any different than setting SPATCH_XARGS to just "xargs" for
> > the unlimited case?
> 
> The "over multiple lines" is important. But it seems not
> anymore. I.e. in an earlier version I had:
> 
>     $(XARGS) \
>         $(XARGS_FLAGS) \
>         $(SPATCH)
> 
> And it would brek if XARGS_FLAGS was empty. So I set it to -n 9999 as a
> fallback.

Ah, OK, that makes more sense. Though I'm still slightly confused, just
because I think the Makefile will eat those backslashed newlines, and
the shell will just see extra whitespace. I.e.:

  $ cat Makefile
  foo:
  	echo \
  		$(A) \
  		$(B) \
  		$(C)

  $ make foo A=one C=three
  echo \
  	one \
  	 \
  	three
  one three

I suspect whatever you wrote that hit the problem was just slightly
different. I doubt this is worth thinking about any further, but it is a
weird curiosity to me. So feel free to explore and respond if you find
it interesting, but don't feel compelled to. :)

> > As I mentioned in the last round, using "-P" is racy. I'm not sure if
> > it's something we should be recommending to people.
> 
> Yes, this would need to use N tempfiles we'd cat together at the end to
> be POSIX-reliable.
> 
> In practice I've never seen this sort of thing be unreliable for a case
> like this.
> 
> POSIX just guarantees that the output won't be interleaved up to
> PIPE_BUF, which is typically 4k. We certainly get patches bigger than
> that from spatch in some cases.

One nit (because I spent quite a long time looking into this a while ago
for an unrelated thing): POSIX only talks about PIPE_BUF for pipes. For
regular files in O_APPEND mode (or two processes sharing a descriptor
from their parent, as we'd have here), I think write() is allowed to do
a short write, at which point you'd lose atomicity.

In practice, I'd expect most small-ish (say, less than a page) writes to
happen in a single go, especially on modern operating systems. But I
wouldn't be too surprised if it depends on details of the filesystem, or
even the file you're writing into. E.g., if there are 20 bytes left in a
filesystem block that the end of the file is currently pointing to, and
you ask to write 30 bytes, it seems plausible that we might write the
first 20 to fill out the block, and then have a point where we could get
interrupted by a signal and return early, etc.

> But from the OS's perspective emitting this output happens at a glacial
> pace. So even if it crosses that boundary it's unlikely to be
> interleaved.

Yes, I think even if it's possible to race, the general lack of volume
of writes is likely to save us.

Everything below is more curiosity, so again, don't sink time into it if
it's not an interesting tangent for you.

> Even:
> 
>     perl -wE 'print "a" for 1..1024*1024*100' >1
>     perl -wE 'print "b" for 1..1024*1024*100' >2
>     perl -wE 'print "\n" for 1..1024*1024*100' >3
>     $ du -shc 1 2 3
>     100M    1
>     100M    2
>     100M    3
>     300M    total
> 
> Which at least on this computer I can't get to not print:
> 
>     $ echo 1 2 3 | xargs -P 3 -n 1 cat|wc -l
>     104857600
> 
> Suggesting that even for output of that size the \n's aren't mixed
> up. YMMV.

I don't think this is telling us much, for two reasons:

  - it's a pipe, not a file, so PIPE_BUF _does_ count here

  - "wc -l" is counting the number of newlines, which always will be the
    same, whether there are interleaved blocks or not. The interesting
    thing is whether a single write() from one of the "cat" calls is
    interleaved with another, but we can't tell that without knowing how
    big a block cat is using.

A more interesting test is something like:

  for i in a b c; do
    perl -e '
      syswrite(STDOUT,"this is $ARGV[0]\n") for 1..1024*1024*10
    ' $i &
  done >out
  wait
  sort <out | uniq -c

We are writing to a shared file here, and we care whether each
individual syswrite ever got interleaved with another (which we would
notice because our sort/uniq output would have more than the expected
three lines).

We can even spice it up with some signals on one of the processes by
putting:

  $SIG{ALRM} = sub { print STDERR "alarm $ARGV[0]\n" };

into the perl, and then doing:

  for t in $(seq 1000); do
    kill -ALRM %1
    sleep 0.01
  done

before the wait. But at least on Linux (with ext4), that seems to always produce
atomic results for each write(). Even if I increase the size of the
message to 4k or larger.

So it seems pretty solid there, but I'm not sure I would guarantee it on
other platforms or filesystems.

-Peff
