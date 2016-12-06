Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B7291FC96
	for <e@80x24.org>; Tue,  6 Dec 2016 15:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbcLFPJ7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 10:09:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:52463 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751951AbcLFPJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 10:09:58 -0500
Received: (qmail 24867 invoked by uid 109); 6 Dec 2016 15:09:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 15:09:56 +0000
Received: (qmail 14434 invoked by uid 111); 6 Dec 2016 15:10:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Dec 2016 10:10:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Dec 2016 10:09:55 -0500
Date:   Tue, 6 Dec 2016 10:09:55 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v3 1/2] difftool: add a skeleton for the upcoming builtin
Message-ID: <20161206150955.mvq4ocamaei52bap@sigill.intra.peff.net>
References: <xmqqa8cjjtfn.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611292128340.117539@virtualbox>
 <xmqqshqadn0f.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1611301325210.117539@virtualbox>
 <xmqqlgvz6x87.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1612051126320.117539@virtualbox>
 <xmqqy3zu43yk.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1612061411000.117539@virtualbox>
 <20161206133650.t7gkg4f6wzw3zxki@sigill.intra.peff.net>
 <alpine.DEB.2.20.1612061512190.117539@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1612061512190.117539@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 06, 2016 at 03:48:38PM +0100, Johannes Schindelin wrote:

> > Should it blindly look at ".git/config"?
> 
> Absolutely not, of course. You did not need me to say that.
> 
> > Now your program behaves differently depending on whether you are in the
> > top-level of the working tree.
> 
> Exactly. This, BTW, is already how the code would behave if anybody called
> `git_path()` before `setup_git_directory()`, as the former function
> implicitly calls `setup_git_env()` which does *not* call
> `setup_git_directory()` but *does* set up `git_dir` which is then used by
> `do_git_config_sequence()`..
> 
> We have a few of these nasty surprises in our code base, where code
> silently assumes that global state is set up correctly, and succeeds in
> sometimes surprising ways if it is not.

Right. I have been working on fixing this. v2.11 has a ton of tweaks in
this area, and my patch to die() rather than default to ".git" is
cooking in next to catch any stragglers.

> > Should it speculatively do repo discovery, and use any discovered config
> > file?
> 
> Personally, I find the way we discover the repository most irritating. It
> seems that we have multiple, mutually incompatible code paths
> (`setup_git_directory()` and `setup_git_env()` come to mind already, and
> it does not help that consecutive calls to `setup_git_directory()` will
> yield a very unexpected outcome).

I agree. We should be killing off setup_git_env(), which is something
I've been slowly working towards over the years.

There are some annoyances with setup_git_directory(), too (like the fact
that you cannot ask "is there a git repository you can find" without
making un-recoverable changes to the process state). I think we should
fix those, too.

> > Now some commands respect config that they shouldn't (e.g., running "git
> > init foo.git" from inside another repository will accidentally pick up
> > the value of core.sharedrepository from wherever you happen to run it).
> 
> Right. That points to another problem with the way we do things: we leak
> global state from discovering a git_dir, which means that we can neither
> undo nor override it.
> 
> If we discovered our git_dir in a robust manner, `git init` could say:
> hey, this git_dir is actually not what I wanted, here is what I want.
> 
> Likewise, `git submodule` would eventually be able to run in the very same
> process as the calling `git`, as would a local fetch.

Yep, I agree with all that. I do think things _have_ been improving over
the years, and the code is way less tangled than it used to be. But
there are so many corner cases, and the code is so fundamental, that it
has been slow going. I'd be happy to review patches if you want to push
it along.

> > So I think the caller of the config code has to provide some kind of
> > context about how it is expecting to run and how the value will be used.
> 
> Yep.
> 
> Maybe even go a step further and say that the config code needs a context
> "object".

If I were writing git from scratch, I'd consider making a "struct
repository" object. I'm not sure how painful it would be to retro-fit it
at this point.

