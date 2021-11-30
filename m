Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0746FC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 20:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343796AbhK3Uug (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 15:50:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:40462 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240271AbhK3Uuf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 15:50:35 -0500
Received: (qmail 13938 invoked by uid 109); 30 Nov 2021 20:47:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Nov 2021 20:47:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30097 invoked by uid 111); 30 Nov 2021 20:47:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Nov 2021 15:47:15 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Nov 2021 15:47:14 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH] vreportf: ensure sensible ordering of normal and
 error output
Message-ID: <YaaN0pibKWgjcVk3@coredump.intra.peff.net>
References: <20211130043946.19987-1-sunshine@sunshineco.com>
 <YaXQ/HinYZH1wL7E@coredump.intra.peff.net>
 <CAPig+cRQqm8Ce29PnkndT47NNxM3UhJv12RZGZZJD-AyGVC7Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cRQqm8Ce29PnkndT47NNxM3UhJv12RZGZZJD-AyGVC7Zw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 30, 2021 at 09:05:54AM -0500, Eric Sunshine wrote:

> >   - shouldn't status messages like this go to stderr anyway? I know some
> >     people follow the "unless it is an error, it should not to go
> >     stderr" philosophy. But I think in general our approach in Git is
> >     more "if it is the main output of the program, it goes to stdout; if
> >     it is chatter or progress for the user, it goes to stderr".
> 
> I considered this as well and agree that it would be a nicer localized
> fix, but...
> 
> (1) I don't think the practice is documented anywhere, so people --
> including me when I wrote builtin/worktree.c -- might not know about
> it. Indeed, we don't seem to be entirely consistent about doing it
> this way. Randomly picking submodule-helper.c, for instance, I see
> status-like messages going to stdout:
> 
>     printf(_("Entering '%s'\n"), displaypath);
>     printf(_("Synchronizing submodule url for '%s'\n"), ...);
> 
>     if (...)
>         format = _("Cleared directory '%s'\n");
>     else
>         format = _("Could not remove submodule work tree '%s'\n");
>     printf(format, displaypath);

Yeah, we've definitely not been consistent here. There's no silver
bullet for this aside from vigilance during review, but probably laying
out guidelines could help.

Here's a past discussion (that actually goes the other way: somebody
complaining that stderr should be on stdout!) where I laid out my mental
model:

  https://lore.kernel.org/git/20110907215716.GJ13364@sigill.intra.peff.net/

> (2) With git-worktree being four or five years old, for
> backward-compatibility concerns, I worry that "that ship has sailed",
> where 'that' is the freedom to relocate those status-like messages
> from stdout to stderr. I don't want to break tooling which exists
> around git-worktree.

IMHO it would be OK to change these. They are, after all, marked for
translation, so they're not reliably machine-readable anyway. It's
possible that some script could not be parsing them, but just trying to
redirect them. Or even keying on content in stderr as a sign of an error
(as tcl likes to do). But I don't think that's a guarantee we want to be
bound by.

See 68b939b2f0 (clone: send diagnostic messages to stderr, 2013-09-18)
for a similar case in the past.

> I'd be happy to be wrong on the second point -- indeed, git-worktree
> is still marked "experimental" in the man-page, but that may not mean
> anything this late in the game -- and submit a patch which places
> git-worktree's status-like messages on stderr instead of stdout.
> Thoughts?

I'm in favor. :)

-Peff
