From: Shawn Pearce <spearce@spearce.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 21:01:46 -0400
Message-ID: <20060421010146.GA819@spearce.org>
References: <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org> <20060420164351.GB31738@spearce.org> <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org> <20060420175554.GH31738@spearce.org> <Pine.LNX.4.64.0604201414490.2215@localhost.localdomain> <7v8xq0yteb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604201630320.2215@localhost.localdomain> <7vfyk8vscl.fsf@assigned-by-dhcp.cox.net> <20060420220240.GB32748@spearce.org> <7vy7xzvpsg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 03:02:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWk21-0008OW-Bc
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 03:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWDUBBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 21:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWDUBBy
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 21:01:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44688 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932195AbWDUBBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 21:01:54 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FWk1i-0002mJ-3s; Thu, 20 Apr 2006 21:01:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 92A4A20FBB4; Thu, 20 Apr 2006 21:01:46 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vy7xzvpsg.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19011>

Junio C Hamano <junkio@cox.net> wrote:
[snip]
> I suspect the test patch makes pack-objects a lot more
> expensive.

Which patch are you talking about the previous patch or the one in
the message I'm now replying to?

> The code before the test patch said "if the size is very small
> or size difference is too great, do not consider this, and do
> not consider any more objects in the delta window, because we
> know they are either even smaller of the same path, they have
> different names, or they are of different type".  The test patch
> you tried was a quick and dirty hack that said "under the
> too-small condition, skip this one, but keep trying the rest of
> the delta window".
> 
> Here is a cleaned up patch.  What it does is "under the
> too-small condition, see if the object has the same basename,
> and if so keep going, but otherwise skip the rest as before".
[snip]

The patch below does not help very much:

  Total 46391, written 46391 (delta 6686), reused 37979 (delta 0)
  129M pack-7f766f5af5547554bacb28c0294bd562589dc5e7.pack

> diff --git a/pack-objects.c b/pack-objects.c
> index 09f4f2c..2173709 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -1036,8 +1036,6 @@ static int try_delta(struct unpacked *cu
>  	oldsize = old_entry->size;
>  	sizediff = oldsize > size ? oldsize - size : size - oldsize;
>  
> -	if (size < 50)
> -		return -1;
>  	if (old_entry->depth >= max_depth)
>  		return 0;
>  
> @@ -1048,20 +1046,27 @@ static int try_delta(struct unpacked *cu
>  	 * more space-efficient (deletes don't have to say _what_ they
>  	 * delete).
>  	 */
> -	max_size = size / 2 - 20;
> -	if (cur_entry->delta)
> -		max_size = cur_entry->delta_size-1;
> -	if (sizediff >= max_size)
> -		return -1;
> -	delta_buf = diff_delta(old->data, oldsize,
> -			       cur->data, size, &delta_size, max_size);
> -	if (!delta_buf)
> +	if (50 <= size) {
> +		max_size = size / 2 - 20;
> +		if (cur_entry->delta)
> +			max_size = cur_entry->delta_size-1;
> +		if (sizediff < max_size) {
> +			delta_buf = diff_delta(old->data, oldsize,
> +					       cur->data, size,
> +					       &delta_size, max_size);
> +			if (!delta_buf)
> +				return 0;
> +			cur_entry->delta = old_entry;
> +			cur_entry->delta_size = delta_size;
> +			cur_entry->depth = old_entry->depth + 1;
> +			free(delta_buf);
> +			return 0;
> +		}
> +	}
> +	/* Keep going as long as the basename matches */
> +	if (((cur_entry->hash ^ old_entry->hash) >>DIRBITS) == 0)
>  		return 0;
> -	cur_entry->delta = old_entry;
> -	cur_entry->delta_size = delta_size;
> -	cur_entry->depth = old_entry->depth + 1;
> -	free(delta_buf);
> -	return 0;
> +	return -1;
>  }
>  
>  static void progress_interval(int signum)
> 

-- 
Shawn.
