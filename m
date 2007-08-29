From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Keep last used delta base in the delta window
Date: Wed, 29 Aug 2007 14:21:33 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708291339580.16727@xanadu.home>
References: <11881617934179-git-send-email-mkoegler@auto.tuwien.ac.at>
 <7v3ay5l5wq.fsf@gitster.siamese.dyndns.org>
 <7vy7fxyy52.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 20:21:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQSAf-00054P-DI
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 20:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbXH2SVh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 14:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758830AbXH2SVg
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 14:21:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23069 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbXH2SVf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 14:21:35 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNJ00GEQSBXQQC0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 29 Aug 2007 14:21:34 -0400 (EDT)
In-reply-to: <7vy7fxyy52.fsf@gitster.siamese.dyndns.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56971>

On Mon, 27 Aug 2007, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Instead of treating the "the last used one happened to be on the
> > horizon -- try not to drop it" special case, I wonder if it
> > makes sense to float the last used delta base object early in
> > the window _after_ it is used.  Wouldn't we keep more than one
> > very recently used delta base objects in the window that way?
> 
> The attached is my quick-and-dirty one.  


I like this.  A LRU sorting of base objects is obviously a good thing to 
do.  Some comments below.

[...]

> diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
> index 9b3ef94..2a5ea29 100644
> --- a/builtin-pack-objects.c
> +++ b/builtin-pack-objects.c
> @@ -1439,6 +1439,61 @@ static void free_unpacked(struct unpacked *n)
>  	n->depth = 0;
>  }
>  
> +static void shift_base(int idx, int window, struct unpacked *array, struct object_entry *delta_base)
> +{
> +	/*
> +	 * The delta_base was a useful one to deltify the object at
> +	 * idx (circular).  Shift the contents of array (circular
> +	 * buffer) so that it will be evicted last.
> +	 */
> +	int good_base, good_at;
> +	struct unpacked swap;
> +
> +	for (good_base = 0; good_base < window; good_base++)
> +		if (array[good_base].entry == delta_base)
> +			break;
> +	if (window <= good_base)
> +		die("Junio is an idiot");
> +
> +	if (window <= ++idx)
> +		idx = 0;

<ranting again>
I cannot do otherwise but hate this notation.  Just for this one I had 
to spend at least 5 seconds thinking about it before I could convince 
myself it is OK.  It annoyed me so much that I switched the condition 
around in my local copy.  I acknowledge your maintainer priviledges, but 
I couldn't stop myself making noise about this again anyway.
</ranting again>

> +	/*
> +	 * The entry at idx modulo window will be evicted first during
> +	 * the next round.  Where in the next window is the good_base
> +	 * found?
> +	 */
> +	good_at = (good_base + window - idx) % window;
> +
> +	/*
> +	 * If it is already at the furthest edge, nothing needs to be done.
> +	 */
> +	if (good_at == window - 1)
> +		return;

This condition will never occur because, upon entering this function, 
idx points to the _current_ 
object which is never considered as a base (can't deltify against self).  
So you probably should avoid increasing idx.

Yet I think it would be clearer if you had this instead (assuming idx 
unchanged):

	/* How far is the good base from the front of the window? */
	good_dist = (window + idx - good_base) % window;

	/* If it is already at the furthest edge, nothing needs to be done. */
	if (good_dist <= 1)
		return;

	/* Otherwise, stash it away, shift the others down and swap it in. */
	swap = array[good_base];
	dst = good_base;
	while (--good_dist > 0) {
		src = (dst + 1) % window;
		array[dst] = array[src];
		dst = src;
	}
	array[dst] = swap;

> +	swap = array[good_base];
> +
> +	while (good_at < window) {

This also had the effect of moving down the current object, i.e. the one 
that was just deltified.  Maybe this is a good thing, in which case the 
"if (good_dist <= 1)" above can be deleted and "while (good_dist-- > 0)" 
used instead.


Nicolas
