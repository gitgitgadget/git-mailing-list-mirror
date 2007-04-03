From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 15:49:03 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704031540140.28181@xanadu.home>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
 <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Chris Lee <clee@kde.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 21:49:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYp0A-00044g-2H
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 21:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422659AbXDCTtG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 15:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbXDCTtG
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 15:49:06 -0400
Received: from relais.videotron.ca ([24.201.245.36]:64101 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422663AbXDCTtE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 15:49:04 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JFX000LCTPR0770@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 03 Apr 2007 15:49:04 -0400 (EDT)
In-reply-to: <db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43646>

On Tue, 3 Apr 2007, Chris Lee wrote:

> There's another issue here.
> 
> I'm running git-index-pack as part of a workflow like so:
> 
> $ git-verify-pack -v .git/objects/pack/*.idx > /tmp/all-objects
> $ grep 'blob' /tmp/all-objects > /tmp/blob-objects
> $ cat /tmp/blob-objects | awk '{print $1;}' | git-pack-objects
> --delta-base-offset --all-progress --stdout > blob.pack
> $ git-index-pack -v blob.pack

Instead of using --stdout with git-pack-object, you should provide it 
with a suitable base name for the resulting pack and the index will be 
created automatically along side the pack for you.  No need to use 
index-pack for that.

> Now, when I run 'git-index-pack' on blob.pack in the current
> directory, memory usage is pretty horrific (even with the applied
> patch to not leak all everything). Shawn tells me that index-pack
> should only be decompressing the object twice - once from the repo and
> once from blob.pack - iff I call git-index-pack with --stdin, which I
> am not.
> 
> If I move the blob.pack into /tmp, and run git-index-pack on it there,
> it completes much faster and the memory usage never exceeds 200MB.
> (Inside the repo, it takes up over 3G of RES according to top.)

The 3G should definitely be fixed with the added free().

The CPU usage is explained by the fact that you're running index-pack on 
objects that are all already found in your repo so the collision check 
is triggered.  This is more or like the same issue as if you tried to 
run unpack-objects on the same pack where none of your objects will 
actually be unpacked.


Nicolas
