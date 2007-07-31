From: Craig Boston <craig@olyun.gank.org>
Subject: Re: Efficient way to import snapshots?
Date: Mon, 30 Jul 2007 20:17:07 -0500
Message-ID: <20070731011707.GA91930@nowhere>
References: <20070730180710.GA64467@nowhere> <alpine.LFD.0.999.0707301144180.4161@woody.linux-foundation.org> <20070730192922.GB64467@nowhere> <alpine.LFD.0.999.0707301240330.4161@woody.linux-foundation.org> <20070730222028.GE64467@nowhere> <alpine.LFD.0.999.0707301629230.4161@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 31 03:17:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFgMM-00034h-Eq
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 03:17:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937347AbXGaBRL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 21:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755146AbXGaBRL
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 21:17:11 -0400
Received: from ion.gank.org ([69.55.238.164]:3385 "EHLO ion.gank.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756006AbXGaBRK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 21:17:10 -0400
Received: by ion.gank.org (Postfix, from userid 1001)
	id 00D0A110F0; Mon, 30 Jul 2007 20:17:07 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0707301629230.4161@woody.linux-foundation.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54301>

On Mon, Jul 30, 2007 at 04:30:22PM -0700, Linus Torvalds wrote:
> > # On branch cvs_RELENG_4
> > nothing to commit (working directory clean)
> > git: 67.65 seconds
> 
> So I _seriously_ hope that about 65 of those 67 seconds was the "cvs 
> update -d" or something like that. 

No, the only thing included in that is

git ls-files -o | git update-index --add --stdin
git commit -a -m "${COMMITMSG}"

> Anything that takes a minute in git is way way *way* too slow. Any 
> half-way normal git operations should take less than a second.

That said, I don't think it's git's fault.  I think most of the time is
spent calling stat() on all the files.  The machine that took 60 seconds
isn't what I'd call top-of-the-line:

1st or maybe 2nd-gen Willamette CPU
512MB memory (stupid motherboard that won't accept more)
Slow disks in RAID-5 configuration
Running ZFS with less than half of the recommended minimum memory, to
the point where I had to reduce the number of vnodes that the kernel is
allowed to cache to avoid running out of KVA

A simple find(1) over the CVS checkout directory takes almost as long.
I don't think it has enough memory to cache the whole thing.  Actually I
know it can't since maxvnodes is set to 25,000 and there's 37,000 files
in the cvs checkout, so it will have to pull some directory entries from
disk regardless.

Just to be sure, I copied the cvs checkout directory and git repository
to a newer, faster dual-core machine with plenty of memory available for
caching.

The first run of 'git status' (cold cache):
git status  1.08s user 3.68s system 13% cpu 34.043 total

The second run:
git status  1.05s user 2.68s system 85% cpu 4.373 total

Based on that I'm fairly confident that most of the 60 seconds is being
spent waiting on data from the disks.  On a tmpfs filesystem I can get
it even faster (1.897 seconds)

As it's a file server for which network is the usual bottleneck, and all
the git operations will be running out of cron, I'm not too worried
about it.

Craig
