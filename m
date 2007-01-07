From: Andrew Morton <akpm@osdl.org>
Subject: Re: How git affects kernel.org performance
Date: Sun, 7 Jan 2007 01:15:42 -0800
Message-ID: <20070107011542.3496bc76.akpm@osdl.org>
References: <20061216094421.416a271e.randy.dunlap@oracle.com>
	<20061216095702.3e6f1d1f.akpm@osdl.org>
	<458434B0.4090506@oracle.com>
	<1166297434.26330.34.camel@localhost.localdomain>
	<1166304080.13548.8.camel@nigel.suspend2.net>
	<459152B1.9040106@zytor.com>
	<1168140954.2153.1.camel@nigel.suspend2.net>
	<45A08269.4050504@zytor.com>
	<45A083F2.5000000@zytor.com>
	<Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
	<20070107085526.GR24090@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-From: linux-ext4-owner@vger.kernel.org Sun Jan 07 10:16:38 2007
Return-path: <linux-ext4-owner@vger.kernel.org>
Envelope-to: gcfe-linux-ext4@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3U8r-0006YO-Ue
	for gcfe-linux-ext4@gmane.org; Sun, 07 Jan 2007 10:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932451AbXAGJQg (ORCPT <rfc822;gcfe-linux-ext4@m.gmane.org>);
	Sun, 7 Jan 2007 04:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbXAGJQg
	(ORCPT <rfc822;linux-ext4-outgoing>); Sun, 7 Jan 2007 04:16:36 -0500
Received: from smtp.osdl.org ([65.172.181.24]:43926 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932436AbXAGJQe (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
	Sun, 7 Jan 2007 04:16:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l079FhWi015212
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 7 Jan 2007 01:15:43 -0800
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id l079FgZm014388;
	Sun, 7 Jan 2007 01:15:42 -0800
To: Willy Tarreau <w@1wt.eu>
In-Reply-To: <20070107085526.GR24090@1wt.eu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
X-Spam-Status: No, hits=-0.526 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36140>

On Sun, 7 Jan 2007 09:55:26 +0100
Willy Tarreau <w@1wt.eu> wrote:

> On Sat, Jan 06, 2007 at 09:39:42PM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Sat, 6 Jan 2007, H. Peter Anvin wrote:
> > > 
> > > During extremely high load, it appears that what slows kernel.org down more
> > > than anything else is the time that each individual getdents() call takes.
> > > When I've looked this I've observed times from 200 ms to almost 2 seconds!
> > > Since an unpacked *OR* unpruned git tree adds 256 directories to a cleanly
> > > packed tree, you can do the math yourself.
> > 
> > "getdents()" is totally serialized by the inode semaphore. It's one of the 
> > most expensive system calls in Linux, partly because of that, and partly 
> > because it has to call all the way down into the filesystem in a way that 
> > almost no other common system call has to (99% of all filesystem calls can 
> > be handled basically at the VFS layer with generic caches - but not 
> > getdents()).
> > 
> > So if there are concurrent readdirs on the same directory, they get 
> > serialized. If there is any file creation/deletion activity in the 
> > directory, it serializes getdents(). 
> > 
> > To make matters worse, I don't think it has any read-ahead at all when you 
> > use hashed directory entries. So if you have cold-cache case, you'll read 
> > every single block totally individually, and serialized. One block at a 
> > time (I think the non-hashed case is likely also suspect, but that's a 
> > separate issue)
> > 
> > In other words, I'm not at all surprised it hits on filldir time. 
> > Especially on ext3.
> 
> At work, we had the same problem on a file server with ext3. We use rsync
> to make backups to a local IDE disk, and we noticed that getdents() took
> about the same time as Peter reports (0.2 to 2 seconds), especially in
> maildir directories. We tried many things to fix it with no result,
> including enabling dirindexes. Finally, we made a full backup, and switched
> over to XFS and the problem totally disappeared. So it seems that the
> filesystem matters a lot here when there are lots of entries in a
> directory, and that ext3 is not suitable for usages with thousands
> of entries in directories with millions of files on disk. I'm not
> certain it would be that easy to try other filesystems on kernel.org
> though :-/
> 

Yeah, slowly-growing directories will get splattered all over the disk.

Possible short-term fixes would be to just allocate up to (say) eight
blocks when we grow a directory by one block.  Or teach the
directory-growth code to use ext3 reservations.

Longer-term people are talking about things like on-disk rerservations. 
But I expect directories are being forgotten about in all of that.
