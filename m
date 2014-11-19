From: Jeff King <peff@peff.net>
Subject: Re: git-fetch: default globally to --no-tags
Date: Wed, 19 Nov 2014 13:42:20 -0500
Message-ID: <20141119184220.GA9569@peff.net>
References: <20141119030523.GO22361@norris-Latitude-E6410>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 19:42:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrACw-0005Bw-OY
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 19:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482AbaKSSmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 13:42:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:42362 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755145AbaKSSmW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 13:42:22 -0500
Received: (qmail 24749 invoked by uid 102); 19 Nov 2014 18:42:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 12:42:21 -0600
Received: (qmail 6125 invoked by uid 107); 19 Nov 2014 18:42:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 19 Nov 2014 13:42:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Nov 2014 13:42:20 -0500
Content-Disposition: inline
In-Reply-To: <20141119030523.GO22361@norris-Latitude-E6410>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 18, 2014 at 07:05:23PM -0800, Brian Norris wrote:

> When I fetch from a remote repository, the only ways to
> prevent fetching tags are:
> 
>   1) git fetch --no-tags <name>
> 
>   2) git config remote.<name>.tagopt --no-tags; git fetch <name>

Yes, there is no way to globally specify --no-tags. I don't see it as a
problem to add something like that.

> The former requires extra typing for a case that (arguably) should be
> the default.

I don't understand this assumption, though. Why don't you want to fetch
tags from the remote side? Wouldn't this break something as simple as:

  git clone git://git.kernel.org/pub/scm/git/git.git
  cd git
  git checkout v2.1.3

(Actually, no, it wouldn't, because clone side-steps the usual
tag-following procedure, but wouldn't you expect the same thing to work
after a fetch in an existing repository?)

(And now having read all the way to the bottom of your email, I at least
see why you dislike tags. But I am not convinced that turning them off
completely does not come with its own set of usability problems).

> I'd prefer something like this, to change the default tag-fetching
> behavior globally:
> 
>   git config --global remote.tagopt --no-tags

Yeah, that would make sense to me (I do not know _why_ you would want to
do it, but it would be consistent with other parts of git). If you are
adding a new config option, though, please do not follow the odd and
confusing "tagopt" config value, and make a boolean remote.autofollowtags
or something.

> --- Bug ---
> 
> When trying to use the remote.<name>.tagopt configuration option
> globally, I get something like this:
> 
>   $ git config --global remote.test.tagopt --no-tags
>   $ git remote update
>   ...
>   Fetching test
>   fatal: 'test' does not appear to be a git repository
>   fatal: Could not read from remote repository.
> 
>   Please make sure you have the correct access rights
>   and the repository exists.
>   error: Could not fetch test
>   ...
> 
> Expected behavior: if the local repository does not have a remote named
> 'test', then no additional output should be printed. If the local
> repository has a remote named test, then it should be fetched with the
> --no-tags option.
> 
> Actual behavior: git prints warnings about the 'test' remote, just
> because there is no remote named 'test.'

That is the expected behavior (sort of). Any time you define a single
key in a remote, that remote "exists", whether there is a remote.*.url
key for it or not. You can use that to set options for remotes you
specify only as a URL, though I do not know how widely-used that feature
is.

IOW, git is not complaining here that there is no remote named 'test'.
It is complaining that you have defined a remote called 'test', whose
URL defaults to 'test' (because you did not specify one in the config),
and that there is no repo called test. If you defined it as:

  git config --global remote.git://github.com/git/git.tagopt --no-tags

that would "work" in the sense that "git remote update" would download
git in every repository. ;)

I think one could argue that "git remote update" should probably skip
remotes for which no url is defined (but we _do_ still want to treat
them as remotes internally, so that when you "git fetch ...", we apply
the config correctly).

> --- Motivations ---
> 
> This is all motivated by the fact that tag namespacing is completely
> broken in git. Tags are globally namespaced, and in a true DVCS
> environment, any particular developer has no control over another
> developer's tag naming conventions. So this namespace can easily become
> polluted, reducing the usefulness of tags as a whole [1]. This problem
> seems to have been acknowledged, and proposals appeared a few years ago
> [2]. But I don't see any solution for tag namespacing.

I don't know if I would say "completely broken", as it mostly gets the
job done. But yes, there are other ways of doing it that would have
advantages.

> My email boils down to two questions:
> 
>   (A) Has there been progress on implementing a proposal like in [2]?

Not really, no. If you'd like to work on it, I'm sure people would be
happy to review patches.

>   (B) Can we allow disabling (auto)tag-fetching globally? Like:
> 
>         git config --global remote.tagopt --no-tags

That seems reasonable to me to use remote.* as defaults for all remotes.

-Peff
