From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git default behavior seems odd from a Unix command line point
 of  view
Date: Tue, 12 May 2009 16:50:39 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905121619310.2147@iabervon.org>
References: <4e963a650905120818m70b75892gb4e052187910b9a5@mail.gmail.com>  <7vd4ae8fls.fsf@alter.siamese.dyndns.org>  <4e963a650905120924j52d38c0dg577d93e913013e38@mail.gmail.com>  <alpine.LNX.2.00.0905121415000.2147@iabervon.org>
 <4e963a650905121305s244309a5vef9eec671d1ee5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Andrew Schein <andrew@andrewschein.com>
X-From: git-owner@vger.kernel.org Tue May 12 22:50:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3yw4-0005d0-G0
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 22:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbZELUuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 16:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbZELUuj
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 16:50:39 -0400
Received: from iabervon.org ([66.92.72.58]:32930 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbZELUuj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 16:50:39 -0400
Received: (qmail 10381 invoked by uid 1000); 12 May 2009 20:50:39 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 May 2009 20:50:39 -0000
In-Reply-To: <4e963a650905121305s244309a5vef9eec671d1ee5e@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118954>

On Tue, 12 May 2009, Andrew Schein wrote:

> > What *is* your use case? What you're doing seems nuts to me (like, you're
> > going to send out files with this script that someone is in the middle of
> > editting), but I don't know what you're trying to do.
> 
> I am new to git... so my first instinct is to try to reproduce a work
> flow that I know works with mercurial setup.  It is possible that the
> concepts don't translate correctly.  Here goes...
> 
> I have a bunch of separate project-related repositories.  There are
> very few users of the system.  Most of the time I am the only user.  I
> want a system for syncing my local repositories to a single shared
> repository.  For example some days I work on my laptop, and some days
> from my desktop.  A third "shared/public" repository "on campus"
> serves as an always available repository that anyone I collaborate
> with can pull from.  Also it is backed up, and for this reason I
> designate it the "shared" version.  So the purpose of the sync.sh
> script is to synchronize the personal laptop/desktop repository to the
> on-campus version.

In general, you should probably not have the script run "commit", but run 
it by hand whenever you've finished making changes (and probably done at 
least a quick syntax test, if possible). Otherwise, you'll often get the 
situation where you get distracted halfway through modifying a line, save 
something by habit, and then find this state getting sent to the system 
that other people pull from, and they'll find that they can't build your 
latest code.

> Something I have learned from using mercurial in industry is that when
> somebody messes up a "public repo" with conflicts they frequently
> don't clean up the mess.  This can be a sign that they have not
> learned the lessons of cleanliness rather than ill intent.  Otherwise
> (and similarly) this messiness can be caused from not noticing that
> they have left a mess.

In the normal process of pushing changes to a shared repository, there is 
no possibility of leaving conflicts, because there's no way to get git to 
attempt a merge on push; the push simply fails, and you then pull, resolve 
any conflicts, commit the merge, and try again at pushing.

> The motivation of having a sync script that is run on each user's
> local repository is to decrease the likelihood of a mess.  This is
> achieved by first pulling from the common repository and resolving
> conflicts _before_ "pushing" (note quotations) their changes to the
> common repository.  There is a possibility of a race condition that
> leaves a conflict on the shared repository, however the risk is
> diminished.
> 
> Finally, I use "push" in quotes because actually the script uses only
> uses the pull command.  This prevents proliferation of branches on the
> shared repository.

It's better to configure the push refspec to do what you want, which seems 
to be "refs/heads/master:refs/heads/master", and use the fact that git 
push actually does what you're trying to do in a race-free and efficient 
way.

Also, the "refs/heads/*:refs/heads/*" refspec is only different in the 
case where you use branches other than "master", and seems like it would 
be useful for your use case; if you actually want to send everything you 
do to the shared location, you want to have all of the branches you've 
made. (That is, you get one branch on the shared repository per distinct 
name of a branch that you use on a local repository, not one "master" for 
each local repository's "master")

	-Daniel
*This .sig left intentionally blank*
