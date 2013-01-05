From: Pete Wyckoff <pw@padd.com>
Subject: Re: Suggested improvements to the git-p4 documentation
 (branch-related)
Date: Sat, 5 Jan 2013 16:25:17 -0500
Message-ID: <20130105212517.GA30315@padd.com>
References: <CAFXk4bqt_pMVDtVKF-JiQuGbSpy2+_rGOg5RTTE+0pNKFcZh3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Olivier Delalleau <shish@keba.be>
X-From: git-owner@vger.kernel.org Sat Jan 05 22:25:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrbFM-0006wu-IQ
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 22:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891Ab3AEVZW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 16:25:22 -0500
Received: from honk.padd.com ([74.3.171.149]:46509 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755851Ab3AEVZU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 16:25:20 -0500
Received: from arf.padd.com (unknown [50.55.142.135])
	by honk.padd.com (Postfix) with ESMTPSA id A98905AED;
	Sat,  5 Jan 2013 13:25:19 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 386D428EAA; Sat,  5 Jan 2013 16:25:17 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAFXk4bqt_pMVDtVKF-JiQuGbSpy2+_rGOg5RTTE+0pNKFcZh3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212716>

shish@keba.be wrote on Thu, 03 Jan 2013 15:58 -0500:
> While struggling to get git-p4 to work properly with branches, I
> thought the documentation on http://git-scm.com/docs/git-p4 could use
> some improvements:

Thanks, I definitely appreciate the constructive comments here.

> 1. At the end of the "Branch detection" section, the following
> commands are provided (for when you want to explicitly provide branch
> mappings to git-p4):
> 
> git config git-p4.branchList main:branch1
> git p4 clone --detect-branches //depot@all
> 
> The second command should end with a dot (".") because the first
> command only works if you are already in a git-initialized folder.
> Thus I would also suggest to add "git init" as first command to type.

That is confusing.  I'll make it this:

    git init depot
    cd depot
    git config git-p4.branchList main:branch1
    git p4 clone --detect-branches //depot@all .

> 2. Even though having a "main" branch is standard in Perforce, it
> would be worth mentioning what happens when you don't: there is a
> message "Could not detect main branch. No checkout/master branch
> created" output by the "git p4 clone" command. However, it will still
> work if you manually set the master branch ("git checkout -b master
> remotes/p4/my_custom_main_branch").

This feels like a bug to me, and indeed I had an old patch series
that planned to fix it.  Let me knock that into shape, instead of
changing the documentation.  It will automatically do the
checkout step you did.

> 3. I don't know what I missed for that one, but I haven't been able to
> get the example for the --branch option to work. It says that after
> "git init", we can import a p4 branch with:
> 
> git p4 sync --branch=refs/remotes/p4/proj2 //depot/proj2
> 
> However, after doing this, followed by "git checkout -b proj2
> remotes/p4/proj2", I am unable to properly use "git p4 sync" or "git
> p4 submit" from this branch, as git complains about a missing
> refs/remotes/p4/master.

Yes, also annoying.  I have a failing test case for this, but
haven't fixed it yet.  The idea is that "git p4 sync --branch=proj2"
will sync refs/remotes/p4/proj2.  If there is no p4/master, and
you don't specify --branch, it will fail with a more useful error
message.

For submit, there is code that walks from your current branch
back in history until it finds a commit on a known p4 remote
branch.  This is sort of like the merge-base calculation in git,
but restricted to a linear history.  I haven't tested that
recently, but will add a test and fix it if needed too.


Please do feel welcome to to rearrange or expand the
documentation so it makes more sense, if you are so inspired.

		-- Pete
