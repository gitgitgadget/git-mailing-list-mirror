From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] use delta index data when finding best delta matches
Date: Thu, 27 Apr 2006 21:56:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604272131410.18816@localhost.localdomain>
References: <Pine.LNX.4.64.0604252330190.18520@localhost.localdomain>
 <7vpsj4sxer.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604261341200.18520@localhost.localdomain>
 <Pine.LNX.4.64.0604262210120.18520@localhost.localdomain>
 <Pine.LNX.4.64.0604262351221.18520@localhost.localdomain>
 <7vy7xqh5g6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 03:56:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZIDG-0001Ai-UW
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 03:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965167AbWD1B4D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 21:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965172AbWD1B4D
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 21:56:03 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9203 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965167AbWD1B4B
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 21:56:01 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IYE00FP4TDCX450@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 27 Apr 2006 21:56:00 -0400 (EDT)
In-reply-to: <7vy7xqh5g6.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19261>

On Thu, 27 Apr 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > This patch allows for computing the delta index for each base object 
> > only once and reuse it when trying to find the best delta match.
> >
> > This should set the mark and pave the way for possibly better delta 
> > generator algorithms.
> >
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> 
> My understanding is that theoretically this should not make any
> difference to the result, and should run faster when the memory
> pressure does not cause the machine to thrash.  However,....
> 
> I am seeing some differences.  Even with the smallish "git.git"
> repository, packing is slightly slower, and the end result is
> smaller.

Well, I changed some euristics a bit.

> Not that I am complaining that it produces better results with a
> small performance penalty.  I am curious because I do not
> understand where the differences are coming from, and I was
> reluctant to merge it in "next" until I understand what is going
> on.
> 
> But I think I know where the differences come from:
> 
> -	sizediff = oldsize > size ? oldsize - size : size - oldsize;
> +	sizediff = src_size < size ? size - src_size : 0;

Right.  The idea is that when the delta source index has to be computed 
each time, if the target buffer is really small then we spend more time 
computing that index than anything else.

But when the delta index is computed only once and already available 
anyway, we don't lose much attempting a delta with a small target buffer 
since the delta computation is non-existent at that point and the actual 
delta generation will be quick if the target buffer is small.

> There is another "omit smaller than 50" difference but that
> should not trigger -- we do not have files that small.

Right.  And if such small files show up they won't waste window space.


Nicolas
