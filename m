From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] simple euristic for further free packing improvements
Date: Mon, 15 May 2006 18:51:34 -0700
Message-ID: <7v4pzqhh3t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605132305580.18071@localhost.localdomain>
	<Pine.LNX.4.64.0605151129540.18071@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 03:51:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffoio-0004yq-Nw
	for gcvg-git@gmane.org; Tue, 16 May 2006 03:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbWEPBvg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 21:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWEPBvg
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 21:51:36 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:19388 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751024AbWEPBvf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 21:51:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516015134.HNMI15447.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 21:51:34 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0605151129540.18071@localhost.localdomain>
	(Nicolas Pitre's message of "Mon, 15 May 2006 11:40:05 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20092>

Nicolas Pitre <nico@cam.org> writes:

> Given that the early eviction of objects with maximum delta depth 
> may exhibit bad packing on its own, why not considering a bias against 
> deep base objects in try_delta() to mitigate that bad behavior.

This is really a good stuff.  Thanks.  Oh, and thanks for
noticing my puzzlement expressed with "#if 0" ;-).

> @@ -1038,8 +1038,8 @@ static int try_delta(struct unpacked *tr
>  
>  	/* Now some size filtering euristics. */
>  	size = trg_entry->size;
> -	max_size = size / 2 - 20;
> -	if (trg_entry->delta)
> +	max_size = (size/2 - 20) / (src_entry->depth + 1);
> +	if (trg_entry->delta && trg_entry->delta_size <= max_size)
>  		max_size = trg_entry->delta_size-1;
>  	src_size = src_entry->size;
>  	sizediff = src_size < size ? size - src_size : 0;

At the first glance, this seems rather too agressive.  It makes
me wonder if it is a good balance to penalize the second
generation base by requiring it to produce a small delta that is
at most half as we normally would (and the third generation a
third), or maybe the penalty should kick in more gradually, like
e.g. ((max_depth * 2 - src_entry->depth) / (max_depth * 2).

Having said that, judging from your past patches, I learned to
trust that you have tried tweaking this part and settled on this
simplicity and elegance, so I'll take the patch as is -- if
somebody wants to play with it that can always be done to
further improve things.
