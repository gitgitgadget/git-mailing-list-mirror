From: Jeff Layton <jlayton@redhat.com>
Subject: Re: fatal: unable to write sha1 file git 1.6.2.1
Date: Tue, 24 Mar 2009 20:49:25 -0400
Message-ID: <20090324204925.7037435f@tleilax.poochiereds.net>
References: <20090324193506.0962b28e@tupile.poochiereds.net>
	<OFBC676D76.DF7BF27E-ON87257584.0000C3CB-86257584.0001BE68@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter <vmail@mycircuit.org>
To: Steven French <sfrench@us.ibm.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 01:57:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmHQM-0002af-61
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 01:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440AbZCYAvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 20:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760389AbZCYAvI
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 20:51:08 -0400
Received: from mx2.redhat.com ([66.187.237.31]:46446 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756676AbZCYAvF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 20:51:05 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n2P0nV6V015313;
	Tue, 24 Mar 2009 20:49:31 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n2P0nNBo006725;
	Tue, 24 Mar 2009 20:49:24 -0400
Received: from tleilax.poochiereds.net (vpn-13-11.rdu.redhat.com [10.11.13.11])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n2P0nRQH028062;
	Tue, 24 Mar 2009 20:49:28 -0400
In-Reply-To: <OFBC676D76.DF7BF27E-ON87257584.0000C3CB-86257584.0001BE68@us.ibm.com>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114531>

On Tue, 24 Mar 2009 19:17:34 -0500
Steven French <sfrench@us.ibm.com> wrote:

> Jeff Layton <jlayton@redhat.com> wrote on 03/24/2009 06:35:06 PM:
> 
> > On Tue, 24 Mar 2009 15:30:38 -0700 (PDT)
> > Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > > 
> > > 
> > > On Tue, 24 Mar 2009, Peter wrote:
> > > > > 
> > > > > What OS? What filesystem? Are you perhaps running out of space?
> > > > 
> > > > Its Lenny Debian 5.0.0, Diskspace is ample . Filesystem is cifs 
> > ( this is a
> > > > windows 2000 share mounted with samba in a VMware Workstation 
> > Debian client (
> > > > yes, I know ... )). Memory usage, according to htop, is constant
> > = 140/504 MB
> > > > during the whole process until git fails.
> > > 
> > > Ok, it sounds very much like a possible CIFS problem. 
> > > 
> > > Getting the exact error code for the "close()" will be interesting, 
> > > because the only thing that can return an error under Linux in close() 
> is 
> > > if the filesystem "->flush()" function fails with an error.
> > > 
> > > In cifs, the cifs_flush() thing does a filemap_fdatawrite(), forcing 
> the 
> > > data out, and that in turn calls do_writepages() which in turn calls 
> > > either generic_writepages() or cifs_writepages() depending on random 
> cifs 
> > > crap.
> > > 
> > > I'm not seeing any obvious errors there. But I would _not_ be 
> surprised if 
> > > the fchmod(fd, 0444) that we did before the close could be causing 
> this: 
> > > cifs gets confused and thinks that it must not write to the file 
> because 
> > > the file has been turned read-only.
> > > 
> > > Here's an idea: if this is reproducible for you, does the behavior 
> change 
> > > if you do
> > > 
> > >    [core]
> > >       core.fsyncobjectfiles = true
> > > 
> > > in your .git/config file? That causes git to always fsync() the 
> written 
> > > data _before_ it does that fchmod(), which in turn means that by the 
> time 
> > > the close() rolls around, there should be no data to write, and thus 
> no 
> > > possibility that anybody gets confused when there is still dirty data 
> on a 
> > > file that has been marked read-only.
> > > 
> > > Anyway, I'm cc'ing Steve French and Jeff Layton, as the major CIFS 
> go-to 
> > > guys. It does seem like a CIFS bug is likely.
> > > 
> > > Steve, Jeff: git does basically
> > > 
> > >    open(".git/objects/xy/tmp_obj_xyzzy", O_RDWR|O_CREAT|O_EXCL, 0600) 
> = 5
> > >    write(5, ".."..., len)
> > >    fchmod(5, 0444)
> > >    close(5)
> > >    link(".git/objects/xy/tmp_obj_xyzzy", ".git/objects/xy/xyzzy");
> > >    unlink(".git/objects/xy/tmp_obj_xyzzy");
> > > 
> > > to write a new datafile. Under CIFS, that "close()" apparently 
> sometimes 
> > > returns with an error, and fails.
> > > 
> > > I guess we could change the "fchmod()" to happen after the close(), 
> just 
> > > to make it easier for filesystems to get this right. And yes, as 
> outlined 
> > > above, there's a config option to make git use fdatasync() before it 
> does 
> > > that fchmod() too. But it does seem like CIFS is just buggy.
> > > 
> > > If CIFS has problems with the above sequence (say, if some timeout 
> > > refreshes the inode data or causes a re-connect with the server or 
> > > whatever), then maybe cifs should always do an implicit fdatasync() 
> when 
> > > doing fchmod(), just to make sure that the fchmod won't screw up any 
> > > cached dirty data?
> > > 
> > 
> > Yes. That's probably the right thing to do here. This is looks like a
> > regression that I introduced some time ago in
> > cea218054ad277d6c126890213afde07b4eb1602. Before that delta we always
> > flushed all the data before doing any setattr. After that delta, we
> > just did it on size changes. In a later commit, Steve fixed it so that
> > it got done on ATTR_MTIME too.
> > 
> > We can easily change the cifs_setattr variants to flush all the dirty
> > data on ATTR_MODE changes, and maybe even change it to only flush on
> > certain ATTR_MODE changes, like when we're clearing all the write bits.
> > 
> > I wonder though whether that's sufficient. If we're changing ownership
> > for instance, will we hit the same issue? Maybe the safest approach is
> > just to go back to flushing on any setattr call.
> > 
> > Steve, thoughts?
> 
> Flushing on all setattr calls seems excessive, but the case of
> fchmod(0444) followed by close should not require it, and should
> work over cifs unless the tcp socket drops between the chmod
> and the close/flush (requiring reconnection and reopening
> the file handle).  For the normal case, the chmod should not
> matter, since for cifs, unlike NFSv3, there is a network
> open operation and access checks are done on the open call, and 
> you already have the file open for write).  If /proc/fs/cifs/Stats
> shows the number of reconnects as 0, then we don't have the case 
> of dropping the network between chmod and flush/close.  Since certain
> writebehind errors (in writepages) can not be returned to the application
> until flush/close, it is just as likely that what you are seeing is
> an error from a previous failed write.  The logic for handling
> errors in cifs_writepages is much better in recent kernels.
> 
> What is the kernel version?
> 

