From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix race and deadlock when sending pack
Date: Mon, 19 Dec 2005 17:00:45 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512191645230.25300@iabervon.org>
References: <43A628F6.1060807@serice.net> <7vzmmxlkbq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0512191236290.25300@iabervon.org> <7vy82gg5t7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Serice <paul@serice.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 23:02:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoT2n-0007W3-HA
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 22:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964777AbVLSV7m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 16:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVLSV7m
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 16:59:42 -0500
Received: from iabervon.org ([66.92.72.58]:7175 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932356AbVLSV7m (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2005 16:59:42 -0500
Received: (qmail 8778 invoked by uid 1000); 19 Dec 2005 17:00:45 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Dec 2005 17:00:45 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy82gg5t7.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13836>

On Mon, 19 Dec 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> My immediate reaction was "do not do it then", but you are
> >> right.  Hooks are run after all the protocol exchanges are done,
> >> so they should be free to throw any garbage at the other end.
> >
> > If we extend it to transfer multiple things, wouldn't we want to run hooks 
> > after each of them, rather than all at the end?
> 
> We do transfer multiple things already, and all protocol
> exchange happens before everything is transferred.  And hooks
> are run for each refs being updated, one by one.  What we do not
> have is a reporting mechanism that says "we refused to update
> this ref because of the hooks/update policy return value for
> it".  Even if we later add that reporting mechanism, as I
> outlined in a separate message earlier, I think it is OK to keep
> running the update hooks after the pack transfer part.

If we have the reporting mechanism, that will effectively be part of the 
protocol. It's obviously done transferring the pack at that point, but it 
still wants fixed-format communication, so switching over to being the 
stardard output of the hooks would cause problems with this.

> > As for the policy:
> >
> > We definitely want to let hooks write to stdout, because git programs that 
> > you might want to run in hooks write to stdout.
> > ... I'd sort of like to avoid making people expect that there 
> > is necessarily a path for text going back to the user directly.
> > ... I 
> > also think that messages are likely to be at least as useful to the owner 
> > of the target repository as the person pushing, which is why I'd prefer a 
> > log file.
> 
> This part I mostly agree with.  Will have to think about the
> details but probably I'd punt this for now and declare it post
> 1.0 ;-).

It's probably worth making sure that all the hooks run with something 
sane, and punt making it configurable andnice until post-1.0. I was only 
really looking at post-update, so I don't know how the others run.

	-Daniel
*This .sig left intentionally blank*
