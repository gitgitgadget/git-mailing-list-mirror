From: Jeff King <peff@peff.net>
Subject: Re: Bug - crash on large commit
Date: Tue, 23 Mar 2010 04:30:13 -0400
Message-ID: <20100323083013.GA14703@coredump.intra.peff.net>
References: <310ba29b220a70e5624819e6ef80bff0.squirrel@www.pkts.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: P Fudd <fink@ch.pkts.ca>
X-From: git-owner@vger.kernel.org Tue Mar 23 09:30:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtzVN-0008Bj-6q
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 09:30:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729Ab0CWIaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 04:30:23 -0400
Received: from peff.net ([208.65.91.99]:53841 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754696Ab0CWIaW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 04:30:22 -0400
Received: (qmail 16986 invoked by uid 107); 23 Mar 2010 08:30:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 23 Mar 2010 04:30:49 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Mar 2010 04:30:13 -0400
Content-Disposition: inline
In-Reply-To: <310ba29b220a70e5624819e6ef80bff0.squirrel@www.pkts.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142998>

On Mon, Mar 22, 2010 at 04:36:25PM -0700, P Fudd wrote:

> Bug 1: git complained about a symbolic link to nowhere and halted...
> several hours into the 'add'.  If I want to store a broken link, let me;
> maybe warn me.

Git does let you store broken links. Without seeing the actual error
message you got, it's hard to say what actually happened. But you should
be able to:

  $ mkdir foo && cd foo && git init
  $ ln -s bogus link
  $ git add .
  $ git commit -m 'add bogus link'
  $ git show
  [...]
  diff --git a/link b/link
  new file mode 120000
  index 0000000..882b604
  --- /dev/null
  +++ b/link
  @@ -0,0 +1 @@
  +bogus
  \ No newline at end of file

> Bug 2: git died with an out-of-memory error on the commit:
> ------
> # git commit -a
> [master (root-commit) 62b52e2] The initial checkin of the whole hard disk.
>  Committer: System Administrator <root@Mac-Pro.local>
> Your name and email address were configured automatically based
> on your username and hostname. Please check that they are accurate.
> You can suppress this message by setting them explicitly:
> 
>     git config --global user.name "Your Name"
>     git config --global user.email you@example.com
> 
> If the identity used for this commit is wrong, you can fix it with:
> 
>     git commit --amend --author='Your Name <you@example.com>'
> 
> git(4667) malloc: *** mmap(size=1964838912) failed (error code=12)
> *** error: can't allocate region
> *** set a breakpoint in malloc_error_break to debug

Note that it actually did make the commit, which means that the problem
you saw happened while git was generating a diffstat summary of the
commit.

It's hard to say exactly what it was trying to mmap without seeing a
stack trace. But note that it is trying to malloc almost 2 gigabytes.
In general, git assumes that it can fit any file you throw at it into
memory during a diff. So presumably you have some gigantic file, and
that is the problem.

Which, as you noted, means git is not really suitable for just throwing
your whole hard disk at it. The topic of better handling gigantic files
comes up occasionally on the list, but I don't know that anyone is
working on anything concrete right now.

Avery Pennarun's "bup" tool may be closer to what you want, but I've
never used it myself:

  http://github.com/apenwarr/bup

-Peff
