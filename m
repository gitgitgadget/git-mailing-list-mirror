From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Error "fatal: cannot pread pack file: Success"
Date: Tue, 27 Feb 2007 22:57:13 -0500
Message-ID: <20070228035713.GC5597@spearce.org>
References: <17892.64236.443170.43061@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Feb 28 04:57:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMFwP-0004AN-1E
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 04:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbXB1D5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 22:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbXB1D5S
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 22:57:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33234 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbXB1D5R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 22:57:17 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMFw7-0007Sh-S6; Tue, 27 Feb 2007 22:57:03 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4BD3D20FBAE; Tue, 27 Feb 2007 22:57:14 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17892.64236.443170.43061@lisa.zopyra.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40888>

Bill Lear <rael@zopyra.com> wrote:
> Using 1.5.0.1.  Can't see what is wrong with this clone...
...
> Indexing 4589 objects.
> remote: Total 4589 (delta 2209), reused 4589 (delta 2209)
>  100% (4589/4589) done
> Resolving 2209 deltas.
> fatal: cannot pread pack file: Success
> fatal: index-pack died with error code 128
> fetch-pack from '/home/rael/devel/project/.git' failed.

What platform is this?  index-pack failed to read using pread(),
but the error code in errno was 0 (success)?  Huh?

It turns out this is steaming from a short read; we asked for some
length of bytes but did not get that exact value.  That sounds like
the packfile is truncated.

Ohh - is this repository on NFS, or some other sort of network
filesystem?  Maybe the FS couldn't give us the entire pread request
in one shot...

I think the pread() in get_data_from_pack of index-pack is wrong,
it really should be looping until we fill the buffer in case the
OS doesn't fully satisfy our read request the first time.

-- 
Shawn.
