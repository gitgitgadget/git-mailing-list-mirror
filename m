From: Nicolas Pitre <nico@cam.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 22:28:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604202213470.2215@localhost.localdomain>
References: <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
 <20060420150315.GB31198@spearce.org>
 <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
 <20060420164351.GB31738@spearce.org>
 <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
 <20060420175554.GH31738@spearce.org>
 <Pine.LNX.4.64.0604201414490.2215@localhost.localdomain>
 <7v8xq0yteb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604201630320.2215@localhost.localdomain>
 <7vfyk8vscl.fsf@assigned-by-dhcp.cox.net> <20060421012029.GB819@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 04:32:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWlRF-0004ia-C7
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 04:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWDUCbA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 22:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932208AbWDUC2m
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 22:28:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:51644 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932103AbWDUC2d
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 22:28:33 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY1008ZAW7KSMI0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 20 Apr 2006 22:28:33 -0400 (EDT)
In-reply-to: <20060421012029.GB819@spearce.org>
X-X-Sender: nico@localhost.localdomain
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19014>

On Thu, 20 Apr 2006, Shawn Pearce wrote:

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

I can confirm this is indeed the best fix so far.  Any "smarter" 
solution I could think of did increase the size of the final pack quite 
spectacularly and rather unexpectedly with Shawn's repository.

Of course removing the if (sizediff >= max_size) entirely does produce a 
smaller pack (39MB) but it takes about twice the CPU.

With the patch above the Linux kernel pack is 0.3% smaller with 1% more 
CPU usage.  But like for the diff-delta hash list limiting code this 
small overhead is certainly a good compromize to avoid big degradations 
in some other cases.


Nicolas
