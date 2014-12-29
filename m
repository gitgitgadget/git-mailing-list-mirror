From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Fwd: git-remote-fd problem
Date: Mon, 29 Dec 2014 21:36:51 +0200
Message-ID: <20141229193651.GA16875@LK-Perkele-VII>
References: <CAOP4-939uAP2Tgofz01F40_Eb0F8GxBsU49HxNvAiyBCW6H08w@mail.gmail.com>
 <20140910144756.GA4267@LK-Perkele-VII>
 <CAOP4-92U+oFJJw38LWNmTqPtKMT=MDq0Ay9FiaGV5je77aUNpg@mail.gmail.com>
 <CAOP4-933YWoJ8QO0ZY2KG1cgtZ6jAR8oL4L9hw_0CcicDnepnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jiri Sevcik <jsevcik14@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 29 20:43:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5gEC-00041Z-7r
	for gcvg-git-2@plane.gmane.org; Mon, 29 Dec 2014 20:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbaL2Tnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 14:43:39 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:57755 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbaL2Tni (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 14:43:38 -0500
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Dec 2014 14:43:38 EST
Received: from LK-Perkele-VII (a88-112-44-140.elisa-laajakaista.fi [88.112.44.140])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 5CF671A25D0;
	Mon, 29 Dec 2014 21:36:51 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <CAOP4-933YWoJ8QO0ZY2KG1cgtZ6jAR8oL4L9hw_0CcicDnepnQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261875>

On Mon, Dec 29, 2014 at 10:47:58AM +0100, Jiri Sevcik wrote:
> > The remote-fd expects the transport to pass half-closes. So you can't
> > close all at once.
> >
> > Let there be pipes W and R and transport connection C.
> >
> > - W-read should be closed after being passed to remote-fd.
> > - R-write should be closed after being passed to remote-fd.
> > - Upon receiving "no more data" from C, close W-write.
> > - Upon receiving EOF from R-read, close it and signal "no more data"
> >   to C.
> 
> Hi, I followed your advices, correctly close pipes but git clone still
> doesnt finish and hanging on.
> Code is in an attachement (its part of big system).

Few ideas:
- Check that git clone (and its subprocesses) don't inherit
w_pipe[0] (/proc/<pid>/fd on Linux might be handy). If they do, that
prevents this program from closing the pipe.

- Setting environment variable GIT_TRANSLOOP_DEBUG to 1 might make
  git spew lots of messages to stderr about reads, writes and closes.

> 
>     #create pipes
>     w_pipe = os.pipe()
>     r_pipe = os.pipe()
> 
>     client_process = subprocess.Popen("/usr/bin/git clone fd::{0},{1} /tmp/gittest".format(r_pipe[0], w_pipe[1]), shell=True)
>     #closing pipes
>     os.close(r_pipe[0]) 
>     os.close(w_pipe[1])
> 
>     epoll = select.epoll()
>     epoll.register(w_pipe[0], select.EPOLLIN)
>     epoll.register(proc.fd, select.EPOLLIN)
> 
>     remoteGit = proc.runDaemon("git-upload-pack /tmp/testgit")
>     
>     while True:
>         events = epoll.poll(1)
> 
>         for fd, event in events:
>             if fd == w_pipe[0]:
>                 if event & select.EPOLLIN:
>                     rd = os.read(w_pipe[0], 10000)
>                     if rd:
>                         #write data to remove git server
>                         remoteGit.writeToChannel(rd)
>                     else:
>                         proc.writeError("Local socket write error")
>                         return 1
>                 else:
>                     proc.writeError("Local socket error")
>                     return 1
> 
>             elif fd == proc.fd:
>                 if event & select.EPOLLIN:
>                     #read data from remote git server
>                     data = remoteGit.getAll()
>                     remoteGit.stderrWrite()
> 
>                     if not data:
>                         #remote server send EOF, close local pipe
>                         #but git clone is still running
>                         os.close(r_pipe[1])
>                         return 0
>                     
>                     want = len(data)
> 
>                     writed = 0
>                     offset = 0
>                     
>                     while(writed != want):
>                         #write data from remote git server to local pipe
>                         wr = os.write(r_pipe[1], data[offset:])
> 
>                         if(wr < 0):
>                             return 1
> 
>                         writed += wr
>                         offset += wr
> 
>                 else:
>                     return -1              

-Ilari
