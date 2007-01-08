From: Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: How git affects kernel.org performance
Date: Mon, 8 Jan 2007 08:35:55 +0530
Message-ID: <20070108030555.GA7289@in.ibm.com>
References: <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org>
Reply-To: suparna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Willy Tarreau <w@1wt.eu>, Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-From: linux-ext4-owner@vger.kernel.org Mon Jan 08 04:02:53 2007
Return-path: <linux-ext4-owner@vger.kernel.org>
Envelope-to: gcfe-linux-ext4@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3kmi-0006RC-Uy
	for gcfe-linux-ext4@gmane.org; Mon, 08 Jan 2007 04:02:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030464AbXAHDCt (ORCPT <rfc822;gcfe-linux-ext4@m.gmane.org>);
	Sun, 7 Jan 2007 22:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030465AbXAHDCt
	(ORCPT <rfc822;linux-ext4-outgoing>); Sun, 7 Jan 2007 22:02:49 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:37324 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030458AbXAHDCr (ORCPT
	<rfc822;linux-ext4@vger.kernel.org>); Sun, 7 Jan 2007 22:02:47 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id l0831fMC018939;
	Sun, 7 Jan 2007 22:01:41 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id l0832jc1537104;
	Sun, 7 Jan 2007 20:02:45 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id l0832iPa011122;
	Sun, 7 Jan 2007 20:02:45 -0700
Received: from qubit.in.ibm.com ([9.124.31.47])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id l0832g1C011069;
	Sun, 7 Jan 2007 20:02:43 -0700
Received: from qubit.in.ibm.com (localhost.localdomain [127.0.0.1])
	by qubit.in.ibm.com (Postfix) with ESMTP id F312E67FFD;
	Mon,  8 Jan 2007 08:37:18 +0530 (IST)
Received: (from suparna@localhost)
	by qubit.in.ibm.com (8.13.1/8.13.1/Submit) id l08361wU016491;
	Mon, 8 Jan 2007 08:36:01 +0530
To: Andrew Morton <akpm@osdl.org>
Content-Disposition: inline
In-Reply-To: <20070107011542.3496bc76.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36229>

On Sun, Jan 07, 2007 at 01:15:42AM -0800, Andrew Morton wrote:
> On Sun, 7 Jan 2007 09:55:26 +0100
> Willy Tarreau <w@1wt.eu> wrote:
> 
> > On Sat, Jan 06, 2007 at 09:39:42PM -0800, Linus Torvalds wrote:
> > >
> > >
> > > On Sat, 6 Jan 2007, H. Peter Anvin wrote:
> > > >
> > > > During extremely high load, it appears that what slows kernel.org down more
> > > > than anything else is the time that each individual getdents() call takes.
> > > > When I've looked this I've observed times from 200 ms to almost 2 seconds!
> > > > Since an unpacked *OR* unpruned git tree adds 256 directories to a cleanly
> > > > packed tree, you can do the math yourself.
> > >
> > > "getdents()" is totally serialized by the inode semaphore. It's one of the
> > > most expensive system calls in Linux, partly because of that, and partly
> > > because it has to call all the way down into the filesystem in a way that
> > > almost no other common system call has to (99% of all filesystem calls can
> > > be handled basically at the VFS layer with generic caches - but not
> > > getdents()).
> > >
> > > So if there are concurrent readdirs on the same directory, they get
> > > serialized. If there is any file creation/deletion activity in the
> > > directory, it serializes getdents().
> > >
> > > To make matters worse, I don't think it has any read-ahead at all when you
> > > use hashed directory entries. So if you have cold-cache case, you'll read
> > > every single block totally individually, and serialized. One block at a
> > > time (I think the non-hashed case is likely also suspect, but that's a
> > > separate issue)
> > >
> > > In other words, I'm not at all surprised it hits on filldir time.
> > > Especially on ext3.
> >
> > At work, we had the same problem on a file server with ext3. We use rsync
> > to make backups to a local IDE disk, and we noticed that getdents() took
> > about the same time as Peter reports (0.2 to 2 seconds), especially in
> > maildir directories. We tried many things to fix it with no result,
> > including enabling dirindexes. Finally, we made a full backup, and switched
> > over to XFS and the problem totally disappeared. So it seems that the
> > filesystem matters a lot here when there are lots of entries in a
> > directory, and that ext3 is not suitable for usages with thousands
> > of entries in directories with millions of files on disk. I'm not
> > certain it would be that easy to try other filesystems on kernel.org
> > though :-/
> >
> 
> Yeah, slowly-growing directories will get splattered all over the disk.
> 
> Possible short-term fixes would be to just allocate up to (say) eight
> blocks when we grow a directory by one block.  Or teach the
> directory-growth code to use ext3 reservations.
> 
> Longer-term people are talking about things like on-disk rerservations.
> But I expect directories are being forgotten about in all of that.

By on-disk reservations, do you mean persistent file preallocation ? (that
is explicit preallocation of blocks to a given file) If so, you are
right, we haven't really given any thought to the possibility of directories
needing that feature.

Regards
Suparna

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ext4" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India
