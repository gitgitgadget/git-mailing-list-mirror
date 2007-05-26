From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sat, 26 May 2007 13:30:46 -0400
Message-ID: <20070526173046.GW28023@spearce.org>
References: <20070526052419.GA11957@spearce.org> <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dana How <danahow@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 20:41:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from [129.240.10.15] (helo=pat.uio.no)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs16j-000382-0P
	for gcvg-git@gmane.org; Sat, 26 May 2007 20:35:17 +0200
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.66)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Hs09p-0005ic-TK
	for gcvg-git@gmane.org; Sat, 26 May 2007 19:34:25 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.66)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Hs09m-0005BD-6J
	for gcvg-git@gmane.org; Sat, 26 May 2007 19:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbXEZRav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 13:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758044AbXEZRav
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 13:30:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54524 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757987AbXEZRau (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 13:30:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hs06C-0002Qd-Il; Sat, 26 May 2007 13:30:40 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4BE3620FBAE; Sat, 26 May 2007 13:30:46 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>
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
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.5, required=12.0, autolearn=disabled, AWL=1.500,UIO_VGER=-3)
X-UiO-Scanned: 1225EC7AC2D1189E8E0D92F01D3FD17DF4A3CFDE
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -14 maxlevel 200 minaction 2 bait 0 mail/h: 40 total 249572 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48481>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> >  This conflicts (in a subtle way) with Dana How's
> >  "sha1_file.c:rearrange_packed_git() should consider packs' object
> >  sizes" patch as we now have num_objects = 0 for any indexes we
> >  have not opened.  In the case of Dana's patch this would cause
> >  those packfiles to have very high ranks, possibly sorting much
> >  later than they should have.
> 
> I am keeping that rearrange stuff on hold, partly because I am
> moderately hesitant to do the fp, which feels overkill at that
> low level of code.

Yea, I've actually been having similiar thoughts.
 
> Also, I am hoping that we can discard that the object density
> criteria altogether by making the default repack behaviour
> friendlier to the pathological cases, e.g. by emitting huge
> blobs at the end of the packstream, potentially pushing it out
> to later parts of split packs by themselves and automatically
> marking them with the .keep flag.  Until that kind of
> improvements materialize, people with pathological cases could
> (1) handcraft a pack that contains only megablob, (2) place that
> on central alternate, (3) touch it with artificially old
> timestamp, which hopefully is a good enough workaround.

Right, I was having the same idea.  If we have pack-objects just
shuffle the really big stuff to the end of its object list they
will naturally fall into the end of the packfile, and the split
out packfiles.  Then if we do the mtime flipping you suggested
earlier right before we exit pack-objects the larger blob packs
will automatically sort behind the smaller commit/tree packs.
No fp needed.

My patch was exactly because I did what you say above; I handcrafted
a pack that contains only large-ish blobs, placed them into a
central repo, and connected it by alternates.  Because of the
local flag logic it is automatically behind my commit/tree pack.
But I also rarely (if ever) have to access that megablob packfile.
Yet the .idx was still being opened.  On Cygwin/Windows that penalty
is high enough to have almost doubled the running time of a simple
"git show".

-- 
Shawn.
