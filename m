Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FCCC4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 19:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiJNTjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 15:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiJNTj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 15:39:28 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905261D79B6
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 12:39:20 -0700 (PDT)
Received: (qmail 14292 invoked by uid 109); 14 Oct 2022 19:39:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Oct 2022 19:39:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1429 invoked by uid 111); 14 Oct 2022 19:39:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Oct 2022 15:39:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Oct 2022 15:39:13 -0400
From:   Jeff King <peff@peff.net>
To:     Elsie Hupp <git@elsiehupp.com>
Cc:     Junio C Hamano <gitster@pobox.com>, reto@labrat.space,
        philipoakley@iee.email, git@vger.kernel.org
Subject: Re: Multiple --global config workspaces?
Message-ID: <Y0m64fHWIjZoXoTQ@coredump.intra.peff.net>
References: <C4E3A512-2E2C-4EA5-9F2E-3662BCF0F165@elsiehupp.com>
 <xmqqwn96x61t.fsf@gitster.g>
 <Y0Vr/4IeA236nxzF@coredump.intra.peff.net>
 <03B277AB-DE33-443D-AC9C-FAB7A2F93AB3@elsiehupp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03B277AB-DE33-443D-AC9C-FAB7A2F93AB3@elsiehupp.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2022 at 12:55:24PM -0400, Elsie Hupp wrote:

> I was using the “Git Book” documentation, not the manpage, since (a)
> the “Git Book” is more user-friendly, and (b) it’s higher on the
> DuckDuckGo results for “git config", i.e.:
> 
> https://www.git-scm.com/book/en/v2/Customizing-Git-Git-Configuration

I'm not too surprised that conditional includes aren't mentioned there.
The last major revision of the book was the second edition in 2014, and
conditional includes are from 2017. (Includes in general were from 2012,
but I think they were pretty niche back then).

> So in summary it seems like a big part the issue I had is that the
> documentation for conditional includes has somewhat lacking SEO, i.e.
> if someone is familiar with the --global config keywords and googles
> that, they are unlikely to find the section for conditional includes.
> And, additionally, conditional includes are a new enough feature that
> they don’t appear in the higher-ranking web-based manpages, neither of
> which display the version of Git they pertain to. (Maybe someone could
> poke them about this, but I’m not sure the best way of doing so.)

I'm not sure who to poke about updating those other sites (or even how
old they are). The git-scm.com is maintained by Git folks, and always
has documentation for the latest version. It also shows up at the top of
Google results for me, but given how personalization works there, I've
no clue how common that is.

As you noted, git-scm.com also carries the book content. They do take
community input, but I don't think there are many (any?) regular Git
developers who contribute much there. Looks like you opened an issue in
the progit2 repository, which is the best next step there.

> As an aside, looking through the full documentation I see that I can also do:
> 
> [includeIf "hasconfig:remote.*.url:https://github.com/**”] path = ./Repositories/github/.gitconfig
> [includeIf "hasconfig:remote.*.url:https://gitlab.com/**”] path =  ./Repositories/gitlab/.gitconfig

Ah, I forgot about that one. Note that it's new-ish, only in v2.36 and
higher. I agree it's probably a better fit for your use case.

> Something more consistent with my initial use case might be a
> hypothetical feature like the following (apologies for dubious
> syntax):
> 
> [user "gitdir:github/"]
> 	email = "elsiehupp.github@example.com"

The trouble there is that the "subsection" (the part in quotes) already
has a meaning for many keys. E.g.,

  [remote "foo"]
  url = ...whatever...

couldn't be conditional. Obviously we could add new syntax to solve
this, but one of the design goals of both the original include feature,
as well as the conditional includes, was to remain syntactically
compatible with existing parsers. But it is an unfortunate tradeoff that
it's a bit clunkier than it otherwise could be.

> I also tried:
> 
> [include] path = $GIT_COMMON_DIR/../.gitconfig
> 
> …only to discover that $GIT_COMMON_DIR is not set automatically. Is
> there some way of automatically describing a path relative to any
> given cloned Git repository?

No, I don't think there's a way of doing that right now. But I agree it
could work and would retain syntactic compatibility. I wonder if it's
worth it, though. The result is potentially fragile (e.g., if you had
github/foo/repo.git it would need to use more dot-dot elements), and it
doesn't really solve the most obvious stumbling block, which is that you
were looking for conditional variables, not conditional includes.

> And I tried the following to no avail (despite both paths resolving when using cat):
> 
> [includeIf "gitdir:github/"] path = ./**/github/.gitconfig
> 
> [includeIf "gitdir:github/"] path = ./*/github/.gitconfig

Right, the value of an include path expands to a single file, and we do
not do any globbing. I suppose it would be possible to do, and we'd read
each file in sequence. But I'm not sure I'm convinced of the utility of
that (and again, it doesn't help the discoverability problem you had).

-Peff
