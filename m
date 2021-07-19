Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27758C636CE
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 09:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 149EC61181
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 09:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbhGSITX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 04:19:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:53392 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235286AbhGSITW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 04:19:22 -0400
Received: (qmail 30696 invoked by uid 109); 19 Jul 2021 09:00:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jul 2021 09:00:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11137 invoked by uid 111); 19 Jul 2021 09:00:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jul 2021 05:00:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 19 Jul 2021 05:00:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Fabian Stelzer <fabian.stelzer@campoint.net>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: progress test failure on fedora34
Message-ID: <YPU/Enow8Mgn5f4j@coredump.intra.peff.net>
References: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net>
 <87a6mo29dp.fsf@evledraar.gmail.com>
 <CAMMLpeQ5Lh8xfqTZoM74f616wE7ZhqWArL1WgGiMtiJSfrYcYg@mail.gmail.com>
 <87h7gsvybx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h7gsvybx.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 18, 2021 at 10:05:44AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > This test also fails for me when using QTerminal or Konsole, but it
> > passes on XTerm and LXTerminal.
> 
> I tried this on Debian 11 with QTerminal 0.16.1 and can't reproduce it,
> resized the window etc., always get COLUMNS=80 if I add some printf
> debugging.
> 
> Do you mind testing with an ad-hoc patch like this on top? It will fail
> right away, but should say COLUMNS = 80 in the output.
> 
> The only thing I can think of right now is that some terminals are doing
> some evil trickery to LD_PRELOAD or whatever and intercept getenv() for
> COLUMNS and the like, but that's an entirely unfounded hunch.

That would be truly evil. :)

Another possible source of weirdness: some shells are picky about
assigning to COLUMNS, and are eager to set it themselves. E.g.:

  $ echo $COLUMNS
  119
  $ COLUMNS=80 bash -c 'echo $COLUMNS'
  80
  $ COLUMNS=80 zsh -c 'echo $COLUMNS'
  119

So zsh, even in a non-interactive shell, will set it. It does at least
accept setting it, and will preserve it in sub-shells and forks. But it
will silently ignore invalid values, instead going back to the ioctl:

  $ zsh -c 'COLUMNS=80; echo $COLUMNS; COLUMNS=foo; echo $COLUMNS'
  80
  119

mksh behaves the same way; I was tipped off to this by b082687cba
(test-lib: skip test with COLUMNS=1 under mksh, 2012-04-27).

I have trouble seeing how this could cause a problem since "80" seems
like a perfectly sensible value. And one would imagine that the same
shell is being used in all cases above (but maybe not, depending on the
configuration of the terminal programs?). But it's another possible
avenue of investigation.

> diff --git a/progress.c b/progress.c
> index 680c6a8bf9..dca254b515 100644
> --- a/progress.c
> +++ b/progress.c
> @@ -144,6 +144,7 @@ static void display(struct progress *progress, uint64_t n, const char *done)
>                         size_t progress_line_len = progress->title_len +
>                                                 counters_sb->len + 2;
>                         int cols = term_columns();
> +                       fprintf(stderr, "cols = %d\n", cols);
>  
>                         if (progress->split) {
>                                 fprintf(stderr, "  %s%*s", counters_sb->buf,

Yeah, this seems like a good start to see if the value we're getting is
bogus. Likewise, it might be interesting for term_columns() to tell us
if it's getting the value from $COLUMNS or from the ioctl (but it's hard
to believe it wouldn't be from $COLUMNS, given the code).

-Peff
