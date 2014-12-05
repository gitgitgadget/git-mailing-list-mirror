From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: SPAM: RE: FW: [cygwin] Cygwin's git says "error: failed to read delta-pack base object"
Date: Fri, 5 Dec 2014 10:26:30 -0500
Organization: PD Inc
Message-ID: <CB189BF2E728417298483F177AAD0309@black>
References: <64C98FC352BD45EC9632202946A081E1@black> <20141204005443.GB200195@vauxhall.crustytoothpaste.net> <F5D60A90C93A45359EF00CC200C81561@black>
Reply-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	  <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 05 16:26:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwumJ-00081s-89
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 16:26:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbaLEP0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 10:26:39 -0500
Received: from mail.pdinc.us ([67.90.184.27]:60783 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbaLEP0i convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 10:26:38 -0500
Received: from black (five-58.pdinc.us [192.168.5.58])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id sB5FQVCj024528;
	Fri, 5 Dec 2014 10:26:32 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <F5D60A90C93A45359EF00CC200C81561@black>
Thread-Index: AdAPXRtpqnFJ0p5ySsSWNqpxnc3bEwArKJ3gACRqPBA=
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260870>


> -----Original Message-----
> From: git-owner@vger.kernel.org 
> [mailto:git-owner@vger.kernel.org] On Behalf Of Jason Pyeron
> Sent: Thursday, December 04, 2014 16:34
> To: git@vger.kernel.org
> Cc: 'brian m. carlson'
> Subject: SPAM: RE: FW: [cygwin] Cygwin's git says "error: 
> failed to read delta-pack base object"
> 
> > -----Original Message-----
> > From: brian m. carlson
> > Sent: Wednesday, December 03, 2014 19:55
> > 
> > On Wed, Dec 03, 2014 at 06:31:18PM -0500, Jason Pyeron wrote:
> > > I remember hitting this a while ago, but just gave up.
> > > 
> > > It seems to be a problem for others too.
> > > 
> > > Any ideas on how to debug this so it can be patched?
> > > 
> > > -----Original Message-----
> > > From: Dave Lindbergh
> > > Sent: Wednesday, December 03, 2014 18:07
> > > To: cygwin
> > > 
> > > Aha - you're right.
> > > 
> > > It works fine on a local NTFS volume.
> > > 
> > > I get the error when I do it on Z:, which is mapped to a 
> > network drive
> > > (on another Windows box).
> > > 
> > > Is there a workaround? Why does this happen?
> > 
> > I don't think anyone is sure.  My wild guess is that 
> there's something
> > about the way that Cygwin wraps Windows calls that makes it 
> > fail in this
> > case.  It might be interesting to run the Windows and 
> Cygwin versions
> > under an strace equivalent and see where things differ.
> 
> [this was posted to the cygwin list]
> 
> http://nerdfever.com/files/strace.txt
> 
> > 
> > It's an interesting problem, but I don't have any Windows 
> > systems, so I
> > can't look into it.
> 
> If it becomes a little less magic, I will chomp on the 
> problem, but I cannot make a predictable test case.

Corrina at Cygwin devined the strace (see below) and I am working on a test cases and hacks.

Pseudo code and observations
./sha1_file.c:write_loose_object(sha1)
{
 filename=sha1_file_name(sha1)
 (fd,tmp_file)=create_tmpfile(filename)
 write_buffer(fd)
 close_sha1_file(fd)
 return move_temp_to_file(tmp_file, filename)
}

move_temp_to_file(tmpfile, filename)
{
 // I am thinking about forcing renames to see if the problem exists then as well
 // if that "works" then a per repo config option allowing for forced renames
 if (OBJECT_CREATION_USES_RENAMES) goto try_rename
 else if link(tmpfile,filename)

 if (failed except exist failures)
 {
  try_rename:
  rename(tmpfile, filename)
  if (ok) goto out
 }
 unlink_or_warn(tmpfile)
 if (failed except exist failures) return error
 out:
}

write_sha1_file(sha1)
{
 return write_loose_object(sha1)
}


> -----Original Message-----
> From: Corinna Vinschen
> Sent: Friday, December 05, 2014 6:35
> To: cygwin@cygwin.com
<snip/>
> What I found in the strace is this:
> 
> - Create file Z:\pic32mx-bmf\.git\objects\30\tmp_obj_YljwNZ
> 
> - open file, write something, close file.
> 
> - link (Z:\pic32mx-bmf\.git\objects\30\tmp_obj_YljwNZ,
> 	
> Z:\pic32mx-bmf\.git\objects\30\0bdeb2fd209d24afb865584da10b78aa8fefc4)
>   succeeds.
> 
> - unlink (Z:\pic32mx-bmf\.git\objects\30\tmp_obj_YljwNZ) succeeds
> 
> - Trying to open
>   
> Z:\pic32mx-bmf\.git\objects\30\0bdeb2fd209d24afb865584da10b78aa8fefc4
>   but the file doesn't exist and NtCreateFile fails with status
>   0xC0000034, STATUS_OBJECT_NAME_NOT_FOUND --> ENOENT.
> 
> - Subsequent unlink (Z:\pic32mx-bmf\.git\objects\30) fails with a
>   STATUS_DIRECTORY_NOT_EMPTY --> ENOTEMPTY.
> 
> - git seems to be prepared for such a case, the parent process calls
>   opendir/readdir on the directory.  Enumerating the files in
>   Z:\pic32mx-bmf\.git\objects\30 shows the entries ".", ".." and
>   "0bdeb2fd209d24afb865584da10b78aa8fefc4".
> 
> - Then git calls lstat on the file, which results in NtOpenFile
>   returning status STATUS_OBJECT_NAME_NOT_FOUND again.
> 
> - From a POSIX POV this means "somebody else" deleted the file,
>   so the dir is empty now.  Git tries to delete the directory again,
>   which again results in STATUS_DIRECTORY_NOT_EMPTY --> ENOTEMPTY
>   and, internally, a sharing violation which disallows to move the
>   directory out of the way.
> 
> This looks suspiciously like a bug in the remote filesystem.  Link
> succeeded, so there are two links to the same file in the directory.
> Unlinking link 1 succeeds, so there's still one link to the 
> file in the
> directory, but link 2 is inaccessible as if the file has been deleted
> completely.  Thus, a full POSIX git on this drive is broken.
> 
> Can you please run
> 
>   /usr/lib/csih/getVolInfo /cygdrive/z
> 
> and paste the output here?  Maybe I can workaround this in the next
> Cygwin version.
> 
> 
> Corinna
> 

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00. 
