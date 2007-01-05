From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Increase packedGit{Limit,WindowSize} on 64 bit systems.
Date: Thu, 04 Jan 2007 22:01:20 -0800
Message-ID: <7v4pr6j9lb.fsf@assigned-by-dhcp.cox.net>
References: <20070105032808.GA14247@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 07:01:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2i8v-0007yT-Nt
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 07:01:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbXAEGBW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 01:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030350AbXAEGBW
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 01:01:22 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:48485 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030340AbXAEGBV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 01:01:21 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105060120.PHPF20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 5 Jan 2007 01:01:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7J1b1W00g1kojtg0000000; Fri, 05 Jan 2007 01:01:36 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070105032808.GA14247@spearce.org> (Shawn O. Pearce's message
	of "Thu, 4 Jan 2007 22:28:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35978>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If we have a 64 bit address space we can easily afford to commit
> a larger amount of virtual address space to pack file access.
> So on these platforms we should increase the default settings of
> core.packedGit{Limit,WindowSize} to something that will better
> handle very large projects.

Hmmmm.  What's the reasoning behind this?

We have more than enough virtual memory anyway, we do not bother
with our own mmap limit -- we will let the operating system
worry about it.

If that is the reasoning, I have a feeling that we might want to
be even more agressive.  If you have a 1.5GB pack, wouldn't you
rather map the whole thing in a single window, instead of
splitting that into two?

Currently we are limited (by pack offset) to 4GB per pack, so
raising the window max to 4GB might make sense.

On the total size of vm space, I am wondering what would happen
if we make this unbounded.  You certainly notice mmap() failure
and fall back to recycle other windows even when your total
usage is under the limit, don't you?  Your later patches in the
series even unmap the mapped but unused window lazily to make
room for xmalloc() and friends, so I suspect it might even make
it simpler not to have this limit especially on larger systems.
