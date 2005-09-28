From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 0/3] http-fetch enhancements
Date: Tue, 27 Sep 2005 23:37:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509272258230.23242@iabervon.org>
References: <Pine.LNX.4.63.0509261823590.23242@iabervon.org>
 <20050928023947.GA385@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nick Hengeveld <Nick.Hengeveld@reactrix.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 05:33:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKSgX-0005p0-57
	for gcvg-git@gmane.org; Wed, 28 Sep 2005 05:32:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbVI1Dcl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 23:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbVI1Dcl
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 23:32:41 -0400
Received: from iabervon.org ([66.92.72.58]:12551 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751168AbVI1Dck (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 23:32:40 -0400
Received: (qmail 22998 invoked by uid 1000); 27 Sep 2005 23:37:11 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Sep 2005 23:37:11 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20050928023947.GA385@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9422>

On Tue, 27 Sep 2005, Nick Hengeveld wrote:

> On Mon, Sep 26, 2005 at 03:29:02PM -0700, Daniel Barkalow wrote:
> 
> >    If you happen to know how to have curl do multiple simultaneous downloads,
> >    that would be a big performance win, and I should be able to explain how
> >    to get this to work. I haven't gotten around to learning libcurl well
> >    enough to do the flow control.
> 
> The curl multi interface looks pretty straightforward.  What did you have
> in mind as far as which requests would be running concurrently and how they
> would need to be limited?

The way fetch.c calls the functions, there's a prefetch() that indicates 
that a given object is needed, and a fetch() that is responsible for 
making sure the object is available when it returns (or returning an 
error). It is arranged such that the same list of hashes is given to each 
of the functions in the same order.

One method is to send requests in prefetch() and accept responses in 
fetch(); this is what git-ssh-pull now does. This seems in practice to 
lead to ~100 outstanding requests at the high point, which is great for 
throughput, but I'm not sure how polite it is. IIRC, browsers tend to do 
~4 simultaneous connections, or at least used to.

The other method is to keep track of what you're fetching, and block in 
prefetch() if too many connections are in use until some connections are 
free, or in fetch() if that is called before the download is complete.

Note that it should theoretically be possible to make additional requests 
on the same connection, provided it's "keep alive", even before reading 
the response, so long as the code is able to figure out what happened if 
the server actually closes it (after the first request) instead of serving 
the later ones.

	-Daniel
*This .sig left intentionally blank*
