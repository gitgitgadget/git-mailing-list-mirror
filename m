From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: FW: [cygwin] Cygwin's git says "error: failed to read delta-pack base object"
Date: Sat, 6 Dec 2014 20:33:12 -0500
Organization: PD Inc
Message-ID: <275080CE3B5A44D7A46B3DF0E55C33D4@black>
References: <F5D60A90C93A45359EF00CC200C81561@black> <F5116E3BF1974D039102426C8F6E3BED@black>
Reply-To: <git@vger.kernel.org>, <lindbergh@92f1.com>,
	  "brian m. carlson" <sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
	"'Dave Lindbergh'" <lindbergh@92f1.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 07 02:33:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxQj4-0003gL-TD
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 02:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbaLGBdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 20:33:23 -0500
Received: from mail.pdinc.us ([67.90.184.27]:32773 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbaLGBdW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Dec 2014 20:33:22 -0500
Received: from black (five-58.pdinc.us [192.168.5.58])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id sB71XD2X029497;
	Sat, 6 Dec 2014 20:33:14 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <F5116E3BF1974D039102426C8F6E3BED@black>
Thread-Index: AdAPXRtpqnFJ0p5ySsSWNqpxnc3bEwArKJ3gACRqPBAAR47CYA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260968>

TLDR = Cygwin remote filesystem sometimes has strange failures -> workaround is to use rename, not link/unlink; 
see https://github.com/pdinc-oss/git/commit/5a36824ed01d4335148ca3846e75cc99c11650e2
> -----Original Message-----
> From: Jason Pyeron
> Sent: Friday, December 05, 2014 10:30
> 
> > -----Original Message-----
> > From: Jason Pyeron
> > Sent: Thursday, December 04, 2014 16:34
> > 
> > > -----Original Message-----
> > > From: brian m. carlson
> > > Sent: Wednesday, December 03, 2014 19:55
> > > 
> > > On Wed, Dec 03, 2014 at 06:31:18PM -0500, Jason Pyeron wrote:
> > > > I remember hitting this a while ago, but just gave up.
> > > > 
> > > > It seems to be a problem for others too.
> > > > 
> > > > Any ideas on how to debug this so it can be patched?
> > > > 
> > > > -----Original Message-----
> > > > From: Dave Lindbergh
> > > > Sent: Wednesday, December 03, 2014 18:07
> > > > To: cygwin
> > > > 
> > > > Aha - you're right.
> > > > 
> > > > It works fine on a local NTFS volume.
> > > > 
> > > > I get the error when I do it on Z:, which is mapped to a 
> > > network drive
> > > > (on another Windows box).
> > > > 
> > > > Is there a workaround? Why does this happen?

I have a really hacky workaround, commit 5a36824ed01d4335148ca3846e75cc99c11650e2 comments out the logic and forces a rename instead of link and unlink.

https://github.com/pdinc-oss/git/tree/cygwin-issue-remoteCIFS-rename

<snip/>

> Pseudo code and observations
> ./sha1_file.c:write_loose_object(sha1)
> {
>  filename=sha1_file_name(sha1)
>  (fd,tmp_file)=create_tmpfile(filename)
>  write_buffer(fd)
>  close_sha1_file(fd)
>  return move_temp_to_file(tmp_file, filename)
> }
> 
> move_temp_to_file(tmpfile, filename)
> {
>  // I am thinking about forcing renames to see if the problem 
> exists then as well
>  // if that "works" then a per repo config option allowing 
> for forced renames
>  if (OBJECT_CREATION_USES_RENAMES) goto try_rename
>  else if link(tmpfile,filename)
> 

Dave has tested a build I made for him on 64 bit Cygwin and it works. I no longer have access to the environment I was having this problem in last February. I will try to investigate this further, but I am not hopeful, maybe Corinna will have luck on the issue. But I was in a secure corporate environment and I thought the host based security system (AV), coupled with the remote file system was causing the problem, namely files created are not available instantly.

I do think that we should have a config option for this, as most users who could encounter such a problem are not likely to be able (or allowed) to rebuild the git executable themselves.

<snip/>

> > -----Original Message-----
> > From: Corinna Vinschen
> > Sent: Friday, December 05, 2014 6:35
> > To: cygwin@cygwin.com
> <snip/>
> > What I found in the strace is this:
> > 
> > - Create file Z:\pic32mx-bmf\.git\objects\30\tmp_obj_YljwNZ
> > 
> > - open file, write something, close file.
> > 
> > - link (Z:\pic32mx-bmf\.git\objects\30\tmp_obj_YljwNZ,
> > 	
> > 
> Z:\pic32mx-bmf\.git\objects\30\0bdeb2fd209d24afb865584da10b78aa8fefc4)
> >   succeeds.
> > 
> > - unlink (Z:\pic32mx-bmf\.git\objects\30\tmp_obj_YljwNZ) succeeds
> > 
> > - Trying to open
> >   
> > 
> Z:\pic32mx-bmf\.git\objects\30\0bdeb2fd209d24afb865584da10b78aa8fefc4
> >   but the file doesn't exist and NtCreateFile fails with status
> >   0xC0000034, STATUS_OBJECT_NAME_NOT_FOUND --> ENOENT.
> > 
> > - Subsequent unlink (Z:\pic32mx-bmf\.git\objects\30) fails with a
> >   STATUS_DIRECTORY_NOT_EMPTY --> ENOTEMPTY.
> > 
> > - git seems to be prepared for such a case, the parent process calls
> >   opendir/readdir on the directory.  Enumerating the files in
> >   Z:\pic32mx-bmf\.git\objects\30 shows the entries ".", ".." and
> >   "0bdeb2fd209d24afb865584da10b78aa8fefc4".
> > 
> > - Then git calls lstat on the file, which results in NtOpenFile
> >   returning status STATUS_OBJECT_NAME_NOT_FOUND again.
> > 
> > - From a POSIX POV this means "somebody else" deleted the file,
> >   so the dir is empty now.  Git tries to delete the directory again,
> >   which again results in STATUS_DIRECTORY_NOT_EMPTY --> ENOTEMPTY
> >   and, internally, a sharing violation which disallows to move the
> >   directory out of the way.
> > 
> > This looks suspiciously like a bug in the remote filesystem.  Link
> > succeeded, so there are two links to the same file in the directory.
> > Unlinking link 1 succeeds, so there's still one link to the 
> > file in the
> > directory, but link 2 is inaccessible as if the file has 
> been deleted
> > completely.  Thus, a full POSIX git on this drive is broken.
> > 
> > Can you please run
> > 
> >   /usr/lib/csih/getVolInfo /cygdrive/z
> > 
> > and paste the output here?  Maybe I can workaround this in the next
> > Cygwin version.

Dave's response: https://www.cygwin.com/ml/cygwin/2014-12/msg00066.html

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00. 
