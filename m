From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Sat, 25 Mar 2006 00:25:21 -0800
Message-ID: <20060325082521.GA17473@hand.yhbt.net>
References: <20060322133337.GU20746@lug-owl.de> <20060324182504.GI31387@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 25 09:25:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN45O-0003Dy-U4
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 09:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWCYIZX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 03:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWCYIZX
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 03:25:23 -0500
Received: from hand.yhbt.net ([66.150.188.102]:52870 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750756AbWCYIZW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 03:25:22 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 8C7497DC005; Sat, 25 Mar 2006 00:25:21 -0800 (PST)
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Content-Disposition: inline
In-Reply-To: <20060324182504.GI31387@lug-owl.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17963>

Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> On Wed, 2006-03-22 14:33:37 +0100, Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> 
> Since it seems nobody looked at the GCC import run (which means to use
> the svnimport), I ran it again, under strace control:

If you don't care for automated branch handling, how about trying git-svn?
under the contrib/ directory in git.git

	git-svn init svn://gcc.gnu.org/svn/gcc
	git-svn fetch

> > GCC
> > ~~~
> > $ /home/jbglaw/bin/git svnimport -C gcc -v svn://gcc.gnu.org/svn/gcc
> 
> > Committed change 3936:/ 1993-03-31 05:44:03)
> > Commit ID ceff85145f8671fb2a9d826a761cedc2a507bd1e
> > Writing to refs/heads/origin
> > DONE: 3936 origin ceff85145f8671fb2a9d826a761cedc2a507bd1e
> > ... 3937 trunk/gcc/final.c ...
> > Can't fork at /home/jbglaw/bin/git-svnimport line 379.
> 
> ... 4279 trunk/gcc/config/i386/xm-sco.h ...
> 
> This time it broke at a different revision, so I guess it's not a SVN
> or git / git-svnimport problem, but rather a problem of my Perl
> installation or the kernel itself?

I've known of SVN library bindings leaking memory in the past, but I
thought it's been solved.  Afaik, any memory allocated by the Perl
interpreter is never released back to the kernel, either.  (At least
that seems to be the case with my setup (Debian unstable, Perl 5.8.8,
2.6 kernel, x86 machine).

> What are possible reasons for clone() to fail with -ENOMEN? I have to
> admit that the box _is_ loaded a bit all the time:
> 
> jbglaw@bixie:~/vax/git-conversion$ uptime
>  19:23:58 up 136 days,  7:46, 20 users,  load average: 4.45, 4.25, 3.05
> jbglaw@bixie:~/vax/git-conversion$ free
>              total       used       free     shared    buffers     cached
> Mem:        507308     501760       5548          0       2184      16900
> -/+ buffers/cache:     482676      24632
> Swap:      2441872    1295512    1146360

Some importers (my own git-svn included) aren't amazingly efficient when
handling lots of history which gcc has.   It looks like (from what I
understand of the SVN api used in git-svnimport) is that the entire log
for the 100k+ revisions in the tree is slurped down into memory before
any processing is done.

git-svn does this too, but by parsing the output of the svn binary
instead of using the library, so at least it won't have issues with the
svn bindings and libraries to worry about.

My git-svn process running on the SVN tree just finished parsing the svn
log output, and it's maxed out at 74M RSS (on a 32-bit x86).  It'll
probably take a while to import it all (which I won't do), but I could
have just as easily done the following to reduce memory usage by ~half:

	git-svn fetch -r0:50000		# import the first 50000k
	git-svn fetch			# now import the remaining

Afaik, there's no way to do something like the above with git-svnimport
for memory-starved setups.

-- 
Eric Wong
