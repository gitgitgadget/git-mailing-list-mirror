From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: cvsps, parsecvs, svn2git and the CVS exporter mess
Date: Thu, 3 Jan 2013 15:53:01 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20130103205301.GD26201@thyrsus.com>
References: <20121222173649.04C5B44119@snark.thyrsus.com>
 <50E5A5CF.2070009@alum.mit.edu>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@free.fr>, Heiko Voigt <hvoigt@hvoigt.net>,
	Antoine Pelisse <apelisse@gmail.com>,
	Bart Massey <bart@cs.pdx.edu>,
	Keith Packard <keithp@keithp.com>,
	David Mansfield <david@cobite.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jan 03 21:54:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqrnl-0004Ix-Bs
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 21:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149Ab3ACUxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 15:53:51 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:48765
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754053Ab3ACUxu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 15:53:50 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 5DC964415C; Thu,  3 Jan 2013 15:53:01 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <50E5A5CF.2070009@alum.mit.edu>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212612>

Michael Haggerty <mhagger@alum.mit.edu>:
> There are two good reasons that the output is written to two separate files:

Those are good reasons to write to a pair of tempfiles, and I was able
to deduce in advance most of what your explanation would be from the
bare fact that you did it that way.

They are *not* good reasons for having an interface that exposes this
implementation detail to the caller - that choice I consider a failure
of interface-design judgment.  But I know how to fix this in a simple and
backward-compatible way, and will do so when I have time to write you
a patch.  Next week or the week after, most likely.

Also, the cvs2git manual page is still rather half-baked and careless,
with several fossil references to cvs2svn that shouldn't be there and
obviously incomplete feature coverage. Fixing these bugs is also on my
to-do list for sometime this month.

I'd be willing to put in this work anyway, but it still in the back of
my mind that if cvs2git wins the test-suite competition I might
officially end-of-life both cvsps and parsecvs.  One of the features
of the new git-cvsimport is direct support for using cvs2git as a
conversion engine.
 
> A potentially bigger problem is that if you want to handle such
> blob/dump output, you have to deal with git-fast-import format's "blob"
> command as opposed to only handling inline blobs.

Not a problem.  All of the main potential consumers for this output,
including reposurgeon, handle the blob command just fine.

> cvs2git does not currently support incremental conversions; therefore, a
> cvsps-based option (if it would actually work, that is) would have at
> least one advantage over cvs2git.

Yes. The reason I didn't ship the replacement patch Junio was
expecting yesterday is that I don't have test coverage for the
incremental case.  I'm working on that now.

> cvs2svn has an extensive test suite which includes tests derived from
> bug reports that we have received over the years.  I adapted a few of
> its test repositories to create the git test suite additions that I made
> in Feb 2009, but there are many more in our project.

I've merged those into my tree.

> I think it would be great to have a way to test across tools, though
> please realize that the inference of the most plausible "true" CVS
> history is partly objective but also often a matter of heuristics and
> taste.  Moreover, the choice of how to represent the inferred history in
> git, which has rather a different model than CVS/Subversion, is also
> non-obvious and somewhat controversial.  I expect that there will be a
> number of simple CVS repositories for which we can all agree about the
> correct git output, but not far away will be a vast number for which the
> "correct" answer is unclear.  Many of the interesting tests would fall
> into the latter category.

I'm aware of the problem.  One of the interesting questions is how much
further into the weird cases everybody can agree on what correct 
translation looks like.  We won't know until we push it.
 
> It's not clear what you want me to sign off on.

If you're not willing to use the new suite, my spending the effort 
required to genericize it gets much less interesting.  I needed 
Junio's agreement because I wanted to move the old git-cvsimport
tests from the git tree to the new test suite; they're not really
tests of the wrapper script at all but of the conversion engines.

>                                               I guess you want to
> replace (or augment?) the cvs2svn test suite with one based on your
> framework? 

Augment, not replace - and just as importantly, commit to writing 
new tests into the new generic framework when they don't involve a 
tool-specific option.  It would be silly and duplicative for us *not*
to be sharing as many tests as we can.

> * We definitely want to continue testing the Subversion output of
> cvs2svn.  A test suite that only tests the git output could at best be
> an addition to the current test suite, not a replacement for it.  (That
> being said, the addition of good tests of the 2git output would be great.)

Agreed.

> * A test suite that tests only the easy cases wouldn't really be
> interesting, because the difficult cases are where the potential
> problems lie.

Yes, I know.  I'm arguing that we should be doing that exploration
jointly rather than separately.

> * It would be unfortunate if the cvs2svn test suite would grow another
> run-time dependency or if we would have to invest a lot of time
> synchronizing with another project, though if the gain were big enough
> we could consider it.

I know how to keep the friction cost low.  You'll see more about this when
I split off the test suite and announce it.

> * The licenses obviously have to be compatible to the extent required by
> the level of coupling.

I don't think this will be a problem.  You own the copyright on your tests and
I own it on mine, so we can relicense under whatever common license we choose.
I'm not fussy about what we use; ASL 2.0 would be fine by me.

> * I don't have a lot of time to work on the integration.  cvs2svn has
> long been at a level of maturity where it doesn't need much care and
> feeding, and I would like to keep it that way :-)  Nowadays I am far
> more interested in working on the git project with my little available
> open-sourcin' time.

I don't want to spend the rest of my life on the CVS-lifting problem either.
My present plans envision intense work on it for another three weeks or
so, after which I expect we'll be at a relatively stable and low-maintainance
state. 

FYI, here are my agenda items in roughly the order I expect to finish them:

1. Write test coverage for incremental imports.
2. Ship version 2 of the git-cvsimport replacement patch (with the fallback 
   option Junio requested) to the git list.
3. Get parsecvs to a non-broken state and ship a release
4. Ship a patch for git-cvsimport that adds the option to use parsecvs 
   as a conversion engine.
5. Break the test suite out of cvsps, give it its own public repo, document
   it, and hand you the keys.
6. Fix the interface-design bug(s) in cvs2git, and its documentation.
7. Torture-test all three tools (cvsps, parsecvs, cvs2git) against the
   new suite.
8. Make a judgement about whether I should EOL cvsps or parsecvs or both.

I have other commitments, so this will take a bit longer than it might
have.  I expect to be at step 8 in roughly a month (early February).
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
