From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: git gc & deleted branches
Date: Fri, 09 May 2008 21:51:15 -0400
Message-ID: <87y76jx6y4.fsf@jeremyms.com>
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
	<7vskwr9coz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Geert Bosch <bosch@adacore.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 10 03:52:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JueGd-0000pN-Lq
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 03:52:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbYEJBwF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 21:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbYEJBwD
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 21:52:03 -0400
Received: from deleuze.hcoop.net ([69.90.123.67]:34259 "EHLO deleuze.hcoop.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbYEJBwA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 21:52:00 -0400
Received: from [67.165.107.197] (helo=localhost)
	by deleuze.hcoop.net with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <jbms@cmu.edu>)
	id 1JueFD-0007su-PY; Fri, 09 May 2008 21:51:28 -0400
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
In-Reply-To: <7vskwr9coz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 09 May 2008 18:21:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81642>

Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> Jeremy Maitin-Shepard <jbms@cmu.edu> wrote:
>>> It is extremely cumbersome to have to worry about whether there are
>>> other concurrent accesses to the repository when running e.g. git gc.
>>> For servers, you may never be able to guarantee that nothing else is
>>> accessing the repository concurrently.  Here is a possible solution:
>>> 
>>> Each git process creates a log file of the references that it has
>>> created.  The log file should be named in some way with e.g. the process
>>> id and start time of the process, and simply consist of a list of
>>> 20-byte sha1 hashes to be considered additional in-use references for
>>> the purpose of garbage collection.

> How would that solve the issue that you should not prune/gc the repository
> "clone --shared" aka "alternates" borrows from?

The log files are only for handling in-progress commands editing the
repository.  I also describe in first part of the e-mail a possible
solution to that issue as well as the issues created by having multiple
working directories:

When you create a new working directory, you would also create in the
original repository a symlink named
e.g. orig_repo/.git/peers/<some-arbitrary-name-that-doesn't-matter> that
points to the .git directory of the newly created working directory.
git clone -shared would likewise create such a link in the original
repository.  There could be a separate simple command to "destroy" a
repository created via clone -shared or via new-work-dir that would
simply remove this "peer" symlink from any repositories it shares from,
and then rm -rf the target repository.  The list of repositories that a
given target repository shares from would be discovered using perhaps
several different methods, depending on whether it is a new work dir, an
actual separate repository, or the new type of "shared" repository I
suggested in my original e-mail, namely one that has its own refs but
completely shares the object store of the original repository, e.g. via
a symlink to the original repository's objects directory In any case, I
believe the information to go "upstream" is already available, and we
just need to add those "peer" symlinks in order to be able to go
"downstream".

There could also be a simple git command to move a repository that would
take care of updating all of the references that other repositories have
to it.  Currently it is not possible to write such a command, because
the "downstream" links are not stored, but with these added symlinks it
would be possible.

As I said in my previous e-mail, if git gc finds any broken symlinks
(i.e. symlinks that point to invalid repositories), it would error out,
because user attention is required to specify whether the symlinks
correspond to deleted repositories, or to repositories that have been
moved without making the proper updates.

> By the way, I do not think your "git-commit stopped for two weeks due to a
> long editing session of the commit message" should result in any object
> lossage, as the new objects are all reachable from the index, and the new
> tree nor the new commit hasn't been built while you are typing (rather,
> not typing) the log message.

> Hmm, a partial commit that uses a temporary index file may lose, come to
> think of it.  Perhaps we should teach reachable.c about the temporary
> index file as well.  I dunno.

Well, providing a generic mechanism for telling git about reachable
things other than the index and refs is precisely what these log files
would do, and also because they would record the process id and a
timestamp, stale log files would automatically get cleaned up.  If each
individual git command has its own special way of trying to keep track
of temporary references, it is just going to be more complicated and
more error prone.

-- 
Jeremy Maitin-Shepard
