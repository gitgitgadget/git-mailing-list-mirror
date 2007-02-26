From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Mon, 26 Feb 2007 18:55:10 -0500
Message-ID: <20070226235510.GF1639@spearce.org>
References: <200702261540.27080.ttelford.groups@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Troy Telford <ttelford.groups@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 00:55:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLpgf-0000bf-30
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 00:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161435AbXBZXzR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 18:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161433AbXBZXzR
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 18:55:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36200 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161435AbXBZXzO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 18:55:14 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HLpgM-0006L0-H2; Mon, 26 Feb 2007 18:55:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F089820FBAE; Mon, 26 Feb 2007 18:55:10 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <200702261540.27080.ttelford.groups@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40674>

Troy Telford <ttelford.groups@gmail.com> wrote:
> As I've not been involved with git development before, I'm
> aware that this may already be on somebody's 'todo' list.  It was an itch
> I needed to scratch, as I have a repository whose size is multiple gigabytes,
> and 'git clone' (by default) forces everything into a single
> packfile with >=git-1.5.0.
> 
> The patch introduces a new packfile index version, which adds a:
>  * header to the index file (index version info).
>  * leaves the object indexes within the index at 32-bit
>  * extends the offsets used to describe the packfile to 64-bit.
> 
> The new index format is only used when the associated  packfile 
> becomes large enough to warrant a 64-bit index; otherwise the original
> index format is used.

Clearly a good deal of work has been put into this patch.  I cannot
say that reviewed every bit of it... because...

Nico and I are neck deep in our pack version 4 topic.  That topic
hits all of the same code you touched with your patch.

Our topic also requires us to change the index file format, and
in doing so we have decided to extend the index records to look
something like the following[*1*]:

	object SHA-1
	64-bit offset within packfile
	32-bit index of next object in packfile

The latter field is to help pack-objects reuse existing packfile
data, as today it needs to sort everything on its own on the fly.
Having that last field of data will help avoid that, and will keep
the index nicely aligned for 64-bit accesses to the offset.

I want to say your patch shouldn't be merged without even bothering
to review it.  The last time I was in this part of the git code
(implementing sliding mmap window) Nico and Junio also both went in
here and rewrote huge chunks.  Their changes prevented sliding mmap
window from applying.  It was 6 months before I got back around to
rewriting the patch.

Right now I'm neck deep in pack v4.  I hope to have the topic in
pu-ready state by some time mid-next week, hopefully in time for
Junio's git day.  I'm very unlikely to have the time to rewrite the
topic again until late June/July if something like your patch goes
in now.

So would you mind waiting a couple of weeks for 64 bit indexes?


*1*: This was Nico's idea; I'm in agreement with him about it.
     The actual disk layout here has not been set in stone as we
     want to kick around different layouts before we settle on
     something final.  I'm a little unhappy with the way the above
     lays out in memory when we mmap it, for example.

-- 
Shawn.
