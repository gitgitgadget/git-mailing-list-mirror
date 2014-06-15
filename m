From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Is there a reason the credential cache server cowardly refuses to delete/reuse the socket file?
Date: Sun, 15 Jun 2014 10:21:14 -0400
Organization: PD Inc
Message-ID: <DA14A8E763504F16BFB4CAC39DEC2400@black>
References: <1EFC4B213D584B1EBAE78E6882705B6D@black> <20140615140800.GA6216@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Jeff King'" <peff@peff.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 16:21:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwBJA-0002It-Du
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 16:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbaFOOVQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 10:21:16 -0400
Received: from mail.pdinc.us ([67.90.184.27]:47086 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbaFOOVQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 10:21:16 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5FELEeq004931;
	Sun, 15 Jun 2014 10:21:14 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20140615140800.GA6216@sigill.intra.peff.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Thread-Index: Ac+Ioz6zpghLbvklQn2L4ztFst3HgwAAQQlQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251677>

> -----Original Message-----
> From: Jeff King  
> Sent: Sunday, June 15, 2014 10:08
> 
> On Sun, Jun 15, 2014 at 09:48:24AM -0400, Jason Pyeron wrote:
> 
> > Whenever my computer crashes, I am left with a socket file. 
> On next git
> > invocation it tries to conenct to the file, but the daemon 
> is not running so it
> > barfs until I delete the file.
> 
> It's supposed to transparently handle this situation. The 
> server always
> runs unlink() before binding to clear it out. The client will 
> spawn the
> server when it tries to connect and gets either ENOENT or 
> ECONNREFUSED.
> 
> But:
> 
> > jpyeron@black /projects/dcarr/saar
> > $ git push
> > fatal: unable to connect to cache daemon: No error
> 
> Apparently your errno is 0 after returning an error from
> credential-cache.c:send_request?
> 
> Could this be a cygwin weirdness? I'd be interested to see the output
> of:
> 
>   echo url=https://example.com |
>   strace -f git credential-cache get

It paused at:
<snip/>
   24  797029 [main] git 5112 fhandler_base::close: closing
'/cygdrive/c/home/public/Desktop/projects/dcarr/saar/.git/config' handle 0x2D4
   70  797099 [main] git 5112 close: 0 = close(3)
  899  797998 [main] git 5112 fhandler_pipe::create: name
\\.\pipe\cygwin-c5e39b7a9d22bafb-5112-pipe-0x1, size 65536, mode
PIPE_TYPE_MESSAGE
  316  798314 [main] git 5112 fhandler_pipe::create: pipe read handle 0x2C4
   27  798341 [main] git 5112 fhandler_pipe::create: CreateFile: name
\\.\pipe\cygwin-c5e39b7a9d22bafb-5112-pipe-0x1
   63  798404 [main] git 5112 fhandler_pipe::create: pipe write handle 0x2C0
   35  798439 [main] git 5112 build_fh_pc: fh 0x612ADE68, dev 000000C6
   25  798464 [main] git 5112 build_fh_pc: fh 0x612B9B4C, dev 000000C5
   24  798488 [main] git 5112 fhandler_base::set_flags: flags 0x10000,
supplied_bin 0x0
   23  798511 [main] git 5112 fhandler_base::set_flags: O_TEXT/O_BINARY set in
flags 0x10000
   22  798533 [main] git 5112 fhandler_base::set_flags: filemode set to binary
   22  798555 [main] git 5112 fhandler_base::init: created new fhandler_base for
handle 0x2C4, bin 1
   26  798581 [main] git 5112 fhandler_base::set_flags: flags 0x10001,
supplied_bin 0x0
   26  798607 [main] git 5112 fhandler_base::set_flags: O_TEXT/O_BINARY set in
flags 0x10000
   22  798629 [main] git 5112 fhandler_base::set_flags: filemode set to binary
   23  798652 [main] git 5112 fhandler_base::init: created new fhandler_base for
handle 0x2C0, bin 1
   23  798675 [main] git 5112 fhandler_pipe::create: 0 = pipe([0x612ADE68,
0x612B9B4C], 65536, 0x10000)
   26  798701 [main] git 5112 pipe: 0 = pipe([3, 4])
   28  798729 [main] git 5112 child_info::child_info: subproc_ready 0x2B4
   25  798754 [main] git 5112 fork: entering
  181  798935 [main] git 5112 sig_send: sendsig 0x350, pid 5112, signal -40,
its_me 1
   24  798959 [main] git 5112 sig_send: wakeup 0x2AC
   27  798986 [main] git 5112 sig_send: Waiting for pack.wakeup 0x2AC
    6  798992 [sig] git 5112 wait_sig: signalling pack.wakeup 0x2AC
  280  799272 [main] git 5112 sig_send: returning 0x0 from sending signal -40
   39  799311 [main] git 5112 frok::parent: priority class 32
   86  799397 [main] git 5112 frok::parent: stack - bottom 0x230000, top
0x207000, addr 0x30000, guardsize 0x0
   25  799422 [main] git 5112 frok::parent: CreateProcessW
(C:\cygwin\bin\git.exe, C:\cygwin\bin\git.exe, 0, 0, 1, 0x420, 0, 0, 0x22A8FC,
0x22A8D0)
 2529  801951 [main] git 5112 frok::parent: forked pid 5796
  213  802164 [main] git 5112 child_info::sync: n 2, waiting for
subproc_ready(0x2B4) and child process(0x290)

Should I have changed example.com to something else and should I have run it
inside or outside of a git project directory?


--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
