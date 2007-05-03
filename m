From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/5] Add --remote option to send-pack
Date: Thu, 3 May 2007 00:04:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705022330460.28708@iabervon.org>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org>
 <7vtzuzg26l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704290152410.28708@iabervon.org>
 <7vejm3g0dg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 03 06:04:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjSYq-0000Z5-Ji
	for gcvg-git@gmane.org; Thu, 03 May 2007 06:04:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767355AbXECEEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 00:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767363AbXECEEm
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 00:04:42 -0400
Received: from iabervon.org ([66.92.72.58]:1733 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767355AbXECEEm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 00:04:42 -0400
Received: (qmail 8241 invoked by uid 1000); 3 May 2007 04:04:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 May 2007 04:04:41 -0000
In-Reply-To: <7vejm3g0dg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46059>

On Sat, 28 Apr 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > We're not pretending anything; remote has confirmed that the head that the 
> > ref tracks has a particular new value (which we provided), so we should be 
> > able to update the tracking ref to that value. I don't think it's 
> > particularly important that we came by this information in the course of 
> > an exchange that wasn't a fetch.
> >
> 
> We are indeed pretending.  Consider:
> 
>  (1) You push, and push succeeds.
> 
>  (2) Somebody fetches your result, works on it and pushes back;
>      this might happen in post-receive hook.
> 
>  (3) You fetch.  You should see somebody else's commit at the
>      tip, not what you pushed in (1).
> 
> By not fetching but instead of storing what you pushed, you are
> pretending that you re-fetched so fast that you gave no chance
> to anybody to perform (2) quickly enough.

But you did effectively re-fetch instantaneously by doing an operation 
that atomicly updates the ref and reports success. If you consider the 
operation that updates tracking refs not to be necessarily "git-fetch" but 
rather "having a connection that discusses refs", this sequence isn't any 
different from (1) being a fetch instead of a push; there's always the 
chance that your interaction with the server is shortly before the ref 
values you update to being replaced, whether the operation you're doing is 
getting the remote's value or setting the remote's value.

Even if a post-update hook further changes the ref you push to, it had 
better not change it to a non-descendant of the value you pushed, since 
there would be a race with other people fetching your value with the 
post-update hook is running and seeing history roll back. So, at worst, 
you could have the situation where, effectively, you *always* miss out on 
the latest thing, but it's already the case that you would *sometimes* 
miss out on the latest thing, if the post-update hook is running more 
slowly than your next fetch.

The fact that the config option is "fetch" isn't really an argument that 
the way you have to get the knowledge of the value of the ref at the 
instant you remember locally has to be "git-fetch"; any way of getting 
knowledge of that value at some instant should suffice.

	-Daniel
*This .sig left intentionally blank*
