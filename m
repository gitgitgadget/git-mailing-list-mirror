From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] Make xstrndup common
Date: Sun, 29 Apr 2007 13:39:12 -0700
Message-ID: <7vy7kadifj.fsf@assigned-by-dhcp.cox.net>
References: <46339819.8030007@freedesktop.org>
	<Pine.LNX.4.64.0704291416370.28708@iabervon.org>
	<4635003F.7080408@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
X-From: git-owner@vger.kernel.org Sun Apr 29 22:39:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiGBA-0006pR-9H
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 22:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031391AbXD2UjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 16:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031421AbXD2UjP
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 16:39:15 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37423 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031391AbXD2UjO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 16:39:14 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070429203913.FPER1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 29 Apr 2007 16:39:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id t8fC1W00D1kojtg0000000; Sun, 29 Apr 2007 16:39:13 -0400
In-Reply-To: <4635003F.7080408@freedesktop.org> (Josh Triplett's message of
	"Sun, 29 Apr 2007 13:29:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45837>

Josh Triplett <josh@freedesktop.org> writes:

> Daniel Barkalow wrote:
> ...
>> Good catch. Replacing the memcpy with strncpy solves this, right? 
>> (Potentially allocating a bit of extra memory if someone is actually using 
>> it on too short a string for some reason, of course).
>
> That would work, but it seems bad to allocate excess memory.  How about just
> using strlen and setting len to that if shorter, before doing the xmalloc and
> memcpy?  Yes, that makes two passes over the string, but I don't see any way
> around that.

Hand-rolling strnlen() would be needed anyway, because there is
no guarantee that the incoming string is NUL terminated.  In the
worst case the string may point at a region of memory filled
with non-NUL to the end, which coincides with a page boundary,
and the next page may be an unmapped one; your strlen() would
sigbus.
