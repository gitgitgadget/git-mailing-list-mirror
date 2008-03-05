From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFH] bug in unpack_trees
Date: Wed, 5 Mar 2008 01:47:57 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0803050130190.19665@iabervon.org>
References: <20080304115940.GA5260@sigill.intra.peff.net> <alpine.LFD.1.00.0803041325370.12253@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	John Goerzen <jgoerzen@complete.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 07:48:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWnQt-0007bt-SA
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 07:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757463AbYCEGsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 01:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756088AbYCEGsE
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 01:48:04 -0500
Received: from iabervon.org ([66.92.72.58]:37509 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757037AbYCEGsB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 01:48:01 -0500
Received: (qmail 29840 invoked by uid 1000); 5 Mar 2008 06:47:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Mar 2008 06:47:57 -0000
In-Reply-To: <alpine.LFD.1.00.0803041325370.12253@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76179>

On Tue, 4 Mar 2008, Linus Torvalds wrote:

> On Tue, 4 Mar 2008, Jeff King wrote:
> >
> > I am tracking down a bug in unpack_trees, but I can't seem to find the
> > exact problem; I'm hoping to get help from people who have touched this
> > code a bit more than I have.
> 
> Ok, I haven't (the blame for that unpack_trees function lies mainly at 
> Dscho, I think ;), and now that I'm looking at it more closely I really 
> don't think unpack_trees() is salvageable.

It was mostly me, 2.5 years ago in a file with a different name.

> I tried. I can't make it work.
> 
> The only really sane way to traverse trees in parallel is with the 
> walk-tree.c functionality (ie using "traverse_trees()"), which is quite 
> straightforward and rather simple, and which I can pretty much guarantee 
> works.
> 
> In contrast, the things that unpack_trees() does to try to figure out how 
> to mix in the index into the pot really doesn't work.

The thing that's hopeless isn't including the index; it's including the 
index that's simultaneously being regenerated. In this case, the mode 0 
entry for df is getting dropped in order to not have both a "remove df" 
entry and a create "df/file" entry, and this means that the position in 
the index is one entry later than it should be, skipping over "new", which 
then doesn't get touched.

Of course, regenerating the same index is not only very difficult but 
inefficient, because it involves adding and removing elements from the 
middle of an array. The sensible thing is just to generate a new 
in-memory index and swap it in on success at the end. This makes the 
position update trivial (increment the position if you use the entry) and 
the result generation efficient. In the process, we could have a separate 
list of things to unlink() that aren't stored as weird index entries.

> I'll take a good hard look at trying to convert users of unpack_trees() 
> into traverse_trees(), or perhaps even convert "unpack_trees()" itself.

I'll see if I can get something sensible worked out Wednesday afternoon.

	-Daniel
*This .sig left intentionally blank*
