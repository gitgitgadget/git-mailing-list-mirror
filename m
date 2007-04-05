From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-{repack,pack-objects} accept --{pack,blob}-limit to control pack size
Date: Thu, 5 Apr 2007 02:54:34 -0400
Message-ID: <20070405065433.GD5436@spearce.org>
References: <56b7f5510704041340l5997b04dp853e8270a644ab28@mail.gmail.com> <alpine.LFD.0.98.0704041750030.28181@xanadu.home> <56b7f5510704041555q4e735961ra9ee8008be0d33db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 08:54:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZLrv-0004bR-A0
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 08:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946000AbXDEGyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 02:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946007AbXDEGyn
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 02:54:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54521 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946000AbXDEGyl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 02:54:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZLrf-0006IW-KO; Thu, 05 Apr 2007 02:54:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AB21A20FBAE; Thu,  5 Apr 2007 02:54:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <56b7f5510704041555q4e735961ra9ee8008be0d33db@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43801>

Dana How <danahow@gmail.com> wrote:
> it's not clear to me that
> the mmap window code works on 32b systems
> with >2GB-sized objects in packs.

Hmmph.  Depends on the system.

For glibc we do try to set _FILE_OFFSET_BITS to 64, so that
even on 32 bit glibcs we pick up a 64 bit off_t.  But really old
glibcs won't have any 64 bit off_t support no matter what we do.
And some systems don't know what _FILE_OFFSET_BITS is, so they
give us whatever size off_t they want.

Forget mmap.  In a 32 bit off_t case there is absolutely no way
that open_packed_git_1 can verify the packfile signature (last
20 bytes) against the index if the packfile is larger than 2 GiB.
In this case we will have an off_t that is negative, subtract 20
from it, and its still probably negative.  I doubt SEEK_SET will
like a negative offset.  This of course assumes that the earlier
fstat call actually succeeded on such a file a large file with
such a small off_t.

If we get through that open_packed_git_1 and actually verify the
signature, we either have some random sequence in the middle of the
packfile that matches the signature in the index (sort of unlikely),
or our off_t is actually large enough to handle the window position
tests that the use_pack and in_window functions perform.  In this
latter case we shouldn't have any problems with the mmap code.

-- 
Shawn.
