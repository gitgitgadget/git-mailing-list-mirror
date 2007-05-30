From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Wed, 30 May 2007 21:43:47 +0200
Message-ID: <87abvmp05o.fsf@rho.meyering.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
	<7v1wh0bpv2.fsf@assigned-by-dhcp.cox.net>
	<87myzmr152.fsf@rho.meyering.net>
	<7vd50i2o9c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 21:44:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtU5i-00035K-Iy
	for gcvg-git@gmane.org; Wed, 30 May 2007 21:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786AbXE3Tnu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 15:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754422AbXE3Tnu
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 15:43:50 -0400
Received: from mx.meyering.net ([82.230.74.64]:56493 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786AbXE3Tnt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 15:43:49 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 9A3CF28CB8; Wed, 30 May 2007 21:43:47 +0200 (CEST)
In-Reply-To: <7vd50i2o9c.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed\, 30 May 2007 10\:51\:43 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48784>

Junio C Hamano <junkio@cox.net> wrote:
> Jim Meyering <jim@meyering.net> writes:
>> Junio C Hamano <junkio@cox.net> wrote:
>>> Jim Meyering <jim@meyering.net> writes:
>>>
>>>> Of course error messages are annoying when your short-pipe-read is
>>>> _deliberate_ (tho, most real uses of git tools will actually get no
>>>> message to be annoyed about[*]), but what if there really *is* a mistake?
>>>> Try this:
>>>>
>>>>     # You want to force git to ignore the error.
>>>>     $ trap '' PIPE; git-rev-list HEAD | sync
>>>>     $
>>>
>>> It is perfectly valid (although it is stupid) for a Porcelain
>>> script to do this:
>>>
>>>     latest_by_jim=$(git log --pretty=oneline --author='Jim' | head -n 1)
>>>     case "$latest_by_jim" in
>>>     '') echo "No commit by Jim" ;;
>>>     *)  # do something interesting on the commit
>>>         ;;;
>>>     esac
>>
>> Hi Junio,
>>
>> The above snippet (prepending a single #!/bin/bash line) doesn't provoke
>> an EPIPE diagnostic from my patched git.  In fact, even if you're using
>> an old, unpatched version of bash, it provokes *no* diagnostic at all.
>
>> To provoke a diagnostic (from bash, not git), using old unpatched bash,
>> you need a script doing output from a subshell, e.g.:
>>
>>     #!/tmp/bash-3.0/bash
>>     for x in 1; do
>>       git-log
>>     done | head -1
>
> I haven't thought it through, but isn't the above example only
> talking about the "Broken pipe" message?  Surely, you would get

I'm not sure which "Broken pipe" message you mean.

There are two types of "Broken pipe" messages.
There's the old, verbose one from bash that includes script line-number,
pid, and killed command name.  Old, unpatched versions of bash
print that message whenever bash kills a process with SIGPIPE.

Then there's the application (EPIPE) one, that can be printed
by a writing application like git,cat,seq,etc. only when SIGPIPE
stops a write but doesn't kill the writer.
In that case, the write syscall fails with errno==EPIPE,
and if it's diagnosed by the application, you get e.g.,

  seq: write error: Broken pipe

Since the script above is not ignoring SIGPIPE, the git-log process
is killed by bash-3.0, and that old version of bash announces the killing
with the verbose message:

  /t/bp-demo: line 2: 14474 Broken pipe             git-log

Any other patched or newer version of bash will print the
single requested line on stdout and nothing on stderr.

> that message from older Bash if you have a shell loop on the
> upstream side of the pipe no matter what we (the command that is
> run by the shell loop) do, and trap is needed to squelch it.

Right.
That's why no one is using such broken shells anymore.
And why no porcelain tools incur the penalty of ignoring
SIGQUIT anymore either.

> But I do not see how this pipeline, where git-rev-list produces
> more than what fits in the in-kernel pipe buffer:
>
> 	"git-rev-list a lot of data | head -n 1"
>
> would not catch EPIPE and say "Broken Pipe" with your patch.

I haven't debugged the old bash to see why that first one
fails to provoke a broken pipe message (from bash).
Unless you add a line like "trap '' PIPE" before it, bash kills
the writer with SIGPIPE, and so my patch is irrelevant,
because the failing write syscall never returns.

> Especially if the downstream is sufficiently slow (say, replace
> it with "(sleep 10 && head -n 1)", perhaps), wouldn't the
> upstream produce enough without being read, gets stuck on write,
> and when the downstream exits, it would notice its write(2)
> failed with EPIPE, wouldn't it?

Are you presuming SIGPIPE is ignored?

> Maybe you are talking about your updated patch?

I was talking about the initial patch, or the one that
also removed the errno == EPIPE tests.
