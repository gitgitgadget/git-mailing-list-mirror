From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 16:32:25 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031625050.28181@xanadu.home>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 22:32:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYpgQ-0001vY-LS
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 22:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945918AbXDCUc1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 16:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945916AbXDCUc1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 16:32:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9982 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945915AbXDCUc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 16:32:26 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFX00HKSVQ1Z450@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 16:32:26 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43654>

On Tue, 3 Apr 2007, Linus Torvalds wrote:

> 
> 
> On Tue, 3 Apr 2007, Chris Lee wrote:
> > 
> > There's another issue here.
> > 
> > I'm running git-index-pack as part of a workflow like so:
> > 
> > $ git-verify-pack -v .git/objects/pack/*.idx > /tmp/all-objects
> > $ grep 'blob' /tmp/all-objects > /tmp/blob-objects
> > $ cat /tmp/blob-objects | awk '{print $1;}' | git-pack-objects
> > --delta-base-offset --all-progress --stdout > blob.pack
> > $ git-index-pack -v blob.pack
> > 
> > Now, when I run 'git-index-pack' on blob.pack in the current
> > directory, memory usage is pretty horrific (even with the applied
> > patch to not leak all everything). Shawn tells me that index-pack
> > should only be decompressing the object twice - once from the repo and
> > once from blob.pack - iff I call git-index-pack with --stdin, which I
> > am not.
> > 
> > If I move the blob.pack into /tmp, and run git-index-pack on it there,
> > it completes much faster and the memory usage never exceeds 200MB.
> > (Inside the repo, it takes up over 3G of RES according to top.)
> 
> Yeah. What happens is that inside the repo, because we do all the 
> duplicate object checks (verifying that there are no evil hash collisions) 
> even after fixing the memory leak, we end up keeping *track* of all those 
> objects.

What do you mean?

> And with a large repository, it's quite the expensive operation.
> 
> That whole "verify no SHA1 hash collision" code is really pretty damn 
> paranoid. Maybe we shouldn't have it enabled by default.

Maybe we shouldn't run index-pack on packs for which we _already_ have 
an index for which is the most likely reason for the collision check to 
trigger in the first place.

This is in the same category as trying to run unpack-objects on a pack 
within a repository and wondering why it doesn't work.

> So how about this updated patch? We could certainly make "git pull" imply 
> "--paranoid" if we want to, but even that is likely pretty unnecessary. 

I'm of the opinion that this patch is unnecessary.  It only helps in 
bogus workflows to start with, and it makes the default behavior unsafe 
(unsafe from a paranoid pov, but still).  And in the _normal_ workflow 
it should never trigger.

So I wouldn't merge it.


Nicolas
