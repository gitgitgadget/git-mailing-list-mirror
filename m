From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Mozilla .git tree
Date: Fri, 1 Sep 2006 22:04:27 -0400
Message-ID: <20060902020426.GF24234@spearce.org>
References: <20060829190548.GK21729@spearce.org> <9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com> <20060829232007.GC22935@spearce.org> <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com> <20060830015122.GE22935@spearce.org> <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com> <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home> <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <7vr6yw58xp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Sep 02 05:21:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJM4L-0005tq-7p
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 05:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWIBDVK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 23:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWIBDVK
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 23:21:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38112 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750720AbWIBDVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Sep 2006 23:21:09 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GJM3r-0005J1-KY; Fri, 01 Sep 2006 23:20:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 769B120FB08; Fri,  1 Sep 2006 22:04:27 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6yw58xp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26318>

Junio C Hamano <junkio@cox.net> wrote:
[snip]
> +A new style .idx file begins with a signature, "\377tOc", and a
> +version number as a 4-byte network byte order integer.  The version
> +of this implementation is 2.

Ick.  I understand why you did this (and thanks for such a good
explanation of it by the way) but what a horrible signature number
and way to wedge in a version number.

>From now on I propose that if we write a file - especially a binary
file - to disk that we always include a 4 byte version number into
the header of the file.  Then we can avoid trying to wedge this into
the file after the fact when some worthwhile improvement requires
changing the format.

I think we probably should have done this when the binary headers
were introduced into loose objects.  Would 4 bytes of file format
version number with an (initial version number which wasn't 0x78
in byte 0 and failed the % 31 test) really have hurt that much in
a loose object?

[snip]
> + . 4-byte network byte order integer, recording the location of the
> +   next object in the main toc table.

Why not just the 4 byte object entry length?  To load an object we
have to go find the next object in the idx file so we can compute
the offset difference.  On very large packs (e.g. the Mozilla pack)
the index is 46 MiB.  The jump across the index could be the entire
thing from back to front just to compute the size of an object when
the fan-out table and the binary search process really only poked
the tail end of the index when searching for the entry.  So we're
demand paging in the front of the index just to compute a length

Sure the scheme you outlined allows a 64 bit difference but
uncompressed objects already can't be larger than 2**32-1 and we
could just as easily move that limit down to say 2**32-16 to leave
room for the object header and zlib header.

-- 
Shawn.

-- 
VGER BF report: U 0.5
