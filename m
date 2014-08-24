From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Relative submodule URLs
Date: Sun, 24 Aug 2014 15:34:28 +0200
Message-ID: <20140824133428.GA2839@book.hvoigt.net>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
 <20140818205505.GA20185@google.com>
 <CAHd499DVf4N3Y6m5qoiy-WQGX4K54umefRzehZMsrxiWbaiZ=g@mail.gmail.com>
 <53F76907.1090904@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Dailey <rcdailey.lists@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Sun Aug 24 15:34:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLXwQ-0001s8-LA
	for gcvg-git-2@plane.gmane.org; Sun, 24 Aug 2014 15:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbaHXNei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2014 09:34:38 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:51109 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbaHXNeh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2014 09:34:37 -0400
Received: from [77.21.76.69] (helo=book.hvoigt.net)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1XLXwH-0001PN-Cp; Sun, 24 Aug 2014 15:34:33 +0200
Content-Disposition: inline
In-Reply-To: <53F76907.1090904@xiplink.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255789>

Hi,

since the mail got quite long. To avoid 'tl;dr', I talk about two topics
in this mail:

  * Submodule settings for default remote (complex, future)
  * New --with--remote parameter for 'git submodule' (simple, now)

Depending on your interest you might want to skip the first part of the
email.

I think they are two separate topics. Please only answer to either one
and remove the other. That way we split the thread here and not mix the
two together anymore.

On Fri, Aug 22, 2014 at 12:00:07PM -0400, Marc Branchaud wrote:
> > I think you're on the right path. However I'd suggest something like
> > the following:
> > 
> > [submodule]
> >     remote = <remote_for_relative_submodules> (e.g. `upstream`)
> 
> I think remote.default would be more generally useful, especially when
> working with detached checkouts.

Depends what workflow you have. Especially for submodules where the
default remote might change from branch to branch this is not
necessarily true. The following drawbacks in relation to submodules come
to my mind:

  * You can not transport such configuration to the server. In case
    you are developing on a branch which has changes in a forked
    submodule that would be useful.

  * When your development in superproject and submodule gets merged to a
    stable branch (i.e. master) you also may not want that other remote
    anymore. So a setting, that can be per branch, might be preferred.

  * When your development gets pushed to a different remote the settings
    do not change. I.e. once part of the upstream repository the
    settings should possibly disappear.

  * You might only want to fork a certain submodule (since thats the
    only one you need to make changes in) in your branch. Then you need
    this setting to be per submodule.

So to sum up a default remote setting which would be generally useful
for submodules needs the following properties (IMO):

  * pushable
  * per branch
  * per remote
  * per submodule

All of these being optional, so in case you have a local mirror,
including submodules, of some project in which you develop with your
team you might just want to set the default remote once for all
submodules.

I have not completely thought that through but the special ref idea[3]
described by Jonathan seems to make it possible to implement all these
properties.

> > [branch.<name>]
> >     submoduleRemote = <remote_for_relative_submodule>
> 
> If I understand correctly, you want this so that your branch can be a fork of
> only the super-repo while the submodules are not forked and so they should
> keep tracking their original repo.
> 
> To me this seems to be going in the opposite direction of having branches
> recursively apply to submodules, which I think most of us want.

I disagree. While recursive branches might make sense in some
situations in most it does not. Consider a project in which you use a
library which is separately maintained. You develop on featureA in your
project and discover a bug in the submodule which you fix on a branch
(which is then tracked in the submodule). Here it does not make sense
to call your branch in the submodule featureA, since the submodule has no
knowledge at all (and should not) about this featureA.

While having said that, for a simple workflow while developing a certain
feature recursive branches make sense. Lets say as a temporary local
branch you could have that featureA branch in your submodule and just
commit any changes you need in the submodule on that branch (including
extensions and stuff). Later in the process you divide up that branch in
the submodule into cleanups, bugfixes, extensions, ...  to push it
upstream for review and integration.

