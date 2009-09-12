From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git push --confirm ?
Date: Sat, 12 Sep 2009 17:55:15 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0909121739480.28290@iabervon.org>
References: <1252777897.2974.24.camel@localhost.localdomain> <20090912184342.GB20561@coredump.intra.peff.net> <1252786266.2974.61.camel@localhost.localdomain> <20090912204905.GA31427@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Owen Taylor <otaylor@redhat.com>, git@vger.kernel.org,
	Colin Walters <walters@verbum.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 12 23:55:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmaZ0-0003CM-PH
	for gcvg-git-2@lo.gmane.org; Sat, 12 Sep 2009 23:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830AbZILVzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Sep 2009 17:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815AbZILVzN
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Sep 2009 17:55:13 -0400
Received: from iabervon.org ([66.92.72.58]:51107 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754797AbZILVzM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Sep 2009 17:55:12 -0400
Received: (qmail 7839 invoked by uid 1000); 12 Sep 2009 21:55:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Sep 2009 21:55:15 -0000
In-Reply-To: <20090912204905.GA31427@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128302>

On Sat, 12 Sep 2009, Jeff King wrote:

> [cc'd Daniel; I think this proposal for a "confirm push" might interact
> with your foreign VCS work a bit. I'm not sure anymore what would be the
> right level for inserting this code.]
> 
> On Sat, Sep 12, 2009 at 04:11:06PM -0400, Owen Taylor wrote:
> 
> > The main UI advantage is that you can adjust the default with 'git
> > config' it on and leave it on. The time you screw up is not when you are
> > worried that you are going to push the wrong thing. It's when you are
> > you know exactly what 'git push' is going to do and it does something
> > different.
> 
> That makes sense. I would not want to use such a feature, but I see the
> use case you are talking about (see, I told you I was bad person to
> comment. ;) ).
> 
> It should be pretty straightforward to implement for the git protocol.
> Pushing goes something like:
> 
>   1. Get the list of refs from the remote.
> 
>   2. Using the desired refspecs (either configured or from the command
>      line), make a list of src/dst pairs of refs to be pushed.
> 
>   3. For each ref pair, send the "<old> <new> <name>" triple to the
>      remote (or not, if it is already up-to-date, a non-fast-forward,
>      etc).
> 
>   4. Send the packed objects.
> 
>   5. For each ref pair, print the status in a summary table.
> 
> So you would just want a "2.5" where you show something similar to the
> summary table and get some confirmation (or abort). An iterative "do you
> want to push this ref" strategy would be similar; just mark the refs you
> do and don't want to push.
> 
> The tricky thing will be handling different transports. Some of that
> code has been factored out, but I haven't looked at the details. On top
> of that, I think Daniel is working in this area for his support
> of foreign VCS helpers (and other transports like libcurl are getting
> pushed out into their own helpers). So he may have a better idea of how
> to go about this sanely.

The status used to be that each method of pushing implemented 
approximately the rules you give, but implemented it separately. Now 
there's a common implementation of those rules, with (1) being a method 
call, (3&4) being a method, and the rest being in transport_push(). 
However, rsync and curl have not yet been converted to the new style. When 
there is support for push with helpers, it will only use the new style 
(because it would be pointlessly annoying to implement the git rules for 
refspecs in the helpers).

So it should be easy to put something into transport_push to do a step 2.5 
confirmation, and a bit more work (which ought to get done anyway) to make 
it apply to rsync and http URLs.

(Furthermore, currently, http-push is a separate program from the fetch 
code, which is moving from the main git executable to git-remote-curl; the 
http push code should probably actually move to git-remote-curl, so that 
there is a single external program taking care of all operations on such 
URLs and there is less complexity in how the curl-using code is 
structured.)

	-Daniel
*This .sig left intentionally blank*
