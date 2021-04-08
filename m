Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739DCC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BB0610A3
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbhDHXST (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:18:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:45292 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232404AbhDHXSS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:18:18 -0400
Received: (qmail 25836 invoked by uid 109); 8 Apr 2021 23:18:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Apr 2021 23:18:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4376 invoked by uid 111); 8 Apr 2021 23:18:06 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Apr 2021 19:18:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Apr 2021 19:18:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] config: Introduce GIT_CONFIG_NOGLOBAL
Message-ID: <YG+PLROZbSo32F3k@coredump.intra.peff.net>
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
 <xmqqczv4vgck.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczv4vgck.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 08, 2021 at 10:25:15AM -0700, Junio C Hamano wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> 
> > While it's already possible to stop git from reading the system config
> > via GIT_CONFIG_NOSYSTEM, doing the same for global config files requires
> > the user to unset both HOME and XDG_CONFIG_HOME. This is an awkward
> > interface and may even pose a problem e.g. when git hooks rely on these
> > variables to be present.
> 
> Yeah, having to unset HOME would affect not just Git.  Git may call
> out something else (e.g. an editor) that may want to know where HOME
> is, Git may be used in something else (e.g. an IDE) that may want to
> know where HOME is.  Same for XDG_CONFIG_HOME.  If it is a valid need
> to not reading from $HOME/.gitconfig, unsetting HOME is an unacceptable
> approach to satisfying that need.

We actually used to have GIT_CONFIG_NOGLOBAL, which was used in the test
suite. But after switching to setting $HOME, it went away in 8f323c00dd
(config: drop support for GIT_CONFIG_NOGLOBAL, 2011-03-15). I agree that
it's a little more awkward these days because of $XDG_CONFIG_HOME (and
also because it influences other programs besides Git).

I'm not particularly opposed to re-adding it, but I do think having an
environment variable for "read this file instead", as you suggested
below, would be much better. It's a superset of the "no" functionality,
and would also let us improve our test coverage (especially if we add a
matching one for "system" config).

Looking at your suggestion:

> So, from these two perspective, for the longer term end-user
> experience, I am not 100% onboard with GIT_CONFIG_NOGLOBAL.  An
> alternative that allows us to move away from GIT_CONFIG_NOSYSTEM in
> the direction to the tangent #2 would be not to repeat the same
> mistake by doing GIT_CONFIG_NOGLOBAL, and instead adding
> GIT_CONFIG_GLOBAL, which is
> 
>  (1) when not set, it does not do anything,
> 
>  (2) when set to "/dev/null" (a literal string; you do not have to
>     spell it "NUL" when on Windows), it acts just like the case
>     where your GIT_CONFIG_NOSYSTEM is set,
> 
>  (3) when set to any other string, it is taken as a filename that
>      has the global configuration.  Unlike $HOME/.gitconfig or
>      $XDG_HOME/git/config, it is an error if the named file does not
>      exist (this is to catch misconfiguration).
> 
> And once this is accepted by users and established as a pattern, we
> could migrate GIT_CONFIG_NOSYSTEM to GIT_CONFIG_SYSTEM=/dev/null

That seems pretty reasonable. I'm on the fence on your (3). Conceivably
somebody could want to override the baked-in defaults without being sure
the file is present. But I'm not sure how useful that would be in
practice.

Some other things to consider:

  - does setting GIT_CONFIG_GLOBAL override both the $HOME and
    $XDG_CONFIG_HOME? If the plan is to override them, that makes sense.
    But we do usually read from both of them, so conceivably you might
    want to override just one? That's probably over-engineering, though.

  - if we have config for "read from this file instead of the system
    config" and "read from this instead of the user-level config", then
    I wonder if people will want "read this instead of the repo config".
    We have resisted having GIT_CONFIG mean that for many years, because
    I think it gets awkward in some cases (e.g., we'd still want to read
    it for core.repositoryformatversion, etc). I'm OK with drawing the
    line there and saying it's not a support feature, but we should be
    prepared to explain it to users (in the docs or at least in the
    commit message adding the system/global override variables).

-Peff
