From: Jeff King <peff@peff.net>
Subject: Re: bug in name-rev on linux-2.6 repo?
Date: Thu, 22 Apr 2010 11:17:08 -0400
Message-ID: <20100422151708.GA15039@coredump.intra.peff.net>
References: <20100421195822.GX10984@baikonur.stro.at>
 <r2sbe6fef0d1004220354g6443218ezbd0452428ad9e4b5@mail.gmail.com>
 <20100422121408.GI3211@stro.at>
 <20100422124042.GA1433@progeny.tock>
 <m2hbn37e7q.fsf@igel.home>
 <20100422144433.GB28923@coredump.intra.peff.net>
 <20100422145455.GC28923@coredump.intra.peff.net>
 <20100422150325.GB4801@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	maximilian attems <max@stro.at>,
	Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 17:17:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4y9z-00037Y-1x
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 17:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754789Ab0DVPRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Apr 2010 11:17:41 -0400
Received: from peff.net ([208.65.91.99]:50354 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754701Ab0DVPRk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Apr 2010 11:17:40 -0400
Received: (qmail 1945 invoked by uid 107); 22 Apr 2010 15:17:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 22 Apr 2010 11:17:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Apr 2010 11:17:08 -0400
Content-Disposition: inline
In-Reply-To: <20100422150325.GB4801@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145540>

On Thu, Apr 22, 2010 at 10:03:25AM -0500, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > Still looking, but definitely some kind of skew problem.
> 
> That explains it, then:
> 
> $ git log --format=%cd' %h' 19f5fb7 ^v2.6.34-rc1~200
> Sun Jan 24 14:34:07 2010 -0500 19f5fb7
> Mon Dec 7 10:36:20 2009 -0500 d2eecb0
> Fri Jan 1 01:00:21 2010 -0500 f8ec9d6
> Wed Dec 23 07:45:44 2009 -0500 71f2be2
> Fri Jan 22 17:40:42 2010 -0500 1f2acb6
> Mon Feb 15 20:17:55 2010 -0500 15121c1
> Thu Feb 4 23:58:38 2010 -0500 a1de02d
> 
> This part of the history is linear.

Thanks for confirming, that was the same stretch of history I ended up
looking at.

> Is the rule that every commit must be at most one day before each of
> its parents?  This should probably be documented somewhere, since it
> is possible to override the committer date with GIT_COMMITTER_DATE.

There is no hard and fast rule. We have to deal with _some_ clock skew,
but I think it has been anybody's guess how much. One can always treat
the graph purely topologically (which is what my first patch removing
the cutoff_date check did), but that usually means more computation. In
this case, we go all the way to the roots instead of looking at a
"recent" subgraph. I think we also look at timestamps in rev-list when
linearizing to avoid doing a full topo-sort, but I don't remember what
effects clock skew can have there.

So what should we do with this incident?

  1. Declare it too much clock skew and ignore it.

  2. Drop the cutoff optimization in favor of correctness. We already do
     this for --stdin, as there is no sensible cutoff for multiple
     inputs. So you can see how much slower it is:

       $ time git name-rev a1de02dccf906faba2ee2d99cac56799bda3b96a
       a1de02dccf906faba2ee2d99cac56799bda3b96a undefined

       real    0m0.163s
       user    0m0.140s
       sys     0m0.020s

       $ time echo a1de02dccf906faba2ee2d99cac56799bda3b96a |
         git name-rev --stdin
       a1de02dccf906faba2ee2d99cac56799bda3b96a (tags/v2.6.34-rc1~199^2~35)

       real    0m3.411s
       user    0m3.244s
       sys     0m0.164s

     So perhaps it is something one would want to enable with a
     command-line option. Or even something we could fall back on
     automatically as a "slow case" when coming up with an un-nameable
     rev.

  3. Bump the slop date. 60 days would work here. What's reasonable? A
     year? At one year, we are still noticeably slower:

       # patched for CUTOFF_SLOP_DATE (365*86400)
       $ time git name-rev a1de02dccf906faba2ee2d99cac56799bda3b96a
       a1de02dccf906faba2ee2d99cac56799bda3b96a
       tags/v2.6.34-rc1~199^2~35

       real    0m1.075s
       user    0m1.028s
       sys     0m0.044s

-Peff
