From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [ANNOUNCE] git-svn - bidirection operations between svn and git
Date: Thu, 16 Feb 2006 11:25:50 -0800
Message-ID: <20060216192550.GD12055@hand.yhbt.net>
References: <20060216073826.GA12055@hand.yhbt.net> <20060216134248.GC4271@duckman.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 16 20:26:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9olI-0000dm-7v
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 20:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWBPTZx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 14:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWBPTZx
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 14:25:53 -0500
Received: from hand.yhbt.net ([66.150.188.102]:27798 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932556AbWBPTZw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 14:25:52 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 7EB3A2DC08D; Thu, 16 Feb 2006 11:25:50 -0800 (PST)
To: Eduardo Pereira Habkost <ehabkost@mandriva.com>
Content-Disposition: inline
In-Reply-To: <20060216134248.GC4271@duckman.conectiva>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16310>

Eduardo Pereira Habkost <ehabkost@mandriva.com> wrote:
> On Wed, Feb 15, 2006 at 11:38:26PM -0800, Eric Wong wrote:
> > Hello, I've written a simple tool for interoperating between git and
> > svn.  I wrote this so I could use git to work on projects where other
> > developers use Subversion.  I really hate using svn, but some projects I
> > work on require it, and svk isn't nearly as fast nor simple as git.
> 
> Great, I was doing some testing with git-svnimport for this, but I missed
> a tool to automatically commit to svn what I have in my GIT tree.
> 
> > 
> > git-svn does not replace git-svnimport, git-svnimport handles branches
> > and tags automatically, but is too inflexible about repository layouts
> > to be useful for a good number of projects I follow, and of course
> > git-svnimport can't commit to Subversion repositories :)
> 
> I am already using git-svnimport to keep a "mirror" of some subversion
> repositories, here (automatically udpated on crontab). Do you plan to
> allow "integration" with repositories that are just clones of
> git-svnimport'ed repositories?

It's possible, just not very obvious at the moment.  git-svn was written
as quickly as possible without regard to svnimport compatibility since I
had some repos that didn't work with svnimport to begin with.

The 'ADDITIONAL FETCH ARGUMENTS' part of the manpage is worth reading
for you.  Basically, you can define equalities
"(svn revision number)=(git commit)" as arguments to git-svn fetch to 
add parents for all the revisions it imports.

If I were you, I'd only want git-svn to care about partial history,
since you already have the rest of it from git-svnimport.  You can do
this:

	svn_revno=<last svn revision number you imported from git-svnimport>
	git_commit=<equivalent commit sha1 name of svn_revno above>
	git-svn fetch --revision $svn_revno:HEAD $svn_revno=$git_commit

> I plan to keep using git-svnimport and the standard git tools to work
> using the "svn mirror on git" as the main repository, but I plan to use
> "git-svn commit" to commit to the SVN repositories. I want this "commit
> tool" to not affect the current repository in any way, just like git-push:
> only send the commits to the remote repository and don't change anything
> in the local repository.
 
> However, it seems that "git-svn commit" does some tasks assuming we
> are on a "git-svn aware" repository (e.g. the "resyncing" just after
> the commit). Would you accept patches to allow using "git-svn commit"
> to commit changes from any GIT repository (i.e. not "svn-git aware"
> repositories) to any SVN repository, just like "git-push" would work
> for a GIT repository?
>
> However, I am not sure if the easier way would be changing git-svn to
> do this for me or writing a different script just for this task.

You should be 95% there just by exporting the svn_checkout_tree()
function to the command-line.  Perhaps automating reading of the
$svn_rev variable can be in order.

-- 
Eric Wong
