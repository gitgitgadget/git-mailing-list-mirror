From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 12:29:10 -0700
Message-ID: <20100902192910.GJ32601@spearce.org>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com> <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com> <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com> <4C7FC3DC.3060907@gmail.com> <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com> <20100902155810.GB14508@sigill.intra.peff.net> <alpine.LFD.2.00.1009021233190.19366@xanadu.home> <4C7FDA32.5050009@gmail.com> <alpine.LFD.2.00.1009021326290.19366@xanadu.home> <AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 21:29:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFTO-0006Wv-6w
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516Ab0IBT3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 15:29:16 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52117 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756495Ab0IBT3P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:29:15 -0400
Received: by qyk33 with SMTP id 33so979848qyk.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:29:15 -0700 (PDT)
Received: by 10.224.37.134 with SMTP id x6mr261554qad.274.1283455754695;
        Thu, 02 Sep 2010 12:29:14 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id l8sm835400qck.6.2010.09.02.12.29.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:29:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155159>

Luke Kenneth Casson Leighton <luke.leighton@gmail.com> wrote:
> 
>  * based on what you kindly mentioned about "git repack -f", would a
> (well-written!) patch to git pack-objects to add a
> "--single-thread-only" option be acceptable?

Probably not.  I can't think of a good reason to limit the number
of threads that get used.  We already have pack.threads as a
configuration variable to support controlling this for the system,
but that's about the only thing that really makes sense.
 
>  * would you, or anyone else with enough knowledge of how this stuff
> reaallly works, be willing to put some low-priority back-of-mind
> thought into how to create a "canonical" pack format

We have.  We've even talked about it on the mailing list.  Multiple
times.  Most times about how to support a p2p Git transport.
That whole Gittorrent thing you are ignoring, we put some effort
into coming up with a pack-like format that would be more stable,
at the expense of being larger in total size.

>  questions (not necessarily for nicolas) - can anyone think of any
> good reasons _other_ than for multiple file-sharing to have a
> "canonical" pack-object?

Yes, its called resuming a clone over git://.

Right now if you abort git:// you break the pack stream, and it
cannot be restarted.  If we had a more consistent encoding we may
be able to restart an aborted clone.

But we can't solve it.  Its a _very_ hard problem.

Nico, myself, and a whole lot of other very smart folks who really
understand how Git works today have failed to identify a way to do
this that we actually want to write, include in git, and maintain
long-term.  Sure, anyone can come up with a specification that says
"put this here, that there, break ties this way".  But we don't
want to bind our hands and maintain those rules.
 
> off the top of my head i can think of one: rsync if the transfer is
> interrupted.  if the pack-objects are large - and not guaranteed to be
> the same - then an interrupted rsync transfer would be a bit of a
> waste of bandwidth.  however if the pack-object could always be made
> the same, the partial transfer could carry on.   musing a bit
> further... mmm... i supooose the same thing applies equally to http
> and ftp.  it's a bit lame, i know: can anyone think of any better
> reasons?

We already do with this http:// and ftp:// during fetch or clone.
We try to resume with a byte range request, and validate the SHA-1
trailer on the end of the pack file after download.  If it doesn't
match, we throw the file away and restart the entire thing.

In general pack files don't change that often, so there are fairly
good odds that resuming an aborted clone only a few hours after
it aborted would succeed by simply resuming the file download.
But every week or two (or even nightly!) its common for packs to
be completely rewritten (when the repository owner does `git gc`),
so we really cannot rely on packs being stable long-term.

-- 
Shawn.