Good point -- I stand corrected. I just gave this series of calls a quick
test against a win2k8 server:

unlink("/mnt/win2k8/testfile")          = 0
open("/mnt/win2k8/testfile", O_RDWR|O_CREAT, 0644) = 3
write(3, "\1\0\0\0\0\0\0\0\35\244@\211:\0\0\0\7\0\0\0\0\0\0\0X\r\25-\377\177\0\0`"..., 1024) = 1024
fchmod(3, 0444)                         = 0
close(3)                                = 0

Here's what it looks like on the wire (forgive the IPv6 addresses, it's
just what I had handy)...

Create the file:
  3.842955      feed::2 -> feed::8      SMB NT Create AndX Request, Path: \testfile
  3.843641      feed::8 -> feed::2      SMB NT Create AndX Response, FID: 0x4007

Set the ATTR_READONLY bit:
  3.844255      feed::2 -> feed::8      SMB Trans2 Request, SET_FILE_INFO, FID: 0x4007
  3.845070      feed::8 -> feed::2      SMB Trans2 Response, FID: 0x4007, SET_FILE_INFO

Write the data:
  3.845766      feed::2 -> feed::8      SMB Write AndX Request, FID: 0x4007, 1024 bytes at offset 0
  3.846627      feed::8 -> feed::2      SMB Write AndX Response, FID: 0x4007, 1024 bytes

Close the file:
  3.847043      feed::2 -> feed::8      SMB Close Request, FID: 0x4007
  3.847940      feed::8 -> feed::2      SMB Close Response, FID: 0x4007

...none of that errored out, even though the writes clearly hit the
server after the mode change. Either there's something else going on
here, or this server is misbehaving. It might be interesting to see a
capture.

Some info about what sort of server this is might also be helpful.

-- 
Jeff Layton <jlayton@redhat.com>
