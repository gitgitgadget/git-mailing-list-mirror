From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: I have end-of-lifed cvsps
Date: Tue, 17 Dec 2013 17:41:36 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20131217224136.GB19511@thyrsus.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com>
 <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com>
 <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <52B02DFF.5010408@gmail.com>
 <CALKQrgf3kuXRpbWmSp_nk8+zDFYNzkgV+dSBHaBbmUkxqjaDUA@mail.gmail.com>
 <20131217145809.GC15010@thyrsus.com>
 <CALKQrgeegcsO7YVqEmQxD4=HfR4eitodAov0tEh7MRvBxtRKUA@mail.gmail.com>
 <20131217184724.GA17709@thyrsus.com>
 <CALKQrgeRKosOSOhcbUArkh03mwJLPkcOH-DROCCnmbTdQ8afyg@mail.gmail.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Dec 17 23:41:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vt3Kg-0006Yr-3w
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 23:41:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020Ab3LQWli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 17:41:38 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:36688
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216Ab3LQWlh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 17:41:37 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 316AE380868; Tue, 17 Dec 2013 17:41:36 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CALKQrgeRKosOSOhcbUArkh03mwJLPkcOH-DROCCnmbTdQ8afyg@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239408>

Johan Herland <johan@herland.net>:
> > Alan and I are going to take a good hard whack at modifying cvs-fast-export
> > to make this work. Because there really aren't any feasible alternatives.
> > The analysis code in cvsps was never good enough. cvs2git, being written
> > in Python, would hit the core limit faster than anything written in C.
> 
> Depends on how it organizes its data structures. Have you actually
> tried running cvs2git on it? I'm not saying you are wrong, but I had
> similar problems with my custom converter (also written in Python),
> and solved them by adding multiple passes/phases instead of trying to
> do too much work in fewer passes. In the end I ended up storing the
> largest inter-phase data structures outside of Python (sqlite in my
> case) to save memory. Obviously it cost a lot in runtime, but it meant
> that I could actually chew through our largest CVS modules without
> running out of memory.

You make a good point.  cvs2git is descended from cvs2svn, which has
such a multipass organization - it will only have to avoid memory
limits per pass.  Alan and I will try that as a fallback if
cvs-fast-import continues to choke.
 
> > It is certainly the case that a sufficiently large CVS repo will break
> > anything, like a star with a mass over the Chandrasekhar limit becoming a
> > black hole :-)
> 
> :) True, although it's not the sheer size of the files themselves that
> is the actual problem. Most of those bytes are (deltified) file data,
> which you can pretty much stream through and convert to a
> corresponding fast-export stream of blob objects. The code for that
> should be fairly straightforward (and should also be eminently
> parallelizable, given enough cores and available I/O), resulting in a
> table mapping CVS file:revision pairs to corresponding Git blob SHA1s,
> and an accompanying (set of) packfile(s) holding said blobs.

Allowing for the fact that cvs-fast-export isn't git and doesn't use
SHA1s or packfiles, this is in fact how a large portion of
cvs-fast-export works.  The blob files get created during the walk
through the master file list, before actual topo analysis is done.

> The hard part comes when trying to correlate the metadata for all the
> per-file revisions, and distill that into a consistent sequence/DAG of
> changesets/commits across the entire CVS repo. And then, of course,
> trying to fit all the branches and tags into that DAG of commits is
> what really drives you mad... ;-)

Well I know this...:-)

> > The question is how common such supermassive cases are. My own guess is that
> > the *BSD repos and a handful of the oldest GNU projects are pretty much the
> > whole set; everybody else converted to Subversion within the last decade.
> 
> You may be right. At least for the open-source cases. I suspect
> there's still a considerable number of huge CVS repos within
> companies' walls...

If people with money want to hire me to slay those beasts, I'm available.
I'm not proud, I'll use cvs2git if I have to.
 
> > I find the very idea of writing anything that encourages
> > non-history-correct conversions disturbing and want no part of it.
> >
> > Which matters, because right now the set of people working on CVS lifters
> > begins with me and ends with Michael Rafferty (cvs2git),
> 
> s/Rafferty/Haggerty/?

Yup, I thinkoed.
 
> > who seems even
> > less interested in incremental conversion than I am.  Unless somebody
> > comes out of nowhere and wants to own that problem, it's not going
> > to get solved.
> 
> Agreed. It would be nice to have something to point to for people that
> want something similar to git-svn for CVS, but without a motivated
> owner, it won't happen.

I think the fact that it hasn't happened already is a good clue that
it's not going to. Given the decline curve of CVS usage, writing 
git-cvs might have looked like a decent investment of time once,
but that era probably ended five to eight years ago.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
