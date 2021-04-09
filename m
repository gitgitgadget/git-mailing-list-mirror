Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223A9C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 00:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F2A60FE8
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 00:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhDIAZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 20:25:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:45428 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232488AbhDIAZs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 20:25:48 -0400
Received: (qmail 26164 invoked by uid 109); 9 Apr 2021 00:25:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Apr 2021 00:25:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4960 invoked by uid 111); 9 Apr 2021 00:25:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Apr 2021 20:25:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Apr 2021 20:25:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] config: Introduce GIT_CONFIG_NOGLOBAL
Message-ID: <YG+e/zGgoITH6qZa@coredump.intra.peff.net>
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
 <xmqqczv4vgck.fsf@gitster.g>
 <YG+PLROZbSo32F3k@coredump.intra.peff.net>
 <xmqq35w0qr5f.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq35w0qr5f.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 08, 2021 at 04:43:08PM -0700, Junio C Hamano wrote:

> > Some other things to consider:
> >
> >   - does setting GIT_CONFIG_GLOBAL override both the $HOME and
> >     $XDG_CONFIG_HOME? If the plan is to override them, that makes sense.
> >     But we do usually read from both of them, so conceivably you might
> >     want to override just one? That's probably over-engineering, though.
> 
> I viewed this to be working at the more conceptual "here is the file
> to read 'system' (or 'per-user') stuff from" level, and not at the
> level of the individual file, as I consider that it is a mere
> implementation detail that 'per-user' may read from multiple files.

Yeah. I'm OK with that. I think it's conceptually simpler. I was going
to also say "less flexible", but once you have pointed Git at the file
of your choice, it is easy to [include] any other one if you want.

> We may have to bite the bullet and make an official catalog of
> really "structurely fundamental" configuration variables that must
> appear in the per-repository file, and a mechanism to enforce that
> by always reading these variables from "$GIT_DIR/config" and always
> ignoring appearances of them in any other places.
> 
> That alone would probably be a good thing to do regardless of the
> GIT_CONFIG_NOGLOBAL issue, as I suspect you may be able to wreak
> havoc by adding random configuration like [extension] in
> $HOME/.gitconfig ;-)

I think we've historically had some problems there, but I think these
days it's not too bad. We look directly at $GIT_DIR/config with
read_repository_format(), loading only stuff that check_repo_format()
cares about:

  - core.repositoryformatversion

  - extensions.*

  - core.bare

  - core.worktree

And those _should_ be ignored by the regular config-reading paths. So I
think it would be OK to have a $GIT_CONFIG_LOCAL variable that overrides
the location in do_git_config_sequence() only, and that would cover only
the preferences parts. I do agree it wouldn't hurt to document which
options are read in which context.

I do wonder how useful such an option would be, though. I can see why
you would want to redirect or disable system-level or user-level config
once, and then use it for many invocations. But in a single repo, you
might as well just set the repo config, or override it for a single
invocation with "git -c", etc.

I guess one possible use could be "I got a repository I do not trust as
a tarball and want to investigate it without paying attention to its
local config". But that's a pretty narrow case, and you'd probably be
better off just vetting the config yourself anyway (since depending on
what you want to do in the repo, you may need some of that config, like
remote.*, etc).

I dunno.

-Peff
