From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 5/8] Add a config option for remotes to specify a foreign
 vcs
Date: Mon, 10 Aug 2009 00:30:29 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908092153520.27553@iabervon.org>
References: <alpine.LNX.2.00.0908091526060.27553@iabervon.org> <7v1vnk79lt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Brian Gernhardt <benji@silverinsanity.com>,
	Johan Herland <johan@herland.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 06:30:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaMWt-0000Td-6l
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 06:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbZHJEaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 00:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbZHJEaa
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 00:30:30 -0400
Received: from iabervon.org ([66.92.72.58]:35125 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbZHJEa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 00:30:29 -0400
Received: (qmail 8032 invoked by uid 1000); 10 Aug 2009 04:30:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Aug 2009 04:30:29 -0000
In-Reply-To: <7v1vnk79lt.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125399>

On Sun, 9 Aug 2009, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > If this is set, the url is not required, and the transport always uses
> > a helper named "git-remote-<value>".
> >
> > It is a separate configuration option in order to allow a sensible
> > configuration for foreign systems which either have no meaningful urls
> > for repositories or which require urls that do not specify the system
> > used by the repository at that location. However, this only affects
> > how the name of the helper is determined, not anything about the
> > interaction with the helper, and the contruction is such that, if the
> > foreign scm does happen to use a co-named url method, a url with that
> > method may be used directly.
> 
> Personally, I do not like this.
> 
> Why isn't it enough to define the canonical remote name git takes as
> "<name of the helper>:<whatever string the helper understands>"?

I think that users should never need to know the names of the helpers. I 
mean, the native protocol uses helpers that most users are completely 
unaware of. The users do need to know what the 

> Then <whatever string the helper understands> part does not have to
> resemble URL at all, if the foreign system does not have such a concept
> (i.e. "have no meaning urls for repositories").  

The problem is not that foreign systems don't have "urls" in particular. 
The problem is that there are foreign systems, like perforce, where the 
lines between different repositories in the git sense are drawn in very 
different ways. In perforce, for example, there is a single namespace for 
all branches of all projects hosted on the same server. It's like if 
kernel.org had branches:

 - git-master
 - linux-master
 - git-next
 - linux-next
 - linux-rt
 - git-pu
 - linux-stable
 - sparse-master
(and hundreds more, mixing all the branches of all of the repositories 
for all of the projects, without any conventions beyond what the 
community on the particular server made up)

You really need a different sort of configuration option to specify what 
we think of as "the git.git repository", which includes certain branches 
and doesn't include other projects hosted on kernel.org. And in order to 
find the server, it uses an arbitrary shell command line that acts like 
rsh (and often consists of "ssh" as the command and a bunch of complicated 
options to connect to the right port of the right host to get the right 
restricted shell with the right preset environment). So there's nothing 
you can put in the <whatever string the helper understands> part, because 
the helper really has to figure out what it's doing from a bunch of 
options.

Furthermore, I don't want to just use "p4:" as what people should use in 
remote.*.url in order to select the right helper, because then people are 
going to have different remotes with the same url option value in order to 
access entirely different data.

The only way I've been able to come up with to support this at all 
usefully is to have a bunch of helper-specific options that specify what 
the helper needs to know about the locations you consider to be part of 
the project and an option that tells git that this remote uses the p4 
helper. I'm not sure what makes sense for other helpers, but the case I 
actually use needs something like what's in this patch.

I think it makes sense for svn access to support just having a url 
option like "svn://something (svn native protocol)", or 
"svn+ssh://something (svn protocol over ssh)" or "svn+https://something 
(https access to a svn repo)", or some other similar syntax, but this is a 
poor fit for p4.

In order to support this, there just needs to be a call to check whether 
"remote-<something>" is an available git command (without running it or 
giving an error), and the helper code should be used if it is. This is 
actually required so that people with workstations whose domain is 
.kernel.org and who have cloned "master:/home/linus/something.git" don't 
start getting "remote-master isn't a git command" errors (that is, 
misinterpreting ssh-format location hostnames as helper names. Johan, 
perhaps you could write that for your CVS helper?

> Your "let's eject curl based transport out of core" helper (already in
> 'next') will become something like these in the canonical form:
> 
> 	curl:http://git.kernel.org/pub/scm/git/git.git
> 	curl:ftp://git.kernel.org/pub/scm/git/git.git
> 	curl:https://git.kernel.org/pub/scm/git/git.git
> 
> that are handled by a single helper binary git-remote-curl, but nobody has
> to use these canonical forms for well-known transports, because we can
> have an obvious set of backward-compatible synonyms that are understood by
> the transport layer to choose that helper program, so that usual
> 
> 	http://git.kernel.org/pub/scm/git/git.git
> 
> will be understood to choose git-remote-curl backend.  We do not need to
> have three git-remote-{http,https,ftp} helpers at all.
> 
> That way, a Subversion repository people may want to interact with would
> be spelled, if the helper is "git-remote-svn", like this:
> 
> 	svn:https://scummvm.svn.sourceforge.net/svnroot/scummvm/
> 
> and it would be crystal clear that it is not a git native repository that
> is accessed over curl based walkers, and also the folks who still have not
> migrated to git can simply drop the leading "svn:" and learn the name of
> the repository they could access natively with Subversion.  Nobody on the
> Subversion side would think svn:https://... is the URL to use with
> Subversion (after all they will see that on the communication in the git
> circle).
> 
> And from the git side, we can tell users: "if you want to interact with
> Subversion repositories, you can use traditional git-svn, or you can use
> the unified remote mechanism.  To use the latter, just prefix 'svn:' in
> front of the URL used to refer to the repository in the Subversion world".
> 
> If you spell the "URL" as https://scummvm.svn.sourceforge.net/svnroot/scummvm/
> then you wouldn't be able to give that directly to git from the command
> line, without using this new configuration.  I do not quite understand why
> this indirection is desired.  I think it only confuses users.

As I said above, I think that just picking the start off of the URL is a 
good solution for systems where the remote repository has a location, but 
that's not every system, and not the one that's my personal itch.

> I recall somebody earlier mentioned a possibility to have more than one
> helper that deals with one type of foreign system.  In such a case, a pair
> of URL and vcs configuration can be used to identify what helper to use on
> what foreign "repository":
> 
> 	(https://scummvm.svn.sourceforge.net/svnroot/scummvm/, svn)
> 	(https://scummvm.svn.sourceforge.net/svnroot/scummvm/, svn-ng)
> 
> and it might become easier to switch the helper without changing the URL
> part.  But I do not particularly think that would be a practical
> advantage, unless we can assume that the next-generation version of the
> helper can somehow reuse the metadata the old version of the helper left
> in the repository and incrementally operate on the repository.  Even in
> that case, I think spelling everything out in a single configuration
> (i.e.. remote.$name.url) would make it clearer to see what is going on.

I think that, ideally, helpers for foreign systems would be portable 
across multiple native systems. The svn helper could be a program 
"svn-remote-access-helper", and anything that speaks fast-import (e.g., 
bzr or hg) would be able to use it. When installing it for git, you'd 
symlink it to git-remote-svn; if you decided to install 
"svn-remote-access-helper-ng", you'd change the symlink.

Of course, there's a long way to go before helpers can be portable in this 
direction, but I think it's mostly tractable and good for making the code 
clean.

	-Daniel
*This .sig left intentionally blank*
