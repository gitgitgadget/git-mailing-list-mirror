Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 600C720357
	for <e@80x24.org>; Tue, 11 Jul 2017 10:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932540AbdGKKTq (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 06:19:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:36780 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932506AbdGKKTp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 06:19:45 -0400
Received: (qmail 2231 invoked by uid 109); 11 Jul 2017 10:19:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 10:19:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14863 invoked by uid 111); 11 Jul 2017 10:19:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 06:19:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 06:19:43 -0400
Date:   Tue, 11 Jul 2017 06:19:43 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 0/7] tag: more fine-grained pager-configuration
Message-ID: <20170711101942.h2uwxtgzvgguzivu@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1499723297.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 10, 2017 at 11:55:13PM +0200, Martin Ågren wrote:

> Using, e.g., `git -c pager.tag tag -a new-tag` results in errors such
> as "Vim: Warning: Output is not to a terminal" and a garbled terminal.
> A user who makes use of `git tag -a` and `git tag -l` will probably
> choose not to configure `pager.tag` or to set it to "no", so that `git
> tag -a` will actually work, at the cost of not getting the pager with
> `git tag -l`.

Right, I think we are all agreed that "pager.tag" as it is now is
essentially worthless.

If I understand your series correctly, though, it adds pager.tag.list
but leaves "pager.tag" behaving more or less the same. It's good that we
now have a way for a user to do the thing they actually want, but it
feels like we're leaving pager.tag behind as a booby-trap.

Should we disable it entirely (or only respect it in list mode)?

At which point, I wonder if we actually need pager.tag.list at all.
Slicing up the namespace further would be valuable if there were a
command which had two pager-worthy modes, and somebody might want to
enable the pager for one but not the other. But it seems like most
commands in this boat (e.g., tag, branch, stash) really have two modes:
listing things or creating things.

Would it makes sense to just have git-tag respect pager.tag in listing
mode, and otherwise ignore it completely?

One nice side effect is that it keeps the multi-level pager.X.Y
namespace clear. We've talked about transitioning to allow:

  [pager "foo"]
  enable = true
  command = some-custom-pager

to configure aspects of the pager separately for git-foo. This has two
benefits:

  1. Syntactically, it allows configuration for commands whose names
     aren't valid config keys.

  2. It would allow setting a command with "enable=false", so that "git
     foo" did not paginate, but "git -p foo" paginated with a custom
     command.

Those are admittedly minor features. And assuming we don't go crazy with
the multi-level names, we could have "pager.tag.list" live alongside
"pager.tag.command". So it's not really an objection, so much as wonder
out loud whether we can keep this as simple as possible.

> This is an attempt to implement something like that. I decided to let
> `pager.tag.list` fall back to `pager.tag` before falling back to "on".
> The default for `pager.tag` is still "off". I can see how that might
> seem confusing. However, my argument is that it would be awkward for
> `git tag -l` to ignore `pager.tag` -- we are after all running a
> subcommand of `git tag`. Also, this avoids a regression for someone
> who has set `pager.tag` and uses `git tag -l`.

Yeah, I agree that turning "pager.tag" into a complete noop is probably
a bad idea. But if we made it a silent noop for the non-list cases, that
would be OK (and the hypothetical user who set it to make `git tag -l`
work would see a strict improvement; they'd still get their paging but
not the weird breakage with non-list modes). And I think that applies
whether we have a pager.tag.list in addition or not.

> I am not moving all builtins to handling the pager on their own, but
> instead introduce a flag IGNORE_PAGER_CONFIG and use it only with the
> tag builtin. That means there's another flag to reason about, but it
> avoids moving all builtins to handling the paging themselves just to
> make one of them do something more "clever".

I think this is very sensible. It's the vast minority that would want to
enable this (git-branch is the other obvious one). At some point we may
need a plan to handle non-builtins (like stash), but that's largely
orthogonal to what you're doing here.

> The discussion mentioned above discusses various approaches. It also
> notes how the current pager.foo-configuration conflates _whether_ and
> _how_ to run a pager. Arguably, this series paints ourselves even
> further into that corner. The idea of `pager.foo.command` and
> `pager.foo.enabled` has been mentioned and this series might make such
> an approach slightly less clean, conceptually. We could introduce
> `paging.foo` as a "yes"/"no"/"maybe" to go alongside `pager.foo` which
> is then "less"/"cat"/.... That's definitely outside this series, but
> should not be prohibited by it...

I think I covered my thoughts on this part above. :)

> A review would be much appreciated. Comments on the way I structured
> the series would be just as welcome as ones on the final result.

Overall the code looks good, though I'll respond with a few comments.

-Peff
