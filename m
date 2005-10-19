From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Errors from http-fetch
Date: Wed, 19 Oct 2005 18:10:52 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510191755280.25300@iabervon.org>
References: <Pine.LNX.4.64.0510191536350.25300@iabervon.org>
 <20051019212644.GB6160@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 00:13:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESM9q-0005Si-Ac
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 00:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbVJSWLf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 18:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbVJSWLf
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 18:11:35 -0400
Received: from iabervon.org ([66.92.72.58]:9732 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751583AbVJSWLf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 18:11:35 -0400
Received: (qmail 9771 invoked by uid 1000); 19 Oct 2005 18:10:52 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Oct 2005 18:10:52 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051019212644.GB6160@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10318>

On Wed, 19 Oct 2005, Nick Hengeveld wrote:

> On Wed, Oct 19, 2005 at 03:46:10PM -0400, Daniel Barkalow wrote:
> 
> > I've now started getting errors from http-fetch; my guess for the output 
> > is that it has problems if an object is not available loose, and is only 
> > available in a pack file which is already being downloaded for a different 
> > object, possibly only if the first request to be made for the loose 
> > object is not the first one to fail.
> 
> Are you getting a curl return code of 52/CURLE_GOT_NOTHING?  Any chance
> you have access to the associated server logs?

I'm getting 404 for the object, which it reports. This was pulling from 
kernel.org.

> In the situation you describe, fetch() won't be called for the second
> object until fetch() for the first object is finished - at which point
> the pack will have been fully downloaded for the first object (or
> failed, causing fetch() for the first object to fail as well.)

My theory is that you have: prefetch(#2), prefetch(#1), (other stuff), #1 
gives an error, start downloading the pack, fetch(#2), #2 gives an error, 
and there are no more packs to try.

That is, it was a later object that prompted getting the pack, because 
either the server decided to send that error message sooner, some packet 
got dropped and retransmitted, the connection got a lower-numbered file 
descriptor and they were ready at the same time, or something like that.

Another thing I noticed was that it was in the middle of downloading the 
pack when it suddenly exitted due to not being able to find the object; it 
would probably be worth having a call to finish up the active transfers 
after giving up on completing the whole thing, since we probably do 
actually want to finish downloading a big pack if we've started.

Consider the situation where you happen to catch the server in the middle 
of mirroring, and you're halfway through a big pack; restarting is nice, 
but it might as well let you finish downloading the pack, so you have less 
to do when you try again later.

	-Daniel
*This .sig left intentionally blank*
