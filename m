Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAE412021E
	for <e@80x24.org>; Mon, 31 Oct 2016 13:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943239AbcJaN4H (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 09:56:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:36447 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S943175AbcJaN4F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 09:56:05 -0400
Received: (qmail 32218 invoked by uid 109); 31 Oct 2016 13:56:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Oct 2016 13:56:04 +0000
Received: (qmail 18057 invoked by uid 111); 31 Oct 2016 13:56:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Oct 2016 09:56:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Oct 2016 09:56:01 -0400
Date:   Mon, 31 Oct 2016 09:56:01 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with
 O_CLOEXEC
Message-ID: <20161031135601.7immbp44wn7uksvs@sigill.intra.peff.net>
References: <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
 <xmqqoa254czs.fsf@gitster.mtv.corp.google.com>
 <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
 <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
 <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com>
 <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>
 <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com>
 <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610281306320.3264@virtualbox>
 <CA+55aFw93vkraxBvFCXFSYJqn836tXW+OCOFuToN+HaxTcJ7cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFw93vkraxBvFCXFSYJqn836tXW+OCOFuToN+HaxTcJ7cg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 09:13:41AM -0700, Linus Torvalds wrote:

> On Fri, Oct 28, 2016 at 4:11 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > You guys. I mean: You guys! You sure make my life hard. A brief look at
> > mingw.h could have answered your implicit question:
> 
> So here's what you guys should do:
> 
>  - leave O_NOATIME damn well alone. It works. It has worked for 10+
> years. Stop arguing against it, people who do.

For some definition of worked, perhaps.

If you set a probe on touch_atime() in the kernel (which is called for
every attempt to smudge the atime, regardless of mount options, but is
skipped when the descriptor was opened with O_NOATIME), you can see the
impact. Here's a command I picked because it reads a lot of objects (run
on my git.git clone):

  $ perf stat -e probe:touch-atime git log -Sfoo >/dev/null

And the probe:touch_atime counts before (stock git) and after (a patch
to drop O_NOATIME):

  before: 22,235
   after: 22,362

So that's only half a percent difference. And it's on a reasonably messy
clone that is partway to triggering an auto-repack:

  $ git count-objects -v
  count: 6167
  size: 61128
  in-pack: 275773
  packs: 18
  size-pack: 86857
  prune-packable: 25
  garbage: 0
  size-garbage: 0

Running "git gc" drops the probe count to 21,733.

It makes a bigger difference for some commands (it's more like 10% for
git-status). And smaller for others ("git log -p" triggers it over
100,000 times).

One thing missing in that count is how many of those calls would have
resulted in an actual disk write. Looking at strace, most of the
filesystem activity is opening .gitattributes files, and we end up
opening the same ones repeatedly (e.g., t/.gitattributes in git.git).
Multiple hits for a given inode in the same second get coalesced into at
most a single disk write.

So I guess it's possible that it produces a noticeable effect in some
cases, but I'm still somewhat doubtful. And actually repacking your
repository had a greater effect in every case I measured (in addition to
providing other speedups).

Like I said, I'm OK keeping O_NOATIME. It's just not that much code. But
if you really care about the issue of dirtying inodes via atime, you
should look into vastly increasing our use of O_NOATIME. Or possibly
looking at caching more in the attribute code.

-Peff
