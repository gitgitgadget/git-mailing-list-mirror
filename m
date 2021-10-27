Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24995C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 11:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D51560F70
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 11:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbhJ0L6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 07:58:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:47932 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241715AbhJ0L6X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 07:58:23 -0400
Received: (qmail 13175 invoked by uid 109); 27 Oct 2021 11:55:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 Oct 2021 11:55:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22224 invoked by uid 111); 27 Oct 2021 11:55:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 Oct 2021 07:55:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 Oct 2021 07:55:57 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH 0/2] Conditional config includes based on remote URL
Message-ID: <YXk+TRnndNZkdsGF@coredump.intra.peff.net>
References: <cover.1634077795.git.jonathantanmy@google.com>
 <20211018204803.75088-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211018204803.75088-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 18, 2021 at 01:48:03PM -0700, Jonathan Tan wrote:

>  (1) Introduce a "includeAfterIf" (or "deferIncludeIf", or some other
>      name) command that is executed after all config files are read. (If
>      there are multiple, they are executed in order of appearance.)
>      Files included by this mechanism cannot directly or indirectly
>      contain another "includeAfterIf". This is the same as what was
>      introduced in this patch set, except for the name of the directive.

I think this works in terms of having self-consistent rules that make
sense. But deferring things does introduce new complications in terms of
overrides, because we rely on last-one-wins. Emily asked elsewhere about
overriding the inclusion of a file. We don't have a way to do that now,
and I think it would be tricky to add. But what about overriding a
single variable?

Right now this works:

  git config --global foo.bar true
  git config --local foo.bar false

to give you "false". But imagining there was a world of deferred config,
then:

  git config --file ~/.gitconfig-foo foo.bar true
  git config --global deferInclude.path .gitconfig-foo
  git config --local foo.bar false

gives "true". We'd read .gitconfig-foo after everything else, overriding
the repo-level config.

If the deferred includes were processed at the end of each individual
file, that would solve that. You're still left with the slight oddness
that a deferred include may override options within the same file that
come after it, but that's inherent to the "defer" concept, and the
answer is probably "don't do that". It's only when it crosses file
boundaries (which are explicitly ordered by priority) that it really
hurts.

>  (2) Leave the name as "includeIf", and when it is encountered with a
>      remote-URL condition: continue parsing the config files, skipping
>      all "includeIf hasRemoteUrl", only looking for remote.*.url. After
>      that, resume the reading of config files at the first "includeIf
>      hasRemoteUrl", using the prior remote.*.url information gathered to
>      determine which files to include when "includeIf hasRemoteUrl" is
>      encountered. Files included by this mechanism cannot contain any
>      "remote.*.url" variables.

I think doing this as "continue parsing" and "resume" is hard to do.
Because you can't look at other non-remote.*.url entries here (otherwise
you'd see them out of order). So you have to either:

  - complete the parse, stashing all the other variables away, and then
    resolve the include, and then look at all the stashed variables as
    if you were parsing them anew.

  - teach our config parser how to save and restore state, including
    both intra-file state and the progress across the set of files

I think it's much easier if you think of it as "start a new config parse
that does not respect hasRemoteURL". And the easiest way to do that is
to just let remote.c's existing git_config() start that parse (probably
by calling git_config_with_options() and telling it "don't respect
hasRemoteURL includes"). You may also need to teach the config parser to
be reentrant. We did some work on that a while ago, pushing the state
int config_source which functions as a stack, but I don't offhand know
if you can call git_config() from within a config callback.

> There are other ideas including:
> 
>  (3) remote.*.url must appear before a "includeIf hasRemoteUrl" that
>      wants to match it. (But this doesn't fit our use case, in which a
>      repo config has the URL but a system or user config has the
>      include.)

Yeah, I agree this won't work.

>  (4) "includeIf hasRemoteUrl" triggers a search of the repo config just
>      for remote.*.url. (I think this out-of-order config search is more
>      complicated than (2), though.)

I think this is what I described above, and actually is less
complicated. ;)

-Peff
