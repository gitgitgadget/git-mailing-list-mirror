From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Sat, 30 Apr 2005 08:20:15 -0700
Message-ID: <20050430152014.GI21897@waste.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <20050429203027.GK17379@opteron.random> <20050429203959.GC21897@waste.org> <20050430025211.GP17379@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 17:15:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRtgg-0000td-2N
	for gcvg-git@gmane.org; Sat, 30 Apr 2005 17:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVD3PUq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Apr 2005 11:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVD3PUq
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Apr 2005 11:20:46 -0400
Received: from waste.org ([216.27.176.166]:52658 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261248AbVD3PUZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2005 11:20:25 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j3UFKFC3012902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 30 Apr 2005 10:20:15 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j3UFKF8G012891;
	Sat, 30 Apr 2005 10:20:15 -0500
To: Andrea Arcangeli <andrea@suse.de>
Content-Disposition: inline
In-Reply-To: <20050430025211.GP17379@opteron.random>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 30, 2005 at 04:52:11AM +0200, Andrea Arcangeli wrote:
> On Fri, Apr 29, 2005 at 01:39:59PM -0700, Matt Mackall wrote:
> > Mercurial is ammenable to rsync provided you devote a read-only
> > repository to it on the client side. In other words, you rsync from
> > kernel.org/mercurial/linus to local/linus and then you merge from
> > local/linus to your own branch. Mercurial's hashing hierarchy is
> > similar to git's (and Monotone's), so you can sign a single hash of
> > the tree as well.
> 
> Ok fine. It's also interesting how you already enabled partial transfers
> through http.
> 
> Please apply this patch so it doesn't fail on my setup ;)
> 
> --- mercurial-0.4b/hg.~1~	2005-04-29 02:52:52.000000000 +0200
> +++ mercurial-0.4b/hg	2005-04-30 00:53:02.000000000 +0200
> @@ -1,4 +1,4 @@
> -#!/usr/bin/python
> +#!/usr/bin/env python

Done.

> On a bit more technical side, one thing I'm wondering about is the
> compression. If I change mercurial like this:
> 
> --- revlog.py.~1~	2005-04-29 01:33:14.000000000 +0200
> +++ revlog.py	2005-04-30 03:54:12.000000000 +0200
> @@ -11,9 +11,11 @@
>  import zlib, struct, mdiff, sha, binascii, os, tempfile
>  
>  def compress(text):
> +    return text
>      return zlib.compress(text)
>  
>  def decompress(bin):
> +    return text
>      return zlib.decompress(bin)
>  
>  def hash(text):
> 
> 
> the .hg directory sizes changes from 167M to 302M _BUT_ the _compressed_
> size of the .hg directory (i.e. like in a full network transfer with
> rsync -z or a tar.gz backup) changes from 55M to 38M:
> 
> andrea@opteron:~/devel/kernel> du -sm hg-orig hg-aa hg-orig.tar.bz2 hg-aa.tar.bz2 
> 167     hg-orig
> 302     hg-aa
> 55      hg-orig.tar.bz2
> 38      hg-aa.tar.bz2
> ^^^^^^^^^^^^^^^^^^^^^ 38M backup and network transfer is what I want
> 
> So I don't really see an huge benefit in compression, other than to
> slowdown the checkins measurably [i.e. what Linus doesn't want] (the
> time of compression is a lot higher than the time of python runtime during
> checkin, so it's hard to believe your 100% boost with psyco in the hg file,
> sometime psyco doesn't make any difference infact, I'd rather prefer people to
> work on the real thing of generating native bytecode at compile time, rather
> than at runtime, like some haskell compiler can do).

Most of that psyco speed up is accelerating subsequent diffs in
difflib, which you probably didn't hit yet.

> mercurial is already good at decreasing the entropy by using an efficient
> storage format, it doesn't need to cheat by putting compression on each blob
> that can only leads to bad ratios when doing backups and while transferring
> more than one blob through the network.
> 
> So I suggest to try disabling compression optionally, perhaps it'll be even
> faster than git in the initial checkin that way! No need of compressing or
> decompressing anything with mercurial (unlike with git that would explode
> without control w/o compression).

I can make it some sort of environment variable, sure. I think the
speed is already in a domain where it's not a big deal though. There
are other things to do first, like unifying the merge/commit/update
code.

> Http is not intended for maximal efficiency, it's there just to make
> life easy. special protocol with zlib is required for maximum
> efficiency.

Yeah, I've got a plan here.

> You also should move the .py into a hg directory, so that they won't
> pollute the site-packages.

Yep, I'm rather new to actually packaging my Python hacks.

-- 
Mathematics is the supreme nostalgia of our time.
