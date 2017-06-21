Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2A7B20401
	for <e@80x24.org>; Wed, 21 Jun 2017 19:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbdFUTwx (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 15:52:53 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59604 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751028AbdFUTww (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 15:52:52 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3E3DE20401;
        Wed, 21 Jun 2017 19:52:52 +0000 (UTC)
Date:   Wed, 21 Jun 2017 19:52:52 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Tim Hutt <tdhutt@gmail.com>, git@vger.kernel.org
Subject: Re: Monitoring a repository for changes
Message-ID: <20170621195252.GA31582@starla>
References: <CAKuVd4Bdhreu6wrwDp1Bia56Db=TXYMQcitsznaRM+QcYVzJnQ@mail.gmail.com>
 <87efud8jrn.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87efud8jrn.fsf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> On Wed, Jun 21 2017, Tim Hutt jotted:
> 
> > Hi,
> >
> > Currently if you want to monitor a repository for changes there are
> > three options:
> >
> > * Polling - run a script to check for updates every 60 seconds.
> > * Server side hooks
> > * Web hooks (on Github, Bitbucket etc.)
> >
> > Unfortunately for many (most?) cases server-side hooks and web hooks
> > are not suitable. They require you to both have admin access to the
> > repo and have a public server available to push updates to. That is a
> > huge faff when all I want to do is run some local code when a repo is
> > updated (e.g. play a sound).

Yeah, it kinda sucks that way.

Currently, for one of my public-inbox mirrors which has ssh
access to the primary server on public-inbox.org, I have:

	#!/bin/sh
	while true
	do
		# GNU tail(1) uses inotify to avoid polling on Linux
		ssh public-inbox.org tail -F /path/to/git-vger.git/info/refs | \
				while read sha1 ref
		do
			for GIT_DIR in git-vger.git
			do
				export GIT_DIR
				git fetch || continue
				git update-server-info
				public-inbox-index # update Xapian index
			done
		done
	done

It's not perfect as it requires multiple processes on the
server, but it's better than polling for my limited use.

> > Currently people resort to polling
> > (https://stackoverflow.com/a/5199111/265521) which is just ugly. I
> > would like to propose that there should be a forth option that uses a
> > persistent connection to monitor the repo. It would be used something
> > like this:
> >
> >     git watch https://github.com/git/git.git
> >
> > or
> >
> >     git watch git@github.com:git/git.git
> >
> > It would then print simple messages to stdout. The complexity of what
> > it prints is up for debate, - it could be something as simple as
> > "PUSH\n", or it could include more information, e.g. JSON-encoded
> > information about the commits. I'd be happy with just "PUSH\n" though.
> 
> Insofar as this could be implemented in some standard way in Git it's
> likely to have a large overlap with the "protocol v2" that keeps coming
> up here on-list. You might want to search for past threads discussing
> that.

Yeah, it hasn't been a priority for me, either...

> > In terms of implementation, the HTTP transport could use Server-Sent
> > Events, and the SSH transport can pretty much do whatever so that
> > should be easy.
> 
> In case you didn't know, any of the non-trivially sized git hosting
> providers (e.g. github, gitlab) provide you access over ssh, but you
> can't just run any arbitrary command, it's a tiny set of whitelisted
> commands. See the "git-shell" manual page (github doesn't use that exact
> software, but something similar).
> 
> But overall, it would be nice to have some rationale for this approach
> other than that you think polling is ugly. There's a lot of advantages
> to polling for something you don't need near-instantly, e.g. imagine how
> many active connections a site like GitHub would need to handle if
> something like this became widely used, that's in a lot of ways harder
> to scale and load balance than just having clients that poll something
> that's trivially cached as static content.

Polling becomes more expensive with TLS and high-latency
connections, and also increases power consumption if done
frequently for redundancy purposes.

I've long wanted to do something better to allow others to keep
public-inbox mirrors up-to-date.  Having only 64-128 bytes of
overhead per userspace per-connection should be totally doable
based on my experience working on cmogstored; at which point
port exhaustion will become the limiting factor (or TLS overhead
for HTTPS).

But perhaps a cheaper option might be the traditional email/IRC
notification and having a client-side process watch for that
before fetching.
