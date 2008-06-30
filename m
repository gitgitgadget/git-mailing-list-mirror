From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pread() over NFS (again) [1.5.5.4]
Date: Sun, 29 Jun 2008 20:32:03 -0400
Message-ID: <20080630003203.GJ11793@spearce.org>
References: <6F25C1B4-85DE-4559-9471-BCD453FEB174@gmail.com> <20080626204606.GX11793@spearce.org> <7vskuzq5ix.fsf@gitster.siamese.dyndns.org> <65688C06-BB6A-4E95-A4B9-A1A7C206BE2E@sent.com> <7vhcbfojgf.fsf@gitster.siamese.dyndns.org> <20080627025715.GB19568@fieldses.org> <1214578229.7437.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>, logank@sent.com,
	Christian Holtje <docwhat@gmail.com>, git@vger.kernel.org,
	Trond Myklebust <trond@netapp.com>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 02:33:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD7KS-0007TV-AW
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 02:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbYF3AcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 20:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbYF3AcP
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 20:32:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36492 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbYF3AcO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 20:32:14 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KD7JD-0006jV-3j; Sun, 29 Jun 2008 20:31:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 41AEE20FBAE; Sun, 29 Jun 2008 20:32:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1214578229.7437.14.camel@localhost>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86851>

Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
> On Thu, 2008-06-26 at 22:57 -0400, J. Bruce Fields wrote:
> > On Thu, Jun 26, 2008 at 04:38:40PM -0700, Junio C Hamano wrote:
> > > logank@sent.com writes:
> > > 
> > > > On Jun 26, 2008, at 1:56 PM, Junio C Hamano wrote:
> > > >
> > > >>> "The file shouldn't be short unless someone truncated it, or there
> > > >>> is a bug in index-pack.  Neither is very likely, but I don't think
> > > >>> we would want to retry pread'ing the same block forever.
> > > >>
> > > >> I don't think we would want to retry even once.  Return value of 0
> > > >> from
> > > >> pread is defined to be an EOF, isn't it?
> > > >
> > > > No, it seems to be a simple error-out in this case. We have 2.4.20
> > > > systems with nfs-utils 0.3.3 and used to frequently get the same error
> > > > while pushing. I made a similar change back in February and haven't
> > > > had a problem since:
> > > >
> > > > diff --git a/index-pack.c b/index-pack.c
> > > > index 5ac91ba..85c8bdb 100644
> > > > --- a/index-pack.c
> > > > +++ b/index-pack.c
> > > > @@ -313,7 +313,14 @@ static void *get_data_from_pack(struct
> > > > object_entry *obj)
> > > > 	src = xmalloc(len);
> > > > 	data = src;
> > > > 	do {
> > > > +		// It appears that if multiple threads read across NFS, the
> > > > +		// second read will fail. I know this is awful, but we wait for
> > > > +		// a little bit and try again.
> > > > 		ssize_t n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
> > > > +		if (n <= 0) {
> > > > +			sleep(1);
> > > > +			n = pread(pack_fd, data + rdy, len - rdy, from + rdy);
> > > > +		}
> > > > 		if (n <= 0)
> > > > 			die("cannot pread pack file: %s", strerror(errno));
> > > > 		rdy += n;
> > > >
> > > > I use a sleep request since it seems less likely that the other thread
> > > > will have an outstanding request after a second of waiting.
> > > 
> > > Gaah.  Don't we have NFS experts in house?  Bruce, perhaps?
> > 
> > Trond, you don't have any idea why a 2.6.9-42.0.8.ELsmp client (2.4.28
> > server) might be returning spurious 0's from pread()?
> > 
> > Seems like everything is happening from that one client--the file isn't
> > being simultaneously accessed from the server or from another client.
> 
> Is the file only being read, or could there be a simultaneous write to
> the same file? I'm surmising this could be an effect resulting from
> simultaneous cache invalidations: prior to Linux 2.6.20 or so, we
> weren't rigorously following the VFS/VM rules for page locking, and so
> page cache invalidation in particular could have some curious
> side-effects.

The file was created and opened O_CREAT|O_EXCL|O_RDWR, by this
process, written linearly using write(2), without any lseeks.
We kept the file descriptor open and starting issuing pread(2)
calls for earlier offsets we had alread written.  One of those
kicks back EOF far too early (and results in this bug report).

Note the only accesses we are using is write(2) and pread(2), and
once we start reading we don't ever go back to writing.  The pread(2)
calls are typically issued in ascending offsets, and we read each
position only once.  This is to try and take advantage of any
read-ahead the kernel may be able to do.  The pread(2) calls are
rarely (if ever) on a block/page boundary.

Nobody else should know about this file. Its written to a temporary
name and no other well behaved processes would attempt to read
the file until it gets closed and renamed to its final destination.
We haven't reached that far in the processing when we get this error,
so there should be only one file descriptor open on the inode, and
its the same one that wrote the data.

-- 
Shawn.
