From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: How-to combine several separate git repos?
Date: Sun, 9 Dec 2007 22:01:03 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712092130560.5349@iabervon.org>
References: <475B8C59.7050707@saville.com> <20071209104336.GA3163@steel.home>
 <475C3E25.30704@saville.com> <Pine.LNX.4.64.0712091445470.5349@iabervon.org>
 <475C7DD5.9040209@saville.com> <Pine.LNX.4.64.0712091942520.5349@iabervon.org>
 <475CA476.6070507@saville.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Wink Saville <wink@saville.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 04:01:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Ytu-0005is-Rq
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 04:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbXLJDBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 22:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751640AbXLJDBH
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 22:01:07 -0500
Received: from iabervon.org ([66.92.72.58]:52782 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbXLJDBF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 22:01:05 -0500
Received: (qmail 13511 invoked by uid 1000); 10 Dec 2007 03:01:03 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Dec 2007 03:01:03 -0000
In-Reply-To: <475CA476.6070507@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67671>

On Sun, 9 Dec 2007, Wink Saville wrote:

> Daniel Barkalow wrote:
> > On Sun, 9 Dec 2007, Wink Saville wrote:
> >   <snip>
> >   
> 
> I got submodule working, buy following the tutorial here:
> http://git.or.cz/gitwiki/GitSubmoduleTutorial#preview.
> 
> As well as looking at:
> http://jonathan.tron.name/articles/2007/09/15/git-1-5-3-submodule
> http://en.wikibooks.org/wiki/Source_Control_Management_With_Git/Submodules_and_Superprojects#endnote_lie_parent
> http://kerneltrap.org/mailarchive/git/2007/10/19/348810
> http://kerneltrap.org/mailarchive/git/2007/10/19/348829
> 
> I'd say the current documentation in git needs to improve at least
> for neophytes. The first step would be to include the GitSubmoduleTutorial.
> Also, I think the second paragraph of the tutorial is very important and
> something like it should probably be the first paragraph of the git-submodule
> man page:
> 
> "Submodules maintain their own identity; the submodule support just stores the
> submodule repository location and commit ID, so other developers who clone the
> superproject can easily clone all the submodules at the same revision."
> 
> My interpretation of the paragraph and how submodules might be used
> is that the "supermodule" provides tags for a set of repositories.
> I see that as important, especially for large projects which could use
> multiple repositories for sub-projects and then use a "supermodule"
> for test and release management.
> 
> That isn't what I really wanted to do. As a one man band I was looking
> to actually "combine" several repositories into one logical repository
> to simplify commits, pushes, pulls to my own backup repositories.
> I now see that that wasn't the purpose of submodule.
> 
> Anyway, that is the perspective of this neophyte and I learned something
> new which is a primary goal of mine.
> 
> Finally, I'm back to my original question how to combine repositories? As
> I said in my response to Alex, the multiple branches I got working but that
> isn't what I want.
> 
> What I think I now want is to create a new repository which contains my
> other repositories as sub-directories (with their histories) after combining
> them I would delete the old repositories. I expect the resulting history
> to be sequential, with the sequence defined by the order I combine them,
> but maybe there is another choice?

Ah, okay. I was assuming that you wanted them to maintain their original 
identities (so you'd send stuff off for each of them separately, for 
example).

I think you can do what you want by doing:

# Set up the new line:
$ mkdir x; cd x
$ git init
$ touch README
$ git add README
$ git commit

# Add a project "foo"
$ git fetch ../foo refs/heads/master:refs/heads/foo
$ git merge --no-commit foo
$ git read-tree --reset -u HEAD
$ git read-tree -u --prefix=foo/ foo
$ git commit

And repeat for all of the other projects.

What's going on here is that you're merging in each project, except that 
you're moving all of the files from that project into a subdirectory as 
you pull in the content. The resulting repository has one recent dull 
initial commit, and then merges in each of the other projects with their 
history, with only the slight oddity that they don't go back to the same 
initial commit, and the merge renames all of the project's files.

I think there may be a more obvious way of doing this (it's essentially 
how gitweb and git-gui got into the git history), but I'm not sure what it 
is, if there is one.

	-Daniel
*This .sig left intentionally blank*
