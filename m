Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EB9F20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 18:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754145AbdASS1Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 13:27:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:41634 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753966AbdASS1X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 13:27:23 -0500
Received: (qmail 3977 invoked by uid 109); 19 Jan 2017 18:27:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 18:27:23 +0000
Received: (qmail 7523 invoked by uid 111); 19 Jan 2017 18:28:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 13:28:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jan 2017 13:27:21 -0500
Date:   Thu, 19 Jan 2017 13:27:21 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Andrew Arnott <Andrew.Arnott@microsoft.com>
Subject: Re: [PATCH 2/2] Be more careful when determining whether a remote
 was configured
Message-ID: <20170119182721.7y2zzrbaalfqjjn6@sigill.intra.peff.net>
References: <cover.1484687919.git.johannes.schindelin@gmx.de>
 <41c347f22c80e96c54db34baa739b6e37e268b61.1484687919.git.johannes.schindelin@gmx.de>
 <20170117214723.p5rni6wwggei366j@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701181334040.3469@virtualbox>
 <20170118125422.gi3ppqiqhyykk7iy@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701181700020.3469@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1701181700020.3469@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 05:22:40PM +0100, Johannes Schindelin wrote:

> > > I want to err on the side of caution. That's why.
> > 
> > I guess I just don't see why changing the behavior with respect to
> > "prune" or "proxy" is any less conservative than changing the one for
> > "refspec".
> 
> Let's take a step back and consider the problem I try to solve, okay?

OK. Though after reading your message over several times, I think I may
have confused things by raising two separate issues.

So let me re-state my issues here for clarity:

  1. I'm concerned that a setting for remote.<url>.X would fail to apply
     to a bare "git fetch <url>" if "X" is considered as "not really"
     configuring a remote.

  2. I'm concerned that splitting the remote.*.X keys into two classes:
     "really configures" and "does not really configure" creates a
     confusing interface for users. Some keys are OK to set in your
     ~/.gitconfig and others are not.

Let's talk about concern 1 first.  Based on your analysis in this
message, it looks like it _isn't_ a problem with your patch (because
is_configured is never used for applying values, only for add/del/rename
types of operations in remote.c).

So good. Thanks for addressing my concern. And that makes your
"conservative" comment make more sense; the idea is that you are not
breaking anything, but just loosening selectively for some values of
"X".

I think there are still some weird corner cases even for "prune",
though. E.g., try:

  git init
  git remote add foo whatever
  git config remote.foo.prune true
  git config remote.other.prune false

So now we have:

	[remote "foo"]
		url = whatever
		fetch = +refs/heads/*:refs/remotes/foo/*
		prune = true
	[remote "other"]
		prune = false

Now try "git remote rename foo other". With current versions of git,
it's disallowed. With your patch, I get:

	[remote "other"]
		url = whatever
		prune = true
	[remote "other"]
		prune = false
		fetch = +refs/heads/*:refs/remotes/other/*

The old value of remote.other.prune is overriding the one we tried to
move into place.

In your motivating example, the old value is in ~/.gitconfig, so it
automatically takes lower precedence, and everything just works (I think
it would also just work if "other" had been defined originally _before_
foo in the config file).

I think you could fix it by having git-remote teach the "not really"
config values (like "prune") to overwrite any existing value when
rewriting the config. I think this just needs the multi_replace flag set
when calling git_config_set_multivar().

That raises questions about what should happen when multi-value keys
like "refspec" would be set (if we were to add them to the "not really"
set). Should they be overwritten, or merged? And in that sense, your
patch lets you punt on those issues.


I still think my second concern is valid. It's made worse by your patch
(if only because everything was disallowed before, and now some things
are and some things aren't). If this is a first step towards a final
state where the rules are simple, then starting conservatively makes
sense. And until we get there, the answer "yes, it should, but nobody
has worked out the semantics yet; care to make a patch?" is an OK one.
But it sounds like you do not ever want to loosen the "refspec" case.

I don't think that's ideal, but at the very least if that's the end
state, the list of "OK to use in ~/.gitconfig" keys should probably be
documented.

Reading your message, though, I still wonder if we can do better...

> The problem is that `git remote rename <old> <new>` refuses to do its job
> if it detects a configured `<new>`. And it detects a configured `<new>`
> even in cases where there is not *really* any remote configured.

I'd add to this that "git remote add <new>" should work in a similar way
(that was the one that I think people often ran into with
remote.origin.fetch refspecs).

> The example use case is to configure `remote.origin.prune = true` in
> ~/.gitconfig, i.e. changing Git's default for all "origin" remotes in all
> of the user's repositories.
> 
> Now, the *real* fix would be to detect whether the remote was "configured"
> in the current repository, or in ~/.gitconfig. But that may not even be
> desirable, as we would want a more general fix for the question: can `git
> remote` rename a given remote to a new name, i.e. is that new name already
> taken?

I think _this_ is a much better way of framing the problem. It is not
about which keys are set, but about _where_ they are set. IOW, a
reasonable rule would be: if there is any remote.*.X in the repo config,
then git-remote should consider it a configured repo. And otherwise, no
matter what is in ~/.gitconfig or elsewhere, git-remote should proceed
as if it doesn't exist (and repo-level config can take precedence over
config defined elsewhere).

I.e., something like this:

diff --git a/remote.c b/remote.c
index 298f2f93f..720d616be 100644
--- a/remote.c
+++ b/remote.c
@@ -373,6 +373,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 	}
 	remote = make_remote(name, namelen);
 	remote->origin = REMOTE_CONFIG;
+	if (current_config_scope() == CONFIG_SCOPE_REPO)
+		remote->configured = 1;
 	if (!strcmp(subkey, "mirror"))
 		remote->mirror = git_config_bool(key, value);
 	else if (!strcmp(subkey, "skipdefaultupdate"))

That doesn't make your test pass, but I think that is only because your
test is not covering the interesting case (it puts the new config in the
repo config, not in ~/.gitconfig).

What do you think?

> Originally, I would even have put the "vcs" into that set, as I could see
> a legitimate use case for users to configure "remote.svn.vcs = vcs" in
> ~/.gitconfig. But the regression test suite specifically tests for that
> case, and I trust that there was a good reason, even if Thomas did not
> describe that good reason in the commit message nor in any reply to this
> patch pair.

The config-scope thing above would allow "remote.svn.vcs" in
~/.gitconfig. But I don't think the test script actually checks that; it
checks for the repo-level config. And we would continue to do the right
thing there.

-Peff
