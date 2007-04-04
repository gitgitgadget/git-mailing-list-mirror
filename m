From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Partitioned packs
Date: Tue, 3 Apr 2007 19:52:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704031944540.6730@woody.linux-foundation.org>
References: <db69205d0704031836u3b3dfc2pb9825dd649aca58@mail.gmail.com>
 <Pine.LNX.4.64.0704031858470.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Chris Lee <clee@kde.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 04:54:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYvdS-0007ME-SN
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 04:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992534AbXDDCxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 22:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992536AbXDDCxc
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 22:53:32 -0400
Received: from smtp.osdl.org ([65.172.181.24]:54548 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992534AbXDDCxb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 22:53:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l342quPD032383
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 3 Apr 2007 19:52:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l342qurm010468;
	Tue, 3 Apr 2007 19:52:56 -0700
In-Reply-To: <Pine.LNX.4.64.0704031858470.6730@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.453 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43706>



On Tue, 3 Apr 2007, Linus Torvalds wrote:
> 
> So trying to partition things doesn't help (because the objects are 
> already well sorted), and it does hurt.

Side note: I think that there *are* cases where partitioned packs can do 
better, but I think that in order to do better you should

 - partition by "recency", ie put objects that are not reachable from any 
   recent point in older packs.

 - make sure that the "packed_git" list is always sorted so that the older 
   data packs are at the end.

and that should actually speed up many loads, just because the recent 
objects are all in one pack, and because it's smaller, that pack can be 
looked up a bit faster.

On the other hand, the power of a log(n) function like a binary search is 
that lookup in a big pack that is four times the size of four smaller 
packs is really not all that much more expensive, so the advantage is 
probably pretty small.

And for things that need old objects (and "git blame" does obviously very 
much tend to fall into that category), any partitioning is likely to be 
bad.

So I think partitioning is valid, but my suspicion is that you'd want to 
partition for *other* reasons than highest performance. Better reasons to 
have multiple packs:

 - just because you haven't repacked ;)
 - to keep "git repack" times down by marking old big packs as "keep" once 
   they get big enough (the space advantage of packing eventually flattens 
   out, so there's no real overwhelming reason to repack old stuff if you 
   have "enough")
 - filesystem and pack-file limitations (ie the 2**31 limit)

but I doubt performance is ever going to be a really compelling one.

You can obviously always optimize for some very *particular* load by 
packing optimally for just that one (keep exactly the objects you need in 
one particular pack, don't even touch any other packs), but I don't think 
any load is *so* special that you shouldn't think of other loads.

			Linus
