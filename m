From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Sun, 27 May 2007 11:16:18 +0200
Message-ID: <87odk6y6cd.fsf@rho.meyering.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun May 27 11:16:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsErU-0008AG-IU
	for gcvg-git@gmane.org; Sun, 27 May 2007 11:16:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbXE0JQV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 05:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbXE0JQV
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 05:16:21 -0400
Received: from mx.meyering.net ([82.230.74.64]:33682 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750839AbXE0JQU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 05:16:20 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id CB50D2F633; Sun, 27 May 2007 11:16:18 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org> (Linus Torvalds's message of "Sat\, 26 May 2007 09\:18\:20 -0700 \(PDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48525>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Sat, 26 May 2007, Jim Meyering wrote:
>>
>> Each git command should report such a failure.
>> Some already do, but with the patch below, they all do, and we
>> won't have to rely on code in each command's implementation to
>> perform the right incantation.
>
> The patch is wrong.

What you should have said is that the patch is fine in principle, since
it does fix a pretty serious bug (important tools ignoring ENOSPC),
but you'd prefer that it continue to ignore EPIPE.

With a name like yours, being more positive would go a long way toward
encouraging (or rather *not discouraging*) contributions.

> Some write errors are expected and GOOD.
>
> For example, EPIPE should not be reported. It's normal. The user got
> bored. It might be hidden by the SIGPIPE killing us, but regardless,
> reporting it for the normal log/diff thing is just not correct. EPIPE
> isn't an error, it's a "ok, nobody is listening any more".

I have to disagree.  There may be precedent for hiding EPIPE errors,
but that is not the norm among command line tools wrt piped stdout.

First of all, one has to work just to get such an error.  These days,
most people use a shell that doesn't ignore, handle or block SIGPIPE, so
direct use of a program like git-log or git-diff gets the signal directly,
and there's no EPIPE error.  E.g., try "cat", and you see it gets SIGPIPE
(141=128+SIGPIPE(13)):

    $ seq 90000|(cat; echo $? >&2) | head -1 > /dev/null
    141

However, you can tweak your shell to handle/ignore SIGPIPE.  Also,
some porcelain scripts do ignore SIGPIPE.  Then, a program run in that
environment does see EPIPE.  Consider how a few other non-interactive
programs work when one of their stdout-writing syscalls fails with EPIPE:

Try GNU diff and sed:
[now, using shorter ":" in place of more realistic head -1]

    $ (trap '' PIPE; seq 90000|diff - /dev/null;echo $? >&2)| :
    diff: standard output: Broken pipe
    2
    $ (trap '' PIPE; seq 90000|sed s/a/b/; echo $? 1>&2)| :
    /bin/sed: couldn't write 5 items to stdout: Broken pipe
    seq: write error: Broken pipe
    4

Try tee (from GNU coreutils):

    $ (trap '' PIPE; seq 90000|tee /dev/null; echo $? >&2) | :
    tee: standard output: Broken pipe
    tee: write error
    1

sort, tac, cut, fold, od, head, tail, tr, uniq, etc. all work the same
way, if you're using the coreutils.  But perhaps that's not fair, since
I maintain the coreutils.  And there is some variance among how other-
vendor versions of those tools work.  E.g., Solaris 10's /bin/cat
diagnoses the error, but neither /bin/sort nor /bin/diff do.

As for version control tools, monotone does what I'd expect in
this situation: "mtn diff" reports the failure and exits nonzero.

svn and cvs also report the error, although they both exit successfully
in spite of that.  I tried both log and diff commands for each tool.
cvs catches the signal, svn doesn't.

mercurial and darcs totally ignore the write error and SIGPIPE,
so there is no way to determine from stderr or exit code whether
their writes complete normally.

For any tool whose output might be piped to another, the pipe-writing
tool should exit nonzero for any write error.  Otherwise, its exit code
ends up being a lie, pretending success but, in effect, covering up for
a failure.  In general, I've found that papering over syscall failures
makes higher-level problems harder to diagnose.

Do you really want git-log to continue to do this?

    $ (trap '' PIPE; git-log; echo $? >&2 ) | :
    0

With my patch, it does this:

    $ (trap '' PIPE; ./git-log; echo $? >&2 ) | :
    fatal: write failure on standard output: Broken pipe
    128

> Also, PLEASE don't do this:
>
>> +		if (0 <= fcntl(fileno (stdout), F_GETFD)

Since Junio is making an effort to "conform",
I too will make the effort when contributing to git.
