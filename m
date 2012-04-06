From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] tests: add initial bash completion tests
Date: Fri, 6 Apr 2012 19:45:45 -0400
Message-ID: <20120406234545.GA31750@sigill.intra.peff.net>
References: <1333740519-3792-1-git-send-email-felipe.contreras@gmail.com>
 <20120406201926.GA1677@sigill.intra.peff.net>
 <CAMP44s0n+dyp-QNOPtiKtGX1VNOsM8GJOLLCksqwPArR+FS8ng@mail.gmail.com>
 <20120406213448.GA5436@sigill.intra.peff.net>
 <CAMP44s0VWWuM6eeij_nys9OAqu6Jr87Wv4K56mbbqhuMbVXKaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 01:46:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGIrN-0000Xs-Vf
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 01:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319Ab2DFXpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 19:45:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52900
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752169Ab2DFXpt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 19:45:49 -0400
Received: (qmail 13948 invoked by uid 107); 6 Apr 2012 23:45:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 06 Apr 2012 19:45:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2012 19:45:45 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s0VWWuM6eeij_nys9OAqu6Jr87Wv4K56mbbqhuMbVXKaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194925>

On Sat, Apr 07, 2012 at 01:05:51AM +0300, Felipe Contreras wrote:

> > So yes, the #! isn't relevant to "make test" (though marking it as
> > #!/bin/sh does serve as documentation for what you expect,
> 
> No, it's the opposite; #!/bin/sh would imply that you can run this
> with any POSIX shell; you can't.

I think you are conflating the test _harness_ with the contents of the
tests themselves.  The harness must run in a POSIX shell, because it
needs to run everywhere and at least say "sorry, I must skip these tests
because I don't have bash".

This issue is made more confusing by the fact that the tool you are
testing is itself a shell. But let us imagine for a moment that you want
to test some tool "foo" that may or may not exist on the system. Then
you would execute the harness via the POSIX shell. Then you would first
check whether "foo" is available (either using "type", or by checking a
build option like NO_FOO). If not, then you would skip all tests, and if
so, you would continue to perform tests using "foo".

So we want the same effect here; you must be able to run the bare
minimum of harness to get to the "skip or run" decision with a POSIX
shell. So you could write it as a pure-sh harness that runs:

  bash -c '. git-completion.bash &&
           some_actual_test'

in each test (or some equivalent). But because the tool you are testing
is in fact a POSIX-compatible shell, you have chosen to instead run all
of the post-skip-decision parts directly inside the harness. Which is
fine by me, but I think is what makes the issue more confusing.

So what is the appropriate shebang line? The first part _must_ be POSIX
shell, but the latter part need not be. I would argue for the lowest
common denominator, as that is what you need for the script to get to
the decision point (and possibly not just exit, but actually run bash).

> For example, if /bin/sh points to
> dash (which is the case in debian AFAIK), the test would fail in the
> middle of it. #!/bin/bash would be more proper; it would properly
> document that you need bash to run this. Sure, maybe bash is not in
> /bin (I have never seen that),

You see this on systems where bash is not part of the base system (e.g.,
Solaris). I think it is also the case on FreeBSD (because bash comes
from ports and gets installed in /usr/local), though it has been years
since I have run FreeBSD, so that may no longer be the case.

> but that would not affect 'make tests',

The shebang line does not affect people who run "make test", but the
fact that the script does not run under a POSIX shell does (and that is
primarily what I was complaining about).

> only the people that want to run this directly, which I suspect are
> very, *very* few, and they would immediately see a clear error:
> './blah: /bin/bash: bad interpreter: No such file or directory', and
> then they could easily try 'bash ./blah'.

Yes, but why make them do that? The script must be able to run and at
least exit gracefully under a POSIX shell (or hopefully find and exec
bash itself) in order for "make test" to work. So since it must contain
code to handle this already, why not have #!/bin/sh in the shebang line
and simply let the code run as it would under "make test"?

> So? 'make test' fails on my Arch Linux box which doesn't have
> /usr/bin/python, which is presumably why there is NO_PYTHON.

We design our test suite to succeed everywhere, and Junio does not push
out master unless it passes (or skips) all tests. If it doesn't, then
either there is a build option (like NO_PYTHON) that you should set, or
there is a bug which should be fixed.  But that is not an excuse to
blatantly violate the existing property of the suite with a new test.

> Instead of doing some nasty hacks such as 'bash
> <<\END_OF_BASH_SCRIPT', it would be much easier to have a NO_BASH
> option. And in fact, when zsh completion tests are available, NO_ZSH
> (probably on by default).

Yeah, we could do that. Though I think it is nice to run the bash tests
even when $SHELL_PATH does not point to bash, since it gets test
coverage on systems that would otherwise not have it (e.g., on debian
systems where /bin/sh is dash). So I would prefer to find and run bash
if it exists, and save NO_BASH for the case of "yes, I have bash, but it
is old or broken, so do not bother to run the tests".

> But you clearly prefer the status quo, so I'm not going to bother.

I'm not even sure what to make of this. I've already said I like the
concept of your patch, that it does not meet the requirements of the
test suite, and tried to work out a solution for meeting that
requirement so we can apply it. How in the world does that equate to the
status quo?

-Peff
