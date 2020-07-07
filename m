Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C681C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 21:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E2D206C3
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 21:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729262AbgGGV7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:59:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:51784 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbgGGV7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 17:59:53 -0400
Received: (qmail 23615 invoked by uid 109); 7 Jul 2020 21:59:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2020 21:59:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32151 invoked by uid 111); 7 Jul 2020 21:59:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2020 17:59:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jul 2020 17:59:51 -0400
From:   Jeff King <peff@peff.net>
To:     Zach Riggle <zachriggle@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git grep --threads 12 --textconv is effectively single-threaded
Message-ID: <20200707215951.GB2300296@coredump.intra.peff.net>
References: <CAMP9c5nUteg_HouuYJZtq7g4MrSE638mns=HeKhNpNTYgQB4=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP9c5nUteg_HouuYJZtq7g4MrSE638mns=HeKhNpNTYgQB4=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 07, 2020 at 04:25:01PM -0500, Zach Riggle wrote:

> It looks like the bit of code that is responsible for performing
> textconv conversions is single-threaded, even if git-grep is provided
> a number of threads to use.

Yes, the locking is much coarser than it could be. The issue is in
grep.c's fill_textconv_grep():

          /*
           * fill_textconv is not remotely thread-safe; it modifies the global
           * diff tempfile structure, writes to the_repo's odb and might
           * internally call thread-unsafe functions such as the
           * prepare_packed_git() lazy-initializator. Because of the last two, we
           * must ensure mutual exclusion between this call and the object reading
           * API, thus we use obj_read_lock() here.
           *
           * TODO: allowing text conversion to run in parallel with object
           * reading operations might increase performance in the multithreaded
           * non-worktreee git-grep with --textconv.
           */
          obj_read_lock();
          size = fill_textconv(r, driver, df, &buf);
          obj_read_unlock();
          free_filespec(df);

Note that this lock is used whether we're doing textconv's or not (i.e.,
it also excludes reading two objects from the object database at the
same time, because none of that code is thread-safe). But the latency
when we're doing a textconv is _much_ higher, because it's shelling out
to a separate process and reading/writing the contents. Note the
much-higher system CPU in your second timing:

> Note the difference in total CPU usage in the following expressions:
> 
> $ git grep --threads 12 -e foobar --and -e fizzbuzz &> /dev/null
> 0.24s user 0.28s system 710% cpu 0.073 total
> 
> $ git grep --threads 12 -e foobar --and -e fizzbuzz --textconv &> /dev/null
> 0.90s user 1.75s system 110% cpu 2.390 total

So I think implementing that TODO would help a lot (because each
textconv could in theory proceed in parallel).

As workaround in the meantime, I suspect that enabling
diff.<driver>.cachetextconv for your particular textconv config might
help. It would be slow on the first run, but then we'd be able to skip
the external process entirely for subsequent runs (the results are
cached in a git-notes tree, which are just raw object reads).

-Peff
