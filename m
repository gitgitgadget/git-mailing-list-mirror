From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 00/12] git p4: submit conflict handling
Date: Fri, 17 Aug 2012 08:21:34 -0400
Message-ID: <20120817122134.GA29257@padd.com>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
 <502DDEF5.4090405@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Aug 17 14:21:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2LYf-0001jI-QF
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 14:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905Ab2HQMVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 08:21:39 -0400
Received: from honk.padd.com ([74.3.171.149]:57271 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755984Ab2HQMVi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 08:21:38 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 4E6131E43;
	Fri, 17 Aug 2012 05:21:37 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id EA16D313FD; Fri, 17 Aug 2012 08:21:34 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <502DDEF5.4090405@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203613>

luke@diamand.org wrote on Fri, 17 Aug 2012 07:04 +0100:
> On 17/08/12 00:35, Pete Wyckoff wrote:
> >These patches rework how git p4 deals with conflicts that
> >arise during a "git p4 submit".  These may arise due to
> >changes that happened in p4 since the last "git p4 sync".
> >
> >Luke: I especially wanted to get this out as you suggested
> >that you had a different way of dealing with skipped commits.
> >
> >The part that needs the most attention is the interaction
> >loop that happens when a commit failed.  Currently, three
> >options are offered:
> >
> >     [s]kip this commit, but continue to apply others
> >     [a]pply the commit forcefully, generating .rej files
> >     [w]rite the commit to a patch.txt file
> >     and the implicit<ctrl-c>  to stop
> >
> >After this series, it offers two:
> >
> >     [c]ontinue to apply others
> >     [q]uit to stop
> >
> >This feels more natural to me, and I like the term "continue" rather
> >than "skip" as it matches what rebase uses.  I'd like to know what
> >others think of the new flow.
> 
> The skip is still needed. In my workflow, git-p4 gets run
> periodically and does the usual sync+rebase on behalf of all the
> people who have pushed to the git repo.
> 
> If someone pushes a change which conflicts with something from
> Perforce land, then what I want to happen is for the script to
> discard the offending commit (git rebase --skip) and then carry on
> with the others.
> 
> In 99% of cases this does exactly what I need, as conflicting
> commits are usually caused by people committing the same fix to both
> p4 and git at around the same time (someone breaks top-of-tree with
> an obvious error, two separate people check in slightly different
> fixes). Discarding the git commit then means that everything carries
> on working.
> 
> I've got a small patch which makes skipping work non-interactively;
> the thing it's missing is reporting the commits which are skipped.

This "discard offending commits" part I had not thought anyone
would ever do.  Instead, why not do "git p4 rebase" on its own
and use "git rebase --skip" to discard the offending ones
explicitly.  It seems dangerous to do it implicitly as part
of a multi-commit submit to p4.

Thanks for sending your RFC work.  I see what you are thinking
about.

Assuming that it really would be good to have a way to
_automatically_ discard conflicting commits, then sure, keeping a
list in submit and plumbing that into the rebase would work.  It
still scares me.  There are quite a few special cases where it
fails, of course, like if future commits involve dependencies on
the one you want to skip.

Would this alternative approach work: "git p4 submit
--discard-conflicting-commits" (and/or the option).  It
automatically hits "skip" after every submit failure.  When done,
it does "git p4 sync" to get a report on what ended up in tree.
Then instead of rebasing, the HEAD is simply taken to the top of
the p4 tree.  No need to rebase if the rule is to discard all
skipped patches.  Plus some reporting to say what was lost.

I will reroll my series once we've figured out how we want these
to co-exist.

		-- Pete
