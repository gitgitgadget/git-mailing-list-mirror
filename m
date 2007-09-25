From: Jeff King <peff@peff.net>
Subject: Re: diffcore-rename performance mode
Date: Tue, 25 Sep 2007 12:38:43 -0400
Message-ID: <20070925163843.GA22987@coredump.intra.peff.net>
References: <20070918082321.GA9883@coredump.intra.peff.net> <7vsl5cwe6p.fsf@gitster.siamese.dyndns.org> <20070918085413.GA11751@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 18:38:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaDQz-0000ky-Pe
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 18:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbXIYQir (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 12:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbXIYQir
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 12:38:47 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4184 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbXIYQiq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 12:38:46 -0400
Received: (qmail 17858 invoked by uid 111); 25 Sep 2007 16:38:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 25 Sep 2007 12:38:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Sep 2007 12:38:43 -0400
Content-Disposition: inline
In-Reply-To: <20070918085413.GA11751@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59146>

On Tue, Sep 18, 2007 at 04:54:13AM -0400, Jeff King wrote:

> > > However, keeping around _just_ the
> > > cnt_data caused only about 100M of extra memory consumption (and gave
> > > the same performance boost).
> > 
> > That would be an interesting and relatively low-hanging optimization.
> 
> I can produce memory usage numbers for the kernel, too.

And here are some kernel numbers. I measured performance of this script
in the linux-2.6 repository:

#!/bin/sh

last=
git-tag | grep -v -- - | while read tag; do
  if test -n "$last"; then
    echo Diffing $last..$tag
    git-diff --raw -M -l0 $last $tag >/dev/null
  fi
  last=$tag
done

under the assumption that diffing between major revisions would give a
good medium of diffs that would be large enough to show the n^2 rename
behavior, but still small enough to be close to "everyday" usage.

I measured three different approaches:
  1. stock 'next' (stock)
  2. removing entirely the calls to diff_free_filespec_data (nofree)
  3. changing those free calls to free everything except cnt_data (somefree)

And I measured two things:
  1. user CPU time to complete
  2. peak memory usage

All numbers are warm-cache, and typical cases after multiple runs.

                 | stock | nofree | somefree
-----------------|---------------------------
user time (s)    | 76.78 | 16.96  | 46.26
peak memory (Kb) | 52300 | 66796  | 59156

The raw 'time' output is below:

stock:
76.78user 3.35system 1:20.72elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+166733minor)pagefaults 0swaps

nofree:
16.96user 1.46system 0:18.47elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+185353minor)pagefaults 0swaps

somefree:
46.26user 1.54system 0:47.94elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+178819minor)pagefaults 0swaps

So this is definitely worth pursuing, as it yields massive speedups even
for regular repositories. And even the 'nofree' case only costs us 14M
of extra memory (although it is a 27% increase, this just isn't that
memory-hungry an endeavour for the sizes of changes we're talking
about). And as Linus noted, now that we have a default rename limit,
you're not likely to hit an explosion of memory usage.

What is most confusing is why the 'somefree' case performs so badly,
since we should just be using the cnt_data. I'll see if gprof can shed
any light on that. It would be nice to use it instead, since it will
have much better memory usage in the face of large blobs (e.g., my
pathological case that started this whole thread).

-Peff
