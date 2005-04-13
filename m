From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: Index/hash order
Date: Wed, 13 Apr 2005 23:40:05 +0200
Message-ID: <87aco2gxu2.fsf@deneb.enyo.de>
References: <425C3F12.9070606@zytor.com>
	<Pine.LNX.4.58.0504121452330.4501@ppc970.osdl.org>
	<20050412224027.GB20821@elte.hu>
	<Pine.LNX.4.58.0504121554140.4501@ppc970.osdl.org>
	<20050412230027.GA21759@elte.hu> <20050412230729.GA22179@elte.hu>
	<20050413111355.GB13865@elte.hu> <425D4E1D.4040108@zytor.com>
	<20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com>
	<Pine.LNX.4.58.0504131008500.4501@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 23:37:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLpXu-00058W-IY
	for gcvg-git@gmane.org; Wed, 13 Apr 2005 23:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVDMVkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 17:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVDMVkZ
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 17:40:25 -0400
Received: from mail.enyo.de ([212.9.189.167]:50363 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261206AbVDMVkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 17:40:16 -0400
Received: from deneb.enyo.de ([212.9.189.171])
	by albireo.enyo.de with esmtp id 1DLpah-0006wN-QR; Wed, 13 Apr 2005 23:40:07 +0200
Received: from fw by deneb.enyo.de with local (Exim 4.50)
	id 1DLpaf-00041w-DZ; Wed, 13 Apr 2005 23:40:05 +0200
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504131008500.4501@ppc970.osdl.org> (Linus
	Torvalds's message of "Wed, 13 Apr 2005 10:24:53 -0700 (PDT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Linus Torvalds:

>  - I want things to distribute well. This means that it has to be based 
>    on a "append data" model, where historical data never changes, and you 
>    only append on top of it (either by adding totally new files, or by 
>    just letting the files grow).

Yes, I think this is something which can easily dominate the choice of
data structure.

>    This works in a forward-delta environment (which is fundamentally based 
>    on the notion of "we know the old version, we're adding new stuff on
>    top of it"), but does _not_ work in the backwards model of "we keep the
>    old history as a delta against the new" model.

Forward deltas don't have to be terribly inefficient.  You can get
O(log n) access to revision n fairly easily, using the trick described
there:

  <http://svn.collab.net/repos/svn/trunk/notes/skip-deltas>

I've run a few tests, just to get a few numbers of the overhead
involved.  I used the last ~8,000 changesets from the BKCVS kernel
repository.  With cold cache, a checkout from cold cache takes about
250 seconds on my laptop.  I don't have git numbers, but a mere copy
of the kernel tree needs 40 seconds.

For the hot-cache case, the difference is 140 seconds vs. 2.5 seconds
(or 6 seconds with decompression).

Uh-oh.  I wouldn't have imaged the difference would be *that*
dramatic.  The file system layer is *fast*.

Subversion's delta implementation is not a speed daemon (it handles
arbitrarily large files, which increases complexity significantly and
slows things down, compared to simpler in-memory algorithms), but it
will be very hard to come even close to the 2.5 seconds.

On the storage front, we have 220 MB for the skip deltas vs. 106 MB
for pure deltas-to-previous vs. 1.1 GB for uncompressed files
(directories are always delta-compressed, so to speak[1]).  In the
first two cases, the first revision in the repository is deltaed
against /dev/null and itself and thus compressed, in case you think
the numbers are suspiciously low.

1. AFAICS, you can't really avoid that if you want to track file
   identity information without introducing arbitrary file IDs.
