From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: git gc & deleted branches
Date: Fri, 09 May 2008 20:07:44 -0400
Message-ID: <877ie3yqb3.fsf@jeremyms.com>
References: <20080508210125.GC32762@sigill.intra.peff.net>
	<alpine.LFD.1.10.0805081712270.23581@xanadu.home>
	<20080508211734.GA819@sigill.intra.peff.net>
	<48236F69.2060900@nrlssc.navy.mil>
	<20080508213107.GA1016@sigill.intra.peff.net>
	<48237344.6070405@nrlssc.navy.mil>
	<20080508214454.GA1939@sigill.intra.peff.net>
	<48237650.5060008@nrlssc.navy.mil>
	<20080508224827.GA2938@sigill.intra.peff.net>
	<loom.20080509T011318-478@post.gmane.org>
	<20080509041921.GA14773@sigill.intra.peff.net>
	<E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com>
	<48246A44.7020303@nrlssc.navy.mil>
	<alpine.LFD.1.10.0805091205580.23581@xanadu.home>
	<7vwsm39kft.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Geert Bosch <bosch@adacore.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 10 02:09:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuceS-0003vc-Mv
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 02:09:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757196AbYEJAIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 20:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756576AbYEJAIf
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 20:08:35 -0400
Received: from deleuze.hcoop.net ([69.90.123.67]:43336 "EHLO deleuze.hcoop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756485AbYEJAId (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 20:08:33 -0400
Received: from [67.165.107.197] (helo=localhost)
	by deleuze.hcoop.net with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <jbms@cmu.edu>)
	id 1Jucd1-0004PE-As; Fri, 09 May 2008 20:07:55 -0400
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
In-Reply-To: <7vwsm39kft.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 09 May 2008 15:33:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81636>

Junio C Hamano <gitster@pobox.com> writes:

> Nicolas Pitre <nico@cam.org> writes:
>> On Fri, 9 May 2008, Brandon Casey wrote:
>> 
>>> Unreferenced objects are sometimes used by other repositories which have
>>> this repository listed as an alternate. So it may not be a good idea to
>>> make the unreferenced objects inaccessible.
>> 
>> Nah.  If this is really the case then you shouldn't be running gc at all 
>> in the first place.

> True.

> I think the true motivation behind --keep-unreachable is not about the
> shared object store (aka "alternates") but about races between gc and
> push (or fetch).  Before push (or fetch) finishes and updates refs, the
> new objects they create would be dangling _and_ the objects these dangling
> objects refer to may be packed but unreferenced.  Repacking unreferenced
> packed objects was a way to avoid losing them.

I feel like the current approach of (not very well) keeping track of
which objects are still needed is very messy, not very well defined or
based on specific solid principles, and prone to errors and losing
objects.

Things like git clone -shared can only really be used in extremely
specialized setups, or if pruning of unreferenced objects is completely
disabled in the source repository, or if specialized scripts are used to
do the garbage collection that take into account the references of the
"child" repository.  It is my impression that even repo.or.cz, while it
has some safe guards, does not even completely safely handle garbage
collection.  Probably it would be very useful to examples of such
scripts in contrib.

I think that ultimately, some general purpose and reliable solution
needs to be found to handle the cases of (1) a repository having its
objects referenced by another via info/alternates; (2) a repository with
multiple working directories (presumably this should warn/error out
unless given a force option/detach head and warn if you try to switch
HEAD for some working directory to the same branch as some other working
directory).  It seems, btw, that a third type of clone, one which merely
symlinks the objects directory, would also be useful, once there is a
solution to the robustness issue.  This would be a case (3) that needs
to be handled as well.

It seems that clear that ultimately, to handle these three cases, every
repository needs to know about every other repository, probably via a
symlink to other repository's .git directory.  Git gc would then also
examine any refs in this directory, making sure to avoid circular
references that might result from following the symlinks.  It should
also probably error out if it finds a symlink that doesn't point to a
valid git repository, because such a symlink either refers to a
now-deleted repository for which the symlink needs to be cleaned up, or
it refers to a repository that was moved and therefore the symlink needs
to be updated.  Simply ignoring invalid symlinks could result in pruning
objects that need to be kept for repositories that have moved.

It is extremely cumbersome to have to worry about whether there are
other concurrent accesses to the repository when running e.g. git gc.
For servers, you may never be able to guarantee that nothing else is
accessing the repository concurrently.  Here is a possible solution:

Each git process creates a log file of the references that it has
created.  The log file should be named in some way with e.g. the process
id and start time of the process, and simply consist of a list of
20-byte sha1 hashes to be considered additional in-use references for
the purpose of garbage collection.  The log file would be cleaned up
when the process exits, and would also be deleted by any instance of git
gc that notices a stale log file that doesn't correspond to a running
process.  To handle shell scripts that need to deal with git-hash-object
directly, git hash-object could be passed maybe a file descriptor or
filename of a log file to use instead of creating one.  Maybe the log
file format could be more complicated, and also support paths to
e.g. alternate index files to also consider for references.  Things
would need to be one so that race conditions do not occur, but I think
something like this would work.

-- 
Jeremy Maitin-Shepard
