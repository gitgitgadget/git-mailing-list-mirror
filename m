Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F341F461
	for <e@80x24.org>; Fri,  5 Jul 2019 05:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfGEFrk (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 01:47:40 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:57846 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfGEFrk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 01:47:40 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hjH4K-0006fz-1s; Fri, 05 Jul 2019 14:47:36 +0900
Date:   Fri, 5 Jul 2019 14:47:36 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Surprising use of memory and time when repacking mozilla's gecko
 repository
Message-ID: <20190705054736.6llkhnopt2fcta2k@glandium.org>
References: <20190704100530.smn4rpiekwtfylhz@glandium.org>
 <20190704120411.2dlzdlsooob4dc7k@dcvr>
 <20190704131320.ksustvlayy6lby23@glandium.org>
 <20190705051412.GB25459@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705051412.GB25459@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 05, 2019 at 01:14:13AM -0400, Jeff King wrote:
> On Thu, Jul 04, 2019 at 10:13:20PM +0900, Mike Hommey wrote:
> 
> > > "public-inbox-index" (reading from git, writing to Xapian+SQLite)
> > > on a dev machine got slow because core count exceeded what SATA
> > > could handle and had to cap the default Xapian shard count to 3
> > > by default for v2 inboxes.
> >  
> > AFAICT, git doesn't write from multiple threads.
> 
> Right. That's always single threaded, and the main difference there is
> going to be what's in the delta base cache.
> 
> > Oh right, I forgot to mention:
> > - I thought this memory usage thing was [1] but it turns out it was real
> >   memory usage.
> > - glibc's mallinfo stores values as int, so it's useless to know how
> >   much memory was allocated when it's more than 4GB.
> > - glibc's malloc_stats relies on the same int data, so while it does
> >   print "in use" data, it can't print values above 4GB correctly.
> > - glibc has a malloc_stats function that, according to its manual page
> >   "addresses the deficiencies in malloc_stats and mallinfo", but while
> >   it outputs a large XML dump, it doesn't contain anything that looks
> >   remotely like the "in use" from malloc_stats.
> > - So all in all, I used jemalloc to gather the "allocated" stats.
> 
> I think I explained all of the memory-usage questions in my earlier
> response, but just for reference: if you have access to it, valgrind's
> "massif" tool is really good for this kind of profiling. Something like:
> 
>   valgrind --tool=massif git pack-objects ...
>   ms_print massif.out.*
> 
> which shows heap usage at various times, points out the snapshot with
> peak usage, and shows a backtrace of the main culprits at a few
> snapshots.

At the expense of time ;) A run would likely last an entire day under
massif (by which I mean a full 24 hours, not a 9-5 day).

Mike
