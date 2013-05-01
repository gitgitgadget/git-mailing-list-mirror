From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Hold an 'unsigned long' chunk of the sha1 in obj_hash
Date: Wed, 1 May 2013 16:49:47 -0400
Message-ID: <20130501204947.GA12789@sigill.intra.peff.net>
References: <6c2b67a2f0b67ee796c7676e3febe4c61ab85d4a.1366912627.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed May 01 22:49:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXdyM-0003Uy-LW
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 22:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757056Ab3EAUtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 16:49:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:50788 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756740Ab3EAUtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 16:49:50 -0400
Received: (qmail 6337 invoked by uid 102); 1 May 2013 20:50:05 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 May 2013 15:50:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2013 16:49:47 -0400
Content-Disposition: inline
In-Reply-To: <6c2b67a2f0b67ee796c7676e3febe4c61ab85d4a.1366912627.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223142>

On Thu, Apr 25, 2013 at 08:04:01PM +0200, Thomas Rast wrote:

> And probing lookups happen a lot: some simple instrumentation shows
> that 'git rev-list --all --objects' on my git.git,
> 
> * 19.4M objects are accessed in lookup_object and grow_object_hash
>   combined, while
> 
> * the linear probing loops in lookup_object and insert_obj_hash run a
>   total of 9.4M times.
> 
> So we take a slightly different approach, and trade some memory for
> better cache locality.  Namely, we change the hash table slots to
> contain
> 
>   struct object *obj;
>   unsigned long sha1prefix;

I think this is a clever idea, though I do worry about the extra memory
use (it's not all _that_ much in the grand scheme, but it works against
the cache locality benefit). I just posted (but forgot to cc you) a
patch that takes a different approach: to actually move the likely
candidate to the front of the collision change. The patch is here:

  http://article.gmane.org/gmane.comp.version-control.git/223139

It does a bit better than the numbers you have here:

> I get a decent speedup, for example using git.git as a test
> repository:
> 
> Test                               before              after
> ---------------------------------------------------------------------------------
> 0001.1: rev-list --all             0.42(0.40+0.01)     0.41(0.39+0.01)   -1.5%**
> 0001.2: rev-list --all --objects   2.40(2.37+0.03)     2.28(2.25+0.03)   -5.0%***
> ---------------------------------------------------------------------------------
> 
> And even more in linux.git:
> 
> ---------------------------------------------------------------------------------
> 0001.1: rev-list --all             3.31(3.19+0.12)     3.21(3.09+0.11)   -2.9%**
> 0001.2: rev-list --all --objects   27.99(27.70+0.26)   25.99(25.71+0.25) -7.1%***
> ---------------------------------------------------------------------------------

It _might_ still be advantageous to do your patch on top, but I suspect
it will diminish the returns from your patch (since the point of it is
to probe less far down the chain on average).

> I expected the big win to be in grow_object_hash(), but perf says that
> 'git rev-list --all --objects' spends a whopping 33.6% of its time in
> lookup_object(), and this change gets that down to 30.0%.

I'm not surprised. I spent some time trying to optimize grow_object_hash
and realized that it doesn't make much difference. The killer in
"rev-list --objects --all" is that we hit the same tree entry objects
over and over.

Another avenue I'd like to explore is actually doing a tree-diff from
the last processed commit, since we should need to examine only the
changed entries. I suspect it won't be a big benefit, though, because
even though the tree diff can happen in O(# of entries), we are trying
to beat doing an O(1) hash for each entry. So it's the same algorithmic
complexity, and it is hard to beat a few hashcmp() calls. We'll see.

-Peff
