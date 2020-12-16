Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64800C2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 19:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F191235FD
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 19:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbgLPTYt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 14:24:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:35304 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388241AbgLPTYs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 14:24:48 -0500
Received: (qmail 26397 invoked by uid 109); 16 Dec 2020 19:24:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Dec 2020 19:24:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1247 invoked by uid 111); 16 Dec 2020 19:24:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Dec 2020 14:24:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Dec 2020 14:24:07 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stuart MacDonald <stuartm.coding@gmail.com>, git@vger.kernel.org
Subject: Re: [Bug report] includeIf config is not displayed in normal
 directories
Message-ID: <X9pe119edtL5KQTU@coredump.intra.peff.net>
References: <CAPQE4+qq11W9VzftJ6y+cbdJ1x64c8Astjwd4z4M-oc5hv1jeA@mail.gmail.com>
 <xmqqczza7lpm.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczza7lpm.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 02:23:17PM -0800, Junio C Hamano wrote:

> > $ git clone --recursive git@github.com:git/git.git
> > OBSERVE B: The clone succeeds
> 
> This may be an unexpected but is an understandable behaviour.
> 
> First the command has to create an empty repository with an initial
> configuration file, and at that point [includeif "gitdir:*"] match
> would notice that there is a gitdir at $(pwd)/.git; by the time the
> command actually starts talking to the other side, the repository
> specific configuration can be picked up.

I think this is not just unexpected, but something we've explicitly
tried to make work. After creating the repository, we re-read the config
in order to pick up any "clone -c" options. I'm not sure if anybody
thought about how includeIf would interact here, but I think it is quite
logical to say "now that we are in a repository, these config options
that are conditional on being in a particular repository will take
effect". I.e., expecting it not to work is making assumptions about
the timing of when Git locks in the value of config options.

> And you are outside any repository, so there shouldn't be any gitdir
> in effect to influence [includeif "gitdir:*"] matching.
> 
> Another option, as Peff suggested in the old thread, would be to
> introduce a separate [includeif "cwd:*"] match, but I do not know
> how well it would fly.  with that, you may be able to
> 
> 	[includeif "cwd:/home/stuart/work/*"]
> 		path = ...
> 
> I think that may be cleaner than the "pretend we have already a
> git-dir here" hack I mentioned earlier, but I didn't think things
> through.

Perhaps. I have no objection to adding an option like that. But I don't
think it solves the fundamental issue in this bug report, which is
asking "what will the config look like in a repository that I created at
this path via git-init or git-clone?".

Maybe Stuart really would prefer to change his config to "whenever I am
in this directory root, repo or no, use this config". It does have weird
corner cases around "git --git-dir=/path/to/repo", but doing that from
another directory is perhaps rare enough that people using a cwd:
conditional would be happy to ignore that.

But if we do want to solve it, then your --pretend-git-dir is doing that
directly. I don't think it's terribly useful in general, but it could be
a debugging aid.

-Peff
