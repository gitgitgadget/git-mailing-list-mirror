From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fixed crash in fetching remote tags when there is not tags.
Date: Fri, 12 Oct 2007 00:07:45 -0400
Message-ID: <20071012040745.GC27899@spearce.org>
References: <1191919868-4963-1-git-send-email-v@pp.inet.fi> <1191919868-4963-2-git-send-email-v@pp.inet.fi> <81553116-3A4F-4526-A772-9A43C53D3E22@pp.inet.fi> <20071009182043.GA2997@steel.home> <20071010051034.GA30834@coredump.intra.peff.net> <20071010212735.GB16635@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff King <peff@peff.net>,
	=?utf-8?B?VsOkaW7DtiBKw6RydmVsw6Q=?= <v@pp.inet.fi>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 06:13:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgBoj-0000B3-5p
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 06:08:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbXJLEHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 00:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbXJLEHy
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 00:07:54 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56457 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbXJLEHx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 00:07:53 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IgBoF-0003DD-39; Fri, 12 Oct 2007 00:07:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4942020FBAE; Fri, 12 Oct 2007 00:07:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071010212735.GB16635@steel.home>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60653>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Still, I'd suggest move the test into the caller, firstly because it
> is the only place that special. Also, I can't think of a proper reason
> to add a NULL ref to a reflist, and so the crashing tail_link_ref will
> help us find the callers which use tail_link_ref incorrectly
> (illogically too).
> 
> As the result of patter expansion can be NULL (empty pattern, as it
> seems), lets just check for it. I parked the patch below locally.
> 
> diff --git a/remote.c b/remote.c
> index 5e92378..58d63ed 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -884,7 +884,8 @@ int get_fetch_map(struct ref *remote_refs,
>  			    rm->peer_ref->name);
>  	}
>  
> -	tail_link_ref(ref_map, tail);
> +	if (ref_map)
> +		tail_link_ref(ref_map, tail);
>  
>  	return 0;
>  }

I disagree with Alex's argument above, because the result of the
pattern expansion can be NULL due to a pattern that matched nothing
from the remote.  This can easily happen if the user originally
configured "remote.$name.fetch = +refs/heads/subdir/*:..." and
then the remote deletes all branches from refs/heads/subdir at some
point in the future.

I think the above patch is the only thing to do here.  Perhaps Alex
can write up a formal patch and send it to back to the list and CC
Lars Hjemli <hjemli@gmail.com> so he can put it into the patch queue.

-- 
Shawn.
