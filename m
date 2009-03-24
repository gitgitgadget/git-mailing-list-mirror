From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: fatal: unable to write sha1 file git 1.6.2.1
Date: Tue, 24 Mar 2009 15:30:38 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903241510010.3032@localhost.localdomain>
References: <49C9246E.3030508@mycircuit.org> <alpine.LFD.2.00.0903241226570.3032@localhost.localdomain> <49C94B02.5010604@mycircuit.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Steve French <sfrench@us.ibm.com>,
	Jeff Layton <jlayton@redhat.com>
To: Peter <vmail@mycircuit.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 23:35:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmFD2-0001oT-DF
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 23:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbZCXWdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 18:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbZCXWda
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 18:33:30 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40037 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751503AbZCXWd3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2009 18:33:29 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2OMUcLn020456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 Mar 2009 15:31:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2OMUc6D004398;
	Tue, 24 Mar 2009 15:30:38 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <49C94B02.5010604@mycircuit.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.45 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114503>



On Tue, 24 Mar 2009, Peter wrote:
> > 
> > What OS? What filesystem? Are you perhaps running out of space?
>   
> Its Lenny Debian 5.0.0, Diskspace is ample . Filesystem is cifs ( this is a
> windows 2000 share mounted with samba in a VMware Workstation Debian client (
> yes, I know ... )). Memory usage, according to htop, is constant = 140/504 MB
> during the whole process until git fails.

Ok, it sounds very much like a possible CIFS problem. 

Getting the exact error code for the "close()" will be interesting, 
because the only thing that can return an error under Linux in close() is 
if the filesystem "->flush()" function fails with an error.

In cifs, the cifs_flush() thing does a filemap_fdatawrite(), forcing the 
data out, and that in turn calls do_writepages() which in turn calls 
either generic_writepages() or cifs_writepages() depending on random cifs 
crap.

I'm not seeing any obvious errors there. But I would _not_ be surprised if 
the fchmod(fd, 0444) that we did before the close could be causing this: 
cifs gets confused and thinks that it must not write to the file because 
the file has been turned read-only.

Here's an idea: if this is reproducible for you, does the behavior change 
if you do

	[core]
		core.fsyncobjectfiles = true

in your .git/config file? That causes git to always fsync() the written 
data _before_ it does that fchmod(), which in turn means that by the time 
the close() rolls around, there should be no data to write, and thus no 
possibility that anybody gets confused when there is still dirty data on a 
file that has been marked read-only.

Anyway, I'm cc'ing Steve French and Jeff Layton, as the major CIFS go-to 
guys. It does seem like a CIFS bug is likely.

Steve, Jeff: git does basically

	open(".git/objects/xy/tmp_obj_xyzzy", O_RDWR|O_CREAT|O_EXCL, 0600) = 5
	write(5, ".."..., len)
	fchmod(5, 0444)
	close(5)
	link(".git/objects/xy/tmp_obj_xyzzy", ".git/objects/xy/xyzzy");
	unlink(".git/objects/xy/tmp_obj_xyzzy");

to write a new datafile. Under CIFS, that "close()" apparently sometimes 
returns with an error, and fails.

I guess we could change the "fchmod()" to happen after the close(), just 
to make it easier for filesystems to get this right. And yes, as outlined 
above, there's a config option to make git use fdatasync() before it does 
that fchmod() too. But it does seem like CIFS is just buggy.

If CIFS has problems with the above sequence (say, if some timeout 
refreshes the inode data or causes a re-connect with the server or 
whatever), then maybe cifs should always do an implicit fdatasync() when 
doing fchmod(), just to make sure that the fchmod won't screw up any 
cached dirty data?

		Linus
