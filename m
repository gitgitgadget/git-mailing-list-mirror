From: Nicolas Pitre <nico@cam.org>
Subject: Re: Preferring shallower deltas on repack
Date: Mon, 09 Jul 2007 16:22:16 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0707091621330.26459@xanadu.home>
References: <20070709044326.GH4087@lavos.net>
 <7v1wfixhvk.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0707090954550.26459@xanadu.home>
 <7vir8tv8dr.fsf@assigned-by-dhcp.cox.net> <20070709185353.GL4087@lavos.net>
 <alpine.LFD.0.999.0707091503000.26459@xanadu.home>
 <20070709192403.GM4087@lavos.net> <20070709194931.GO4087@lavos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Mon Jul 09 22:22:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7zkU-0005hx-D4
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 22:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbXGIUWS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 16:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753967AbXGIUWS
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 16:22:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:10968 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727AbXGIUWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 16:22:17 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JKX0085NHX4I780@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Jul 2007 16:22:17 -0400 (EDT)
In-reply-to: <20070709194931.GO4087@lavos.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52017>

On Mon, 9 Jul 2007, Brian Downing wrote:

> On Mon, Jul 09, 2007 at 02:24:03PM -0500, Brian Downing wrote:
> > No, I didn't try it on top of mine; sorry.  I'll try that out.
> 
> The results with both your patch and mine are exactly the same as
> yours applied to master (c956395e).  The only thing mine adds on top of
> yours is:
> 
> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 9a33698..2da78b4 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1373,6 +1373,12 @@ static int try_delta(struct unpacked *trg, struct unpacke
>                 return 0;
> 
>         if (trg_entry->delta_data) {
> +               /* Prefer only shallower same-sized deltas. */
> +               if (delta_size == trg_entry->delta_size &&
> +                   src_entry->depth + 1 >= trg_entry->depth) {
> +                       free(delta_buf);
> +                       return 0;
> +               }
>                 delta_cache_size -= trg_entry->delta_size;
>                 free(trg_entry->delta_data);
>         }
> 
> Which was meant to pick off the cases where I got an equivalently
> sized patch that was as deep or deeper.  This was neccessary due to
> my changing:
> 
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1337,7 +1337,7 @@ static int try_delta(struct unpacked *trg, struct unpacked
>         if (max_size == 0)
>                 return 0;
>         if (trg_entry->delta && trg_entry->delta_size <= max_size)
> -               max_size = trg_entry->delta_size-1;
> +               max_size = trg_entry->delta_size;
>         src_size = src_entry->size;
>         sizediff = src_size < trg_size ? trg_size - src_size : 0;
>         if (sizediff >= max_size)
> 
> 	max_size = trg_entry->delta_size;
> 
> Your patch changed the max_size selection logic, so I'm not sure the
> rest of mine will do anything anymore.

It is still valid nevertheless.


Nicolas
