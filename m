From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: What to expect after 0.99.8
Date: Tue, 4 Oct 2005 00:13:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510032306190.23242@iabervon.org>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510031522590.23242@iabervon.org> <7vmzlqnwmw.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510031709360.23242@iabervon.org> <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Dan Aloni <da-x@monatomic.org>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 06:09:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMe6s-0006Oz-56
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 06:08:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbVJDEIp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 00:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbVJDEIp
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 00:08:45 -0400
Received: from iabervon.org ([66.92.72.58]:12041 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751175AbVJDEIo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Oct 2005 00:08:44 -0400
Received: (qmail 31443 invoked by uid 1000); 4 Oct 2005 00:13:25 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 4 Oct 2005 00:13:25 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x32l0gz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9659>

On Mon, 3 Oct 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > The code in ssh-fetch already does parallel fetching, actually (only over 
> > one connection, but requests are sent before responses are read), so 
> > multiple requests are in progress at the same time.
> 
> This reminds me of one patch:
> 
>     From: Dan Aloni <da-x@monatomic.org>
>     Subject: [PATCH] Fix git+ssh's indefinite halts during long fetches
>     Date: Sat, 1 Oct 2005 21:39:42 +0300
>     Message-ID: <20051001183942.GA2099@localdomain>
> 
> I'd appreciate it if you had a chance to take a look at it and
> comment on it.

I think it's overly hacky; we should be able, in prefetch, to check 
whether we've stuffed in a lot of hashes already, and actually read an 
object out before requesting another; there's nothing in the fetch 
contract that says that an object can't become available at some random 
time between the start of the fetch and when it gets requested with 
fetch(). (In fact, I had a pack-exchange version of the ssh stuff which 
would notice that you have certain things and you're looking for a commit, 
and get a bunch of stuff you probably want as a pack before you actually 
ask for it, but Linus beat me on that one with send-pack/upload-pack.)

I think that a limit of 100 objects in transit is about right, because the 
requests for 100 objects fits well within 4K and I expect that we 
commonly have small enough objects that we need to queue up a relatively 
large number of requests to maintain streaming.

I've got a patch, which I'll send in the next email.

	-Daniel
*This .sig left intentionally blank*
