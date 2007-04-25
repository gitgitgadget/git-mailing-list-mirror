From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Problem with git-daemon and mmap.
Date: Wed, 25 Apr 2007 03:43:54 -0400
Message-ID: <20070425074354.GH5942@spearce.org>
References: <1177483875.12689.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Ansell <mithro@mithis.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 09:44:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgcAX-0005C1-Aa
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 09:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161667AbXDYHoB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 03:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161683AbXDYHoA
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 03:44:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57614 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161667AbXDYHn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 03:43:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgcAO-00059f-6v; Wed, 25 Apr 2007 03:43:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5135320FBAE; Wed, 25 Apr 2007 03:43:55 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1177483875.12689.22.camel@localhost>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45504>

Tim Ansell <mithro@mithis.com> wrote:
> [30957] Request upload-pack for '/git/web.git'
> fatal: Out of memory? mmap failed: Bad file descriptor
> error: git-upload-pack: git-rev-list died with error.
> fatal: git-upload-pack: aborting due to possible repository corruption
> on the remote side.

Owwww....  I don't know what your bug is, but your bug is showing my
own bug.  Filtering the strace to the rev-list child shows this gem:

20769 open("./objects/pack/pack-1931b39bd648fd595248e234f43717569ec5c354.pack", O_RDONLY|O_LARGEFILE <unfinished ...>
20769 <... open resumed> )              = 5

OK, so the packfile is fd 5...

20769 mmap2(NULL, 33554432, PROT_READ, MAP_PRIVATE, 5, 0 <unfinished ...>
20769 <... mmap2 resumed> )             = 0xb5e2d000

and we mapped one 32 MiB window from it at position 0...

20769 mmap2(NULL, 31020635, PROT_READ, MAP_PRIVATE, 5, 0x6000 <unfinished ...>
20769 <... mmap2 resumed> )             = -1 ENOMEM (Cannot allocate memory)

And we asked for another window further into the file.  But got denied.

Now where are we in the code?  We're down inside use_pack(), after
we have called unuse_one_window() enough times to make sure we stay
within our allowed maximum window size.  Since we didn't unmap the
prior window at 0xb5e2d000 we aren't exceeding the current limit
(which probably the defaults).

But we're actually down inside xmmap()...

So we release the window we do have (by calling release_pack_memory),
assuming memory pressure...

20769 munmap(0xb5e2d000, 33554432 <unfinished ...>
20769 <... munmap resumed> )            = 0
20769 close(5 <unfinished ...>
20769 <... close resumed> )             = 0

And that was the last window in this packfile.  So we closed it.
Way to go us.  Our xmmap does not expect release_pack_memory
to close the fd its about to map...

20769 mmap2(NULL, 31020635, PROT_READ, MAP_PRIVATE, 5, 0x6000 <unfinished ...>
20769 <... mmap2 resumed> )             = -1 EBADF (Bad file descriptor)

And so the Linux kernel happily tells us f' off.

20769 write(2, "fatal: ", 7 <unfinished ...>
20769 <... write resumed> )             = 7
20769 write(2, "Out of memory? mmap failed: Bad "..., 47 <unfinished ...>
20769 <... write resumed> )             = 47

And we report the bad file descriptor error, and not the ENOMEM.


I'm not really sure why you blew out the memory and couldn't mmap
a second window here; you really should have been able to given
that there was only one 32 MiB window mapped, and this was fairly
earily in the process' life.  You can try tuning the packing code
down to a smaller window size (see core.packedGitWindowSize and
core.packedGitLimit).

But that strace above shows a secondary bug when we get into this
sort of situation.  Not pretty.

-- 
Shawn.
