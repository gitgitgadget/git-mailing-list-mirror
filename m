From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: thin packs ending up fat
Date: Thu, 12 Jan 2012 18:54:59 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1201121852120.2722@xanadu.home>
References: <20120112221523.GA3663@sigill.intra.peff.net>
 <20120112223234.GA4949@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 13 00:55:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlUU5-00065p-PE
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 00:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756088Ab2ALXzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 18:55:00 -0500
Received: from relais.videotron.ca ([24.201.245.36]:8991 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260Ab2ALXzA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 18:55:00 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR001.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LXP00KPMMDCH430@VL-VM-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 12 Jan 2012 18:53:36 -0500 (EST)
In-reply-to: <20120112223234.GA4949@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188488>

On Thu, 12 Jan 2012, Jeff King wrote:

> On Thu, Jan 12, 2012 at 05:15:23PM -0500, Jeff King wrote:
> 
> > It turns out that when packing a subset of a fully packed repo (as we do
> > for a bundle or for a fetch), we tend not to make thin packs at all.
> > The culprit is this logic in try_delta:
> > 
> >         /*
> >          * We do not bother to try a delta that we discarded
> >          * on an earlier try, but only when reusing delta data.
> >          */
> >         if (reuse_delta && trg_entry->in_pack &&
> >             trg_entry->in_pack == src_entry->in_pack &&
> >             trg_entry->in_pack_type != OBJ_REF_DELTA &&
> >             trg_entry->in_pack_type != OBJ_OFS_DELTA)
> >                 return 0;
> > [...]
> > Maybe it is enough to simply turn off this optimization if the potential
> > delta source is not being included in the pack (i.e., we are using
> > --thin and it is a boundary object). Because if both objects are being
> > sent, we will just end up reusing the delta that goes in the reverse
> > direction anyway.
> 
> Hmm. It turns out this is really easy, because we have already marked
> such objects as preferred bases.

That's exactly what I was about to suggest after reading your first 
email.

> So with this patch:
> 
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 96c1680..d05e228 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1439,6 +1439,7 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
>  	 */
>  	if (reuse_delta && trg_entry->in_pack &&
>  	    trg_entry->in_pack == src_entry->in_pack &&
> +	    !src_entry->preferred_base &&
>  	    trg_entry->in_pack_type != OBJ_REF_DELTA &&
>  	    trg_entry->in_pack_type != OBJ_OFS_DELTA)
>  		return 0;

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> here are the numbers I get:
> 
>                   dataset
>             | fetches | tags
> ---------------------------------
>      before | 53358   | 2750977
> size  after | 32398   | 2668479
>      change |   -39%  |      -3%
> ---------------------------------
>      before |  0.18   | 1.12
> CPU   after |  0.18   | 1.15
>      change |    +0%  |      +3%
> 
> So nearly all of the size benefit, but very little CPU change (even the
> 3% on the larger-pack case is close to the levels of run-to-run noise).
> Obviously the size benefit in the larger-pack case isn't impressive, but
> I think the "fetches" case is much more indicative of a real server
> load.

Indeed.  Please make sure to capture those numbers in the commit log.


Nicolas
