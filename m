From: Jeff Layton <jlayton@redhat.com>
Subject: Re: fatal: unable to write sha1 file git 1.6.2.1
Date: Tue, 24 Mar 2009 19:35:06 -0400
Message-ID: <20090324193506.0962b28e@tupile.poochiereds.net>
References: <49C9246E.3030508@mycircuit.org>
	<alpine.LFD.2.00.0903241226570.3032@localhost.localdomain>
	<49C94B02.5010604@mycircuit.org>
	<alpine.LFD.2.00.0903241510010.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Peter <vmail@mycircuit.org>,
	Git Mailing List <git@vger.kernel.org>,
	Steve French <sfrench@us.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 00:38:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmGCh-0005Zf-JW
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 00:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755048AbZCXXhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 19:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754769AbZCXXhQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 19:37:16 -0400
Received: from mx2.redhat.com ([66.187.237.31]:45861 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753987AbZCXXhO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 19:37:14 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n2ONZfgK002373;
	Tue, 24 Mar 2009 19:35:41 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n2ONZYF6024911;
	Tue, 24 Mar 2009 19:35:35 -0400
Received: from tupile.poochiereds.net (vpn-13-11.rdu.redhat.com [10.11.13.11])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n2ONZcW4014002;
	Tue, 24 Mar 2009 19:35:39 -0400
In-Reply-To: <alpine.LFD.2.00.0903241510010.3032@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114516>

On Tue, 24 Mar 2009 15:30:38 -0700 (PDT)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Tue, 24 Mar 2009, Peter wrote:
> > > 
> > > What OS? What filesystem? Are you perhaps running out of space?
> >   
> > Its Lenny Debian 5.0.0, Diskspace is ample . Filesystem is cifs ( this is a
> > windows 2000 share mounted with samba in a VMware Workstation Debian client (
> > yes, I know ... )). Memory usage, according to htop, is constant = 140/504 MB
> > during the whole process until git fails.
> 
> Ok, it sounds very much like a possible CIFS problem. 
> 
> Getting the exact error code for the "close()" will be interesting, 
> because the only thing that can return an error under Linux in close() is 
> if the filesystem "->flush()" function fails with an error.
> 
> In cifs, the cifs_flush() thing does a filemap_fdatawrite(), forcing the 
> data out, and that in turn calls do_writepages() which in turn calls 
> either generic_writepages() or cifs_writepages() depending on random cifs 
> crap.
> 
> I'm not seeing any obvious errors there. But I would _not_ be surprised if 
> the fchmod(fd, 0444) that we did before the close could be causing this: 
> cifs gets confused and thinks that it must not write to the file because 
> the file has been turned read-only.
> 
> Here's an idea: if this is reproducible for you, does the behavior change 
> if you do
> 
> 	[core]
> 		core.fsyncobjectfiles = true
> 
> in your .git/config file? That causes git to always fsync() the written 
> data _before_ it does that fchmod(), which in turn means that by the time 
> the close() rolls around, there should be no data to write, and thus no 
> possibility that anybody gets confused when there is still dirty data on a 
> file that has been marked read-only.
> 
> Anyway, I'm cc'ing Steve French and Jeff Layton, as the major CIFS go-to 
> guys. It does seem like a CIFS bug is likely.
> 
> Steve, Jeff: git does basically
> 
> 	open(".git/objects/xy/tmp_obj_xyzzy", O_RDWR|O_CREAT|O_EXCL, 0600) = 5
> 	write(5, ".."..., len)
> 	fchmod(5, 0444)
> 	close(5)
> 	link(".git/objects/xy/tmp_obj_xyzzy", ".git/objects/xy/xyzzy");
> 	unlink(".git/objects/xy/tmp_obj_xyzzy");
> 
> to write a new datafile. Under CIFS, that "close()" apparently sometimes 
> returns with an error, and fails.
> 
> I guess we could change the "fchmod()" to happen after the close(), just 
> to make it easier for filesystems to get this right. And yes, as outlined 
> above, there's a config option to make git use fdatasync() before it does 
> that fchmod() too. But it does seem like CIFS is just buggy.
> 
> If CIFS has problems with the above sequence (say, if some timeout 
> refreshes the inode data or causes a re-connect with the server or 
> whatever), then maybe cifs should always do an implicit fdatasync() when 
> doing fchmod(), just to make sure that the fchmod won't screw up any 
> cached dirty data?
> 

Yes. That's probably the right thing to do here. This is looks like a
regression that I introduced some time ago in
cea218054ad277d6c126890213afde07b4eb1602. Before that delta we always
flushed all the data before doing any setattr. After that delta, we
just did it on size changes. In a later commit, Steve fixed it so that
it got done on ATTR_MTIME too.

We can easily change the cifs_setattr variants to flush all the dirty
data on ATTR_MODE changes, and maybe even change it to only flush on
certain ATTR_MODE changes, like when we're clearing all the write bits.

I wonder though whether that's sufficient. If we're changing ownership
for instance, will we hit the same issue? Maybe the safest approach is
just to go back to flushing on any setattr call.

Steve, thoughts?

-- 
Jeff Layton <jlayton@redhat.com>
