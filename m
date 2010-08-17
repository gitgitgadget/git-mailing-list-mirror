From: Jan Hudec <bulb@ucw.cz>
Subject: Re: fixing workdirs
Date: Tue, 17 Aug 2010 20:34:35 +0200
Message-ID: <20100817183435.GA2717@efreet.light.src>
References: <20100708110842.GC12789@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git ML <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@madism.org>
X-From: git-owner@vger.kernel.org Tue Aug 17 20:53:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlRIH-0000Gb-GR
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 20:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500Ab0HQSxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Aug 2010 14:53:46 -0400
Received: from cuda1.bluetone.cz ([212.158.128.5]:42886 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758506Ab0HQSxp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 14:53:45 -0400
X-Greylist: delayed 1146 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Aug 2010 14:53:44 EDT
X-ASG-Debug-ID: 1282070075-090714ce0001-QuoKaX
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145]) by cuda1.bluetone.cz with ESMTP id GdcLT7xQyz7cBeGG; Tue, 17 Aug 2010 20:34:35 +0200 (CEST)
X-Barracuda-Envelope-From: bulb@ucw.cz
X-Barracuda-Apparent-Source-IP: 85.207.119.145
Received: from bulb by efreet.light.src with local (Exim 4.72)
	(envelope-from <bulb@ucw.cz>)
	id 1OlQzb-0007EV-DN; Tue, 17 Aug 2010 20:34:35 +0200
X-ASG-Orig-Subj: Re: fixing workdirs
Content-Disposition: inline
In-Reply-To: <20100708110842.GC12789@madism.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Barracuda-Connect: 145-119-207-85.strcechy.adsl-llu.static.bluetone.cz[85.207.119.145]
X-Barracuda-Start-Time: 1282070075
X-Barracuda-URL: http://212.158.128.5:8000/cgi-mod/mark.cgi
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5167 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.5 KILL_LEVEL=4.8 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.38247
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153773>

On Thu, Jul 08, 2010 at 13:08:42 +0200, Pierre Habouzit wrote:
> At work we (ab-)use workdirs a lot, though, workdirs aren't for
> everybody, and as our company grows, not everybody uses them sanely.
> 
> The two problems (that are well known to this list, and is the reason
> why git new-workdir is in contrib afaict) with workdirs are:
> 
>   - the HEAD reflogs aren't shared, which means that pruning a working
>     directory may trash accessible stuff from the reflog of another one.
>
>   - if two workdirs are on the same branch at the same time, really,
>     really, *REALLY* bad things may happen if one isn't aware of that
>     fact.

It should be possible to guard against those bad things. Basically the bad
things happen when a symbolic HEAD's target is changed in a way the HEAD is
not aware. But in those, and only those, cases the HEAD's reflog is not
updated. So some operations could check whether HEAD@{0} resolves to the same
commit as HEAD and if not they would either fail or automatically detach
HEAD.

That would serve as a safeguard not just against one worktree commiting to
a branch checked out in another worktree. It would also safeguard against
pushing to the branch provided the code in update that updates HEAD's reflog
was disabled for non-bare repositories.

> I'm intending to adress those issues, though I would like to know how it
> would be received. My current plan is this one. Have a git workdir
> command, with a few subcommands (create, move, rename, ...), that
> addresses both of the previous issues.
> 
> for the first one, the fix is simple: workdirs have now a name, and
> their HEAD reflog lives in the "master" git repository reflog namespace
> under logs/workdir/$workdir_name/HEAD. The workdir HEAD reflog is then a
> symlink to the masters.
> 
> In this way, all workdirs see all the reflogs of every single workdir,
> and pruning is safe again.

The problem with it is that it falls apart when somebody forgets to use the
'git worktree remove' command and deletes (or renames) the work-tree
manually.

Alternative idea would be to add support for new layout with one repository
and multiple worktrees. The worktrees would be restricted to siblings of the
.git directory where the repository lives with the repository itself being
marked as bare. So the layout would be:

  somedir/
  somedir/.git/           <- the repository, makred as bare
  somedir/worktree1/      <- a worktree
  somedir/worktree1/.git/ <- worktree's .git in current format
  somedir/worktree2/      <- another worktree
  somedir/worktree2/.git/ <- worktree's .git in current format
  ...

Such scheme would exchange some flexibility for more safety. The worktrees
could be created with current new-workdir. They would be found as simply
$GIT_DIR/../*/.git for purpose of solving the two problems above. On the
other hand a method for preparing this layout (git init --multiple-trees,
git clone --multiple-trees or something like that) would be needed.

IIRC bazaar uses scheme like this for it's multiple-worktree support.

> For the second one, when a workdir is created, a [workdir "foo"] section
> is added to the master directory, with a path configuration variable
> pointing to the ... path of the working directory. My plan would be to
> teach git checkout to lean about that, and when there are workdirs
> set up, git checkout would check that no other workdir is currently "on
> the same branch", and would refuse to checkout to a branch that is
> already checkouted elsewhere.

Wait a second. Don't you have the HEADs and their reflogs for workdirs stored
in the master? So you can just compare with all the other HEADs there, no?

The bookkeeping would break if you just deleted the workdir without telling
git. The configuration will break even more readily as renaming also breaks
it. 

Kind regards,
Jan

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
