From: Shawn Pearce <spearce@spearce.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 18:02:40 -0400
Message-ID: <20060420220240.GB32748@spearce.org>
References: <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org> <20060420150315.GB31198@spearce.org> <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org> <20060420164351.GB31738@spearce.org> <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org> <20060420175554.GH31738@spearce.org> <Pine.LNX.4.64.0604201414490.2215@localhost.localdomain> <7v8xq0yteb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604201630320.2215@localhost.localdomain> <7vfyk8vscl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 00:02:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWhEg-0002my-JH
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 00:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWDTWCs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 18:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWDTWCs
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 18:02:48 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:20712 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751335AbWDTWCr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 18:02:47 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FWhEP-00074W-Go; Thu, 20 Apr 2006 18:02:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B479220FBB4; Thu, 20 Apr 2006 18:02:40 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyk8vscl.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19004>

Junio C Hamano <junkio@cox.net> wrote:
> Nicolas Pitre <nico@cam.org> writes:
> 
> >> But I suspect we have a built-in "we sort bigger to smaller, and
> >> we cut off when we switch bins" somewhere in find_delta() loop,
> >> which I do not recall touching when I did that change, so that
> >> may be interfering and preventing 0-11-AdjLite.deg from all over
> >> the place to delta against each other.
> >
> > I just cannot find something that would do that in the code.  When 
> > --no-reuse-delta is specified, the only things that will break the loop
> > in find_delta() is when try_delta() returns -1, and that happens only 
> > when changing object type or when the size difference is too big, but 
> > nothing looks at the name hash.
> 
> The list is sorted by type then hash then size (type_size_sort),
> so if you have t/Makefile that are big medium small too-small
> and then doc/Makefile that are big medium, once you see the
> too-small t/Makefile it would not consider the big doc/Makefile
> as a candidate X-<.
> 
> This _might_ improve things:
> 
> diff --git a/pack-objects.c b/pack-objects.c
> index 09f4f2c..0c6abe9 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -1037,7 +1039,7 @@ static int try_delta(struct unpacked *cu
>  	sizediff = oldsize > size ? oldsize - size : size - oldsize;
>  
>  	if (size < 50)
> -		return -1;
> +		return 0;
>  	if (old_entry->depth >= max_depth)
>  		return 0;
>  
> @@ -1052,7 +1054,7 @@ static int try_delta(struct unpacked *cu
>  	if (cur_entry->delta)
>  		max_size = cur_entry->delta_size-1;
>  	if (sizediff >= max_size)
> -		return -1;
> +		return 0;
>  	delta_buf = diff_delta(old->data, oldsize,
>  			       cur->data, size, &delta_size, max_size);
>  	if (!delta_buf)

Holy cow, it did:

  Total 46391, written 46391 (delta 8391), reused 37774 (delta 0)
   46M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

That's the smallest packing I've seen yet.  And it doesn't have a
negative affect on repacking GIT either.

-- 
Shawn.
