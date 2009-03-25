From: Nicolas Pitre <nico@cam.org>
Subject: Re: large(25G) repository in git
Date: Tue, 24 Mar 2009 21:21:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903241709090.26337@xanadu.home>
References: <49C7FAB3.7080301@brainfood.com>
 <alpine.LFD.2.00.0903232056520.26337@xanadu.home>
 <49C91F87.3050105@brainfood.com>
 <alpine.LFD.2.00.0903241404080.26337@xanadu.home>
 <49C948C1.2070404@brainfood.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Adam Heath <doogie@brainfood.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 02:23:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmHpo-0000Kv-ST
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 02:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757321AbZCYBV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 21:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756871AbZCYBV2
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 21:21:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:25571 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231AbZCYBV1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 21:21:27 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KH100I0SFPV05Z0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Mar 2009 21:20:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <49C948C1.2070404@brainfood.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114533>

On Tue, 24 Mar 2009, Adam Heath wrote:

> Nicolas Pitre wrote:
> > As much as I would like to believe you, this doesn't help fixing the 
> > problem if you don't provide more information about this.  For example, 
> > the output from git during the whole operation might give us the 
> > beginning of a clue.  Otherwise, all I can tell you is that such thing 
> > is not supposed to happen.
> 
> First off, you've put a bad tone on this.  It appears that you are
> saying I'm mistaken, and it didn't send all that data.  "It can't
> happen, so it didn't happen."  Believe me, if it hadn't resent all
> this data, I wouldn't have even sent the email.

I don't know you.  All I had is the information you provided which was 
rather incomplete.  So don't be offended if I ask for more.  I'm trying 
to help you after all.

And especially in this case, the problem seems not to be about 
packing...

> In any event, we got lucky.  I *do* have a log of the push side of
> this problem.  I doubt it's enough to figure out the actual cause tho.

Well, I think it might.

> ==
> Counting objects: 96637, done.
> Compressing objects: 100% (29670/29670), done.
> Writing objects: 100% (96637/96637), 25.49 GiB | 226 KiB/s, done.
> Total 96637 (delta 48713), reused 96637 (delta 48713)
> To ssh://bf-yum/@anon-site@
>  * [new branch]      master -> lnxwww10

Was that branch really new on the remote side?  If no, then this is 
highly suspicious.  If somehow the previously aborted push attempt 
screwed the remote refs, then the local client would think that the 
remote is empty and conclude that all commits have to be pushed.

> >> After I ran git push, ssh timed out, the temp pack that was created
> >> was then removed, as git complained about the connection being gone.
> > 
> > On a push, there is no creation of a temp pack.  It is always produced 
> > on the fly and pushed straight via the ssh connection.
> 
> No.  I saw a temp file in strace.  It *was* created on the local disk,
> and *not* sent on the fly.

A temp pack is created on the receiving side, not the sending side 
though.  The sending side is piping the pack data on its standard output 
which is connected to ssh's standard input.

> >> Um, if it's missing documentation, then how am I supposed to know
> >> about it?
> > 
> > Asking on the list, like you did.  However this attribute should be 
> > documented as well of course.  I even think that someone posted a patch 
> > for it a while ago which might have been dropped.
> 
> What I'd like, is a way to say a certain pattern of files should only
> be deduped, and not deltafied.  This would handle the case of exact
> copies, or renames, which would still be a win for us, but generally
> when a new video(or doc or pdf) is uploaded, it's alot of work to try
> and deltafy, for very little benefit.

Renamed/duplicated files are always stored uniquely by design.  Git 
store file data into objects which are named after the SHA1 of their 
content.

In order to not attempt any delta on PDF files for example, you need to 
add a negative delta attribute line such as:

*.pdf	-delta

either in a file called .gitattributes which gets versionned 
and distributed, or in .git/info/attributes in which case it'll remain 
local.  Any file matching *.pdf won't be delta compressed.


Nicolas
