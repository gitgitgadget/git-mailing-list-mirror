From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Mon, 4 Sep 2006 02:44:43 -0400
Message-ID: <20060904064443.GB30032@spearce.org>
References: <Pine.LNX.4.64.0609011129270.27779@g5.osdl.org> <7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0609011721390.27779@g5.osdl.org> <7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net> <20060902045246.GB25146@spearce.org> <7vodty1swz.fsf@assigned-by-dhcp.cox.net> <20060902175408.GD27826@spearce.org> <7vhczovf6m.fsf@assigned-by-dhcp.cox.net> <20060904041052.GA29369@spearce.org> <7v3bb8qixi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 10:40:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK9zt-0002W5-0W
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 10:40:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWIDIj5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 04:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWIDIjo
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 04:39:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:19937 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932367AbWIDGox (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 02:44:53 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GK8CM-0001lc-6D; Mon, 04 Sep 2006 02:44:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 893D920E42C; Mon,  4 Sep 2006 02:44:44 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v3bb8qixi.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26404>

Junio C Hamano <junkio@cox.net> wrote:
> Now if we fix dumb transport downloaders, then we could even
> make a convention that the packs named pack-[0-9a-f]{40}.pack
> are archive packs.  And git-repack can even have a convention
> that .git/objects/pack/pack-active.(pack|idx) is the active
> pack.

Seems reasonable.

I take it you are proposing that a dumb transport always downloads
pack-active.pack as pack-n{40}.pack where the dumb protocol
downloader computed the correct pack name from its contents.  Thus
any remote pack downloaded over a dumb transport is automatically
treated as a historical pack by the receiving repository.

This will cause someone tracking a remote repository over a dumb
transport to need to repack only a subset of their historical packs
frequently into their own active.pack while leaving other historical
packs untouched.


But the more that I think about this neither solution (an active
pack symref or pack-active.pack) really solves this.  Being limited
to just one active pack seems to be a problem with at least the
dumb transports.

I think that's why I preferred the size threshold idea.  The active
packs are cheap to repack because they are small.  The larger
packs aren't cheap to repack because they are large - and probably
historical.  What we are trying to get is fast repacks for the
active objects while still getting full validation anytime we do a
repack and (possibly) destroy the source.  A size threshold does it.

When Jon Smirl and I started kicking around the idea of a historical
pack for Mozilla I was thinking of just storing a list of pack base
names in ".git/objects/pack/historical".  Packs listed there should
generally be exempt from repacking.  During an initial clone we'd
need to deliver the contents of that file to the new repository,
as if the source considers a pack historical its likely the new
repository would want to as well.

But now as I write this email I'm thinking that it may be just as
easy to change the base name of the pack to "hist-n{40}" when we
want to consider it historical.

[snipped and re-ordered]
> It first downloads the .idx files, so it can compute the
> _right_ packname using the sorted object names recorded there

Why trust the .idx?  I've seen you post that the .idx is purely
a local matter.  The "smart" Git protocol only receives the .pack
from the remote and computes the .idx locally or unpacks it to loose
objects locally; why should a dumb transport trust the remote .idx?

Oh, I know, when the .idx is >50 MiB, the .pack is >450 MiB, has
2 million objects and delta chains ~5000 long.

Are we thinking that .idx files may need to have a slightly wider
distribution than "local"?

-- 
Shawn.

-- 
VGER BF report: S 1
