From: esr@thyrsus.com (Eric S. Raymond)
Subject: Python extension commands in git - request for policy change
Date: Sat, 24 Nov 2012 21:44:51 -0500 (EST)
Message-ID: <20121125024451.1ADD14065F@snark.thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 25 03:46:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcSEH-0002hO-RH
	for gcvg-git-2@plane.gmane.org; Sun, 25 Nov 2012 03:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab2KYCpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2012 21:45:43 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:39233
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab2KYCpm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2012 21:45:42 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 1ADD14065F; Sat, 24 Nov 2012 21:44:51 -0500 (EST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210329>

git presently contains one Python extension command, Pete Wycoff's p4
importer.  If my git-weave code is merged it will acquire another.  
I think we can expect more submissions of Python extensions in the
future, for two good reasons:

1. Python has a much richer type ontology than shell; there are many
things this makes relatively easy that are quite painful in shell.

2. While Perl shares advantage #1, compared to Python it's a
maintainability mess - much more difficult to read 6 months later.

On the other hand, 

3. Attitudes in the git dev group seem to be influenced by a
perception that up-to-date Python versions are not as reliably present
on our target platforms as Perl is.

4. Python has the disadvantage that comes with robust growth; you have
to specify "version x.y or later" as a dependency, mainly because new
modules keep getting getting folded into the stock Python environment.

Previous conversation on the list suggests that there has been a tacit
policy of managing these problems by (a) discouraging (though not entirely
forbidding) Python extensions, and (b) requiring extension submitters to
document some dependency on language version.

I think this is suboptimal.  By not forbidding the Python language
entirely, we guarantee having to deal with problems 3 and 4 anyway -
but by discouraging it, we're buying significant long-term
maintainability costs. It especially disturbed me to hear of Python
commands being recoded in C - that is definitely not the right
direction for reducing expected defect counts, if only because of
memory-management issues.

We're behind the best-practices curve here.  The major Linux
distributions, which have to deal with almost the same set of
tradeoffs we do, went to Python for pretty much all glue and
administration scripts outside /etc a decade ago, and the decision has
served them well.

That, among other things, means up-to-date versions of Python are
ubiquitous unless we're looking at Windows - in which case Perl and
shell actually become much bigger portability problems.  Mac OS X 
has kept up to date, too; Lion shipped 2.7.1 and that was a major
release back at this point.

To be fair, there was a time when being a bit twitchy about Python
version skew and deployment breadth was justified, but I believe that
time is now well past us. My basis for believing this is very simple -
I maintain a lot of Python code for systems programmers with stiff
portability requirements (things like reposurgeon, coverity-submit,
freecode-submit, shipper, and the Python tools in gpsd). I know what
kinds of bug reports I get and what kinds I don't, and in the last
few years "this breaks on my Python version" has gone from unusual
to doesn't-happen.

I think my experience with gpsd is particularly instructive.  Like
git, that project has a C core with Python wrappers and extension 
components. Like git, it gets deployed in a lot of odd places by people
who cannot afford the time to be tolerant about cross-platform
problems and are quite willing to hit the maintainer with a clue-bat
when they encounter them.  The good news is - they don't have to.

I should also point out that none of Mercurial's problems seem to
have anything to do with the fact that it's written in Python...

I think we can choose a better policy based on some simple premises.

1) In 2012, we can specify a "floor" Python version of 2.6 (shipped in
2008) and be pretty much guaranteed it will be anywhere we want to
deploy except Windows.  Windows will remain a problem because Python
isn't part of the stock install, but that's an equal or worse problem
for shell and Perl - and at least the Python project ships a binary
installer for Windows.

2) Python extension commands should test the Python version on startup
and die loudly but gracefully in the rare case that they don't find
what they need.

3) We should be unconditionally be encouraging extensions to move
from shell and Perl to Python.  This would be a clear net gain is
portability and maintainability.

4) We should be encouraging C code to move to Python, too.  There's
little gain in portability on this path because modern C has cleaned
up its act a lot, but the drop in expected bug loads would be well
worth the porting effort.  Segfaults are not your friend, and the x2 to
x5 drop in line count would do very good things for long-term
maintainability.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>

Live free or die; death is not the worst of evils.
	-- General George Stark.
