From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: git gc & deleted branches
Date: Fri, 09 May 2008 20:43:52 -0400
Message-ID: <873aoryomv.fsf@jeremyms.com>
References: <20080508214454.GA1939@sigill.intra.peff.net>
	<48237650.5060008@nrlssc.navy.mil>
	<20080508224827.GA2938@sigill.intra.peff.net>
	<loom.20080509T011318-478@post.gmane.org>
	<20080509041921.GA14773@sigill.intra.peff.net>
	<E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com>
	<48246A44.7020303@nrlssc.navy.mil>
	<alpine.LFD.1.10.0805091205580.23581@xanadu.home>
	<7vwsm39kft.fsf@gitster.siamese.dyndns.org> <877ie3yqb3.fsf@jeremyms.com>
	<20080510002014.GH29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Geert Bosch <bosch@adacore.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat May 10 02:45:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JudDU-0004j5-CE
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 02:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464AbYEJAod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 20:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756576AbYEJAod
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 20:44:33 -0400
Received: from deleuze.hcoop.net ([69.90.123.67]:53529 "EHLO deleuze.hcoop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678AbYEJAob (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 20:44:31 -0400
Received: from c-67-165-107-197.hsd1.pa.comcast.net ([67.165.107.197] helo=localhost)
	by deleuze.hcoop.net with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <jbms@cmu.edu>)
	id 1JudBw-0008Tw-6w; Fri, 09 May 2008 20:44:00 -0400
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
In-Reply-To: <20080510002014.GH29038@spearce.org> (Shawn O. Pearce's message
	of "Fri, 9 May 2008 20:20:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81639>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Jeremy Maitin-Shepard <jbms@cmu.edu> wrote:
>> It is extremely cumbersome to have to worry about whether there are
>> other concurrent accesses to the repository when running e.g. git gc.
>> For servers, you may never be able to guarantee that nothing else is
>> accessing the repository concurrently.  Here is a possible solution:
>> 
>> Each git process creates a log file of the references that it has
>> created.  The log file should be named in some way with e.g. the process
>> id and start time of the process, and simply consist of a list of
>> 20-byte sha1 hashes to be considered additional in-use references for
>> the purpose of garbage collection.

> I believe we partially considered that in the past and discarded it
> as far too complex implementation-wise for the benefit it gives us.

It doesn't seem all that complex, and I'd say that fundamentally it is
the _correct_ way to do things.  Being sloppy is always easier in the
short run, but then either means the system is permanently broken or
results in a lot of "fixing up" work later.  I think almost all of the
work of handling these log files could be done without impacting a lot
of code that calls the relevant APIs that would actually use the log
files.  I think the biggest impact would be on non-C code, but even for
that code, appropriate wrapper could be used to avoid having to make
many changes.

> The current approach of leaving unreachable loose objects around
> for 2 weeks is good enough.  Any Git process that has been running
> for 2 weeks while still not linking everything it needs into the
> reachable refs of that repository is already braindamaged and
> shouldn't be running anymore.

This sort of reasoning just leads to an inherently unreliable system.
Sure, two weeks might seem good enough for nearly all cases, but why
_shouldn't_ I be able to leave my editor open for two weeks before
typing in my commit message and finishing the commit, or wait for two
weeks in the middle of a rebase (it seems that in the new
implementation, temporary refs are created basically to do the same
thing as the log file I described.)  I could easily be typing up my
commit message, then switch to something else, and happen not to come
back to it for two weeks.

Because such a "timeout" based solution isn't really the "correct
solution" but will work most of the time, potential problems won't be
noticed while testing.

Another significant issue is that this timeout means that unreferenced
junk has to stay around in the repository for two weeks for no (good)
reason.

> If we are dealing with a pack file, those are protected by .keep
> "lock files" between the time they are created on disk and the
> time that the git-fetch or git-receive-pack process has finished
> updating the refs to anchor the pack's contents as reachable.
> Every once in a while a stale .keep file gets left behind when a
> process gets killed by the OS, and its damn annoying to clean up.

> I'd hate to clean up logs from every little git-add or git-commit
> that aborted in the middle uncleanly.

First of all, merely exiting due to an error should not cause log files
to be left around.  The only thing that should cause log files to be
left around is kill -9 or a system crash.  Second, by storing the
process id and a timestamp of when the log file was created, it is
possible to reliably determine if a log file is stale.

-- 
Jeremy Maitin-Shepard
