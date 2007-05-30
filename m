From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Wed, 30 May 2007 10:51:43 -0700
Message-ID: <7vd50i2o9c.fsf@assigned-by-dhcp.cox.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
	<7v1wh0bpv2.fsf@assigned-by-dhcp.cox.net>
	<87myzmr152.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Wed May 30 19:51:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtSKs-0000YT-Q5
	for gcvg-git@gmane.org; Wed, 30 May 2007 19:51:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118AbXE3Rvp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 13:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753387AbXE3Rvp
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 13:51:45 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64292 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbXE3Rvo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 13:51:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070530175143.JFNN19731.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 30 May 2007 13:51:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 5Vrj1X00B1kojtg0000000; Wed, 30 May 2007 13:51:43 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48776>

Jim Meyering <jim@meyering.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Jim Meyering <jim@meyering.net> writes:
>>
>>> Of course error messages are annoying when your short-pipe-read is
>>> _deliberate_ (tho, most real uses of git tools will actually get no
>>> message to be annoyed about[*]), but what if there really *is* a mistake?
>>> Try this:
>>>
>>>     # You want to force git to ignore the error.
>>>     $ trap '' PIPE; git-rev-list HEAD | sync
>>>     $
>>
>> It is perfectly valid (although it is stupid) for a Porcelain
>> script to do this:
>>
>>     latest_by_jim=$(git log --pretty=oneline --author='Jim' | head -n 1)
>>     case "$latest_by_jim" in
>>     '') echo "No commit by Jim" ;;
>>     *)  # do something interesting on the commit
>>         ;;;
>>     esac
>
> Hi Junio,
>
> The above snippet (prepending a single #!/bin/bash line) doesn't provoke
> an EPIPE diagnostic from my patched git.  In fact, even if you're using
> an old, unpatched version of bash, it provokes *no* diagnostic at all.

> To provoke a diagnostic (from bash, not git), using old unpatched bash,
> you need a script doing output from a subshell, e.g.:
>
>     #!/tmp/bash-3.0/bash
>     for x in 1; do
>       git-log
>     done | head -1

I haven't thought it through, but isn't the above example only
talking about the "Broken pipe" message?  Surely, you would get
that message from older Bash if you have a shell loop on the
upstream side of the pipe no matter what we (the command that is
run by the shell loop) do, and trap is needed to squelch it.

But I do not see how this pipeline, where git-rev-list produces
more than what fits in the in-kernel pipe buffer:

	"git-rev-list a lot of data | head -n 1"

would not catch EPIPE and say "Broken Pipe" with your patch.
Especially if the downstream is sufficiently slow (say, replace
it with "(sleep 10 && head -n 1)", perhaps), wouldn't the
upstream produce enough without being read, gets stuck on write,
and when the downstream exits, it would notice its write(2)
failed with EPIPE, wouldn't it?

Maybe you are talking about your updated patch?

> ...[patch to make git/EPIPE exit nonzero, but with no diagnostic]
>
> Thank you for taking the time to reply and to come up with a compromise.
> At first I thought this would be a step in the right direction, but,
> now that I understand how infrequently EPIPE actually comes into play,
> I think it'd be better to avoid a half-measure fix, since that would
> just perpetuate the idea that EPIPE is worth handling specially.

After having read what Linus said about how the "fixed" one
would behave differently, depending on the amount of data we
produce before the consumer says "I've seen enough" and
depending on the amount of data that would fit in the in-kernel
pipe buffer, I no longer think the compromise patch you mention
above is improvement anymore.
