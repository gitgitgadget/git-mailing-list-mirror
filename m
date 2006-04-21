From: Shawn Pearce <spearce@spearce.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 22:40:12 -0400
Message-ID: <20060421024012.GA1213@spearce.org>
References: <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org> <20060420164351.GB31738@spearce.org> <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org> <20060420175554.GH31738@spearce.org> <Pine.LNX.4.64.0604201414490.2215@localhost.localdomain> <7v8xq0yteb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604201630320.2215@localhost.localdomain> <7vfyk8vscl.fsf@assigned-by-dhcp.cox.net> <20060421012029.GB819@spearce.org> <Pine.LNX.4.64.0604202213470.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 04:40:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWlZI-0005tx-4M
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 04:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWDUCkU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 22:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWDUCkU
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 22:40:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55196 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932218AbWDUCkT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 22:40:19 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FWlYx-0005GO-JN; Thu, 20 Apr 2006 22:40:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D3B1320FBB4; Thu, 20 Apr 2006 22:40:12 -0400 (EDT)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604202213470.2215@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19016>

Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 20 Apr 2006, Shawn Pearce wrote:
> 
> > Based on Linus' comment I changed your patch to just the following.
> > It still produced the 46M pack file, so the first hunk apears to
> > not have had much of an affect with this data.
> > 
> > From a running time perspective it appears as though this patch is
> > making things slightly better, not worse.  I ran it a few times
> > for each case always using the 46M pack as input for
> >  "git-repack -a -d -f".
> > 
> >   'next'       137.13 real        95.82 user        25.24 sys
> >   'next'+patch 131.62 real        89.35 user        28.56 sys
> > 
> > but even if the running time was an extra 6 seconds I'd still rather
> > spend 4% more running time to use 1/2 the storage space.
> > 
> > 
> > diff --git a/pack-objects.c b/pack-objects.c
> > index 09f4f2c..f7d6217 100644
> > --- a/pack-objects.c
> > +++ b/pack-objects.c
> > @@ -1052,7 +1052,7 @@ static int try_delta(struct unpacked *cu
> >         if (cur_entry->delta)
> >                 max_size = cur_entry->delta_size-1;
> >         if (sizediff >= max_size)
> > -               return -1;
> > +               return 0;
> >         delta_buf = diff_delta(old->data, oldsize,
> >                                cur->data, size, &delta_size, max_size);
> >         if (!delta_buf)
> 
> I can confirm this is indeed the best fix so far.  Any "smarter" 
> solution I could think of did increase the size of the final pack quite 
> spectacularly and rather unexpectedly with Shawn's repository.

Wow.  I'm such a trouble maker.  *grin*
 
> Of course removing the if (sizediff >= max_size) entirely does produce a 
> smaller pack (39MB) but it takes about twice the CPU.

Eh, that's not worth it.  7M disk space saved for twice the work isn't
that good of a tradeoff.  I'm not in favor of that version.

> With the patch above the Linux kernel pack is 0.3% smaller with 1% more 
> CPU usage.  But like for the diff-delta hash list limiting code this 
> small overhead is certainly a good compromize to avoid big degradations 
> in some other cases.

Hmm.  See the email I just sent. I was seeing a good 10% increase
in my own tests on a Linux kernel repository.  But I guess I can
hope that my test was flawed somehow and it really is closer to a 1%
increase in running time, making it more likely that the above fix
makes it into GIT.

-- 
Shawn.
