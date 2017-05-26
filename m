Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3DA51FA14
	for <e@80x24.org>; Fri, 26 May 2017 13:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763203AbdEZNYh (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 May 2017 09:24:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:58492 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758537AbdEZNYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 May 2017 09:24:36 -0400
Received: (qmail 31907 invoked by uid 109); 26 May 2017 13:24:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 13:24:34 +0000
Received: (qmail 30050 invoked by uid 111); 26 May 2017 13:25:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 May 2017 09:25:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 May 2017 09:24:32 -0400
Date:   Fri, 26 May 2017 09:24:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] recognize pathspec magic without "--" disambiguation
Message-ID: <20170526132432.zcoml5vphrzd557t@sigill.intra.peff.net>
References: <20170525152739.t63dbsq2dojy2y2h@sigill.intra.peff.net>
 <xmqq4lw8cql8.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lw8cql8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 26, 2017 at 11:13:55AM +0900, Junio C Hamano wrote:

> >    - git log :^foo
> >       (when "^foo" exists in your index)
> >
> >       The same logic applies; it would continue to work. And
> >       ditto for any other weird filenames in your index like
> >       "(attr)foo".
> 
> "git show :$path" where $path happens to be "^foo" would grab the
> contents of the $path out of the index and I think that is what you
> meant, but use of "git log" in the example made me scratch my head
> greatly.

Yeah, sorry about that confusion. My original motivation for this was
for use with git-grep, but since the existing tests all used "git log",
I tried to switch to that for consistency. But index paths obviously
make no sense with "git log" (we _do_ still parse it the same as we
would for git-show, etc, even though git-log doesn't do anything with
it).

As an aside, I wonder if git-log should issue a warning when there are
pending objects that it doesn't handle.

> >    - git log :/foo
> >       (when "foo" does _not_ match a commit message)
> >	...
> >       This same downside actually exists currently when you
> >       have an asterisk in your regex. E.g.,
> >
> >         git log :/foo.*bar
> >
> >       will be treated as a pathspec (if it doesn't match a
> >       commit message) due to the wildcard matching in
> >       28fcc0b71.
> 
> In other words, we are not making things worse?

We're making them slightly worse. The "problem" used to trigger with
":/foo.*bar", and now it would trigger with ":/foobar", too. I don't
know if that's a meaningful distinction, though.

> Unlike "git log builtin-checkout.c" that errors out (only because
> there is no such file in the checkout of the current version) and
> makes its solution obvious to the users, this change has the risk of
> silently accepting an ambiguous input and computing result that is
> different from what the user intended to.  So I am not sure.  

Right, that's what I was trying to catalogue in the commit message.

> As you pointedout, ":/" especially does look like a likely point of
> failure, in that both "this is path at the top" pathspec magic and
> "the commit with this string" are not something that we can say with
> confidence that are rarely used because they are so esoteric.
> 
> As to "is it OK to build a rule that we cannot explain easily?", I
> think it is OK to say "if it is not a rev, and if it is not a
> pathname in the current working tree, you must disambiguate, but Git
> helps by guessing in some cases---if you want to have more control
> (e.g. you are a script), explicitly disambiguate and you'd be OK",
> and leave the "some cases" vague, as long as we are only making
> reasonably conservative guesses.

I don't know. That is punting on the issue by not making any promises.
But that's a small consolation to somebody who does:

  $ git log :^foo
  [ok, works great...]
  $ git log :/foo
  fatal: ambiguous argument ':/foo': unknown revision or path not in the working tree.
  [stupid git! why don't you work?]

An explanation like "it's complicated, and the rules are meant to be
conservative and avoid confusion" does not really help Git's reputation
for being arcane.

I dunno. The one saving grace of ":/" is that we actually do handle
the ":/foo" case completely in check_filename(). So going back to my
:/foobar example: if you have a file "foobar" in your root directory, it
_is_ considered ambiguous.

So if that was the one exception, it would probably be OK in practice.

Which again makes me feel a bit like the right solution is doing the
existence checks on the non-magic portion of the pathspec for more magic
besides ":/".

Unfortunately, since writing my last message I did look into asking the
pathspec code to parse the arguments for us, but I think it would take
quite a bit of refactoring. It's very ready to die() or emit warnings on
bogus pathspecs, so it's not a good match for this kind of speculative
"is it a pathspec" test.

The middle ground would be to replicate a simple subset of the rules in
verify_filename(). If we assume that all arguments with ":(" are
pathspecs (which seem rather unlikely to have false positives), then
that leaves only a few short-magic patterns: :/, :!, and :^.

We already specially handle :/ here. So it would really just be adding
the other two (which are just aliases of each other). It's not that much
code. The dirty thing is just that we're replicating some of the
pathspec logic, and any new magic would have to be updated here, too.

I'll see if I can work up a patch.

-Peff
