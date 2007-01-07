From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: problem with git clone on cygwin
Date: Sun, 7 Jan 2007 01:00:08 -0500
Message-ID: <20070107060007.GA10351@spearce.org>
References: <20070106170330.GA8041@scotty.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 07:00:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3R4s-0006mK-Ie
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 07:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbXAGGAO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 01:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbXAGGAO
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 01:00:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48764 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932405AbXAGGAM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 01:00:12 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H3R56-0000Eh-BO; Sun, 07 Jan 2007 01:00:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 81D7720FB65; Sun,  7 Jan 2007 01:00:08 -0500 (EST)
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
Content-Disposition: inline
In-Reply-To: <20070106170330.GA8041@scotty.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36128>

"Stefan-W. Hahn" <stefan.hahn@s-hahn.de> wrote:
> running git on Cygwin I have a problem with git clone on local disk,
> while packing data. 
> 
> The problem comes with v1.5.0-rc0. I bisected the problem down to
> commit 6d2fa7 as the first bad commit.

That was a performance improvement for Mac OS X to reduce the
index-pack time on linux.git from almost an hour to about 1 minute.
 
> It seems to be a problem with cygwin.dll prior v1.5.22 and pread(), if
> using an offset!=0. (I'm running cygwin.dll v1.5.21 build date
> 2006-07-27 and I can't update because of other compatibility problems).

Why can't you upgrade Cygwin?
 
> So I tried:
> - not to set NO_MMAP to use real mmap

FYI: you can "unset" NO_MMAP at compile time:

  make NO_MMAP=

or by putting it into your personal config.mak:

  echo NO_MMAP= >config.mak
  make

this way you always build with the real mmap, but don't need to
locally patch Makefile.

> - changing get_data_from_pack() from index-pack.c to used mmap() as
>   in 042aea8. (I did this because it directly uses pread().)
> This solved the problem for my testcase.

This isn't ideal because of the performance problems that some
OSes have with small but frequent mmap() calls.

Perhaps we should add our own fake pread (aka git_pread) to
git-compat-util.h and provide a NO_PREAD option in the Makefile?
Though I don't think its really worth it, as pretty much every
OS we run on should have a functioning pread call.  Except some
Cygwins apparently.

-- 
Shawn.