> > Right now if setup_git_directory() or similar hasn't been called, the
> > config code does not look.
> 
> Correct.
> 
> Actually, half correct. If setup_git_directory() has not been called, but,
> say, git_path() (and thereby implicitly setup_git_env()), the config code
> *does* look. At a hard-coded .git/config.

Not since b9605bc4f (config: only read .git/config from configured
repos, 2016-09-12). That's why pager.c needs its little hack.

I guess you could see that as a step backwards, but I think it is
necessary one on the road to doing it right.

> > Ideally there would be a way for a caller to say "I am running early and
> > not even sure yet if we are in a repo; please speculatively try to find
> > repo config for me".
> 
> And ideally, it would not roll *yet another* way to discover the git_dir,
> but it would reuse the same function (fixing it not to chdir()
> unilaterally).

Yes, absolutely.

> Of course, not using `chdir()` means that we have to figure out symbolic
> links somehow, in case somebody works from a symlinked subdirectory, e.g.:
> 
> 	ln -s $PWD/t/ ~/test-directory
> 	cd ~/test-directory
> 	git log

There's work happening elsewhere[1] on making real_path() work without
calling chdir(). Which necessarily involves resolving symlinks
ourselves. I wonder if we could leverage that work here (ideally by
using real_path() under the hood, and not reimplementing the same
readlink() logic ourselves).

[1] http://public-inbox.org/git/1480964316-99305-1-git-send-email-bmwill@google.com/

> > The pager code does this manually, and without great accuracy; see the
> > hack in pager.c's read_early_config().
> 
> I saw it. And that is what triggered the mail you are responding to (you
> probably saw my eye-rolling between the lines).
> 
> The real question is: can we fix this? Or is there simply too great
> reluctance to change the current code?

The code in pager.c is only a month or two old. Like I said, it's ugly,
but I think it's a necessary step on the way forward. So I don't think
there's reluctance at all. The next steps (which I outlined) just
haven't been taken yet.

> > I think the way forward is:
> > 
> >   1. Make that an optional behavior in git_config_with_options() so
> >      other spots can reuse it (probably alias lookup, and something like
> >      your difftool config).
> 
> Ideally: *any* early call to `git_config_get_value()`. Make things less
> surprising.

I'm not convinced that's a good idea. The changes in b9605bc4f were
motivated by a real bug, which your suggestion would reintroduce (namely
low-level code run by git-init ending up with config variables from a
repo that _should_ be unrelated).

In my mental model, the cases are:

  1. We are "early" in the process, before we know if we have a repo or
     not. These early looks should speculatively look at repo config,
     which is confined to generic things like pager config, alias
     config, etc.

  2. We are in a repo. Obviously look at $GIT_DIR/config.

  3. We are in a program which has done setup and determined we are
     _not_ in a repo. Definitely do not look at .git/config or anything
     else.

My plan was for the config code to default to (3) when we are not in a
repo, but let some lookups ask specifically for (1).

If you want to default to (1), you need some way for programs to say "I
am really case (3); do not look for a repo". And it needs to be global,
as the config lookup may be done by much lower-level code. That could be
by turning startup_info->have_repository into a tri-state. It just
wasn't the way I was planning on it.

> >   2. Make it more accurate. Right now it blindly looks in .git/config,
> >      but it should be able to do the usual repo-detection (_without_
> >      actually entering the repo) to try to find a possible config file.
> 
> The real trick will be to convince Junio to have a single function for
> git_dir discovery, I guess, lest we have multiple, slightly incompatible
> ways to discover it. I expect a lot of resistance here, because we would
> have to change tried-and-tested (if POLA-violating) code.

Personally, I haven't seen any resistance from Junio on refactoring this
area. I'm sure he is concerned that we do not regress, but it's not like
the area has been unchanged over the years. It has been slow going
because we want to do it carefully, but I think we are actually at the
point now where the next step is making setup_git_directory() more sane.

-Peff
