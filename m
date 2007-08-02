From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: cvs2svn conversion directly to git ready for experimentation
Date: Thu, 02 Aug 2007 19:23:57 +0200
Message-ID: <46B2132D.7090304@alum.mit.edu>
References: <46AFCF3E.5010805@alum.mit.edu> <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, users@cvs2svn.tigris.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: users-return-1607-gcvscu-users=m.gmane.org@cvs2svn.tigris.org Thu Aug 02 19:24:06 2007
Return-path: <users-return-1607-gcvscu-users=m.gmane.org@cvs2svn.tigris.org>
Envelope-to: gcvscu-users@gmane.org
Received: from sc157.sjc.collab.net ([204.16.104.146] helo=tigris.org)
	by lo.gmane.org with smtp (Exim 4.50)
	id 1IGeP6-0000wB-45
	for gcvscu-users@gmane.org; Thu, 02 Aug 2007 19:24:04 +0200
Received: (qmail 27445 invoked by uid 5000); 2 Aug 2007 17:24:02 -0000
Mailing-List: contact users-help@cvs2svn.tigris.org; run by ezmlm
Precedence: bulk
list-help: <mailto:users-help@cvs2svn.tigris.org>
list-unsubscribe: <mailto:users-unsubscribe@cvs2svn.tigris.org>
list-post: <mailto:users@cvs2svn.tigris.org>
Delivered-To: mailing list users@cvs2svn.tigris.org
Received: (qmail 27415 invoked from network); 2 Aug 2007 17:24:02 -0000
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAA+wsUbAbSoIh2dsb2JhbACOEwEBCQoH
X-IronPort-AV: i="4.19,214,1183359600"; 
   d="scan'208"; a="78852225:sNHT40532975"
X-IRONPORT: SCANNED
X-Envelope-From: mhagger@alum.mit.edu
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.12) Gecko/20070604 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
In-Reply-To: <65F1862F-4DF2-4A52-9FD5-20802AEACDAB@zib.de>
X-Enigmail-Version: 0.94.0.0
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54575>

Steffen Prohaska wrote:
> On Aug 1, 2007, at 2:09 AM, Michael Haggerty wrote:
>> I am looking forward to your feedback.  Even better would be if somebody
>> wants to join forces on this project.  I would be happy to supply the
>> cvs2svn knowledge if you can bring the git experience.
> 
> I tried it with revision trunk@3930 of cvs2svn. The results are as follows.

Thanks for the feedback!

> cvs2svn created a lot of branches that are not present in CVS,
> with names identical to CVS tags. Apparently these branches are
> used to create a commit matching a certain CVS tag.

That is correct.  This is something that I plan to work on, at least for
tags that can be created from a single source commit.

> The branching structure looks, ... hmm ..., interesting. cvs2svn
> manufactured commits to get the branching points right.
> Apparently our CVS has some weired commits like 'unlabeled-1.1.1'
> and two other named tags (maybe vendor branches?) that cause
> these manufactured commits. In gitk I see long lines running
> parallel to the cvs trunk all down to these weired CVS tags. They
> are not very useful, altough they might be correct. Note,
> parsecvs imports our repository without such basically useless
> links.  However, I can't verify if parsecvs gets something wrong.

Branches with names like "unlabeled-1.1.1" come from CVS branches for
which the revisions are still contained in the RCS files but for which
the branch name has been deleted.  These wreak havoc on cvs2svn's
attempt to find simple branch sources and cause a proliferation of
basically useless branches.  The main problem is that cvs2svn does not
attempt to figure out that "unlabeled-1.2.4" in one file might be the
same as "unlabeled-1.2.6" in another etc.

An "unlabeled-1.1.1", in particular, means that the branch whose name
was deleted was a vendor branch.  The deletion of a vendor branch name
can cause even more mayhem.

In most cases it makes sense to exclude the unlabeled branches.  After
all, somebody tried to delete them, so they can't be that important,
right?  Use --exclude='unlabeled-.*', or add a line like this to your
options file:

ctx.symbol_strategy.add_rule(ExcludeRegexpStrategyRule(r'unlabeled-.*'))

.  This can of course cause problems if other branches or tags were
created that branched off of the unlabeled branch.  In such cases the
dependent branches/tags might have to be excluded too.

> Other branches are created over a couple of commits mixing in
> several branches (maybe again our weired commits already
> mentioned). See branching1.png, branching2.png, branching3.png.
> [ I have to apologize, our cvs repository contains proprietary
>   information, so I can't publish it's history freely. ]

This can definitely be caused by unlabeled branches.  It can also be
caused by branches rooted in a vendor branch.  In many cases, such
branches can actually be grafted onto trunk, but cvs2svn does not (yet)
attempt this.

> cvs2svn is the first tool besided parsecvs that worked for me,
> that is imported the whole repository, passed the basic test of
> matching checkouts from cvs and git, and got the one suspicious
> commit right that I'm using for verifying the branching points.
> 
> [ I have no time to go into the details of all these tests.
>   Therefore only a very short summary:
>   All tools needed basic cleanup of a few corrupted ,v files and
>      ,v files that were duplicated in Attic.
>   git-cvsimport fails to create branches at the right commit.
>   fromcvs's togit surrendered during the import.
>   fromcvs's tohg accepted more of the history, but finally
>     surrendered as well.
>   parsecvs works for me (crashes on corrupted ,v files).
>   cvs2svn followed by git-svnimport create wrong state at the
>     tips of branches.
>   cvs2svn direct git import works for me (reports corrupted ,v files).
>   ]

Thanks very much for this interesting summary.

> Right now, I'd prefer the import by parsecvs because of the
> simpler history. However, I don't know if I loose history
> information by doing so. I'd start by a run of cvs2svn to validate
> the overall structure of the CVS repository. Dealing with corruption
> in the CVS repository seems to be superior in cvs2svn. It reports
> errors when parsecvs just crashes.

If excluding the unlabeled branches does not fix things for you, I
suggest checking out the first revision on such a branch, and comparing
the results from CVS, from parsecvs, and from cvs2svn.  It *should* be
that the version of the file from the vendor branch is included in the
working copy.  cvs2svn should handle this correctly.  I am curious
whether parsecvs does.

Michael
