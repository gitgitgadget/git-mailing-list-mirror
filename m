From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Mozilla .git tree
Date: Fri, 1 Sep 2006 21:19:50 -0400
Message-ID: <20060902011950.GB24234@spearce.org>
References: <20060829190548.GK21729@spearce.org> <9e4733910608291252q130fc723r945e6ab906ca6969@mail.gmail.com> <20060829232007.GC22935@spearce.org> <9e4733910608291807q9b896e4sdbfaa9e49de58c2b@mail.gmail.com> <20060830015122.GE22935@spearce.org> <9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com> <20060830031029.GA23967@spearce.org> <Pine.LNX.4.64.0608300124550.9796@xanadu.home> <7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <7vr6yw58xp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Sep 02 04:16:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJL3k-0005Hl-6v
	for gcvg-git@gmane.org; Sat, 02 Sep 2006 04:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWIBCQb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Sep 2006 22:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750699AbWIBCQa
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Sep 2006 22:16:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:10714 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750709AbWIBCQa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Sep 2006 22:16:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GJL3C-0000gv-Qj; Fri, 01 Sep 2006 22:16:03 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 55A1020FB7F; Fri,  1 Sep 2006 21:19:51 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26317>

Junio C Hamano <junkio@cox.net> wrote:
>  Step 3.  Work on integrating partial mmap() support with Shawn.
>           This is more or less orthogonal to 4GB ceiling (people
>           would hit mmap() limit even with a 1.5GB pack), but I
>           suspect it would be necessary to be able to tell where
>           the end of each pack entry is cheaply to implement
>           this.

I was just getting ready to move my partial mmap support over from
fast-import.

Although I did the implementation a little differently in fast-import
than what I think I'll do in core Git.  In fast-import store a
hashtable in memory of all objects in the pack but I chose not to
store the ending offset (or compressed length) and instead just
guess about where the object ends.  I did that to save 4 bytes of
memory per object. :-)

Its necessary to know where the object ends to ensure that your
current mapping (or any remapping you are about to do) covers the
entire object before you start deflating.  Otherwise you might
have to remap the pack in the middle of the inflate operation.
(Of course you might need to do this anyway if the compressed object
is larger than your default mapping unit.)

What I did in fast-import was give inflate whatever was left in
the current mapping; then if I got a Z_OK or Z_BUF_ERROR back from
inflate I move the mapping to the next 128 MiB chunk and reset my
z_stream's next_in/avail_in accordingly, then recall inflate.

No I didn't performance test it to see how frequently I'm mapping
a pack multiple times to get one object.  But I'm going to stick my
neck out and say that most objects probably don't have a compressed
length exceeding 128 MiB so we're talking one remap that we would
have had to do anyway if the object spanned over the end of the
current mapping.  If the object's starting offset was completely
outside of the current mapping then I rounded the offset down to
the page size (from getpagesize) and remapped; therefore we also
probably only do one remap on objects needing it.


But having the length or ending offset in the index will help with
copying the object during a repack as well as prevent us from needing
to guess during accesses.  So good news indeed that you are adding
it to the index.

-- 
Shawn.

-- 
VGER BF report: U 0.5
