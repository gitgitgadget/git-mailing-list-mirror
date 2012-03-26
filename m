From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH 0/2] Make run-command.c honour SHELL_PATH
Date: Mon, 26 Mar 2012 09:38:45 -0400
Message-ID: <1332768900-sup-4533@pinkfloyd.chass.utoronto.ca>
References: <1332678696-4001-1-git-send-email-bwalton@artsci.utoronto.ca> <20120326011148.GA4428@burratino>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster <gitster@pobox.com>, peff <peff@peff.net>,
	git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 15:38:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCA8M-000338-V3
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 15:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446Ab2CZNit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 09:38:49 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:48791 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757182Ab2CZNis (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 09:38:48 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:33343 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SCA8D-0004El-Dq; Mon, 26 Mar 2012 09:38:45 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SCA8D-0001yF-CJ; Mon, 26 Mar 2012 09:38:45 -0400
In-reply-to: <20120326011148.GA4428@burratino>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193911>

Excerpts from Jonathan Nieder's message of Sun Mar 25 21:11:48 -0400 2012:

Hi Jonathan,

> > In this case, the failing test was t7006-pager:command-specific
> > pager.  That test (and some subsequent ones) were setting the pager
> > command used by git log to "sed s/^/foo:/ >actual" which is fine in a
> > POSIX-compliant sh, but not in Solaris' sh.  If the user PATH at
> > runtime happened to allow the broken system sh used instead of a sane
> > sh, the ^ is interpreted the same as[1] | and this caused sed to fail
> > with incomplete s/ command and a "command not found: /foo:" from the
> > other forked process.
> 
> When I first read the corresponding patch without reading this cover
> letter I was mystified.  Until I saw the above paragraph, I did not
> even see what problem was being solved.  The above paragraph should
> probably be part of the commit message.

Ok, that's fair.  I thought the commit message was self-contained
enough to justify the change, but point taken. :)  I'll redo the
commit log and squash the two patches as per your later points.

> My first reaction was to suspect the series is solving the problem
> in the wrong place.  The core of the bug might be t7006 itself,
> which assumes that the shell used to interpret the GIT_PAGER setting
> is a POSIX-style shell rather than an ancient Bourne shell or
> cmd.exe.  In the far long term, we should probably skip this test on
> some platforms using an appropriate test prerequisite.

I started looking through t7006 first as well, thinking that some
non-POSIX syntax had slipped in... This raises a good point though.
I'd come at this thinking that things _should_ be able to rely on a
POSIX shell (or a modern standard, anyway) for things like this.  Is
there any sort of defined expectation for this?

>From my point of view, I'd expect the command to be spawned under
something sane on the current platform.  I haven't looked for this
specifically, but this code path would still try to fork 'sh' on
Windows as far as my understanding of it goes.  I don't use git there,
so I don't know if part of the installation sets up a usable sh
too.

> To put it another way, the RUN_USING_SHELL magic is just supposed to
> be a more featureful way to do what system() normally does.  What
> shell does system() use on Solaris?

This depends on some macros.  The default is /usr/bin/sh, but if
various XOPEN-type macros are set, it will use /usr/xpg4/bin/sh.

> A second reaction was to wonder why the usual fixup from
> v1.6.4-rc0~66^2~1 (Makefile: insert SANE_TOOL_PATH to PATH before
> /bin or /usr/bin, 2009-07-08) didn't apply.  Should the git wrapper
> prepend the same magic to $PATH that git-sh-setup.sh does to make
> the behavior of scripted and unscripted commands a little more
> consistent?

I did some poking at this before creating my patch as that is what I'd
expected too.  It would likely be a good idea, but in my case, even
that wouldn't help.

I add /opt/csw/gnu:/opt/csw/bin:/usr/xpg4/bin to the SANE_TOOL_PATH
but set the SHELL_PATH to /opt/csw/bin/bash.  Without my patch, but
with SANE_TOOL_PATH honoured, I'd still see /opt/csw/bin/sh forked and
that sh is crippled too.

So that leads me to think that if we're going to fork a shell, it
should be one that we know to be good...if the builder has provided
that value.  I think you agree with this based on your next comment.

> A third reaction was that git_pager in the sh-setup library uses the
> eval builtin, so we are already assuming that GIT_PAGER is
> appropriate input for a POSIX-style shell.  So maybe the approach
> you've adopted is appropriate after all, at least in the short term
> while we require a POSIX-style shell elsewhere in git.

I'm unclear what you're meaning by this.  Are you implying that the
requirement for a POSIX-style shell should be relaxes to the point
where things don't rely on that base set of functionality?

> A few added words in the commit message could save the next reader
> from going through so long a thought process before seeing why what
> the patch does is the right thing to do.

Ok, I can re-do the commit message to incorporate notes about the
broken text and some of your rationale above.

> A more minor comment: patch 1/2 was even more mysterious.  Combining
> the two patches would be enough to avoid confusion there.  I haven't
> checked the makefile changes and interaction with GIT-CFLAGS
> carefully yet and hope to do so in the next round.

To me they were two logically separate changes, so I split them.  I
don't mind squashing it together though.

I'll resubmit later today.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
