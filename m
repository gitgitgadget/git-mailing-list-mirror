From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Thu, 06 Jan 2011 22:21:36 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101061956470.22191@xanadu.home>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 04:21:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb2tp-00073B-Vc
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 04:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742Ab1AGDVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 22:21:39 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18337 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755471Ab1AGDVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 22:21:37 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LEM00H2SUMQ8U10@vl-mh-mrz25.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Jan 2011 22:20:50 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164698>

On Wed, 5 Jan 2011, Nguyen Thai Ngoc Duy wrote:

> Hi,
> 
> I've been analyzing bittorrent protocol and come up with this. The
> last idea about a similar thing [1], gittorrent, was given by Nicolas.
> This keeps close to that idea (i.e the transfer protocol must be around git
> objects, not file chunks) with a bit difference.
> 
> The idea is to transfer a chain of objects (trees or blobs), including
> base object and delta chain. Objects are chained in according to
> worktree layout, e.g. all objects of path/to/any/blob will form a
> chain, from a commit tip down to the root commits. Chains can have
> gaps, and don't need to start from commit tip. The transfer is
> resumable because if a delta chain is corrupt at some point, we can
> just request another chain from where it stops. Base object is
> obviously resumable.

How do you actually define your chain?  Given that Git is conceptually 
snapshot based, there is currently no relationship between two blobs 
forming the content for two different versions of the same file.  Even 
delta objects are not really part of the Git data model as they are only 
an encoding variation of a given primary object.  In fact, we may and 
actually do have deltas where the base object is not from the same 
worktree file as the delta object itself.

The only thing that 
ties this all together is the commit graph.  And that graph might have 
multiple forks and merges so any attempt at a linearity representation 
into a chain is rather futile.  Therefore it is not clear to me how you 
can define a chain with a beginning and an end, and how this can be 
resumed midway.

> We start by fetching all commit contents reachable from a commit tip.

Sure.  This is doable today and is called a shalow clone with depth=1.

> This is a chain, therefore resumable.

I don't get that part though.  How is this resumable?  That's the very 
issue we have with a clone.

I proposed a solution to that already, which is to use 
git-upload-archive for one of the tip commit since the data stream 
produced by upload-archive (once decompressed) is actually 
deterministic.  Once completed, this can be converted into a shalow 
clone on the client side, and can be deepened in smaller steps 
afterwards.

> From there each commit can be
> examined. Missing trees and blobs will be fetched as chains. Everytime
> a delta is received, we can recreate the new object and verify it (we
> should have its SHA-1 from its parent trees/commits).

What if the delta is based on an object from another chain?  How do you 
determine which chain to ask for to get that base?

> Because these chains are quite independent, in a sense that a blob
> chain is independent from another blob chain (but requires tree
> chains, of course). We can fetch as many as we want in parallel, once
> we're done with the commit chain.

But in practice, most of those chains will end up containing objects 
which are duplicate of objects in another chain.  How do you tell the 
remote that you want part of a chain because you've got 96% of it in 
another chain already?

> The last thing I like about these chains is that the number of chains
> is reasonable. It won't increase too fast over time (as compared to
> the number of commits). As such it maps well to BitTorrent's "pieces".

My problem right now is that I don't see how this maps well to Git.


Nicolas
