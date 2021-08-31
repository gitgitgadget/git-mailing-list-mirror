Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809C3C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 10:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5277B60F42
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 10:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240978AbhHaK02 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 06:26:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:34806 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240831AbhHaK01 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 06:26:27 -0400
Received: (qmail 5750 invoked by uid 109); 31 Aug 2021 10:25:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Aug 2021 10:25:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22438 invoked by uid 111); 31 Aug 2021 10:25:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Aug 2021 06:25:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 31 Aug 2021 06:25:30 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     gitster@pobox.com, me@ttaylorr.com, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v3 0/2] send_ref buffering
Message-ID: <YS4DmlJdjxeo+QI0@coredump.intra.peff.net>
References: <xmqqbl5ic19t.fsf@gitster.g>
 <20210831093444.28199-1-jacob@gitlab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210831093444.28199-1-jacob@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 11:34:42AM +0200, Jacob Vosmaer wrote:

> Thanks for the reactions everyone. I agree that packet_fwrite_fmt
> simplifies the patch nicely. Jeff, I hope I have given you credit
> in an appropriate way, let me know if you want me to change something
> there.

What you did looks fine.

Overall the series looks much nicer, and I don't have any real
complaints. I do think it would be nice to take the packet_writer
interface further (letting it replace the static buf, and use stdio
handles, and using it throughout upload-pack). But this is a strict
improvement, so we can do that other refactoring later.

> Regarding setvbuf: I have found out that GNU coreutils has a utility
> called stdbuf that lets you modify the stdout buffer size at runtime
> using some LD_PRELOAD hack so we can use that in Gitaly. I don't
> think this is the best outcome for users, we ought to give them a
> good default instead of expecting them to invoke git-upload-pack
> as 'stdbuf -o 64K git-upload-pack'. But I can't judge the impact
> of globally changing the stdout buffer size for Git so I'll settle
> for having to use stdbuf.

Does the 64k buffer actually improve things? Here are the timings I get
on a repo with ~1M refs (it's linux.git with one ref per commit). "git"
is current unbuffered version, and "git.compile" is master with your
patches on top:

  $ hyperfine -i 'git upload-pack .' 'git.compile upload-pack .' 'stdbuf -o 64K git.compile upload-pack .'
  Benchmark #1: git upload-pack .
    Time (mean ± σ):     948.6 ms ±   7.3 ms    [User: 840.8 ms, System: 107.8 ms]
    Range (min … max):   937.7 ms … 961.1 ms    10 runs
   
    Warning: Ignoring non-zero exit code.
   
  Benchmark #2: git.compile upload-pack .
    Time (mean ± σ):     867.3 ms ±   6.8 ms    [User: 821.5 ms, System: 45.7 ms]
    Range (min … max):   859.7 ms … 883.0 ms    10 runs
   
    Warning: Ignoring non-zero exit code.
   
  Benchmark #3: stdbuf -o 64K git.compile upload-pack .
    Time (mean ± σ):     861.1 ms ±   8.2 ms    [User: 815.5 ms, System: 45.6 ms]
    Range (min … max):   846.1 ms … 872.0 ms    10 runs
   
    Warning: Ignoring non-zero exit code.
   
  Summary
    'stdbuf -o 64K git.compile upload-pack .' ran
      1.01 ± 0.01 times faster than 'git.compile upload-pack .'
      1.10 ± 0.01 times faster than 'git upload-pack .'

This is on a glibc system, so the default buffers should be 4k. It
doesn't appear to make any difference (there's a slight improvement, but
well within the noise, and I had other runs where it did worse).

By the way, if you really want to speed things up, try this:

  $ hyperfine -i 'git.compile upload-pack .' 'GIT_REF_PARANOIA=1 git.compile upload-pack .'
  Benchmark #1: git.compile upload-pack .
    Time (mean ± σ):     855.4 ms ±   5.8 ms    [User: 803.4 ms, System: 52.0 ms]
    Range (min … max):   848.7 ms … 869.5 ms    10 runs
   
    Warning: Ignoring non-zero exit code.
   
  Benchmark #2: GIT_REF_PARANOIA=1 git.compile upload-pack .
    Time (mean ± σ):     394.4 ms ±   3.0 ms    [User: 357.9 ms, System: 36.4 ms]
    Range (min … max):   390.6 ms … 400.3 ms    10 runs
   
    Warning: Ignoring non-zero exit code.
   
  Summary
    'GIT_REF_PARANOIA=1 git.compile upload-pack .' ran
      2.17 ± 0.02 times faster than 'git.compile upload-pack .'

It's not exactly the intended use of that environment variable, but its
side effect is that we do not call has_object_file() on each ref tip.

-Peff
