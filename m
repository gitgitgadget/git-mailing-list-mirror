From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Secure central repositories by UNIX socket authentication
Date: Sun, 27 Jan 2008 19:47:22 -0500
Message-ID: <20080128004722.GZ24004@spearce.org>
References: <20080127103934.GA2735@spearce.org> <7vsl0ix4gh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 01:48:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJIAJ-0001vN-DJ
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 01:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbYA1Ar2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 19:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753442AbYA1Ar2
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 19:47:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:43828 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbYA1Ar1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 19:47:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JJI9a-0003YN-Gc; Sun, 27 Jan 2008 19:47:14 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4C42820FBAE; Sun, 27 Jan 2008 19:47:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vsl0ix4gh.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71842>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > This isn't anywhere near ready for application, but I'm floating
> > it out there to see what people think.  Its a cool new feature that
> > will certainly *not* be in 1.5.4.  :-)
> >
> > In a central repository configuration users may not have access
> > to write new objects into a Git repository, or to edit the refs,
> > especially if the repository is being protected by an update hook
> > (e.g. contrib/hooks/updated-paranoid).
> 
> Sorry, but I am puzzled about what this assumption is trying to
> achieve here.
> 
> If the configuration is based on central repository model,
> wouldn't the users who are participating in the project have
> write access to the repository by being in the project's group
> and the repository initialized with core.sharedrepository=true?

Hmm.  core.sharedrepository is sometimes a bad solution.

core.sharedrepository means I need to give write access to both the
refs database and the object database to all members of the project.
Some of whom may not be able to be trusted with tools like "rm",
but who need real shell access to that system anyway.  And sometimes
management won't allow users to have two accounts on the same system
(one that is fixed to git-shell, and one that has a real shell)
because the world would implode if a user was given two different
accounts for two different access purposes.  I have no idea why that
would happen, but someone paid 3x what I earn has figured that out.

Last I checked how UNIX filesystem access controls work, Git's
core.sharedrepository cannot possibly prevent a user from doing
something like this:

	cd $repo_path
	git log
	... go to lunch ...
	rm -rf *
	git log
	... bitch about how crappy git is ...

Now any "real" version control and SQL database system allows the
administrator to restrict access to the database to avoid such
mistakes.  CVS has pserver; SVN can use Apache HTTPd or its own
server; Perforce has its own server.  PostgreSQL, Oracle, Informix,
DB2, even MySQL don't allow users to directly read or modify the
database files but instead ask them to go through authenticated
socket based interfaces.

Under a DSCM one would say the central model is insane, and that
every user should have their own repository, with write access
limited to only that user.  Obviously this is the model that
kernel.org uses for kernel development, and that git itself uses
for git development.


The problem is the purely distributed model falls apart when you have
50 "Aunt Tillies" making changes to the same 30 files at around the
same time.  Its bad enough that they have to have a local clone and
push and fetch to share their changes.  Trying to explain that you
need to fetch+merge from Jane right now and Bob 3 minutes later,
then back to Jane to get the changes you are working on in parallel
is sheer chaos.  Eyes gloss over and management declares "Git is
crap; it cannot possibly be used in the enterprise".

How do you setup 50 URLs into all 50 user's .git/config?  When a new
user joins the project how do you get their URL into all existing
user's trees?  Its total chaos in the cube farm as they shout back
and forth "Did you get Bob's changes?  Jane's?  Oh, maybe you didn't
get Sally's too and that's why you aren't seeing X in there".

At day-job I manage two completely different workflows, but both
are based upon Git.

Real developers who hack out program source code use a model much
like kernel.org.  Code is developed on topic branches, code is
reviewed on topic branches at the individual change level, and code
is merged from a developer's topic branch by a maintainer into a
master branch.  For convience sake we store all topic branches in a
single central repository, so everyone just has to have the "origin"
URL in their local repositories.  We could deal with individual
developer repos like kernel.org does.  We choose not to simply
because we also have to handle the next case, and its easier to
not have individual developer repos.

Aunt Tillies (who far out number real developers) edit small text
files through a fancy GUI tool.  These folks don't really care
about versions, topic branches, and really don't want to know.
All they know is they have to edit "Foo.data_file" but to do so
they need the changes just made to "Bar.data_file" 5 minutes ago.
Usually they don't even know if Bob, Sally, Jane or Nick made that
change, they just know they need it.  And their collective changes
(from all 50 Aunt Tillies) all have to somehow wind up in the same
Git branch at the end of the day so a real developer/maintainer
can pull it into a product build.


I've lived through the daily fires of these workflows over the past
year and a half.  Its mostly settled out to something that works very
well for us, but its heavily based upon this concept of a central,
shared repository.  And to keep the auditors and management happy
I cannot allow "rm -rf *" to be executed by a user who happens to
have push access to that same repository.

We're not the only Git user that has a shared repository.  Doesn't
X.org use a shared repository model?  I'm guessing that since they
are an open source project they have less concerns about the "rm
-rf *" case.  Wasn't the receive-pack service added to git-daemon
to allow users to push into a repository, but not actually have
write access to its filesystem?  Obviously someone else other than
just me wants to safeguard the repository.

-- 
Shawn.
