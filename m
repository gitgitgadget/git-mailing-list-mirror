From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Fri, 29 Apr 2005 12:12:08 -0700
Message-ID: <20050429191207.GX21897@waste.org>
References: <20050426004111.GI21897@waste.org> <Pine.LNX.4.58.0504251859550.18901@ppc970.osdl.org> <20050429060157.GS21897@waste.org> <3817.10.10.10.24.1114756831.squirrel@linux1> <20050429074043.GT21897@waste.org> <Pine.LNX.4.58.0504290728090.18901@ppc970.osdl.org> <20050429163705.GU21897@waste.org> <Pine.LNX.4.58.0504291006450.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262897AbVD2TOT@vger.kernel.org Fri Apr 29 21:15:36 2005
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262897AbVD2TOT@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRaxH-0007cp-4E
	for glk-linux-kernel@gmane.org; Fri, 29 Apr 2005 21:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbVD2TOT (ORCPT <rfc822;glk-linux-kernel@m.gmane.org>);
	Fri, 29 Apr 2005 15:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVD2TNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:13:40 -0400
Received: from waste.org ([216.27.176.166]:25995 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262892AbVD2TMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:12:14 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j3TJC8o3010467
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 29 Apr 2005 14:12:08 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j3TJC8Kt010464;
	Fri, 29 Apr 2005 14:12:08 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504291006450.18901@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040907i
X-Virus-Scanned: by amavisd-new
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 10:09:38AM -0700, Linus Torvalds wrote:
> 
> 
> On Fri, 29 Apr 2005, Matt Mackall wrote:
> > 
> > That's because no one paid attention until I posted performance
> > numbers comparing it to git! Mercurial's goals are:
> > 
> > - to scale to the kernel development process
> > - to do clone/pull style development
> > - to be efficient in CPU, memory, bandwidth, and disk space
> >   for all the common SCM operations
> > - to have strong repo integrity
> 
> Ok, sounds good. Have you looked at how it scales over time, ie what 
> happens with files that have a lot of delta's?

I've done things like 10000 commits of a pair of revisions to printk.c
and it maintains consistently high speed and compression throughout that
range. I've also done things like commit all 500 revisions of
linux/Makefile from bkcvs. This took a couple seconds and resulted in
an 88k repo file (bkcvs takes 250k).

I haven't tried the whole kernel history corpus yet, but I've
committed all the 2.6 releases without any difficulties popping up and
I've had handling >1M total file revisions in my head since I sat down
to work on it. I'll maybe take a stab at a full history import next
week, if vacation doesn't interfere too much.

One downside Mercurial has is that long-lived repos can get fragmented on
disk. Things get defragmented to some extent as you go by doing COW on
files that are shared between local branches clones. Also a complete
defrag is a simple cp -a or equivalent, so I think this is not a big
deal.

Here's an excerpt from http://selenic.com/mercurial/notes.txt on how
the back-end works.

---

Revlogs:

The fundamental storage type in Mercurial is a "revlog". A revlog is
the set of all revisions to a file. Each revision is either stored
compressed in its entirety or as a compressed binary delta against the
previous version. The decision of when to store a full version is made
based on how much data would be needed to reconstruct the file. This
lets us ensure that we never need to read huge amounts of data to
reconstruct a file, regardless of how many revisions of it we store.

In fact, we should always be able to do it with a single read,
provided we know when and where to read. This is where the index comes
in. Each revlog has an index containing a special hash (nodeid) of the
text, hashes for its parents, and where and how much of the revlog
data we need to read to reconstruct it. Thus, with one read of the
index and one read of the data, we can reconstruct any version in time
proportional to the file size.

Similarly, revlogs and their indices are append-only. This means that
adding a new version is also O(1) seeks.

Generally revlogs are used to represent revisions of files, but they
also are used to represent manifests and changesets.

-- 
Mathematics is the supreme nostalgia of our time.
