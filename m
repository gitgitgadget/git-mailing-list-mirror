From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH] Reduce the number of connects when fetching
Date: Mon, 5 Nov 2007 22:04:49 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0711052150340.7357@iabervon.org>
References: <Pine.LNX.4.64.0711041614390.7357@iabervon.org>
 <7v1wb4kuoc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 04:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpEkW-0003Zb-Bc
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 04:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbXKFDEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 22:04:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbXKFDEv
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 22:04:51 -0500
Received: from iabervon.org ([66.92.72.58]:42458 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751938AbXKFDEu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 22:04:50 -0500
Received: (qmail 6497 invoked by uid 1000); 6 Nov 2007 03:04:49 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Nov 2007 03:04:49 -0000
In-Reply-To: <7v1wb4kuoc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63616>

On Mon, 5 Nov 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > The idea is to keep the open connection in the data for the transport in 
> > between getting the list of refs and doing anything further. This 
> > therefore moves the connection-handling aspects outside of fetch-pack() 
> > and handles them primarily in transport.c.
> 
> The idea is very sound.  The scripted version of git-fetch used
> a separate ls-remote only because peek-remote and fetch-pack
> were separate programs.

I figured that had to be the case, due to the way the protocol acts at the 
beginning.

> > ... In particular, I don't know if there's a way to have the 
> > connection end up in a state where objects for more refs can be requested 
> > after some refs have been requested and the resulting objects read.
> 
> The upload-pack protocol goes "S: here are what I have, C: I
> want these, C: I have these, S: ok, continue, C: I have these,
> S: ok, continue, C: I have these, S: ok, I've heard enough, C:
> done, S: packfile is here", so after packfile generation starts
> there is nothing further the downloader can say.
> 
> Otherwise you would be able to do the tag following using the
> same connection, but that is unfortunately not a case.

It would be nice if this could continue: "C: I also want these, S: ok, 
heard enough, C: done, S: another packfile is here"; we should be able to 
identify the end of the packfile on both ends to resume doing other 
things.

Or, maybe, "C: I also want these single objects, S: here's a thin pack of 
them", since it's exclusively tags pointing to objects we have just 
gotten.

	-Daniel
*This .sig left intentionally blank*
