From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Mar 2009, #02; Thu, 05)
Date: Thu, 05 Mar 2009 16:18:46 +0100
Message-ID: <49AFED56.3030102@alum.mit.edu>
References: <7vbpsg2sgx.fsf@gitster.siamese.dyndns.org> <20090305110051.GA17921@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Heiko Voigt <git-list@hvoigt.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 16:21:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfFNJ-0005nR-Cp
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 16:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908AbZCEPTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 10:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753620AbZCEPTG
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 10:19:06 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:38621 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051AbZCEPTE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 10:19:04 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id n25FImqD005307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 5 Mar 2009 16:18:49 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.19) Gecko/20090105 Thunderbird/2.0.0.19 Mnenhy/0.7.5.666
In-Reply-To: <20090305110051.GA17921@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112311>

Jeff King wrote:
> On Thu, Mar 05, 2009 at 02:07:26AM -0800, Junio C Hamano wrote:
> 
>> * mh/cvsimport-tests (Mon Feb 23 06:08:14 2009 +0100) 5 commits
>>  - Add a test of "git cvsimport"'s handling of tags and branches
>>  - Add some tests of git-cvsimport's handling of vendor branches
>>  - Test contents of entire cvsimported "master" tree contents
>>  - Use CVS's -f option if available (ignore user's ~/.cvsrc file)
>>  - Start a library for cvsimport-related tests
>>
>> Tests without fixes are of dubious value.  Any takers?
> 
> [...]
> 
> The final two introduce the new tests. They look fine as far as fitting
> into the test infrastructure, but I have to admit that I haven't
> actually looked closely at _what_ they are testing. I assumed since they
> are adapted from Michael's cvs2svn tests that they are showing real
> problems that he had faced there. If they are meant to show failings of
> cvsps-based conversion (which is my understanding from Michael's other
> messages), then I'm not even sure they _are_ fixable without a total
> rewrite.

The test script added by this patch:

  Add some tests of git-cvsimport's handling of vendor branches

indicates a breakage that will occur for any CVS repository that used
the CVS "vendor branch" feature by importing a vendor tree more than
once.  This is a standard-vanilla use of CVS, though probably used in a
minority of repositories.  In such a case, the master branch of the
cvsimported git repository will have different contents than the HEAD
branch of the CVS repository.  I don't know enough to say whether this
is fixable without ditching cvsps.

The test script added by this patch:

  Add a test of "git cvsimport"'s handling of tags and branches

is even more basic.  In CVS it is possible, and common, to add some
files but not others to a branch or tag, or to add files from multiple
source branches to a branch or tag.  For some workflows, this is
recommended practice in the CVS world.  AFAIK cvsps does not attempt to
figure out what files were added to a branch but rather assumes that an
entire source branch was tagged/branched at a single moment in time.
The result of this false assumption is that the contents of the
branch/tag as checked out of git are different than those in the same
branch/tag in CVS.

The following patch by Heiko Voigt:

* hv/cvsimport-tests (Mon Mar 2 18:59:36 2009 +0100) 1 commit
 - cvsimport: add test illustrating a bug in cvsps

occurs due to out-of-order timestamps in the CVS repo, which can occur
whenever CVS *client* clocks are not synchronized.

I have another failing test (patch not yet submitted) that reveals a
conversion failure whenever CVS commits are applied to different files
in different orders (even if the timestamps are in order).  This occurs
shockingly often in CVS repositories because commits are not atomic, so
commits from two clients can be interleaved.  It can also occur if two
commits within cvsps's time window coincidentally have the same author
and commit message (e.g., a blank commit message).  In this case
git-cvsimport commits changes *to a single file* in the wrong
topological order (e.g., revision 1.3 is overwritten by revision 1.2),
also potentially leaving obsolete file contents at HEAD.

In all of these cases *the git content is objectively wrong*.  These are
not quality-of-conversion quibbles, they are egregious correctness
problems that will occur in most nontrivial CVS repositories.

> So I don't know whether it makes sense to apply them if we never plan on
> fixing them. [...]

IMHO there are only two intellectually honest alternatives:

1. Commit the new tests in the hope that somebody will try to fix them,
which probably requires ditching cvsps and starting almost from scratch.
 Until they are fixed add a disclaimer, in big red letters, to the
git-cvsimport documentation, saying that it *should not be trusted* to
make accurate conversions (though it might be useful in very restricted
scenarios requiring incremental synchronization with a CVS repo).  In
this case the tests should be retained as documentation, though perhaps
they should not be run unless the user turns on a particular flag.

2. Remove the git-cvsimport command altogether.

The status quo is untenable.  git-cvsimport is broken in ways that
casual users might easily overlook.  Their source tree might be altered,
possibly on HEAD but even more likely on branches and historical tags.
By the time they notice, sometime in the future, that their repository
is corrupt, it will be too late to fix because git development has taken
place on top of the faulty converted repository.

Michael
