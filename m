From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] improved delta support for git
Date: Wed, 18 May 2005 14:41:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505181428170.20274@localhost.localdomain>
References: <Pine.LNX.4.62.0505112309480.5426@localhost.localdomain>
 <d6dohe$dql$1@sea.gmane.org>
 <Pine.LNX.4.62.0505180005230.20274@localhost.localdomain>
 <d6evrk$jv2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 20:44:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYTVJ-0002yM-Tu
	for gcvg-git@gmane.org; Wed, 18 May 2005 20:42:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVERSnV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 14:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbVERSnV
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 14:43:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64051 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S262333AbVERSmg
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2005 14:42:36 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IGP005OO7XU5A@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 18 May 2005 14:41:54 -0400 (EDT)
In-reply-to: <d6evrk$jv2$1@sea.gmane.org>
X-X-Sender: nico@localhost.localdomain
To: Dan Holmsand <holmsand@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 18 May 2005, Dan Holmsand wrote:

> Nicolas Pitre wrote:
> > One thing I've been wondering about is whether gzipping small deltas is
> > actually a gain.  For very small files it seems that gzip is adding more
> > overhead making the compressed file actually larger.  Might be worth storing
> > some deltas uncompressed if the compressed version turns out to be larger.
> 
> It's probably better to skip deltafication of very small files altogether. Big
> pain for small gain, and all that.

No, that's not what I mean.

Suppose a large source file that may change only one line between two 
versions.  The delta may therefore end up being only a few bytes long.  
Compressing a few bytes with zlib creates a _larger_ file than the 
original few bytes.

> > Well, any delta object smaller than its original object saves space, even if
> > it's 75% of the original size. But...
> 
> That's not true if you want to keep the delta chain length down (and thus
> performance up).

Sure.  That's why I added the -d switch to mkdelta.  But if you can fit 
a delta which is 75% the size of its original object size then you still 
save 25% of the space, regardless of the delta chain length.

> But in this case, the trick is to know when to stop deltafying against one
> base file, and start over with another. If you switch to a new keyframe too
> often, you obviously lose some potential savings. But if you don't switch
> often enough, you end up repeating the same data in too many delta files.

That's why multiple combinations should be tried.  And to keep things 
under control then a new argument specifying the delta "distance" might 
limit the number of trials.

> A maximum delta size of 10% turned out to be ideal for at least the "fs"
> tree. 8% was significantly worse, as was 15%. (The ideal size depends on  how
> big the average change is: the smaller the average change, the smaller the max
> delta size should be).

In fact it seems that deltas might be significantly harder to compress.  
Therefore a test on the resulting file should probably be done as well 
to make sure we don't end up with a delta larger than the original 
object.

> > ... but then the ultimate solution is to try out all possible references
> > within a given list.  My git-deltafy-script already finds out the list of
> > objects belonging to the same file.  Maybe git-mkdelta should try all
> > combinations between them.  This way a deeper delta chain could be allowed
> > for maximum space saving.
> 
> Yeah. But then you lose the ability to do incremental deltafication, or
> deltafication on-the-fly.

Not at all.  Nothing prevents you from making the latest revision of a 
file be the reference object and the previous revision turned into a 
delta against that latest revision, even if it was itself a reference 
object before.  The only thing that must be avoided is a delta loop and 
current mkdelta code takes care of that already.


Nicolas
