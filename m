From: esr@thyrsus.com (Eric S. Raymond)
Subject: cvsps, parsecvs, svn2git and the CVS exporter mess
Date: Sat, 22 Dec 2012 12:36:48 -0500 (EST)
Message-ID: <20121222173649.04C5B44119@snark.thyrsus.com>
To: Yann Dirson <ydirson@free.fr>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Bart Massey <bart@cs.pdx.edu>,
	Keith Packard <keithp@keithp.com>,
	David Mansfield <david@cobite.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 18:37:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmT11-0006Fy-4b
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 18:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790Ab2LVRhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 12:37:14 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:53527
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731Ab2LVRhM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 12:37:12 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 04C5B44119; Sat, 22 Dec 2012 12:36:48 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212061>

Wanting reposurgeon to be able to read CVS repositories has landed me
in the middle of a mess.  This note explains my thinking, what I
intend to do to fix the mess, and how others can help if they are
motivated.  I have copied all the individuals who I know have an
interest in the problem, and the git list because what I'm planning is
going to be significant for them.

My requirement is not complicated to describe. For use as a
reposurgeon front end I need a tool that is basically a
cvs-fast-export, runnable in either a CVS repository or a checkout
(either will do, both is not required) and emitting a fast-import
stream.

There are three competing tools that might fit this bill.  

* One is Michael Haggerty's cvs2git.  I had bad experiences with the
cvs2svn code it's derived from in the past, but Michael believes those
problems have been fixed and I will accept that - at least until I can
test for myself.  Its documented interface is not quite good enough
yet; as the documentation says, "The data that should be fed to git
fast-import are written to two files, which have to be loaded into git
fast-import manually."

* Another is the cvsps code formerly maintained by David Mansfield and
used by git-cvsimport; he passed the maintainer's baton to me, and I
have shipped a 3.0 with a working --fast-export option.

* A third is parsecvs, which Keith Packard and Bart Massey handed off
to me a week before David invited me to take over cvsps.  While
parsecvs does not yet have a --fast-export option, I anticipate no
great difficulty in adding one.

It is pure accident that I now maintain two of these.  Initially I
was interested in parsecvs, but it failed to build for me.  By the
time Bart Massey sent me a fix patch, I had already been handed 
cvsps, added --fast-export, and shipped 3.0.

Having three different tools for this job seems to me duplicative and
pointless; two of them should probably be let die an honorable death.
I don't actually care which of the three survives - and, in
particular, if I determine that cvs2git is doing the best job of the
three I am quite willing to declare end-of-life for cvsps and
parsecvs.  It's not like I don't have plenty of other projects to work
on.

Therefore, I think my main focus needs to be developing a really
effective test suite to triage these tools with and applying it to all
three.  I have already made a solid start on this; see
tests/cvstest.py and tests/basic.tst in the cvsps-3.0 distribution for
my test framework.

I presently know of three test suites other than mine. One was built
by Heiko to test cvsps, another lives in the git t/ directory, and the
third is cvs2git's. I haven't looked at cv2git's yet, but the others
are not in their present form suited to where I am taking cvsps and
parsecvs.  Heiko's relies on the default human-readable cvsps format,
which I consider obsolete and uninteresting.  The git tests are
dependent on details of porcelain behavior.  I think it would be
better to test import-stream output.

Here is what I propose.  Let's build a common test suite that cvs2git,
git-cvsimport, cvsps, and parsecvs can all use, apply it rigorously,
and let the best tool win.  (This would mean, among other things, that
git can stop carrying things that are essentially cvsps tests in its
tree.)

The two people I most need to sign off on this are, I guess, Michael
Haggerty and either Junio Hamano or whoever specifically owns
git-cvsimport and its tests.  Whichever way this comes out, the back
end of git-cvsimport is going to need some work - I don't plan to put
any further effort into the output format it's presently using.

If we can agree on this, I'll start a public repo, and contribute my
Python framework - it's more capable than any of the shell harnesses
out there because it can easily drive interleaved operations on multiple 
checkout directories.

Anybody who is still interested in this problem should contribute
tests.  Heiko Voigt, I'd particularly like you in on this.  David
Mansfield, if you can spare the few minutes required to write
generators for the "funky" and "invalid" tag cases, that would be
really helpful.  Michael Haggerty, your piece would be moving the
cvs2git tests to the new framework.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

The kind of charity you can force out of people nourishes about as much as
the kind of love you can buy --- and spreads even nastier diseases.
