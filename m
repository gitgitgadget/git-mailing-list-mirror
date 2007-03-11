From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Errors cloning large repo
Date: Sat, 10 Mar 2007 21:00:13 -0500
Message-ID: <20070311020013.GD10343@spearce.org>
References: <645002.46177.qm@web52608.mail.yahoo.com> <20070310030718.GA2927@spearce.org> <esu11i$m54$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 03:00:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQDMG-0000BT-BH
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 03:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbXCKCAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 21:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbXCKCAU
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 21:00:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57122 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932442AbXCKCAS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 21:00:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQDLx-0006Ls-RM; Sat, 10 Mar 2007 21:00:05 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B434B20FBAE; Sat, 10 Mar 2007 21:00:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <esu11i$m54$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41895>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn O. Pearce wrote:
> 
> > One thing that you could do is segment the repository into multiple
> > packfiles yourself, and then clone using rsync or http, rather than
> > using the native Git protocol.
> 
> By the way, it would be nice to have talked about fetch / clone
> support for sending (and creating) _multiple_ pack files. Beside
> the situation where we must use more than one packfile because
> of size limits, it would also help clone as it could send existing
> packs and pack only loose objects (trading perhaps some bandwidth
> with CPU load on the server; think kernel.org).

I've thought about adding that type of protocol extension on
more than one occasion, but have now convinced myself that it is
completely unnecessary.  Well at least until a project has more
than 2^32-1 objects anyway.

The reason is we can send any size packfile over the network; there
is no index sent so there is no limit on how much data we transfer.
We could easily just dump all existing packfiles as-is (just clip
the header/footers and generate our own for the entire stream)
and then send the loose objects on the end.

The client could easily segment that into multiple packfiles
locally using two rules:

  - if the last object was not a OBJ_COMMIT and this object is
  an OBJ_COMMIT, start a new packfile with this object.

  - if adding this object to the current packfile exceeds my local
  filesize threshold, start a new packfile.

The first rule works because we sort objects by type, and commits
appear at the front of a packfile.  So if you see a non-commit
followed by a commit, that's the packfile boundary that the
server had.

The second rule is just common sense.  But I'm not sure the first
rule is even worthwhile; the server's packfile boundaries have no
real interest for the client.


But Linus has already pointed all of this out (more or less) in a
different fork of this thread.  ;-)

-- 
Shawn.
