From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn sucks when it should not
Date: Mon, 7 Jul 2008 02:44:38 -0700
Message-ID: <20080707094438.GA5964@untitled>
References: <alpine.DEB.1.00.0807070135450.7342@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 11:45:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFnHt-0002Mh-QK
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 11:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbYGGJok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 05:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbYGGJok
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 05:44:40 -0400
Received: from hand.yhbt.net ([66.150.188.102]:56946 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750807AbYGGJoj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 05:44:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 550012DC095;
	Mon,  7 Jul 2008 02:44:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807070135450.7342@eeepc-johanness>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87596>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Eric,

Hi Johannes,

> I have the pleasure of needing to work with a subversion project where 
> parts of the webserver are password restricted.
> 
> In particular, I cannot access the parent directory, and one of 
> the branches is protected, too.
> 
> Maybe you remember me describing that problem on IRC a few weeks ago: yes, 
> it is still persistent.
> 
> Now, I thought that I know my way around Perl, at least a little bit, but 
> while git-svn barfed on the repository, I... uhm, well, you probably get 
> the idea.
> 
> The funny part is this: when I say "git svn clone $URL/trunk", or the same 
> with the absolute paths to the single tags, instead of "git svn clone -s 
> $URL", git-svn does the correct thing.  It works, importing the stuff as 
> "git-svn".

Noted, -s/--stdlayout doesn't work well with access-restricted
repositories.  I remember leaving the minimize_url() stuff out of the
non--stdlayout code path so git-svn could at least have a way of working
with restricted repositories.

> So I tried to just edit out by hand the branches section, so that the 
> password-protected branch would not be a problem.
> 
> The result was surprising: git svn fetch exited with success, but it 
> did... absolutely nothing.
> 
> After a lot of frustrating hours, which were not at all helped by 
> brilliant variable names such as "r" and "gsv", I now know this: the log 
> contains paths that do not have a prefix "trunk", but "<dir>/trunk", 
> where "<dir>" is the last directory of the URL.

$r should always revision number ('r' is pretty common in the svn
command-line client in referring to revision numbers).  $gsv is just
a $gs vector (like 'argv') with multiple Git::SVN objects.

On the other hand, your comments about some of the other code being
gross is completely valid...

> Changing git-svn's URL to the parent of <dir> is a no-go, since that is -- 
> as I mentioned above -- password protected.
> 
> Yes, in a perfect world I could just force the admin to change that, but 
> no, this is not a perfect world, so do not even try to suggest that if 
> you want to help.

In a perfect world, everybody would be using git and we wouldn't have to
deal with SVN :)

I highly doubt I'd ask you to get an admin to give you access, so please
don't suggest that's something I would ask of you.  I always try to stay
as under-the-radar as possible as far as dealing with admins go and
avoid ever mentioning git-svn to them.

Closed repositories suck, yes, and I've had the fortune (and misfortune
to some users such as yourself) to have never had work with anything
less than full read access.

> Changing the fetch line to "<dir>/trunk:refs/remotes/trunk" does not work 
> either, since git-svn cleverly checks $URL/<dir>/<dir>/trunk/.
> 
> I then tried to hack match_globs() and match_paths() to add that extra 
> prefix to the patterns, so that that extra prefix + trunk would be 
> matched and edited out.  This happened to work out alright.
> 
> But I tried for several hours to get in a proper solution which does not 
> throw up on the tags, and I have to conclude that this piece of code is 
> not hackable by anybody else but you.

I've actually been afraid to touch the globbing/paths stuff myself.  I
got it working for common repository types ~18 months ago and have been
afraid to look at it ever since, so I definitely feel your pain.

git-svn works alright for most repositories people come across, but
yes, it has trouble with less-common, restricted ones.

Does it do some brain-damaged things?  Yes, and those things should get
fixed.  But nowadays I'm much busier with other projects and working
with SVN/SVN bindings was a traumatic experience for me, and (possibly
as a result) the git-svn code scares me, too.

A first step to making the git-svn code more accessible would be
to split out the individual packages into smaller, more manageable
files.  The second would be documenting more of the internal data
structures that it uses (including the ones SVN returns).

Rewriting the paths/globbing code from scratch would probably be
the next step...

> So I stand defeated by your program.  Thank you.
> 
> My ugly, ugly workaround that is however easy, easy, is a shell script 
> that uses curl to find out what refs are new, and clones each ref 
> individually, then pushes all the results together into one repository.
> 
> Should not have been _that_ hard,
> Dscho

It might be helpful to publish your script so other people can see/use it.

dcommit, multi-init/fetch (precursor to clone --stdlayout) were all
prototyped as shell scripts using git-svn commands before they were
integrated into the main program.

-- 
Eric Wong
