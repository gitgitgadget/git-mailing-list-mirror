From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Tue, 29 May 2007 22:19:46 +0200
Message-ID: <87r6ozs7q5.fsf@rho.meyering.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	<87odk6y6cd.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705270904240.26602@woody.linux-foundation.org>
	<87sl9hw0o0.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705280929140.26602@woody.linux-foundation.org>
	<871wh0ww80.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705281957160.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 29 22:19:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht8Ad-0007us-JK
	for gcvg-git@gmane.org; Tue, 29 May 2007 22:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbXE2UTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 16:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752289AbXE2UTs
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 16:19:48 -0400
Received: from mx.meyering.net ([82.230.74.64]:48506 "EHLO mx.meyering.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751875AbXE2UTr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 16:19:47 -0400
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 457245560F; Tue, 29 May 2007 22:19:46 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.98.0705281957160.26602@woody.linux-foundation.org> (Linus Torvalds's message of "Mon\, 28 May 2007 20\:01\:15 -0700 \(PDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48708>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 28 May 2007, Jim Meyering wrote:
>>
>> Um... maybe you've forgotten that this patch fixes a hole in the
>> "old code" (git.c).  Many git tools ignore write (ENOSPC) failures.
>
> Maybe you have not noticed, but my argument has ben about EPIPE.

Ha ha.  That's a good one.
The point was that even you must see that your
"[Jim's] WHOLE patch is crap" statement was wrong.

>>   1) Continue to ignore EPIPE write failure: can obscure real errors.
>>        BTW, Linus, don't you agree?  You never commented on this point.
>
> THAT'S THE ONLY THING I'VE BEEN COMMENTING ON!
>
> They aren't "obscure real errors". EPIPE is neither obscure _nor_ an
> error.

Reread #1, above.
"ignore EPIPE write failure: can obscure real errors" (using "obscure"
as a verb, not an adjective) means that ignoring EPIPE failure can cause
git commands to hide/mask/paper-over a real, conceptual error like this:

    # This is obviously bogus shell code:
    # "cat" with an argument like this doesn't read stdin
    git-rev-list HEAD | cat foo | ...

We're really on the head of a pin here, since the EPIPE test
makes a difference only when SIGPIPE is being ignored (unusual).
Note that ignoring SIGPIPE can cause gross inefficiencies or
even expose bugs.  E.g., On Solaris 10, this infloops:

  (trap '' PIPE; /bin/yes) |head -1

so there are good reasons *not* to ignore SIGPIPE.  Add to that the fact
that the condition provoking an EPIPE is not *that* common, and you
begin to see that even if EPIPE is a little different, it doesn't matter
enough to justify polluting every application file-close test with an
EPIPE exemption.

> The code-paths where you removed EPIPE handlign have two cases:
>  - SIGPIPE happens: you made no change
>  - SIGPIPE diesn't happen: you broke the code.
>
> So remind me again, why the hell do you think your patch is so great and
> so important,

Whoa!  I guess you had a bad day, yesterday.

I try to be humble, and certainly have not been crowing that this
tiny patch is "so great and so important."  However, I did defend it
when you claimed that the whole thing was crap.

> considering that it broke real code, and made things worse?

I believe it is an IMPROVEMENT to make such mistakes detectable (exit
nonzero), and that the risk of annoying users with EPIPE diagnostics is
minimal.  You seem to think there would be some outpouring of "broken
pipe" errors, but since so few Porcelains ignore SIGPIPE, I disagree.

However, it's an improvement only in the unusual event that SIGPIPE is
being ignored, which is also when an application may output the "broken
pipe" error.  IMHO, these conditions are rare enough (now) that there's
no point in making an exception for EPIPE everywhere.

> And why don't you just admit that EPIPE is special, isn't an error, and
> shouldn't be complained about? If you get EPIPE on the write, it means
> "the other end didn't care". It does NOT mean "I should now do a really
> annoying message".

Sure, EPIPE is special, but it is so unusual now that it's not
worth even the small added complexity to treat it specially in all
application code.

> It's that simple. You seem to admit that SIGPIPE handling in bash should
> have been fixed, and that it was annoying to complain about it there. Why

Yes. When bash-3.0 announced each process-killing-via-SIGPIPE with e.g.,
    /some/script: line 2: 31994 Broken pipe     seq 99999
that was a big deal because it affected many scripts.

> can't you just admit that it's annoyign and wrong to complain about the
> same thing when it's EPIPE?

If it happened a lot, it *would* be annoying, but that's just it:
it doesn't happen much at all anymore.

Also, no one is complaining about EPIPE diagnostics from any of
the GNU coreutils, and I take that as a good indication that there
is no problem.
