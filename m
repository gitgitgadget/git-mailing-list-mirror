From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Replacing the system call pread() with real mmap().
Date: Sun, 7 Jan 2007 06:24:45 -0500
Message-ID: <20070107112445.GE10351@spearce.org>
References: <20070106170330.GA8041@scotty.home> <20070107060007.GA10351@spearce.org> <20070107111712.GB9909@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 12:25:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3W8y-0003EH-Kc
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 12:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbXAGLYu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 06:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbXAGLYu
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 06:24:50 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:55259 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509AbXAGLYt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 06:24:49 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H3W9C-00086K-KH; Sun, 07 Jan 2007 06:25:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E512620FB65; Sun,  7 Jan 2007 06:24:45 -0500 (EST)
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Content-Disposition: inline
In-Reply-To: <20070107111712.GB9909@scotty.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36160>

"Stefan-W. Hahn" <stefan.hahn@s-hahn.de> wrote:
> +# Define NO_PREAD if you have a problem with pread() system call (i.e.
> +# cygwin.dll before v1.5.22). This needs NO_MMAP not to be set, because pread()
> +# is emulated using mmap.

Better to emulate pread using lseek/xread/lseek:

	off_t p = lseek(fd, offset, SEEK_SET);
	xread(fd, buf, count);
	lseek(fd, p, SEEK_SET);

If you look at the history for contrib/mmap.c you will see an
implementation like that before it was called git_mmap().

This works OK in Git as we only ever have one thread, therefore
there is no race condition during the seek/read/seek calls.  Its also
usually faster on platforms like Mac OS X where mmap() is horrible.
If the platform is lacking a good pread() it may also be the case
that it lacks a good mmap(); in this case it would be desirable to
set both NO_MMAP and NO_PREAD.

-- 
Shawn.
