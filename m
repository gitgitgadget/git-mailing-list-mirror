From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 17:42:01 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031735470.28181@xanadu.home>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
 <Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704031322490.6730@woody.linux-foundation.org>
 <alpine.LFD.0.98.0704031657130.28181@xanadu.home>
 <Pine.LNX.4.64.0704031413200.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Chris Lee <clee@kde.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:42:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqlU-0007xU-Dj
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbXDCVmF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753684AbXDCVmF
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:42:05 -0400
Received: from relais.videotron.ca ([24.201.245.36]:49346 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662AbXDCVmE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:42:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFX00CKFYY1OG30@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 17:42:02 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0704031413200.6730@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43675>

On Tue, 3 Apr 2007, Linus Torvalds wrote:

> 
> 
> On Tue, 3 Apr 2007, Nicolas Pitre wrote:
> >
> > I don't see where that might be.  The only thing that the paranoia check 
> > triggers is:
> > 
> > 	foo = read_sha1_file(blah);
> > 	memcmp(foo with bar);
> > 	free(foo);
> > 
> > So where is that commit ID information actually stored when using 
> > read_sha1_file()?
> 
> I've got the numbers: it uses much more memory when doing even failing 
> lookups, ie:
> 
> 	With --paranoid: 5583 minor pagefaults (21MB)
> 	Without --paranoid: 2957 minor pagefaults (11MB)
> 
> (remember, this was *just* the git pack, not the kernel pack)
> 
> It could be as simple as just the index file itself. That's 11MB for the 
> kernel. Imagine if the index file was 20 times bigger - 200MB of memory 
> paged in with bad access patterns just for unnecessary lookups.

Again that presumes you have to page in the whole index, which should 
not happen when pulling (much smaller packs) and with a better lookup 
algorithm.

> > Not if you consider that it is performed _while_ receiving (and waiting 
> > for) the pack data over the net in the normal case.
> 
> ..which is why I think it makes sense for "pull" to be paranoid. I just 
> don't think it makes sense to be paranoid *all* the time, since it's 
> clearly expensive.

Make it conditionnal on --stdin then.  This covers all cases where we 
really want the secure thing to happen, and the --stdin case already 
perform the atomic rename-and-move thing when the pack is fully indexed.


Nicolas
