From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Wed, 30 May 2007 13:39:37 +0200
Message-ID: <87myzmr152.fsf@rho.meyering.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
	<7v1wh0bpv2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 13:39:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtMWz-0000va-6L
	for gcvg-git@gmane.org; Wed, 30 May 2007 13:39:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbXE3Ljk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 07:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751576AbXE3Ljk
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 07:39:40 -0400
Received: from mx.meyering.net ([82.230.74.64]:55991 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbXE3Ljj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 07:39:39 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id BA0C928CB8; Wed, 30 May 2007 13:39:37 +0200 (CEST)
In-Reply-To: <7v1wh0bpv2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Mon\, 28 May 2007 14\:27\:45 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48752>

Junio C Hamano <junkio@cox.net> wrote:
> Jim Meyering <jim@meyering.net> writes:
>
>> Of course error messages are annoying when your short-pipe-read is
>> _deliberate_ (tho, most real uses of git tools will actually get no
>> message to be annoyed about[*]), but what if there really *is* a mistake?
>> Try this:
>>
>>     # You want to force git to ignore the error.
>>     $ trap '' PIPE; git-rev-list HEAD | sync
>>     $
>
> It is perfectly valid (although it is stupid) for a Porcelain
> script to do this:
>
>     latest_by_jim=$(git log --pretty=oneline --author='Jim' | head -n 1)
>     case "$latest_by_jim" in
>     '') echo "No commit by Jim" ;;
>     *)  # do something interesting on the commit
>         ;;;
>     esac

Hi Junio,

The above snippet (prepending a single #!/bin/bash line) doesn't provoke
an EPIPE diagnostic from my patched git.  In fact, even if you're using
an old, unpatched version of bash, it provokes *no* diagnostic at all.

To provoke a diagnostic (from bash, not git), using old unpatched bash,
you need a script doing output from a subshell, e.g.:

    #!/tmp/bash-3.0/bash
    for x in 1; do
      git-log
    done | head -1

With unpatched bash-3.0, it does this:

    commit 42e3a6f676e9ae4e9640bc2ff36b7ab0b061a60e
    /tmp/bp-demo: line 2: 24864 Broken pipe             git-log

It's only if you try to avoid the above and change your script to
ignore SIGPIPE do you finally get an offending EPIPE diagnostic:

    #!/tmp/bash-3.0/bash
    trap '' PIPE
    for x in 1; do
      ./git-log; echo $? 1>&2
    done | head -1

Here's its output, using my patch:

    commit 42e3a6f676e9ae4e9640bc2ff36b7ab0b061a60e
    fatal: write failure on standard output
    128

That trap has the nasty side effect of making the poorly written script
wait until "git-log" has completed (before, it was interrupted right
away), so it can take a lot longer.  With my patch, it also gives a
diagnostic, which might serve to inform someone that they should not
ignore SIGPIPE.

No porcelain (modulo [*]) in git proper or cogito ignores SIGPIPE,
so I don't see how EPIPE error diagnostics can be a problem.

[*] These scripts do ignore SIGPIPE, but either don't need to,
or can/should be fixed not to:

   git-archimport.perl
   git-cvsimport.perl
   git-svnimport.perl

And, yes, I'd be happy to fix them, if anyone is interested.

> In such a case, it is a bit too much for my taste to force the
> script to redirect what comes out of fd 2 of the upstream of the
> pipe, so that it can filter out only the "write error" message
> but still show other kinds of error messages.  You could do so
> by elaborate shell magic, perhaps like this:
>
>         filter_pipe_error () {
>                 exec 3>&1
>                 (eval "$1" 2>&1 1>&3 | grep >&2 -v 'Broken pipe')
>         }
>
> 	latest_by_jim=$(filter_pipe_error \
>         	'git log --pretty=oneline --author='\''Jim'\'' | head -n 1'
> 	)

I agree that would be extreme.  But it's not necessary, since the
'Broken pipe' diagnostic appears now only in contrived circumstances.

> but what's the point?
>
> I think something like this instead might be more palatable.

...[patch to make git/EPIPE exit nonzero, but with no diagnostic]

Thank you for taking the time to reply and to come up with a compromise.
At first I thought this would be a step in the right direction, but,
now that I understand how infrequently EPIPE actually comes into play,
I think it'd be better to avoid a half-measure fix, since that would
just perpetuate the idea that EPIPE is worth handling specially.

Jim
