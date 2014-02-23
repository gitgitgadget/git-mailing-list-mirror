From: Pete Wyckoff <pw@padd.com>
Subject: Re: Fwd: git p4: feature request - branch check filtering
Date: Sun, 23 Feb 2014 10:12:47 -0500
Message-ID: <20140223151247.GA1272@padd.com>
References: <CADtnS+zWzPY6ftwxWUE+Gb-OKq_Kzf9y+fFfgJ-demWyX3azCg@mail.gmail.com>
 <CADtnS+weco6Lvk3hHuM7BcaRsvMkeDCmqH26s19TrgWvBYXAvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Philip Herron <redbrain@gcc.gnu.org>
To: Dan Porter <dpreid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 23 16:13:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHak5-0004zR-Pj
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 16:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbaBWPMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 10:12:52 -0500
Received: from honk.padd.com ([74.3.171.149]:60092 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbaBWPMv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 10:12:51 -0500
Received: from arf.padd.com (unknown [50.105.0.78])
	by honk.padd.com (Postfix) with ESMTPSA id 56CD324FF;
	Sun, 23 Feb 2014 07:12:50 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6B31820450; Sun, 23 Feb 2014 10:12:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CADtnS+weco6Lvk3hHuM7BcaRsvMkeDCmqH26s19TrgWvBYXAvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242544>

dpreid@gmail.com wrote on Tue, 18 Feb 2014 12:42 +0000:
> I work at a company that has recently moved all CVS, SVN, and git
> repositories to Perforce.  Depots have not been setup correctly in
> every case, and there is one depot that contains literally hundreds of
> projects under commercial development (and hundreds of branches as a
> result)

My condolences.

> My project may be in //stupid_depot/commercial/teamporter/rok.  This
> is the path I clone with git-p4.  The only branches in this depot that
> contain files at this path are titled as
> 'rok_porter_branch/release_1.x' or similar.
> 
> When using '--detect-branches' git-p4 checks each key of branches to
> see if any of them have files in the path I've cloned.  Whilst this is
> good in practice there is unfortunately 6,809 branches, git-p4
> processes about 2 a second and just under an hour to perform any
> git-p4 rebase, submit, or similar operation.

This is in getBranchMapping() presumably.  Where it loops
over each branch doing "p4 branch -o".  Yuk.

You could always avoid the --detect-branches if you don't really
need it, instead doing, say, multiple "git p4 sync" for the
different areas of the repo that interest you, each with its own
destination branch in git ("p4/depot-part1", "p4/depot-part3",
...).  Or --use-client-spec to cobble together an exact mapping
of where p4 files should land in git, all in a single git branch
then.

> I propose the addition of a branch list filtering option
> (--filter-branches) that takes either a regular expression or list of
> branches it should check.  This may be useful in sane situations where
> you don't want to scan every branch in a Perforce repository, or
> blacklist branches that have undesirable content (for example, one of
> the branches is called 'svn-backup'.  It contains a single, multi-GB
> tarball.)

There is the existing git-p4.branchList option that explicitly
adds (or overrides) branch information, beyond the ones auto-discovered.

You might be able to use that option, but change its behavior
to avoid the scan.  So that if that option is set in the config,
p4 is not asked anything about its branches.  Not sure if this
would break anyone's setup though.

Another approach would be to add a config option
git-p4.branchScan that defaults to True.  You could turn it off
and use branchList.

> It would be ideal to have this information (after initial clone or
> sync) stored somewhere in the git config where is appropriate so that
> future submit/rebase operations adhere to this list.
> 
> Has something like this been worked on, or has been considered in the
> past?  If not I will consider implementing this after reading up on
> the Git code guidelines.
> 
> Thanks for keeping the Git workflow accessible in painful areas.

It would be great if you could get something like this to work.
Start in getBranchMapping() and don't forget to write up your
work in Documentation/git-p4.txt.  Also, this is sort of a messy
area of the code, unfortunately.  t/t9801 tries to make sure some
of it keeps working.

		-- Pete
