From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 15:22:59 -0700
Message-ID: <7vsllnob3w.fsf@assigned-by-dhcp.cox.net>
References: <20060628223744.GA24421@coredump.intra.peff.net>
	<7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
	<20060629180011.GA4392@coredump.intra.peff.net>
	<Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
	<20060629185335.GA6704@coredump.intra.peff.net>
	<Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
	<20060629195201.GA10786@coredump.intra.peff.net>
	<Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
	<Pine.LNX.4.64.0606291352110.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 00:23:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw4ui-0008Qn-6S
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 00:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058AbWF2WXE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 18:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933061AbWF2WXD
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 18:23:03 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62183 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S933060AbWF2WXB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 18:23:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629222300.FELH554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 18:23:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 29 Jun 2006 14:04:01 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22921>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 29 Jun 2006, Nicolas Pitre wrote:
>> 
>> The negative delta cache concept is certainly attractive even for normal 
>> repositories, especially for public servers, since when used in 
>> conjonction with delta reuse it makes the creation of a pack basically 
>> free.  So I think this idea really has merits, as long as the cache 
>> remains small.
>
> I don't really see much of a point of this all.
>
> Instead of having a separate cache, wouldn't it be much better to just 
> take the hint from the previous pack-file?
>
> In the repacking window, if both objects we are looking at already came 
> from the same (old) pack-file, don't bother delta'ing them against each 
> other. 
>
> That means that we'll still always check for better deltas for (and 
> against!) _unpacked_ objects, but assuming incremental repacks, you'll 
> avoid the delta creation 99% of the time.
>
> Ie somethng really simple like the appended.
>
> 		Linus
> ---
> diff --git a/pack-objects.c b/pack-objects.c
> index bed2497..cea63e7 100644
> --- a/pack-objects.c
> +++ b/pack-objects.c
> @@ -988,6 +988,13 @@ static int try_delta(struct unpacked *tr
>  		return -1;
>  
>  	/*
> +	 * We do not bother to try a delta that we discarded
> +	 * on an earlier try
> +	 */
> +	if (trg_entry->in_pack && trg_entry->in_pack == src_entry->in_pack)
> +		return -1;
> +
> +	/*

I think you meant to return 0 from here though.  -1 means "do
not use this pair and do not bother try improving it with the
remaining candidates".
