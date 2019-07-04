Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9966D1F461
	for <e@80x24.org>; Thu,  4 Jul 2019 13:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfGDNNZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 09:13:25 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:59436 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfGDNNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 09:13:25 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hj1Y8-0001Ib-DS; Thu, 04 Jul 2019 22:13:20 +0900
Date:   Thu, 4 Jul 2019 22:13:20 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: Surprising use of memory and time when repacking mozilla's gecko
 repository
Message-ID: <20190704131320.ksustvlayy6lby23@glandium.org>
References: <20190704100530.smn4rpiekwtfylhz@glandium.org>
 <20190704120411.2dlzdlsooob4dc7k@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704120411.2dlzdlsooob4dc7k@dcvr>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 04, 2019 at 12:04:11PM +0000, Eric Wong wrote:
> Mike Hommey <mh@glandium.org> wrote:
> > I'm puzzled by the fact writing objects is so much faster with 1 thread.
> 
> I/O contention in the multi-threaded cases?
> 
> "public-inbox-index" (reading from git, writing to Xapian+SQLite)
> on a dev machine got slow because core count exceeded what SATA
> could handle and had to cap the default Xapian shard count to 3
> by default for v2 inboxes.
 
AFAICT, git doesn't write from multiple threads.
 
> As for memory use, does git use the producer/consumer pattern
> for malloc+free so free happens in a different thread from the
> malloc?
> 
> Because current versions of glibc gets pathological with that case
> (but I have a long-term fix for it):
> 
> https://public-inbox.org/libc-alpha/20180731084936.g4yw6wnvt677miti@dcvr/T/
> Only locklessinc malloc seemed OK in the IPC department
> (But I haven't kept up with jemalloc, tcmalloc developments in years)

Oh right, I forgot to mention:
- I thought this memory usage thing was [1] but it turns out it was real
  memory usage.
- glibc's mallinfo stores values as int, so it's useless to know how
  much memory was allocated when it's more than 4GB.
- glibc's malloc_stats relies on the same int data, so while it does
  print "in use" data, it can't print values above 4GB correctly.
- glibc has a malloc_stats function that, according to its manual page
  "addresses the deficiencies in malloc_stats and mallinfo", but while
  it outputs a large XML dump, it doesn't contain anything that looks
  remotely like the "in use" from malloc_stats.
- So all in all, I used jemalloc to gather the "allocated" stats.

Mike

1. https://sourceware.org/bugzilla/show_bug.cgi?id=23416
