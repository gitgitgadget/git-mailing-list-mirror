From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add support for parallel HTTP transfers
Date: Fri, 7 Oct 2005 18:39:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510071808071.23242@iabervon.org>
References: <20051005214447.GF15593@reactrix.com> <Pine.LNX.4.63.0510061550510.23242@iabervon.org>
 <20051007000041.GH15593@reactrix.com> <Pine.LNX.4.63.0510071149550.23242@iabervon.org>
 <7v8xx55kia.fsf@assigned-by-dhcp.cox.net> <20051007172206.GK15593@reactrix.com>
 <7vachl42tt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nick Hengeveld <nickh@reactrix.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 00:37:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EO0q0-00042W-Bg
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 00:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932653AbVJGWef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 18:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbVJGWef
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 18:34:35 -0400
Received: from iabervon.org ([66.92.72.58]:42763 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932653AbVJGWef (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 18:34:35 -0400
Received: (qmail 8195 invoked by uid 1000); 7 Oct 2005 18:39:22 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Oct 2005 18:39:22 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vachl42tt.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9822>

On Fri, 7 Oct 2005, Junio C Hamano wrote:

> Nick Hengeveld <nickh@reactrix.com> writes:
> 
> > I think the only downside to leaving that check in place is that when
> > pull() finishes there may be completed requests left behind in the
> > queue, possibly with unreported transfer errors.  Would it make sense
> > to just release any requests left in the queue after pull(), and report
> > if any of them had transfer errors?
> 
> Pull finishing and reporting success while some requests have
> still been outstanding with transfer errors sounds to me that
> decision to finish and declare success is made prematurely.
> What do these leftover requests you are worried about ask for?
> Are you making redundant requests, which can turn out to be
> unneeded?

I believe that the situation is the one you describe in your previous 
message: we determine we need to fetch A and B; we ask for A; we ask for 
B; we find A isn't available alone, but is available in a pack; we get the 
pack; we find we now have B (in the pack); the request for B (which would 
probably fail) is left dangling.

The only actual problem I can see is if this happens with a whole bunch of 
objects at the beginning of a big download, and all but one of your 
connections are left in this state while you download all of the loose 
objects over the one connection that got the pack.

I don't know if this is a problem for the new http code, but it could be 
an issue in general if a transport method allocates resources in 
prefetch().

	-Daniel
*This .sig left intentionally blank*
