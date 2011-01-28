From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 13:46:33 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101281304270.8580@xanadu.home>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net>
 <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	John Hawley <warthog19@eaglescrag.net>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 28 19:46:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PitLJ-0003by-26
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 19:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417Ab1A1Sqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 13:46:42 -0500
Received: from relais.videotron.ca ([24.201.245.36]:19780 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755413Ab1A1Sqk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 13:46:40 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFQ00L7YXGXAW20@vl-mo-mrz24.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 28 Jan 2011 13:46:10 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165632>

On Fri, 28 Jan 2011, Shawn Pearce wrote:

> This started because I was looking for a way to speed up clones coming
> from a JGit server.  Cloning the linux-2.6 repository is painful, it
> takes a long time to enumerate the 1.8 million objects.  So I tried
> adding a cached list of objects reachable from a given commit, which
> speeds up the enumeration phase, but JGit still needs to allocate all
> of the working set to track those objects, then go find them in packs
> and slice out each compressed form and reformat the headers on the
> wire.  Its a lot of redundant work when your kernel repository has
> 360MB of data that you know a client needs if they have asked for your
> master branch with no "have" set.
> 
> Later I realized, we can get rid of that cached list of objects and
> just use the pack itself.  Its far cleaner, as there is no redundant
> cache.  But either way (object list or pack) its a bit of a challenge
> to automatically identify the right starting points to use.  Linus
> Torvalds' linux-2.6 repository is the perfect case for the RFC I
> posted, its one branch with all of the history, and it never rewinds.
> But maybe Linus is just very unique in this world.  :-)

Playing my old record again... I know.  But pack v4 should solve a big 
part of this enumeration cost.

I've changed the format slightly again in my WIP branch.  The idea is to:

1) Have a non compressed yet still really dense representation for tree 
   objects;

2) do the same thing for the first part of commit objects, and only 
   deflate the free form text part.

There is nothing new here.  However, it should be possible to:

3) replace all SHA1 references by an offset into the pack file directly, 
   just like we do for OFS_DELTA objects.  If the SHA1 is actually 
   needed then we can obtain it with a reverse lookup with given object offset 
   in the pack index file, but in practice that is not actually required that 
   often.

So walking the history graph and enumerating objects would require 
nothing more than simply following straight pointers in the pack data in 
99% of the cases.  No object decompression, no memory buffer 
allocation/deallocation to perform that decompression, no string parsing 
in the tree object case, etc. Only cross pack references would require a 
full SHA1 based lookup like we do now.

I still have to sit down and figure out the implications of this, 
especially with forward references, meaning that the offset might have 
to be an object index so to allow for variable length encoding, and also 
to make sure index-pack can reconstruct the pack index.  But that would 
only be an indirect lookup which shouldn't be significantly costly.

So that's the idea.  Keep the exact same functionality as we have now, 
without any need for cache management, but making the data structure in 
a form that should improve object enumeration by some magnitude.


Nicolas
