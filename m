From: Willy Tarreau <w@1wt.eu>
Subject: Re: How git affects kernel.org performance
Date: Sun, 7 Jan 2007 09:55:26 +0100
Message-ID: <20070107085526.GR24090@1wt.eu>
References: <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 09:56:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3TpI-00025n-TC
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 09:56:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbXAGI4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 03:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbXAGI4S
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 03:56:18 -0500
Received: from 1wt.eu ([62.212.114.60]:1803 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932409AbXAGI4R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 03:56:17 -0500
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36137>

On Sat, Jan 06, 2007 at 09:39:42PM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 6 Jan 2007, H. Peter Anvin wrote:
> > 
> > During extremely high load, it appears that what slows kernel.org down more
> > than anything else is the time that each individual getdents() call takes.
> > When I've looked this I've observed times from 200 ms to almost 2 seconds!
> > Since an unpacked *OR* unpruned git tree adds 256 directories to a cleanly
> > packed tree, you can do the math yourself.
> 
> "getdents()" is totally serialized by the inode semaphore. It's one of the 
> most expensive system calls in Linux, partly because of that, and partly 
> because it has to call all the way down into the filesystem in a way that 
> almost no other common system call has to (99% of all filesystem calls can 
> be handled basically at the VFS layer with generic caches - but not 
> getdents()).
> 
> So if there are concurrent readdirs on the same directory, they get 
> serialized. If there is any file creation/deletion activity in the 
> directory, it serializes getdents(). 
> 
> To make matters worse, I don't think it has any read-ahead at all when you 
> use hashed directory entries. So if you have cold-cache case, you'll read 
> every single block totally individually, and serialized. One block at a 
> time (I think the non-hashed case is likely also suspect, but that's a 
> separate issue)
> 
> In other words, I'm not at all surprised it hits on filldir time. 
> Especially on ext3.

At work, we had the same problem on a file server with ext3. We use rsync
to make backups to a local IDE disk, and we noticed that getdents() took
about the same time as Peter reports (0.2 to 2 seconds), especially in
maildir directories. We tried many things to fix it with no result,
including enabling dirindexes. Finally, we made a full backup, and switched
over to XFS and the problem totally disappeared. So it seems that the
filesystem matters a lot here when there are lots of entries in a
directory, and that ext3 is not suitable for usages with thousands
of entries in directories with millions of files on disk. I'm not
certain it would be that easy to try other filesystems on kernel.org
though :-/

Willy
