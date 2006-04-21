From: Shawn Pearce <spearce@spearce.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 22:32:22 -0400
Message-ID: <20060421023222.GA1117@spearce.org>
References: <20060420150315.GB31198@spearce.org> <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org> <20060420164351.GB31738@spearce.org> <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org> <20060420175554.GH31738@spearce.org> <Pine.LNX.4.64.0604201414490.2215@localhost.localdomain> <7v8xq0yteb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604201630320.2215@localhost.localdomain> <7vfyk8vscl.fsf@assigned-by-dhcp.cox.net> <20060421012029.GB819@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 04:33:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWlSI-0004ts-Qy
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 04:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWDUCco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 22:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWDUCcf
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 22:32:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:2204 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932134AbWDUCc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 22:32:28 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FWlRN-00053J-Cg; Thu, 20 Apr 2006 22:32:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E711A20FBB4; Thu, 20 Apr 2006 22:32:22 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060421012029.GB819@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19015>

I just tried the patch below on a couple-month-old Linux 2.6
repository from Linus (last commit: Feb 14 2006).  It did not
decrease the pack file size by much despite the higher delta:

  'next'       Total 189435, written 189435 (delta 142093), reused 44057 (delta 0)
  'next'+patch Total 189435, written 189435 (delta 142712), reused 43954 (delta 0)

  'next'       104464297 bytes
  'next'+patch 104092920 bytes (99.6% of 'next')

  'next'       328.98 real       206.02 user        93.60 sys
  'next'+patch 363.06 real       218.98 user        94.72 sys

So it looks like the patch is taking longer to run, and by about 10%.
An expensive price to pay for what amounts to only a 0.4% reduction
in pack size on the kernel.


Shawn Pearce <spearce@spearce.org> wrote:
> Based on Linus' comment I changed your patch to just the following.
> It still produced the 46M pack file, so the first hunk apears to
> not have had much of an affect with this data.
> 
> From a running time perspective it appears as though this patch is
> making things slightly better, not worse.  I ran it a few times
> for each case always using the 46M pack as input for
>  "git-repack -a -d -f".
> 
>   'next'       137.13 real        95.82 user        25.24 sys
>   'next'+patch 131.62 real        89.35 user        28.56 sys
> 
> but even if the running time was an extra 6 seconds I'd still rather
> spend 4% more running time to use 1/2 the storage space.
> 
> 
> diff --git a/pack-objects.c b/pack-objects.c
> index 09f4f2c..f7d6217 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -1052,7 +1052,7 @@ static int try_delta(struct unpacked *cu
>         if (cur_entry->delta)
>                 max_size = cur_entry->delta_size-1;
>         if (sizediff >= max_size)
> -               return -1;
> +               return 0;
>         delta_buf = diff_delta(old->data, oldsize,
>                                cur->data, size, &delta_size, max_size);
>         if (!delta_buf)

-- 
Shawn.
