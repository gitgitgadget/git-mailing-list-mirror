Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4D0C83004
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 04:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F4F2051A
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 04:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgD1EKL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 00:10:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:41796 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725885AbgD1EKL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 00:10:11 -0400
Received: (qmail 17903 invoked by uid 109); 28 Apr 2020 04:10:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 04:10:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30983 invoked by uid 111); 28 Apr 2020 04:21:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Apr 2020 00:21:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Apr 2020 00:10:10 -0400
From:   Jeff King <peff@peff.net>
To:     Dale Henrichs <dale.henrichs@gemtalksystems.com>
Cc:     Antoine Pelisse <apelisse@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Kurt Kilpela <kurt.kilpela@gemtalksystems.com>
Subject: Re: all memory consuming `git diff-tree` bug
Message-ID: <20200428041010.GA2371637@coredump.intra.peff.net>
References: <5e00fe77-3f72-0729-2b30-9f4f98a28b1c@gemtalksystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e00fe77-3f72-0729-2b30-9f4f98a28b1c@gemtalksystems.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 27, 2020 at 05:28:26PM -0700, Dale Henrichs wrote:

> When I execute the follow set of commands, the `git diff-tree` command will
> go on to consume all 30G of ram and then 30G of swap on a system running
> Ubuntu 18.04.
> 
> git clone git@github.com:GemTalk/Rowan.git
> cd Rowan
> git checkout c70f69b50dc90c0a6207a5aa36705b71b59b92b3
> git diff-tree -r -p --textconv --submodule -C --cc --no-commit-id -U3 --root
> c70f69b50dc90c0a6207a5aa36705b71b59b92b3

Interesting case. To narrow it down a bit, the problem is in the
combined diff of this file:

  $ git diff-tree -r --raw -c c70f69b50dc
  [...]
  ::100644 100644 000000 3d41426ebb801416ec0941d8b9cffdd53c300e43 7aa23a5f12ca31523c999d8eff767d0e2923a76f 0000000000000000000000000000000000000000 DD	platforms/gemstone/topaz/3.5.0/project_src_v2/ComponentV2.gs

where two different versions of it were resolved as a deletion. Doing
the content-level diff shows the problem:

  git diff-tree -p -c c70f69b50dc -- platforms/gemstone/topaz/3.5.0/project_src_v2/ComponentV2.gs
  [hangs, allocating tons of memory until I kill it]

The allocations all happen in combine-diff:coalesce_lines(). I don't
know the combined-diff code very well, but it looks like this:

        for (i = 0; i < origbaselen + 1; i++) {
                lcs[i] = xcalloc(st_add(lennew, 1), sizeof(int));
                directions[i] = xcalloc(st_add(lennew, 1), sizeof(enum coalesce_direction));
                directions[i][0] = BASE;
        }

is essentially quadratic in the number of lines in the file (well,
really m*n, but it's common for them to be the same order of magnitude).
Here the files are 186991 and 114598 lines respectively. So that's 20GB
times the size of the ints and enum (probably 8 bytes or so), plus
malloc overhead. I'd guess you need on the order of 200GB, if the
quadratic run-time didn't just kill you.

That code comes from:

    commit 99d3206010ba1fcc9311cbe8376c0b5e78f4a136
    Author: Antoine Pelisse <apelisse@gmail.com>
    Date:   Sat Mar 23 18:23:28 2013 +0100

    combine-diff: coalesce lost lines optimally
    
    This replaces the greedy implementation to coalesce lost lines by using
    dynamic programming to find the Longest Common Subsequence.
    
    The O(n²) time complexity is obviously bigger than previous
    implementation but it can produce shorter diff results (and most likely
    easier to read).
    
    List of lost lines is now doubly-linked because we reverse-read it when
    reading the direction matrix.

So it looks like the issue was known, but the author did not anticipate
input this large. An amusing quote from the email thread[1]:

  Unfortunately on a commit that would remove A LOT of lines (10000)
  from 7 parents, the times goes from 0.01s to 1.5s... I'm pretty sure
  that scenario is quite uncommon though.

Without engaging my brain to think about what this code is doing or
whether there might be clever solutions, it really sounds like we might
consider using this quadratic code for small cases if it produces better
results, and then switching to the less-accurate greedy implementation
when we need to.

-Peff

[1] https://lore.kernel.org/git/CALWbr2yfgA8kvtn4yxzPD5cencAPmwMqx=A6n4ohsjdzfAE1bQ@mail.gmail.com/
