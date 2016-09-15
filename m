Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311AD2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 00:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933610AbcIOA4p (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Sep 2016 20:56:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:43503 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933531AbcIOA4p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Sep 2016 20:56:45 -0400
Received: (qmail 26170 invoked by uid 109); 15 Sep 2016 00:56:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 00:56:44 +0000
Received: (qmail 5902 invoked by uid 111); 15 Sep 2016 00:56:55 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Sep 2016 20:56:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2016 17:56:41 -0700
Date:   Wed, 14 Sep 2016 17:56:41 -0700
From:   Jeff King <peff@peff.net>
To:     Jonathon Mah <me@jonathonmah.com>
Cc:     git@vger.kernel.org
Subject: Re: Tracking down a segfault in delta_base_cache
Message-ID: <20160915005640.3ui4qfmiqjz2lsov@sigill.intra.peff.net>
References: <3946EE74-219D-4E9C-9CED-69D53B940955@jonathonmah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3946EE74-219D-4E9C-9CED-69D53B940955@jonathonmah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 14, 2016 at 05:42:29PM -0700, Jonathon Mah wrote:

> Hi git, I've been seeing git segfault over the past few days. I'm on Mac OS X 10.12, 64-bit, compiling with clang (Apple LLVM version 8.0.0 (clang-800.0.40)).
> [...]
> Bisect says:
> 
> 8261e1f139db3f8aa6f9fd7d98c876cbeb0f927c is the first bad commit
> commit 8261e1f139db3f8aa6f9fd7d98c876cbeb0f927c
> Author: Jeff King <peff@peff.net>
> Date:   Mon Aug 22 18:00:07 2016 -0400
> 
>     delta_base_cache: use hashmap.h

Have you tried with the patch in:

  http://public-inbox.org/git/20160912164616.vg33kldazuthff3d@sigill.intra.peff.net/

?

> $ lldb /Users/jmah/Documents/Streams/git/git-log -- -u
> (lldb) target create "/Users/jmah/Documents/Streams/git/git-log"
> Current executable set to '/Users/jmah/Documents/Streams/git/git-log' (x86_64).
> (lldb) settings set -- target.run-args  "-u"
> (lldb) process launch -o /dev/null
> Process 92815 launched: '/Users/jmah/Documents/Streams/git/git-log' (x86_64)
> Process 92815 stopped
> * thread #1: tid = 0x1c30677, 0x00000001001bba80 git-log`release_delta_base_cache(ent=0xffffffffffffffd0) + 16 at sha1_file.c:2171, queue = 'com.apple.main-thread', stop reason = EXC_BAD_ACCESS (code=1, address=0x10)
>     frame #0: 0x00000001001bba80 git-log`release_delta_base_cache(ent=0xffffffffffffffd0) + 16 at sha1_file.c:2171
>    2168	
>    2169	static inline void release_delta_base_cache(struct delta_base_cache_entry *ent)
>    2170	{
> -> 2171		free(ent->data);
>    2172		detach_delta_base_cache_entry(ent);

The problems I saw with valgrind weren't here, but would explain this.
We free() the previous node, then walk forward from its "next" pointer.
On my Linux box, that happens to work, but we could be feeding total
junk to the list pointer, which would meant ent->data is junk, and
free() notices.

-Peff
