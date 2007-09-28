From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Merge non-first refs that match first refspec
Date: Fri, 28 Sep 2007 00:15:09 -0400
Message-ID: <20070928041509.GU3099@spearce.org>
References: <Pine.LNX.4.64.0709272351010.5926@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 06:15:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib7GA-0001p1-F5
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 06:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbXI1EPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 00:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752262AbXI1EPP
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 00:15:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45623 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbXI1EPO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 00:15:14 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ib7Ga-0003ms-T1; Fri, 28 Sep 2007 00:15:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3BC2A20FBAE; Fri, 28 Sep 2007 00:15:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709272351010.5926@iabervon.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59356>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> The code only looked at the first ref in the map of refs when looking
> for matches for the first refspec in the case where there is not
> per-branch configuration of ref to merge. This is often sufficient,
> but not always. Make the logic clearer and test everything in the map.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> I ran all the usual tests with this, and it seems like it should fix a bug 
> you saw, but I don't have the test case to make sure.
> 
>  builtin-fetch.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin-fetch.c b/builtin-fetch.c
> index 2f639cc..47811c9 100644
> --- a/builtin-fetch.c
> +++ b/builtin-fetch.c
> @@ -101,12 +101,13 @@ static struct ref *get_ref_map(struct transport *transport,
>  				if (remote->fetch[i].dst &&
>  				    remote->fetch[i].dst[0])
>  					*autotags = 1;
> -				if (!i && !has_merge && ref_map &&
> -				    !strcmp(remote->fetch[0].src, ref_map->name))
> -					ref_map->merge = 1;
>  			}
>  			if (has_merge)
>  				add_merge_config(&ref_map, remote_refs, branch, &tail);
> +			else
> +				for (rm = ref_map; rm; rm = rm->next)
> +					if (!strcmp(remote->fetch[0].src, rm->name))
> +						rm->merge = 1;
>  		} else {
>  			ref_map = get_remote_ref(remote_refs, "HEAD");
>  			ref_map->merge = 1;

Hmmph.  I'm not seeing how this fixes the bug.  But if it fixes it,
it fixes it.

My understanding of the old code was that it should do what Junio
was reporting as broken:

  - when i == 0 this is the first remote.$foo.fetch;
  - when has_merge == 0 we have no branch.$name.merge;
  - when ref_map != NULL we have at least one ref from this fetch spec;
  - when fetch[0].src == ref_map->name it wasn't a wildcard spec;

The if conditional above was ordered the way it is so we can skip
the more expensive operation (the strcmp) most of them time through
the loop iteration.

The only way I can see the old code was failing was if ref_map
as returned by get_fetch_map() pointed to more than one refspec.
But for that to be true then fetch[1].src must have been a wildcard,
in which case the strcmp() would fail.  So we should only ever
get one entry, it should be the first entry, and dammit it should
have matched.

How/why are we getting cases where fetch[0].src isn't in the first
entry in ref_map?  What are those other entries?  Are they possibly
going to also match fetch[0].src and cause more than one branch
to merge?

BTW, thanks for looking at this.  I didn't have time to get to it
this week and now I'm really unlikely to be able to do so until
after I get back from San Jose.  I have too many things crammed
into this next week. :-\

-- 
Shawn.
