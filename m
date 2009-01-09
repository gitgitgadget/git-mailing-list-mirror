From: Jeff King <peff@peff.net>
Subject: Re: Funny: git -p submodule summary
Date: Fri, 9 Jan 2009 03:38:36 -0500
Message-ID: <20090109083836.GB21389@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 09 09:40:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLCuz-0008Qp-SJ
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 09:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbZAIIik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 03:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753610AbZAIIij
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 03:38:39 -0500
Received: from peff.net ([208.65.91.99]:58190 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753063AbZAIIii (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 03:38:38 -0500
Received: (qmail 17355 invoked by uid 107); 9 Jan 2009 08:39:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 09 Jan 2009 03:39:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jan 2009 03:38:36 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104988>

On Thu, Jan 08, 2009 at 04:07:08PM +0100, Johannes Schindelin wrote:

> Just try this with a submodule that has more changes than fit on a screen:
> 
> 	$ git -p submodule summary
> 
> In my tests, it consistently fscks up my console.  I wonder if this is 
> related to ea27a18(spawn pager via run_command interface).
> 
> *reverts that commit* Yep, that fixes it.

Hmm. I can reproduce your problem here, like this:

  $ git -p submodule summary

but when I tried to dig deeper using strace, the problem goes away:

  $ strace -f -o foo.out git -p submodule summary

However, I was able to get some data by stracing _just_ less:

  $ GIT_PAGER='strace -f -o foo.out less' git -p submodule summary

and that reproduces the problem. And here's the interesting bit:

  open("/dev/tty", O_RDONLY|O_LARGEFILE)  = 3
  ...
  read(0, $SOME_SUBMODULE_OUTPUT, ...)
  write(1, $SOME_SUBMODULE_OUTPUT, ...)
  read(3, 0xbfd3442f, 1)                  = -1 EIO (Input/output error)

That is, after displaying the actual output, the next thing less does is
try to get input from the user on /dev/tty. But it returns EIO. At which
point less just dies, leaving your terminal in a funny state.

Hrm. Here's a theory. The new pager behavior goes something like this
for a builtin:

  1. fork, child becomes pager
  2. register atexit handler to wait for pager to finish
  3. run builtin
  4. exit, triggering handler

but for an external command (like a shell script), we exec the command,
and presumably forget about out atexit handler entirely. Which means
that our shell script writes all of its output and exits before less has
a chance to prompt and get a response from the tty.

And I'll admit to being very hazy on the details of process groups and
controlling terminals, but from what I recall, perhaps the EIO is
related to the process group leader being dead. Which means we could
paper over it by putting less in its own pgrp.

So here's a little test (in bash):

  $ set +m ;# disable job control, leaving bash as the pgrp leader
  $ git -p submodule summary

A-ha. That "works" in the sense that less runs fine and show the output.
So it is a pgrp issue.  _But_ we still have a problem, which is that the
original process has exited, and bash thinks the command is finished. So
now annoyingly we have both bash and less trying to read from the
terminal.

So the _real_ problem is that we are not always triggering the "wait for
pager to finish" code because we exec and forget about it. Which means
this strategy of "git runs child pager" will never work properly.
Instead, we have to use three processes: git and the pager become child
processes, while the original process waits for both to exit and returns
the proper exit code from git.

Let me try to work up a patch.

-Peff

PS I believe this is related to a similar bug which I have been hunting
   fruitlessly for a few weeks: if you use ^C to kill git, the pager
   will sometimes do funny things. I also traced that to an EIO on
   reading from the terminal, which makes sense: we are killing git
   before it gets a chance to do wait_for_pager.
