Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C81C20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 11:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbeLLLYM (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 06:24:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:39344 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726869AbeLLLYL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 06:24:11 -0500
Received: (qmail 11066 invoked by uid 109); 12 Dec 2018 11:24:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 12 Dec 2018 11:24:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15225 invoked by uid 111); 12 Dec 2018 11:23:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 12 Dec 2018 06:23:42 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2018 06:24:10 -0500
Date:   Wed, 12 Dec 2018 06:24:10 -0500
From:   Jeff King <peff@peff.net>
To:     "Iucha, Florin" <Florin.Iucha@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: High locking contention during repack?
Message-ID: <20181212112409.GB30673@sigill.intra.peff.net>
References: <SN1PR12MB23840AFE62E41D908A40D1B095A70@SN1PR12MB2384.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN1PR12MB23840AFE62E41D908A40D1B095A70@SN1PR12MB2384.namprd12.prod.outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 12, 2018 at 03:01:47AM +0000, Iucha, Florin wrote:

> I am running “git-repack  -A -d -f -F --window=250 --depth=250” on a
> Git repository converted using git-svn.

Sort of tangential to your question, but:

  - Using "-F" implies "-f" already, so you don't need both. That said,
    you are probably wasting CPU to use "-F", unless you have adjusted
    zlib compression settings since the last pack. (Whereas using "-f"
    is useful, if you're willing to pay the CPU tradeoff).

  - Using --depth=250 does not actually decrease the packfile size very
    much, and results in a packfile which is more expensive for
    subsequent processes to use. Some experimentation showed that
    --depth=50 is a sweet spot, and that is the default for both normal
    "git gc" and "git gc --aggressive" these days.

    See 07e7dbf0db (gc: default aggressive depth to 50, 2016-08-11) for
    more discussion.

> The system is a 16 core / 32 thread Threadripper with 128GB of RAM and
> NVMe storage. The repack starts strong, with 32 threads but it fairly
> quickly gets to 99% done and the number of threads drops to 4 then 3
> then 2. However, running “dstat 5” I see lots of “sys” time without
> any IO time (the network traffic you see is caused by SSH).

This sounds mostly normal and expected. The parallel part of a repack is
the delta search, which is not infinitely parallelizable. Each worker
thread is given a "chunk" of objects, and it uses a sliding window to
search for delta pairs through that chunk. You don't want a chunk that
approaches the window size, since at every chunk boundary you're missing
delta possibilities.

The default chunk size is about 1/nr_threads of the total list size
(i.e., we portion out all the work). And then when a thread finishes, we
take work from the thread with the most work remaining, and portion it
out. However, at some point the chunks approach their minimum, and we
stop dividing. So the number of threads will drop, eventually to 1, and
you'll be waiting on it to finish that final chunk.

So that's all working as planned. Having high sys load does seem a bit
odd. Most of the effort should be going to reading the mmap'd data from
disk, zlib-inflating it and computing a fingerprint, and then comparing
the fingerprints. So that would mostly be user time.

> Running a strace on the running git-repack process shows only these:
> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
> --- SIGALRM {si_signo=SIGALRM, si_code=SI_KERNEL} ---
> 
> Any idea on how to debug this? I have ran git-repack under gdb, but it seems to spin on builtin/repack.c line 409.

The heavy lifting here is done by the pack-objects child process, not
git-repack itself. Try running with GIT_TRACE=1 in the environment to
see the exact invocation, but timing and debugging:

  git pack-objects --all --no-reuse-delta --delta-base-offset --stdout \
    </dev/null >/dev/null

should produce interesting results.

The SIGALRM loop you see above is likely just the progress meter
triggering once per second (the actual worker threads are updating an
int, and then at least once per second we'll show the int).

-Peff
