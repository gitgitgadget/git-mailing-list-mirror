From: Peter <vmail@mycircuit.org>
Subject: Re: fatal: unable to write sha1 file git 1.6.2.1
Date: Tue, 24 Mar 2009 23:42:24 +0100
Message-ID: <49C961D0.4010704@mycircuit.org>
References: <49C9246E.3030508@mycircuit.org> <alpine.LFD.2.00.0903241226570.3032@localhost.localdomain> <49C94B02.5010604@mycircuit.org> <alpine.LFD.2.00.0903241510010.3032@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 24 23:44:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmFMX-000591-3Q
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 23:44:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753948AbZCXWma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 18:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbZCXWma
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 18:42:30 -0400
Received: from mailfe06.tele2.ch ([212.247.154.168]:53303 "EHLO swip.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751335AbZCXWm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 18:42:29 -0400
X-Cloudmark-Score: 0.000000 []
X-Cloudmark-Analysis: v=1.0 c=1 a=rOj5MoUHdesA:10 a=zs1h1pAyPHAA:10 a=Qy6mu5jw0WABpOr/wumM4A==:17 a=VwQbUJbxAAAA:8 a=iGKFZzS48cDMD-NU1xkA:9 a=fVdImSgD4ygOf8IhAcYA:7 a=ctK3nKZ0u_Qq1fia8wEr6qsZJvoA:4 a=DLWQtoLnVnAA:10
Received: from mail.mycircuit.org (account cxu-8g8-ypb@tele2.ch [83.180.79.156] verified)
  by mailfe06.swip.net (CommuniGate Pro SMTP 5.2.6)
  with ESMTPA id 1215773758; Tue, 24 Mar 2009 23:42:24 +0100
Received: from [192.168.1.191] (unknown [192.168.1.191])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "p_email", Issuer "192.168.2.2" (verified OK))
	by mail.mycircuit.org (Postfix) with ESMTP id 2A15ED0360;
	Tue, 24 Mar 2009 23:42:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
In-Reply-To: <alpine.LFD.2.00.0903241510010.3032@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114505>

Linus Torvalds wrote:
> On Tue, 24 Mar 2009, Peter wrote:
>   
>>> What OS? What filesystem? Are you perhaps running out of space?
>>>       
>>   
>> Its Lenny Debian 5.0.0, Diskspace is ample . Filesystem is cifs ( this is a
>> windows 2000 share mounted with samba in a VMware Workstation Debian client (
>> yes, I know ... )). Memory usage, according to htop, is constant = 140/504 MB
>> during the whole process until git fails.
>>     
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
> 		Linus
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>   
Hi
Thanks a lot , I will check that out tomorrow, in the meantime, this is 
the result of your patch being applied:

$ git add <big stuff>

fatal: error when closing sha1 file (Bad file descriptor)

Peter
