From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Add support for parallel HTTP transfers
Date: Fri, 7 Oct 2005 12:23:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0510071149550.23242@iabervon.org>
References: <20051005214447.GF15593@reactrix.com> <Pine.LNX.4.63.0510061550510.23242@iabervon.org>
 <20051007000041.GH15593@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 18:21:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENuvK-0004AC-PB
	for gcvg-git@gmane.org; Fri, 07 Oct 2005 18:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbVJGQSP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Oct 2005 12:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbVJGQSP
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Oct 2005 12:18:15 -0400
Received: from iabervon.org ([66.92.72.58]:43014 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030482AbVJGQSO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2005 12:18:14 -0400
Received: (qmail 6648 invoked by uid 1000); 7 Oct 2005 12:23:01 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Oct 2005 12:23:01 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051007000041.GH15593@reactrix.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9805>

On Thu, 6 Oct 2005, Nick Hengeveld wrote:

> On Thu, Oct 06, 2005 at 04:07:07PM -0400, Daniel Barkalow wrote:
> 
> > Somewhat weirdly, the version of curl on my desktop doesn't actually have 
> > an implementation of curl_multi_info_read, although it's in the header 
> > file and documentation. So you'll want a version check somewhere, I think, 
> > which should probably just disable parallel transfers.
> 
> I was afraid that was going to happen...  From the archived versions on the
> CURL download site, it looks as though multi support was added in 7.9.8 -
> which version do you have installed on your desktop?

I'll have to check, but I think it's 7.9.8 or close to that; it seems like 
they added multi support without a critical function, so you might need to 
bump the check from what the history would suggest.

> > It should be fine to download objects and a pack that contains them at the 
> > same time, although there's currently a check in fetch.c which should be 
> > removed, so that it will call fetch() for an object if the object appears 
> > between the prefetch() and the fetch().
> 
> Can you provide a patch, or point me toward the right place to make that
> change?

It's line 168 of fetch.c; the "!has_sha1_file(obj->sha1)" part should go 
away.

> > I should be able to review this over the weekend. What sort of performance 
> > are you getting at this point (in terms of bandwidth utilization)?
> 
> I've done limited testing by using the time command to track real/user/sys
> taken to run 'git fetch http://kernel.org/pub/scm/git/git.git master',
> and have seen performance improve by a factor of ~2-10:

That looks good. I think it might be good to set the default connection 
limit higher; I don't think we can generate enough parallelism that we'd 
cause problems for a server with a single client, and, with a constant 
stream of clients, this will just shuffle around when the connections 
happen; to the extent that a single client does more simultaneous 
connections, it'll overlap less with other clients.

> About that "-r" arg - seems like it should be something else as -r is
> used elsewhere in git to enable recursion.  "-c" was my first thought,
> but that's used to fetch commit objects.

The other things that affect the behaviour of the HTTP fetch in particular 
are done as environment variables, which seems like a good idea to me. 
Alternatively, you could use a long option. I don't expect there will be 
much variation in what someone uses.

	-Daniel
*This .sig left intentionally blank*
