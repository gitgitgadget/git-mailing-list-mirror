From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-index-pack really does suck..
Date: Tue, 03 Apr 2007 14:44:13 -0700
Message-ID: <7vvegduo9e.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704030754020.6730@woody.linux-foundation.org>
	<db69205d0704031227q1009eabfhdd82aa3636f25bb6@mail.gmail.com>
	<Pine.LNX.4.64.0704031304420.6730@woody.linux-foundation.org>
	<alpine.LFD.0.98.0704031625050.28181@xanadu.home>
	<Pine.LNX.4.64.0704031346250.6730@woody.linux-foundation.org>
	<20070403210319.GH27706@spearce.org>
	<Pine.LNX.4.64.0704031411320.6730@woody.linux-foundation.org>
	<20070403211709.GJ27706@spearce.org>
	<alpine.LFD.0.98.0704031730300.28181@xanadu.home>
	<20070403213710.GK27706@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Chris Lee <clee@kde.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:44:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYqna-0000lw-EN
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 23:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945985AbXDCVoP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 17:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbXDCVoP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 17:44:15 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38111 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbXDCVoO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 17:44:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070403214414.GCTJ28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 17:44:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ilkC1W00K1kojtg0000000; Tue, 03 Apr 2007 17:44:13 -0400
In-Reply-To: <20070403213710.GK27706@spearce.org> (Shawn O. Pearce's message
	of "Tue, 3 Apr 2007 17:37:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43676>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Nicolas Pitre <nico@cam.org> wrote:
>> First, I truly believe we should have a 64-bit pack index and fewer 
>> larger packs than many small packs.
>
> I'll buy that.  ;-)
>  
>> Which leaves us with the actual pack index lookup.  At that point the 
>> cost of finding an existing object and finding that a given object 
>> doesn't exist is about the same thing, isn't it?
>
> Here's the rub:  in the missing object case we didn't find it
> in the pack index, but it could be loose.  That's one failed
> syscall per object if the object isn't loose.  If the object
> isn't loose, it could be that it was *just* removed by a
> running prune-packed, and the packfile that it was moved
> to was created after we scanned for packfiles, so time to
> rescan...

If that is the only reason we have these reprepare_packed_git()
sprinkled all over in sha1_file.c (by 637cdd9d), perhaps we
should rethink that.  Is there a cheap way to trigger these
rescanning only when a prune-packed is in progress, I wonder...
