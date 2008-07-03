From: Brian Foster <brian.foster@innova-card.com>
Subject: Non-inetd git-daemon hangs in syslog(3)/fclose(3) if --syslog --verbose accessing non-repositories
Date: Thu, 3 Jul 2008 14:00:36 +0200
Message-ID: <200807031400.36315.brian.foster@innova-card.com>
Reply-To: Brian Foster <brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 14:08:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KENbx-0006M6-3V
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 14:08:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756113AbYGCMBW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 08:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756094AbYGCMBV
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 08:01:21 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:26910 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087AbYGCMBR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jul 2008 08:01:17 -0400
Received: by rv-out-0506.google.com with SMTP id k40so975591rvb.1
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:reply-to:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        bh=W3gvDeTEzITTkj4FDHY12aNG2AnuLLB7VRo6mGoAgf0=;
        b=rDmp3AN51ITNY/P48XBK7RALRVAg/0SxblJYOM7iCg9+EFAZu35tJwCcn2Jl7FJc/F
         qbjvGbEUpxXRedkHPIgM8kPkMcsvJDHj2vWmgdU+AWAwbFO5IzyF3FHakIx8ZJCI8inc
         TkM7f5EXu4FLnfnm1+xVY2r+B66NxqOy6MjcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:reply-to:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        b=JDm/7YrgggPxiRLpSrlLJgwO4OeE80bph0HXcvcO7PcgoeI7tpH3zaCrCroaz9RY+E
         wtT+4W5McatErR2NQoP/36WWnY8iM3G0ZUi4uLJGUvNc93SI6b1fd0FNNAmPX8ZeqJ3O
         GKwb/x7NqZ/FWZPXvcdSwIiVx8d0D/tvjy88k=
Received: by 10.114.185.8 with SMTP id i8mr67206waf.28.1215086477321;
        Thu, 03 Jul 2008 05:01:17 -0700 (PDT)
Received: from innova-card.com ( [81.252.61.1])
        by mx.google.com with ESMTPS id 4sm30964fge.5.2008.07.03.05.00.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jul 2008 05:01:15 -0700 (PDT)
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87267>


 I've seen several reports of what seems to be the following
 problem, but no fixes.  I do not understand the root-cause.
 I have found, however, what seems to be a work-around.

 I'm starting v1.5.2.5 (the Kubuntu 7.10 package) git-daemon
 (as a normal-user, *not* super-user) as:

     export GIT_TRACE=3D/tmp/LOG-git-daemon
     exec  \
        git daemon --detach --syslog --verbose --base-path=3D/pub/scm

 The repositories being served are simple (non-bare) clones,
 with nothing strange/weird.  The remote machine (CentOS),
 running a self-built un-modified v1.5.5, can access them Ok:

     $ git ls-remote git://SERVER/repo
     ... works ...
     $=20

 However, an invalid path causes both the git-daemon and the
 client to hang (I'm too impatient and do not know if either
 times out):

     $ git ls-remote git://SERVER/repo/garbage
     ... hangs ...

 I can ^C the client, but the server is still hung, and will
 not respond to *any* requests.  I must kill the git-daemon.
 The GIT_TRACE log's contents do not seem to be interesting.
 The last entries in the syslog are:

     git-daemon: [3705] Connection from <REMOTE>
     git-daemon: [3705] Extended attributes (17 bytes) exist <...>
     git-daemon: [3705] Request upload-pack for '/repo/garbage'
     git-daemon: [3705] '/pub/scm/repo/garbage': unable to chdir or not=
 a git archive

 Annoyingly, strace(1)ing git-daemon causes the problem to
 vanish!  Everything then seems to be work as expected.
 But now the syslog contains an additional, 5th, line:

     git-daemon: [3705] Disconnected (with error)

 (The "with error" is present only in the .../garbage case.)

 Attaching to a hung git-daemon with strace shows that it's
 hung in futex(2):

     $ strace -p3705
     Process 3705 attached - interrupt to quit
     futex(0x2b502cbf3980, FUTEX_WAIT, 2, NULL <unfinished ...>
     ... hangs ...

 Attaching to a hung git-daemon with gdb(1) results in the
 following backtrace:

     (gdb) where
     #0  0x00002b502c97d1d8 in ?? () from /lib/libc.so.6
     #1  0x00002b502c913698 in ?? () from /lib/libc.so.6
     #2  0x00002b502c912960 in realloc () from /lib/libc.so.6
     #3  0x00002b502c905eb4 in ?? () from /lib/libc.so.6
     #4  0x00002b502c8fd897 in fclose () from /lib/libc.so.6
     #5  0x00002b502c96d371 in __vsyslog_chk () from /lib/libc.so.6
     #6  0x00002b502c96d8a0 in syslog () from /lib/libc.so.6
     #7  0x0000000000403896 in ?? ()
     #8  <signal handler called>
     #9  0x00002b502c9373ab in fork () from /lib/libc.so.6
     #10 0x0000000000404443 in ?? ()
     #11 0x0000000000404c99 in ?? ()
     #12 0x00002b502c8bab44 in __libc_start_main () from /lib/libc.so.6
     #13 0x0000000000403179 in ?? ()
     #14 0x00007fff7e63eab8 in ?? ()
     #15 0x0000000000000000 in ?? ()
     (gdb)=20

 It's fairly clear it's hung doing the syslog(3) of the (missing)
 "Disconnected (with error)" message.  A interesting point is the
 SIGCHLD handler in (git-)daemon.c appears to have been called
 before the parent's fork(2) returned.  I presume there is a race
 here, but admit I do not see it.  This (broadly) makes sense; the
 server is a Very Fast machine.  And strace'ing slows things down.

 The workaround is to omit --verbose and hence never try to syslog
 the "Disconnected ..." message.

cheers!
	-blf-

--=20
=E2=80=9CHow many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools.=E2=80=9D |      http://www.stope=
sso.com
