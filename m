From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: thin packs ending up fat
Date: Thu, 12 Jan 2012 21:19:29 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1201122118530.2722@xanadu.home>
References: <20120112221523.GA3663@sigill.intra.peff.net>
 <20120112223234.GA4949@sigill.intra.peff.net>
 <7vwr8wz8u9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 03:19:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlWjw-0005pU-TK
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 03:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757195Ab2AMCTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 21:19:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53933 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757067Ab2AMCTa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 21:19:30 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR006.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LXP0034XT4CRYA0@VL-VM-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jan 2012 21:19:24 -0500 (EST)
In-reply-to: <7vwr8wz8u9.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188493>

On Thu, 12 Jan 2012, Junio C Hamano wrote:

> From: Jeff King <peff@peff.net>
> Subject: [PATCH] thin-pack: try harder to create delta against preferred base
> 
> When creating a pack using objects that reside in existing packs, we try
> to avoid recomputing futile delta between an object (trg) and a candidate
> for its base object (src) if they are stored in the same packfile, and trg
> is not recorded as a delta already. This heuristics makes sense because it
> is likely that we tried to express trg as a delta based on src but it did
> not produce a good delta when we created the existing pack.
> 
> As the pack heuristics prefer producing delta to remove data, and Linus's
> law dictates that the size of a file grows over time, we tend to record
> the newest version of the file as inflated, and older ones as delta
> against it.
> 
> When creating a thin-pack to transfer recent history, it is likely that we
> will try to send an object that is recorded in full, as it is newer.  But
> the heuristics to avoid recomputing futile delta effectively forbids us
> from attempting to express such an object as a delta based on another
> object. Sending an object in full is often more expensive than sending a
> suboptimal delta based on other objects, and it is even more so if we
> could use an object we know the receiving end already has (i.e. referred
> base object) as the delta base.
> 
> Tweak the recomputation avoidance logic, so that we do not punt on
> computing delta against a preferred base object.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
> 
>  builtin/pack-objects.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index c6e2d87..8bfe3a6 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1248,11 +1248,16 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>  		return -1;
>  
>  	/*
> -	 * We do not bother to try a delta that we discarded
> -	 * on an earlier try, but only when reusing delta data.
> +	 * We do not bother to try a delta that we discarded on an
> +	 * earlier try, but only when reusing delta data.  Note that
> +	 * src_entry that is marked as the preferred_base should always
> +	 * be considered, as even if we produce a suboptimal delta against
> +	 * it, we will still save the transfer cost, as we already know
> +	 * the other side has it and we won't send src_entry at all.
>  	 */
>  	if (reuse_delta && trg_entry->in_pack &&
>  	    trg_entry->in_pack == src_entry->in_pack &&
> +	    !src_entry->preferred_base &&
>  	    trg_entry->in_pack_type != OBJ_REF_DELTA &&
>  	    trg_entry->in_pack_type != OBJ_OFS_DELTA)
>  		return 0;
> -- 
> 1.7.9.rc0.53.gc8bc2
> 
