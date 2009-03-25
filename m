From: Steven French <sfrench@us.ibm.com>
Subject: Re: fatal: unable to write sha1 file git 1.6.2.1
Date: Tue, 24 Mar 2009 19:17:34 -0500
Message-ID: <OFBC676D76.DF7BF27E-ON87257584.0000C3CB-86257584.0001BE68@us.ibm.com>
References: <20090324193506.0962b28e@tupile.poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter <vmail@mycircuit.org>
To: Jeff Layton <jlayton@redhat.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 01:19:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmGps-0000jW-A3
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 01:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971AbZCYARj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 20:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755890AbZCYARj
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 20:17:39 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:37507 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774AbZCYARi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 20:17:38 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2P0G9ct005237
	for <git@vger.kernel.org>; Tue, 24 Mar 2009 18:16:09 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id n2P0HamF222740
	for <git@vger.kernel.org>; Tue, 24 Mar 2009 18:17:36 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.13.1/8.13.3) with ESMTP id n2P0HfWn005825
	for <git@vger.kernel.org>; Tue, 24 Mar 2009 18:17:42 -0600
Received: from d03nm123.boulder.ibm.com (d03nm123.boulder.ibm.com [9.17.195.149])
	by d03av06.boulder.ibm.com (8.13.1/8.12.11) with ESMTP id n2P0Hf1M005822;
	Tue, 24 Mar 2009 18:17:41 -0600
In-Reply-To: <20090324193506.0962b28e@tupile.poochiereds.net>
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 8.0.1|February 07, 2008) at
 03/24/2009 18:17:35,
	Serialize complete at 03/24/2009 18:17:35
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114522>

Jeff Layton <jlayton@redhat.com> wrote on 03/24/2009 06:35:06 PM:

> On Tue, 24 Mar 2009 15:30:38 -0700 (PDT)
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > 
> > 
> > On Tue, 24 Mar 2009, Peter wrote:
> > > > 
> > > > What OS? What filesystem? Are you perhaps running out of space?
> > > 
> > > Its Lenny Debian 5.0.0, Diskspace is ample . Filesystem is cifs 
> ( this is a
> > > windows 2000 share mounted with samba in a VMware Workstation 
> Debian client (
> > > yes, I know ... )). Memory usage, according to htop, is constant
> = 140/504 MB
> > > during the whole process until git fails.
> > 
> > Ok, it sounds very much like a possible CIFS problem. 
> > 
> > Getting the exact error code for the "close()" will be interesting, 
> > because the only thing that can return an error under Linux in close() 
is 
> > if the filesystem "->flush()" function fails with an error.
> > 
> > In cifs, the cifs_flush() thing does a filemap_fdatawrite(), forcing 
the 
> > data out, and that in turn calls do_writepages() which in turn calls 
> > either generic_writepages() or cifs_writepages() depending on random 
cifs 
> > crap.
> > 
> > I'm not seeing any obvious errors there. But I would _not_ be 
surprised if 
> > the fchmod(fd, 0444) that we did before the close could be causing 
this: 
> > cifs gets confused and thinks that it must not write to the file 
because 
> > the file has been turned read-only.
> > 
> > Here's an idea: if this is reproducible for you, does the behavior 
change 
> > if you do
> > 
> >    [core]
> >       core.fsyncobjectfiles = true
> > 
> > in your .git/config file? That causes git to always fsync() the 
written 
> > data _before_ it does that fchmod(), which in turn means that by the 
time 
> > the close() rolls around, there should be no data to write, and thus 
no 
> > possibility that anybody gets confused when there is still dirty data 
on a 
> > file that has been marked read-only.
> > 
> > Anyway, I'm cc'ing Steve French and Jeff Layton, as the major CIFS 
go-to 
> > guys. It does seem like a CIFS bug is likely.
> > 
> > Steve, Jeff: git does basically
> > 
> >    open(".git/objects/xy/tmp_obj_xyzzy", O_RDWR|O_CREAT|O_EXCL, 0600) 
= 5
> >    write(5, ".."..., len)
> >    fchmod(5, 0444)
> >    close(5)
> >    link(".git/objects/xy/tmp_obj_xyzzy", ".git/objects/xy/xyzzy");
> >    unlink(".git/objects/xy/tmp_obj_xyzzy");
> > 
> > to write a new datafile. Under CIFS, that "close()" apparently 
sometimes 
> > returns with an error, and fails.
> > 
> > I guess we could change the "fchmod()" to happen after the close(), 
just 
> > to make it easier for filesystems to get this right. And yes, as 
outlined 
> > above, there's a config option to make git use fdatasync() before it 
does 
> > that fchmod() too. But it does seem like CIFS is just buggy.
> > 
> > If CIFS has problems with the above sequence (say, if some timeout 
> > refreshes the inode data or causes a re-connect with the server or 
> > whatever), then maybe cifs should always do an implicit fdatasync() 
when 
> > doing fchmod(), just to make sure that the fchmod won't screw up any 
> > cached dirty data?
> > 
> 
> Yes. That's probably the right thing to do here. This is looks like a
> regression that I introduced some time ago in
> cea218054ad277d6c126890213afde07b4eb1602. Before that delta we always
> flushed all the data before doing any setattr. After that delta, we
> just did it on size changes. In a later commit, Steve fixed it so that
> it got done on ATTR_MTIME too.
> 
> We can easily change the cifs_setattr variants to flush all the dirty
> data on ATTR_MODE changes, and maybe even change it to only flush on
> certain ATTR_MODE changes, like when we're clearing all the write bits.
> 
> I wonder though whether that's sufficient. If we're changing ownership
> for instance, will we hit the same issue? Maybe the safest approach is
> just to go back to flushing on any setattr call.
> 
> Steve, thoughts?

Flushing on all setattr calls seems excessive, but the case of
fchmod(0444) followed by close should not require it, and should
work over cifs unless the tcp socket drops between the chmod
and the close/flush (requiring reconnection and reopening
the file handle).  For the normal case, the chmod should not
matter, since for cifs, unlike NFSv3, there is a network
open operation and access checks are done on the open call, and 
you already have the file open for write).  If /proc/fs/cifs/Stats
shows the number of reconnects as 0, then we don't have the case 
of dropping the network between chmod and flush/close.  Since certain
writebehind errors (in writepages) can not be returned to the application
until flush/close, it is just as likely that what you are seeing is
an error from a previous failed write.  The logic for handling
errors in cifs_writepages is much better in recent kernels.

What is the kernel version?

Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench at-sign us dot ibm dot com