> A branch should fork the entire repo, including its submodules.  The
> implication is that if you want to push that branch somewhere, that somewhere
> needs to be able to accept the forks of the submodules *even if those
> submodules aren't changed in your branch* because at the very least the
> branch ref has to exist in the submodules' repositories.

I disagree here as well. As the distributed nature of git allows to have
different remotes, I think its perfectly legitimate to just fork the
repositories you need to change. It should be easy to work on a
repository that is forked in its entirety, but it should also be possible
(and properly supported) to only fork some submodules. I know it does
make the situation more complex, but I think we should properly define
the goal beforehand, so we do not exclude any use-cases. Then we can go
ahead and just implement the simpler stuff (like entire repo forks)
first, while making sure we do not block the more complex use-cases.

> With absolute-path submodules, the push is a simple as creating the branch
> ref in the submodules' "home" repositories -- even if the main "somewhere"
> you're pushing to isn't one of those repositories.
> 
> With relative-path submodules, the push's target repo *must* also have the
> submodules in their proper places, so that they can get updated.
> Furthermore, if you clone a repo that has relative-path submodules you *must*
> also clone the submodules.

That is not true. You can have relative submodules and just clone/fetch
some from a different remote. Its just a question of how to
specifiy/transport this information.

> Robert, I think what you'll say to this is that you still want your branch to
> track the latest submodules updates from their "home" repository. (BTW, I'm
> confused with how you're using the terms "upstream" and "origin".  I'll use
> "home" to refer to the repository where everything starts from, and "fork"
> for the repository that your branch tracks.)  Well, you get the updates you
> want when your branch tracks a ref in the "home" repository.  But when your
> branch starts tracking a ref in another "fork" repository then you'll get the
> submodule updates in that ref's history from that "fork" repository.
> 
> Once your branch is tracking the "fork" repository, if you do a pull you
> won't get any submodule updates because the fork's branch hasn't changed.
> You need to fetch (recursively) from the "home" repo to get the submodule
> updates (assuming one of the "home" repo's branches has updated its
> submodules).  Then, with your branch checked out in the super-repo, if you
> check out the latest refs in your submodules git will tell you that you have
> uncommitted changes in your branch.  The correct way to get submodule updates
> into your branch is to commit them.  Even though you're doing a pull/rebase,
> there's nothing to rebase onto in the "fork" repository that has the updated
> submodules.

Let's please use the terms as Junio described them here[1]. Do not add
confusion by introducing new terms when we do not need them. If we need
new ones lets introduce them properly. Maybe even define them in the
glossary. I feel for some things it is needed when talking about
submodules, so we talk about the same things.


New --with--remote parameter for 'git submodule'
------------------------------------------------

While having said all that about submodule settings I think a much
much simpler start is to go ahead with a commandline setting, like
Robert proposed here[2].

For that we do not have to worry about how it can be stored,
transported, defined per submodule or on a branch, since answers to this
are given at the commandline (and current repository state).

There are still open questions about this though:

  * Should the name in the submodule be 'origin' even though you
    specified --with-remote=somewhere? For me its always confusing to
    have the same/similar remotes named differently in different
    repositories. That why I try to keep the names the same in all my
    clones of repositories (i.e. for my private, github, upstream
    remotes).

  * When you do a 'git submodule sync --with-remote=somewhere' should
    the remote be added or replaced.

My opinion on these are:

The remote should be named as in the superproject so
--with-remote=somewhere adds/replaces the remote 'somewhere' in the
submodules named on the commandline (or all in case no submodule is
specified). In case of a fresh clone of the submodule, there would be no
origin but only a remote under the new name.

Would the --with-remote feature I describe be a feasible start for you
Robert? What do others think? Is the naming of the parameter
'--with-remote' alright?

Cheers Heiko

[1] http://article.gmane.org/gmane.comp.version-control.git/255512
[2] http://article.gmane.org/gmane.comp.version-control.git/255512
[3] https://github.com/jlehmann/git-submod-enhancements/wiki#special-ref-overriding-gitmodules-values
