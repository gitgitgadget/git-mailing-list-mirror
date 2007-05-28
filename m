From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Mon, 28 May 2007 22:04:47 +0200
Message-ID: <871wh0ww80.fsf@rho.meyering.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705280929140.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 28 22:05:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HslSi-0007J1-7G
	for gcvg-git@gmane.org; Mon, 28 May 2007 22:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759798AbXE1UEt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 May 2007 16:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759813AbXE1UEt
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 16:04:49 -0400
Received: from mx.meyering.net ([82.230.74.64]:55808 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759798AbXE1UEs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 16:04:48 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 2D9E732CF1; Mon, 28 May 2007 22:04:47 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.98.0705280929140.26602@woody.linux-foundation.org> (Linus Torvalds's message of "Mon\, 28 May 2007 09\:32\:06 -0700 \(PDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48636>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, 28 May 2007, Jim Meyering wrote:
>>
>> I suspect that git's special treatment of EPIPE was a shoot-the-messenger
>> reaction to the work-around (trap '' PIPE) required to avoid diagnostics
>> from porcelain being interpreted by what would now be a 2-year-old
>> version of bash.

Hi Linus!

Thanks for all the encouragement.

> No. You don't seem to realize. That was the *default* behaviour of bash.

Of course it was the default.  Because it was the default, it
provoked contortions like using `trap '' PIPE' in shell scripts,
which in turn provoked EPIPE diagnostics from git, which
prompted the EPIPE-ignoring changes in git plumbing.
And those changes can now OBSCURE REAL ERRORS, as I've shown.

Note: it was the SIGPIPE-ignoring work-around that caused the trouble.
The bash bug didn't cause trouble with git _directly_.

If anyone can find a mainstream distro (I didn't) on which my
patch causes trouble, please let us all know.

Bash changed its default first in bash-3.1-alpha1.
The next stable release was bash-3.1, in Dec 2005:

  r.  By default, the shell no longer reports processes dying from SIGPIPE.

It looks like most major distros had fixed it long before.
The latest stable release is bash-3.2 from October, 2006.

> For all I know, it might _still_ be the default behaviour.

It's not.  See above.
Easy to test: run this: seq 99999|head -1
if all you see is a single line with "1" on it, and an exit status of 0,
then there's no problem.

However, the version of bash you use is IRRELEVANT to the question of
EPIPE.  SIGPIPE has always been delivered by default.  The only difference
lay in whether bash _reported_ the delivery.  It's only the work-around
ignoring of SIGPIPE that used to provoke EPIPE "broken pipe" errors.
Now, all of the git porcelain shell code that did that appears to be gone,
probably converted to perl or C.

You can get an EPIPE diagnostic with my patch any time the affected
plumbing is invoked from an environment in which SIGPIPE is ignored.
That environment could be your shell (if you put "trap '' PIPE" in a
start-up file -- though no one does *that*), or porcelain that does that,
or the perlish $SIG{PIPE} = 'IGNORE'.  The following are the only parts
of git I've found that ignore SIGPIPE:

  git-archimport.perl
  git-cvsimport.perl
  git-svn.perl
  git-svnimport.perl

And nothing in cogito does.
So, now, I *really* don't see why there's any fuss about EPIPE.

> The only reason not everybody ever even noticed, was that most
> distributions were clueful enough to have figured out that it was broken,
> and configured bash separately. But "most" does not mean "all", and I had
> this problem on powerpc, and others had it on Debian, I htink  (might have
> been slackware). I think RH and SuSE had both fixed it explicitly.

Precisely.  That behavior in bash was so annoying that people were
motivated to fix it quickly.  But all of that was resolved long ago.

...
> Nack. Nack. NACK.
>
> I think this patch is fundamentally WRONG. This fragment is just a prime
> example of why the whole patch is crap. The old code was correct, and you
> broke it.

Um... maybe you've forgotten that this patch fixes a hole in the
"old code" (git.c).  Many git tools ignore write (ENOSPC) failures.
Compared to that aspect of the fix, I would have thought EPIPE-
handling would be a minor detail.  But now, the whole patch has
become "crap"?

Consider the EPIPE-related risks/choice:

  1) Continue to ignore EPIPE write failure: can obscure real errors.
       BTW, Linus, don't you agree?  You never commented on this point.

  2) Remove the EPIPE exclusion: *might* make git give a "broken pipe"
       diagnostic, if you run git in a SIGPIPE-ignoring environment.

#2 seems to be the lesser of two evils, considering that we can fix or
work around the occasional "broken pipe" error, but we can't work around
an unconditionally-ignored EPIPE.

Jim
