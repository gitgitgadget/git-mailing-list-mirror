From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix random fast-import errors when compiled with NO_MMAP
Date: Sun, 20 Jan 2008 22:57:56 -0500
Message-ID: <20080121035755.GC24004@spearce.org>
References: <20080118035700.GA3458@spearce.org> <alpine.LFD.1.00.0801172013270.2957@woody.linux-foundation.org> <20080118084201.GA14763@hashpling.org> <alpine.LFD.1.00.0801180842350.2957@woody.linux-foundation.org> <7vwsq6a44w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 21 04:58:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGno9-0002Uq-HU
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 04:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204AbYAUD6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 22:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756126AbYAUD6V
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 22:58:21 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54612 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756199AbYAUD6G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 22:58:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JGnn9-0004md-M1; Sun, 20 Jan 2008 22:57:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5AFC920FBAE; Sun, 20 Jan 2008 22:57:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vwsq6a44w.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71211>

Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Btw, even with Shawn's patch, I wonder if the index_data usage is correct.
...
> So I do not think "index_data usage" can be incorrect, as there
> won't be any index_data usage with unfinalized pack, and the
> core part of git would not even have any mmap(2) (nor open fd)
> into its idx file before it is finalized.

Correct.
 
> By the way, I was quite puzzled how the gfi_unpack_entry()
> function manages to work correctly when it has to read an object
> it deltified based on another object it wrote into the same
> unfinalized pack earlier.  It knows where in the unfinalized
> pack it wrote the object, so it can find from its own "struct
> object_entry" the offset for the object, and calls
> unpack_entry() defined in the core to do the rest.
> 
> However, most of the core does not really know about the other
> objects in this half-built pack.  If the object is a delta,
> unpack_delta_entry() needs to find the delta base.  And it needs
> to do that without having the idx.
> 
> The trick (the code really needs a bit more documentation) is
> that gfi never writes anything but OFS_DELTA.  So the core, even
> though it does not have the corresponding idx file, does not
> have to look up the object (in fact it does not even know what
> object to look up for the base, it only knows the offset).

Yup.

Older fast-imports (pre OFS_DELTA) had to replicate a good chunk of
the unpack_entry() logic directly inside of fast-import.  But it
later occurred to me that OFS_DELTA simplifies the code and lets
me reuse more of the existing sha1_file.c implementation.

So yea, fast-import only emits OFS_DELTA, and does so only so that it
can pull this delta-base-unpack trick on the core, without actually
giving the core the corresponding idx file first.

-- 
Shawn.
